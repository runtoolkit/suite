> **⚠️ ARCHIVED / MOVED**
>
> This repository (`runtoolkit/suite`) is **archived** and no longer maintained.
>
> All further development continues at:
> **https://github.com/vortacraftmc/core**
>
> Please open issues, PRs, and use the latest releases from the new repository.
> This repo is kept only as a historical snapshot.

# TEMPLATE-MOD

A Fabric mod template for Minecraft 26.1.2.

## Requirements

- Minecraft **26.1.2**
- Fabric Loader
- Fabric API
- Java **25**

## Getting Started

### Using this template

1. Click **Use this template** on GitHub
2. Clone your new repository
3. Edit `gradle.properties` with your mod details
4. Run `./gradlew build`

### Building

```bash
./gradlew build
```

Output will be in `build/libs/`.

## Project Structure

```
src/
├── main/          # Common (server + client) code
└── client/        # Client-only code
```

## License

See [LICENSE](LICENSE).
