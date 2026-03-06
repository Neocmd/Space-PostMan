from __future__ import annotations

import json
import shutil
import sys
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
DIST_DIR = REPO_ROOT / "dist"
PACKAGE_ROOTS = [
    REPO_ROOT / "docs",
    REPO_ROOT / "data",
    REPO_ROOT / "FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md",
    REPO_ROOT / "CONTRIBUTING.md",
]


def build_manifest(version: str) -> dict[str, object]:
    return {
        "package": "foundation-pack",
        "version": version,
        "included": [
            "FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md",
            "CONTRIBUTING.md",
            "docs/",
            "data/",
        ],
    }


def add_path_to_zip(archive: zipfile.ZipFile, path: Path) -> None:
    if path.is_file():
        archive.write(path, path.relative_to(REPO_ROOT).as_posix())
        return

    for child in sorted(path.rglob("*")):
        if child.is_file():
            archive.write(child, child.relative_to(REPO_ROOT).as_posix())


def main(argv: list[str]) -> int:
    version = argv[1] if len(argv) > 1 else "dev"
    DIST_DIR.mkdir(exist_ok=True)

    manifest = DIST_DIR / "foundation-pack-manifest.json"
    manifest.write_text(json.dumps(build_manifest(version), indent=2), encoding="utf-8")

    archive_path = DIST_DIR / f"foundation-pack-{version}.zip"
    if archive_path.exists():
        archive_path.unlink()

    with zipfile.ZipFile(archive_path, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in PACKAGE_ROOTS:
            add_path_to_zip(archive, path)
        archive.write(manifest, manifest.relative_to(REPO_ROOT).as_posix())

    print(f"Packaged foundation bundle: {archive_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
