# Security & Usage Notes

## ⚠️ Risk Scenarios

### Account Security
- Suspicious software can steal tokens and hijack sessions.
- Microsoft accounts are vulnerable to these attacks.

### Server Rules
Most servers treat the following as cheating or exploiting:
- External scripts
- Automation
- AI bot behavior

### Mod Sources
Cracked or unknown mods may contain:
- Malicious code
- Backdoors
- Data leaks

---

## 🔒 Safe Usage Guidelines

### 1. Use Trusted Platforms
- Use **Modrinth** or **CurseForge**.
- Do not download mods from random GitHub or Discord links.

### 2. AI Integration — Development Side Only

| Use Case | Status |
|---|---|
| Writing datapacks | ✅ |
| Generating code | ✅ |
| Automation (CI/CD) | ✅ |
| Runtime AI inside the game | ❌ |
| Running as a bot on a server | ❌ |

### 3. Clean Client in Multiplayer
- Only use **Fabric** or **Forge**.
- Stick to known, trusted mods.
- Avoid files with unclear origins like `unknown_client.jar`.

### 4. Security Ranking
```
Datapack > Mod > External Tool
```
Datapacks run in a sandbox, are vanilla-compatible, and pose no risk as long as they are not abused.

---

## Summary

| Risk Factor | Notes |
|---|---|
| Ban risk | Client cheats + exploits + suspicious mods |
| AI on its own | Not a problem |
| How you use it | Everything |

> **AI + Minecraft = excellent as a development tool. Risky if integrated into live gameplay.**
