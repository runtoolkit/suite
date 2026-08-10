#!/usr/bin/env python3
"""
macroEngine-dp Load Order & Basic Validation Script
"""

import os
import json
import sys
from pathlib import Path

def main():
    root = Path(".")
    errors = []
    warnings = []

    print("🔍 macroEngine-dp Validation Starting...\n")

    # 1. pack.mcmeta kontrolü
    mcmeta = root / "pack.mcmeta"
    if not mcmeta.exists():
        errors.append("❌ pack.mcmeta dosyası bulunamadı!")
    else:
        try:
            with open(mcmeta, encoding='utf-8') as f:
                data = json.load(f)
            version = data.get("pack", {}).get("pack_format")
            print(f"✅ pack.mcmeta bulundu (pack_format: {version})")
        except Exception as e:
            errors.append(f"❌ pack.mcmeta okunamadı: {e}")

    # 2. Kritik load fonksiyonları var mı?
    critical_functions = [
        "data/macro/functions/load.mcfunction",
        "data/ame_load/functions/_.mcfunction",
        "data/load/tags/functions/load.json"
    ]

    for func in critical_functions:
        if not (root / func).exists():
            warnings.append(f"⚠️ Kritik dosya eksik: {func}")

    # 3. Version consistency kontrolü
    version_set = root / "1_20_3/data/ame_load/functions/load/internal/version_set.mcfunction"
    if version_set.exists():
        content = version_set.read_text(encoding='utf-8')
        if "set #ame.major ame.pre_version 4" in content:
            errors.append("❌ version_set.mcfunction içinde major versiyon hâlâ 4 olarak duruyor! (5 olmalı)")
        else:
            print("✅ Internal version kontrolü geçti")

    # 4. StringLib CharMap uyarısı (performans)
    charmap = root / "data/stringlib/function/zprivate/init.mcfunction"
    if charmap.exists():
        size = charmap.stat().st_size
        if size > 80000:
            warnings.append(f"⚠️ StringLib CharMap oldukça büyük ({size//1024} KB). Performansı etkileyebilir.")

    # Sonuç
    print("\n" + "="*50)
    if errors:
        print(f"❌ {len(errors)} hata bulundu:")
        for err in errors:
            print(err)
        sys.exit(1)
    else:
        print("🎉 Temel validasyon başarıyla tamamlandı!")

    if warnings:
        print(f"\n⚠️  {len(warnings)} uyarı:")
        for warn in warnings:
            print(warn)

    print("\n✅ Validation completed successfully!")


if __name__ == "__main__":
    main()
