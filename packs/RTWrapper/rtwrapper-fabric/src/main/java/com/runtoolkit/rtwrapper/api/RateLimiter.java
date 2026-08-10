package com.runtoolkit.rtwrapper.api;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Per-source rate limiting. Each distinct source (identified by
 * ServerCommandSource#getName(), which covers both players and the
 * console/command-block sources) gets its own fixed-window bucket.
 *
 * This has no datapack equivalent — the datapack had no per-caller
 * throttling at all, only the tick-level 1-per-tick autotick cap, which
 * throttles the whole queue, not any individual caller. A single source
 * enqueueing 200 requests in a burst could still dominate every tick's
 * autotick slot. RateLimiter caps that at the source level, independent
 * of the queue.
 *
 * Fixed-window, not sliding/token-bucket: simple, cheap, and sufficient
 * for a command-dispatch guard rather than a general-purpose traffic
 * shaper. A source can burst up to the limit at the start of a window
 * and again right after it resets — acceptable here since the real goal
 * is "stop one source from monopolizing dispatch", not smooth pacing.
 */
public final class RateLimiter {

    private RateLimiter() {}

    /** Default limit: commands allowed per source per window. */
    private static volatile int limit = 10;

    /** Window length in milliseconds. */
    private static volatile long windowMillis = 1000L;

    private static final class Bucket {
        long windowStart;
        int count;
    }

    private static final Map<String, Bucket> BUCKETS = new ConcurrentHashMap<>();

    public static void configure(int newLimit, long newWindowMillis) {
        if (newLimit <= 0) throw new IllegalArgumentException("limit must be positive");
        if (newWindowMillis <= 0) throw new IllegalArgumentException("windowMillis must be positive");
        limit = newLimit;
        windowMillis = newWindowMillis;
    }

    public static int limit() {
        return limit;
    }

    public static long windowMillis() {
        return windowMillis;
    }

    /**
     * Returns true if the source is still under its limit for the current
     * window (and records the attempt). Returns false if the source has
     * exceeded the limit and should be rejected.
     */
    public static boolean tryAcquire(String sourceKey) {
        long now = System.currentTimeMillis();
        Bucket bucket = BUCKETS.computeIfAbsent(sourceKey, k -> {
            Bucket b = new Bucket();
            b.windowStart = now;
            b.count = 0;
            return b;
        });
        synchronized (bucket) {
            if (now - bucket.windowStart >= windowMillis) {
                bucket.windowStart = now;
                bucket.count = 0;
            }
            if (bucket.count >= limit) {
                return false;
            }
            bucket.count++;
            return true;
        }
    }

    /** Drops stale buckets so long-running servers don't accumulate memory for players who left. */
    public static void evictOlderThan(long maxAgeMillis) {
        long now = System.currentTimeMillis();
        BUCKETS.entrySet().removeIf(e -> {
            synchronized (e.getValue()) {
                return now - e.getValue().windowStart > maxAgeMillis;
            }
        });
    }

    public static void reset(String sourceKey) {
        BUCKETS.remove(sourceKey);
    }

    public static void resetAll() {
        BUCKETS.clear();
    }
}
