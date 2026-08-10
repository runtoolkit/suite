package com.runtoolkit.rtwrapper.api;

import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

/**
 * Delayed dispatch: run a request N ticks from now instead of immediately.
 *
 * Mirrors the intent of the datapack's `schedule function ... <delay>`
 * pattern, but without scheduling an actual function call — a task here
 * is just an RTRequest plus a target tick, held in a min-heap and drained
 * by RTWrapper's existing END_SERVER_TICK hook (see tick(long)). No new
 * tick listener is registered; this rides the one that already exists for
 * autotick, so the ordering already documented there (one queued autotick
 * request drained max per tick) is untouched — ScheduledDispatch has its
 * own, independent budget below.
 *
 * A tick counter, not wall-clock time, is used deliberately: server ticks
 * can run slower than 50ms under load, and "N ticks from now" is the
 * datapack-equivalent notion of delay (schedule's delay is also
 * tick-based under the hood), not "N milliseconds from now".
 */
public final class ScheduledDispatch {

    private ScheduledDispatch() {}

    private record Task(long targetTick, RTRequest request) {}

    private static final PriorityQueue<Task> QUEUE =
            new PriorityQueue<>((a, b) -> Long.compare(a.targetTick, b.targetTick));

    private static long currentTick = 0L;

    /** Cap on how many due tasks are dispatched in a single tick, so a pile-up can't spike one tick. */
    private static final int MAX_PER_TICK = 20;

    /**
     * Schedule a request to run `delayTicks` ticks from now. delayTicks <= 0
     * runs it on the very next call to tick().
     */
    public static void schedule(RTRequest request, long delayTicks) {
        long target = currentTick + Math.max(0, delayTicks);
        synchronized (QUEUE) {
            QUEUE.add(new Task(target, request));
        }
    }

    /**
     * Advance the internal clock by one tick and dispatch anything now due.
     * Call this from the mod's existing END_SERVER_TICK registration.
     * Returns the results of whatever was dispatched this call (possibly empty).
     */
    public static List<RTDispatchResult> tick() {
        currentTick++;
        List<Task> due = new ArrayList<>();
        synchronized (QUEUE) {
            while (!QUEUE.isEmpty() && due.size() < MAX_PER_TICK && QUEUE.peek().targetTick() <= currentTick) {
                due.add(QUEUE.poll());
            }
        }
        List<RTDispatchResult> results = new ArrayList<>(due.size());
        for (Task t : due) {
            results.add(RTWrapperAPI.execute(t.request()));
        }
        return results;
    }

    public static int pendingCount() {
        synchronized (QUEUE) {
            return QUEUE.size();
        }
    }

    public static void clear() {
        synchronized (QUEUE) {
            QUEUE.clear();
        }
    }

    public static long currentTick() {
        return currentTick;
    }
}
