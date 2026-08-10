package dev.barden.guimaker.command;

import com.mojang.brigadier.Command;
import com.mojang.brigadier.arguments.ArgumentType;
import com.mojang.brigadier.arguments.BoolArgumentType;
import com.mojang.brigadier.arguments.IntegerArgumentType;
import com.mojang.brigadier.arguments.StringArgumentType;
import com.mojang.brigadier.builder.LiteralArgumentBuilder;
import com.mojang.brigadier.builder.RequiredArgumentBuilder;
import com.mojang.brigadier.context.CommandContext;
import com.mojang.brigadier.exceptions.CommandSyntaxException;
import com.mojang.brigadier.exceptions.SimpleCommandExceptionType;
import dev.barden.guimaker.model.GuiButtonAction;
import dev.barden.guimaker.model.GuiChangeMenu;
import dev.barden.guimaker.model.GuiPage;
import dev.barden.guimaker.model.GuiProfile;
import dev.barden.guimaker.model.GuiSlotDefinition;
import dev.barden.guimaker.model.GuiSlotType;
import dev.barden.guimaker.screen.GuiMakerScreenHandler;
import dev.barden.guimaker.state.GuiMakerState;
import dev.barden.guimaker.util.GuiItemUtil;
import dev.barden.guimaker.util.GuiMakerItemFactory;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.minecraft.block.entity.BlockEntity;
import net.minecraft.command.argument.EntityArgumentType;
import net.minecraft.command.argument.IdentifierArgumentType;
import net.minecraft.inventory.Inventory;
import net.minecraft.item.ItemStack;
import net.minecraft.item.Items;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.registry.RegistryWrapper;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;
import net.minecraft.util.Identifier;

public final class GuiMakerCommands {
    private static final SimpleCommandExceptionType NEEDS_CONTAINER = new SimpleCommandExceptionType(Text.literal("Stand above a chest/barrel/trapped chest inventory to capture data."));
    private static final SimpleCommandExceptionType INVALID_IMPORT = new SimpleCommandExceptionType(Text.literal("The held item does not contain GUI Maker export data."));

    private GuiMakerCommands() {
    }

    public static void register() {
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) -> dispatcher.register(root()));
    }

    private static LiteralArgumentBuilder<ServerCommandSource> root() {
        var pageArgument = CommandManager.argument("page", IntegerArgumentType.integer(1))
            .executes(context -> open(context, IntegerArgumentType.getInteger(context, "page")));

        var guiIdArgument = CommandManager.argument("guiId", IntegerArgumentType.integer(1))
            .executes(context -> open(context, 1));
        guiIdArgument.then(pageArgument);

        var targetsArgument = CommandManager.argument("targets", EntityArgumentType.players());
        targetsArgument.then(guiIdArgument);

        var openBranch = CommandManager.literal("open").then(targetsArgument);

        return CommandManager.literal("guimaker")
            .requires(source -> source.hasPermissionLevel(2))
            .then(CommandManager.literal("items").executes(GuiMakerCommands::giveItems))
            .then(profileBranch())
            .then(pageBranch())
            .then(slotBranch())
            .then(exportBranch())
            .then(CommandManager.literal("import").executes(GuiMakerCommands::importHeld))
            .then(openBranch);
    }

    private static LiteralArgumentBuilder<ServerCommandSource> profileBranch() {
        return CommandManager.literal("profile")
            .then(CommandManager.literal("create").executes(GuiMakerCommands::createProfile))
            .then(CommandManager.literal("delete")
                .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1)).executes(GuiMakerCommands::deleteProfile)))
            .then(CommandManager.literal("list").executes(GuiMakerCommands::listProfiles));
    }

    private static LiteralArgumentBuilder<ServerCommandSource> pageBranch() {
        return CommandManager.literal("page")
            .then(CommandManager.literal("capture")
                .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1))
                    .executes(context -> capturePage(context, null))
                    .then(CommandManager.argument("name", StringArgumentType.greedyString()).executes(context -> capturePage(context, StringArgumentType.getString(context, "name"))))))
            .then(CommandManager.literal("rename")
                .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1))
                    .then(CommandManager.argument("page", IntegerArgumentType.integer(1))
                        .then(CommandManager.argument("name", StringArgumentType.greedyString()).executes(GuiMakerCommands::renamePage)))))
            .then(CommandManager.literal("delete")
                .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1))
                    .then(CommandManager.argument("page", IntegerArgumentType.integer(1)).executes(GuiMakerCommands::deletePage))))
            .then(CommandManager.literal("list")
                .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1)).executes(GuiMakerCommands::listPages)));
    }

    private static LiteralArgumentBuilder<ServerCommandSource> slotBranch() {
        var slotBranch = CommandManager.literal("slot");

        slotBranch.then(CommandManager.literal("icon").then(slotTarget(GuiMakerCommands::setSlotIcon)));
        slotBranch.then(CommandManager.literal("type").then(slotTargetWithExtra("type", StringArgumentType.word(), GuiMakerCommands::setSlotType)));
        slotBranch.then(CommandManager.literal("cached").then(slotTargetWithExtra("value", BoolArgumentType.bool(), GuiMakerCommands::setSlotCached)));
        slotBranch.then(CommandManager.literal("togglelist").then(slotTarget(GuiMakerCommands::setToggleListFromContainer)));
        slotBranch.then(CommandManager.literal("clear").then(slotTarget(GuiMakerCommands::clearSlot)));

        var actionBranch = CommandManager.literal("action");
        actionBranch.then(CommandManager.literal("clear").then(slotTarget(GuiMakerCommands::clearAction)));
        actionBranch.then(CommandManager.literal("command").then(slotTargetWithExtra("command", StringArgumentType.greedyString(), GuiMakerCommands::setActionCommand)));
        actionBranch.then(CommandManager.literal("function").then(slotTargetWithExtra("callback", IdentifierArgumentType.identifier(), GuiMakerCommands::setActionFunction)));
        actionBranch.then(CommandManager.literal("itemmodifier").then(slotTargetWithExtra("modifier", IdentifierArgumentType.identifier(), GuiMakerCommands::setActionItemModifier)));
        actionBranch.then(CommandManager.literal("sound").then(slotTargetWithExtra("sound", IdentifierArgumentType.identifier(), GuiMakerCommands::setActionSound)));
        actionBranch.then(CommandManager.literal("changemenu").then(slotTargetWithChangeMenu()));

        slotBranch.then(actionBranch);
        return slotBranch;
    }

    private static LiteralArgumentBuilder<ServerCommandSource> exportBranch() {
        return CommandManager.literal("export")
            .then(CommandManager.argument("guiId", IntegerArgumentType.integer(1))
                .executes(context -> export(context, requiredPlayer(context.getSource())))
                .then(CommandManager.argument("targets", EntityArgumentType.players()).executes(context -> export(context, EntityArgumentType.getPlayers(context, "targets")))));
    }

    private static RequiredArgumentBuilder<ServerCommandSource, Integer> slotTarget(Command<ServerCommandSource> command) {
        return CommandManager.argument("guiId", IntegerArgumentType.integer(1))
            .then(CommandManager.argument("page", IntegerArgumentType.integer(1))
                .then(CommandManager.argument("slot", IntegerArgumentType.integer(0, 53)).executes(command)));
    }

    private static <T> RequiredArgumentBuilder<ServerCommandSource, Integer> slotTargetWithExtra(String extraName, ArgumentType<T> extraType, Command<ServerCommandSource> command) {
        return CommandManager.argument("guiId", IntegerArgumentType.integer(1))
            .then(CommandManager.argument("page", IntegerArgumentType.integer(1))
                .then(CommandManager.argument("slot", IntegerArgumentType.integer(0, 53))
                    .then(CommandManager.argument(extraName, extraType).executes(command))));
    }

    private static RequiredArgumentBuilder<ServerCommandSource, Integer> slotTargetWithChangeMenu() {
        return CommandManager.argument("guiId", IntegerArgumentType.integer(1))
            .then(CommandManager.argument("page", IntegerArgumentType.integer(1))
                .then(CommandManager.argument("slot", IntegerArgumentType.integer(0, 53))
                    .then(CommandManager.argument("targetGuiId", IntegerArgumentType.integer(1))
                        .then(CommandManager.argument("targetPage", IntegerArgumentType.integer(1)).executes(GuiMakerCommands::setActionChangeMenu)))));
    }

    private static int giveItems(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        ServerPlayerEntity player = requiredPlayer(context.getSource());
        give(player, GuiMakerItemFactory.itemHolder(false));
        give(player, GuiMakerItemFactory.itemHolder(true));
        give(player, GuiMakerItemFactory.toggleButton(false));
        give(player, GuiMakerItemFactory.toggleButton(true));
        give(player, GuiMakerItemFactory.dataDrivenButton());
        give(player, GuiMakerItemFactory.dataDrivenPageCreator());
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Special items granted."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int createProfile(CommandContext<ServerCommandSource> context) {
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        GuiProfile profile = state.createProfile();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Created GUI profile #" + profile.guiId()), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int deleteProfile(CommandContext<ServerCommandSource> context) {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        state.deleteProfile(guiId);
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Deleted GUI profile #" + guiId), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int listProfiles(CommandContext<ServerCommandSource> context) {
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        if (state.profiles().isEmpty()) {
            context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] No GUI profiles exist."), false);
            return Command.SINGLE_SUCCESS;
        }

        for (GuiProfile profile : state.profiles()) {
            context.getSource().sendFeedback(() -> Text.literal("- GUI #" + profile.guiId() + " (pages: " + profile.pages().size() + ")"), false);
        }
        return Command.SINGLE_SUCCESS;
    }

    private static int capturePage(CommandContext<ServerCommandSource> context, String explicitName) throws CommandSyntaxException {
        ServerPlayerEntity player = requiredPlayer(context.getSource());
        Inventory inventory = inventoryBelow(player);
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        GuiProfile profile = requireProfile(state, guiId);
        GuiPage page = profile.addCapturedPage(explicitName, inventory, context.getSource().getServer().getRegistryManager());
        state.markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Captured page " + page.page() + " into GUI #" + guiId), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int renamePage(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiPage page = requirePage(GuiMakerState.get(context.getSource().getServer()), IntegerArgumentType.getInteger(context, "guiId"), IntegerArgumentType.getInteger(context, "page"));
        String name = StringArgumentType.getString(context, "name");
        page.rename(name);
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Page renamed to: " + name), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int deletePage(CommandContext<ServerCommandSource> context) {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        int page = IntegerArgumentType.getInteger(context, "page");
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        state.deletePage(guiId, page);
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Deleted page " + page + " from GUI #" + guiId), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int listPages(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        GuiProfile profile = requireProfile(GuiMakerState.get(context.getSource().getServer()), guiId);
        for (GuiPage page : profile.pages()) {
            context.getSource().sendFeedback(() -> Text.literal("- Page " + page.page() + ": " + page.name() + " (size " + page.size() + ")"), false);
        }
        return Command.SINGLE_SUCCESS;
    }

    private static int open(CommandContext<ServerCommandSource> context, int page) throws CommandSyntaxException {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        Collection<ServerPlayerEntity> targets = EntityArgumentType.getPlayers(context, "targets");
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        for (ServerPlayerEntity target : targets) {
            GuiMakerScreenHandler.open(target, state, guiId, page);
        }
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Opened GUI #" + guiId + "/" + page + " for " + targets.size() + " player(s)."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setSlotIcon(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        ServerPlayerEntity player = requiredPlayer(context.getSource());
        GuiSlotDefinition slot = requireSlot(context);
        slot.setIconStack(player.getMainHandStack().copy());
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot icon updated."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setSlotType(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        slot.setType(GuiSlotType.fromString(StringArgumentType.getString(context, "type")));
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot type updated to " + slot.type().name()), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setSlotCached(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        slot.setCached(BoolArgumentType.getBool(context, "value"));
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot cached flag updated."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setToggleListFromContainer(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        ServerPlayerEntity player = requiredPlayer(context.getSource());
        Inventory inventory = inventoryBelow(player);
        GuiSlotDefinition slot = requireSlot(context);
        List<ItemStack> stacks = new ArrayList<>();
        for (int i = 0; i < inventory.size(); i++) {
            if (!inventory.getStack(i).isEmpty()) {
                stacks.add(inventory.getStack(i).copy());
            }
        }
        slot.setType(GuiSlotType.TOGGLE_BUTTON).setToggleStacks(stacks);
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Toggle list captured with " + stacks.size() + " states."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int clearSlot(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        int page = IntegerArgumentType.getInteger(context, "page");
        int slotIndex = IntegerArgumentType.getInteger(context, "slot");
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        requirePage(state, guiId, page).removeSlot(slotIndex);
        state.markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot cleared."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int clearAction(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        slot.setAction(new GuiButtonAction());
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot action cleared."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setActionCommand(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        slot.action().withCommand(StringArgumentType.getString(context, "command"));
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot command action updated."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setActionFunction(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        Identifier callback = IdentifierArgumentType.getIdentifier(context, "callback");
        slot.action().withFunctionId(callback.toString());
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot callback updated to " + callback), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setActionItemModifier(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        Identifier modifier = IdentifierArgumentType.getIdentifier(context, "modifier");
        slot.action().withItemModifierId(modifier.toString());
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot item modifier updated to " + modifier), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setActionSound(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        Identifier sound = IdentifierArgumentType.getIdentifier(context, "sound");
        slot.action().withSoundId(sound.toString());
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot sound updated to " + sound), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int setActionChangeMenu(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiSlotDefinition slot = requireSlot(context);
        int targetGuiId = IntegerArgumentType.getInteger(context, "targetGuiId");
        int targetPage = IntegerArgumentType.getInteger(context, "targetPage");
        slot.action().withChangeMenu(new GuiChangeMenu(targetGuiId, targetPage));
        GuiMakerState.get(context.getSource().getServer()).markDirty();
        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Slot change-menu target updated."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int export(CommandContext<ServerCommandSource> context, ServerPlayerEntity singleTarget) throws CommandSyntaxException {
        return export(context, List.of(singleTarget));
    }

    private static int export(CommandContext<ServerCommandSource> context, Collection<ServerPlayerEntity> targets) throws CommandSyntaxException {
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        GuiProfile profile = requireProfile(state, guiId);
        RegistryWrapper.WrapperLookup registries = context.getSource().getServer().getRegistryManager();

        ItemStack exportItem = new ItemStack(Items.BARREL);
        GuiItemUtil.setName(exportItem, "GUI Exported Data™");
        NbtCompound root = new NbtCompound();
        NbtCompound export = new NbtCompound();
        NbtList profiles = new NbtList();
        profiles.add(profile.toDatapackProfileNbt(registries));
        export.put("profiles", profiles);
        root.put("guimaker_export", export);

        NbtCompound gui = new NbtCompound();
        gui.put("export", profiles.copy());
        root.put("gui", gui);
        GuiItemUtil.setCustomData(exportItem, root);

        for (ServerPlayerEntity target : targets) {
            give(target, exportItem.copy());
        }

        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Exported GUI #" + guiId + " to " + targets.size() + " player(s)."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static int importHeld(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        ServerPlayerEntity player = requiredPlayer(context.getSource());
        ItemStack stack = player.getMainHandStack();
        NbtCompound root = GuiItemUtil.getCustomData(stack);
        RegistryWrapper.WrapperLookup registries = context.getSource().getServer().getRegistryManager();
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());

        boolean imported = false;
        if (root.contains("guimaker_export", NbtElement.COMPOUND_TYPE)) {
            NbtCompound export = root.getCompound("guimaker_export");
            if (export.contains("profiles", NbtElement.LIST_TYPE)) {
                NbtList profiles = export.getList("profiles", NbtElement.COMPOUND_TYPE);
                for (NbtElement element : profiles) {
                    state.putProfile(GuiProfile.fromDatapackProfileNbt((NbtCompound) element, registries));
                    imported = true;
                }
            }
        }

        if (!imported && root.contains("gui", NbtElement.COMPOUND_TYPE)) {
            NbtCompound gui = root.getCompound("gui");
            if (gui.contains("export", NbtElement.LIST_TYPE)) {
                NbtList profiles = gui.getList("export", NbtElement.COMPOUND_TYPE);
                for (NbtElement element : profiles) {
                    state.putProfile(GuiProfile.fromDatapackProfileNbt((NbtCompound) element, registries));
                    imported = true;
                }
            }
        }

        if (!imported) {
            throw INVALID_IMPORT.create();
        }

        context.getSource().sendFeedback(() -> Text.literal("[GuiMaker] Import completed."), true);
        return Command.SINGLE_SUCCESS;
    }

    private static GuiProfile requireProfile(GuiMakerState state, int guiId) throws CommandSyntaxException {
        GuiProfile profile = state.getProfile(guiId);
        if (profile == null) {
            throw new SimpleCommandExceptionType(Text.literal("GUI profile not found: " + guiId)).create();
        }
        return profile;
    }

    private static GuiPage requirePage(GuiMakerState state, int guiId, int page) throws CommandSyntaxException {
        GuiPage guiPage = state.getPage(guiId, page);
        if (guiPage == null) {
            throw new SimpleCommandExceptionType(Text.literal("GUI page not found: " + guiId + "/" + page)).create();
        }
        return guiPage;
    }

    private static GuiSlotDefinition requireSlot(CommandContext<ServerCommandSource> context) throws CommandSyntaxException {
        GuiMakerState state = GuiMakerState.get(context.getSource().getServer());
        int guiId = IntegerArgumentType.getInteger(context, "guiId");
        int page = IntegerArgumentType.getInteger(context, "page");
        int slot = IntegerArgumentType.getInteger(context, "slot");
        return requirePage(state, guiId, page).getOrCreateSlot(slot);
    }

    private static ServerPlayerEntity requiredPlayer(ServerCommandSource source) throws CommandSyntaxException {
        return source.getPlayerOrThrow();
    }

    private static Inventory inventoryBelow(ServerPlayerEntity player) throws CommandSyntaxException {
        BlockEntity blockEntity = player.getWorld().getBlockEntity(player.getBlockPos().down());
        if (blockEntity instanceof Inventory inventory) {
            return inventory;
        }
        throw NEEDS_CONTAINER.create();
    }

    private static void give(ServerPlayerEntity player, ItemStack stack) {
        if (!player.getInventory().insertStack(stack)) {
            player.dropItem(stack, false);
        }
    }
}
