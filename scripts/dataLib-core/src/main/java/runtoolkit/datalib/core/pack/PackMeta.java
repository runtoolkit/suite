package runtoolkit.datalib.core.pack;

/**
 * Parsed representation of a pack.mcmeta file with DataLib extensions.
 *
 * Standard fields:
 *   pack_format  — Mojang's pack format integer
 *   description  — human-readable description
 *
 * DataLib extension fields (all optional):
 *   id           — stable identifier for this pack, used by CommandAliasLoader
 *                  instead of the namespace. Falls back to pack directory name.
 *   environment  — where this pack should be active:
 *                    "all"          (default) — singleplayer + server
 *                    "server"       — dedicated server only
 *                    "singleplayer" — integrated server only
 */
public record PackMeta(
    String packName,      // directory / zip name, always present
    int    packFormat,
    String description,
    String id,            // nullable → falls back to packName
    String environment    // "all" | "server" | "singleplayer"
) {
    /** Effective id: explicit "id" field, or packName as fallback. */
    public String effectiveId() {
        return (id != null && !id.isBlank()) ? id : packName;
    }

    /** Returns true if this pack should be active in the current environment. */
    public boolean isActiveIn(Environment env) {
        if (environment == null) return true;
        return switch (environment.toLowerCase()) {
            case "server"       -> env == Environment.SERVER;
            case "singleplayer" -> env == Environment.SINGLEPLAYER;
            default             -> true; // "all" or unknown → always active
        };
    }

    public enum Environment {
        SERVER,
        SINGLEPLAYER;

        public static Environment detect(net.minecraft.server.MinecraftServer server) {
            return server instanceof net.minecraft.server.dedicated.DedicatedServer
                ? SERVER
                : SINGLEPLAYER;
        }
    }
}
