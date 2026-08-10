package com.runtoolkit.rtwrapper.api;

import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Runtime configuration mirroring the datapack's rtw.config scoreboard /
 * rtwrapper:runtime config storage (#debug, #silent, #auto_tick).
 *
 * Datapack defaults were: debug=0, silent=1, auto_tick=0 (see load.mcfunction).
 * Same defaults kept here for behavioral parity.
 */
public final class RTWrapperConfig {

    private RTWrapperConfig() {}

    private static final AtomicBoolean DEBUG = new AtomicBoolean(false);
    private static final AtomicBoolean SILENT = new AtomicBoolean(true);
    private static final AtomicBoolean AUTO_TICK = new AtomicBoolean(false);

    private static final AtomicInteger PROCESSED = new AtomicInteger(0);
    private static final AtomicInteger ERRORS = new AtomicInteger(0);

    public static boolean isDebug() {
        return DEBUG.get();
    }

    public static void setDebug(boolean value) {
        DEBUG.set(value);
    }

    public static boolean isSilent() {
        return SILENT.get();
    }

    public static void setSilent(boolean value) {
        SILENT.set(value);
    }

    public static boolean isAutoTick() {
        return AUTO_TICK.get();
    }

    public static void setAutoTick(boolean value) {
        AUTO_TICK.set(value);
    }

    public static int incrementProcessed() {
        return PROCESSED.incrementAndGet();
    }

    public static int incrementErrors() {
        return ERRORS.incrementAndGet();
    }

    public static int processedCount() {
        return PROCESSED.get();
    }

    public static int errorCount() {
        return ERRORS.get();
    }
}
