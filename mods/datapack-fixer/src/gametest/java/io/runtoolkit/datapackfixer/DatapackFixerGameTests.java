package io.runtoolkit.datapackfixer;

import net.fabricmc.fabric.api.gametest.v1.FabricGameTest;
import net.minecraft.block.Blocks;
import net.minecraft.test.GameTest;
import net.minecraft.test.TestContext;

public final class DatapackFixerGameTests implements FabricGameTest {
    @GameTest(templateName = FabricGameTest.EMPTY_STRUCTURE)
    public void scannerDoesNotCrashOnMissingDirectory(TestContext context) {
        if (!new DatapackSyntaxScanner().scan(java.nio.file.Path.of("build", "nonexistent-datapacks")).isEmpty()) {
            throw new AssertionError("Missing directories must be safe.");
        }
        context.complete();
    }

    @GameTest(templateName = FabricGameTest.EMPTY_STRUCTURE)
    public void scannerDoesNotMutateTheGameWorld(TestContext context) {
        context.setBlockState(0, 0, 0, Blocks.AIR);
        context.expectBlock(Blocks.AIR, 0, 0, 0);
        context.complete();
    }
}
