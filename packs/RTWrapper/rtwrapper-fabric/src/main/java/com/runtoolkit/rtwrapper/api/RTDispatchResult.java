package com.runtoolkit.rtwrapper.api;

/**
 * Outcome of a dispatch attempt. Distinguishes the two failure modes that
 * the datapack silently conflated:
 *   - PERMISSION_DENIED: the source didn't have enough permission level.
 *   - COMMAND_FAILED: Brigadier itself rejected/failed the built command.
 * The datapack's error_bad_cmd handler couldn't tell these apart because
 * it only ever saw a raw macro-dispatch failure.
 */
public final class RTDispatchResult {

    public enum Status { SUCCESS, PERMISSION_DENIED, UNKNOWN_COMMAND, COMMAND_FAILED }

    private final Status status;
    private final String message;

    private RTDispatchResult(Status status, String message) {
        this.status = status;
        this.message = message;
    }

    public static RTDispatchResult success() {
        return new RTDispatchResult(Status.SUCCESS, null);
    }

    public static RTDispatchResult permissionDenied(int required, int actual) {
        return new RTDispatchResult(Status.PERMISSION_DENIED,
                "Requires permission level " + required + ", source has " + actual);
    }

    public static RTDispatchResult unknownCommand(String literal) {
        return new RTDispatchResult(Status.UNKNOWN_COMMAND,
                "'" + literal + "' is not in the RTWrapper command allowlist");
    }

    public static RTDispatchResult commandFailed(String message) {
        return new RTDispatchResult(Status.COMMAND_FAILED, message);
    }

    public Status status() {
        return status;
    }

    public String message() {
        return message;
    }

    public boolean isSuccess() {
        return status == Status.SUCCESS;
    }
}
