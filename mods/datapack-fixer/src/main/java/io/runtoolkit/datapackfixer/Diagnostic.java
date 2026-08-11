package io.runtoolkit.datapackfixer;

import java.nio.file.Path;

public record Diagnostic(Path file, int line, Severity severity, String code, String message, String suggestion) {
    public enum Severity { WARNING, ERROR }
}
