package dev.barden.guimaker.state;

import dev.barden.guimaker.model.GuiPage;
import dev.barden.guimaker.model.GuiProfile;
import dev.barden.guimaker.model.PlayerGuiCache;
import java.util.Collection;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;
import net.minecraft.nbt.NbtCompound;
import net.minecraft.nbt.NbtElement;
import net.minecraft.nbt.NbtList;
import net.minecraft.registry.RegistryWrapper;
import net.minecraft.server.MinecraftServer;
import net.minecraft.world.PersistentState;

public final class GuiMakerState extends PersistentState {
    private static final String STATE_ID = "guimaker_state";
    private static final Type<GuiMakerState> TYPE = new Type<>(GuiMakerState::new, GuiMakerState::fromNbt, null);

    private int nextGuiId = 1;
    private final Map<Integer, GuiProfile> profiles = new LinkedHashMap<>();
    private final Map<UUID, PlayerGuiCache> playerCaches = new LinkedHashMap<>();

    public static GuiMakerState get(MinecraftServer server) {
        return server.getOverworld().getPersistentStateManager().getOrCreate(TYPE, STATE_ID);
    }

    public Collection<GuiProfile> profiles() {
        return this.profiles.values();
    }

    public GuiProfile createProfile() {
        int id = this.nextGuiId++;
        GuiProfile profile = new GuiProfile(id);
        this.profiles.put(id, profile);
        this.markDirty();
        return profile;
    }

    public void putProfile(GuiProfile profile) {
        this.profiles.put(profile.guiId(), profile);
        this.nextGuiId = Math.max(this.nextGuiId, profile.guiId() + 1);
        this.markDirty();
    }

    public GuiProfile getProfile(int guiId) {
        return this.profiles.get(guiId);
    }

    public GuiPage getPage(int guiId, int page) {
        GuiProfile profile = this.getProfile(guiId);
        return profile == null ? null : profile.getPage(page);
    }

    public void deleteProfile(int guiId) {
        this.profiles.remove(guiId);
        this.markDirty();
    }

    public void deletePage(int guiId, int page) {
        GuiProfile profile = this.getProfile(guiId);
        if (profile != null) {
            profile.removePage(page);
            this.markDirty();
        }
    }

    public PlayerGuiCache cacheFor(UUID playerId) {
        return this.playerCaches.computeIfAbsent(playerId, ignored -> new PlayerGuiCache());
    }

    @Override
    public NbtCompound writeNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        nbt.putInt("next_gui_id", this.nextGuiId);

        NbtList profiles = new NbtList();
        this.profiles.values().stream().sorted(Comparator.comparingInt(GuiProfile::guiId)).forEach(profile -> profiles.add(profile.toNbt(registries)));
        nbt.put("profiles", profiles);

        NbtCompound caches = new NbtCompound();
        for (Map.Entry<UUID, PlayerGuiCache> entry : this.playerCaches.entrySet()) {
            caches.put(entry.getKey().toString(), entry.getValue().toNbt(registries));
        }
        nbt.put("player_caches", caches);
        return nbt;
    }

    public static GuiMakerState fromNbt(NbtCompound nbt, RegistryWrapper.WrapperLookup registries) {
        GuiMakerState state = new GuiMakerState();
        state.nextGuiId = Math.max(1, nbt.getInt("next_gui_id"));

        if (nbt.contains("profiles", NbtElement.LIST_TYPE)) {
            NbtList profiles = nbt.getList("profiles", NbtElement.COMPOUND_TYPE);
            for (NbtElement element : profiles) {
                GuiProfile profile = GuiProfile.fromNbt((NbtCompound) element, registries);
                state.profiles.put(profile.guiId(), profile);
                state.nextGuiId = Math.max(state.nextGuiId, profile.guiId() + 1);
            }
        }

        if (nbt.contains("player_caches", NbtElement.COMPOUND_TYPE)) {
            NbtCompound caches = nbt.getCompound("player_caches");
            for (String key : caches.getKeys()) {
                try {
                    UUID uuid = UUID.fromString(key);
                    state.playerCaches.put(uuid, PlayerGuiCache.fromNbt(caches.getCompound(key), registries));
                } catch (IllegalArgumentException ignored) {
                }
            }
        }

        return state;
    }
}
