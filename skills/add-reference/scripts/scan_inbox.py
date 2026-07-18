"""Read-only inbox inventory for the add-reference skill."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


DIRECT = {".png", ".jpg", ".jpeg", ".webp"}
CONVERT = {".avif", ".bmp", ".gif", ".heic", ".heif", ".tif", ".tiff"}
SKIP_NAMES = {"readme.md", "processed-manifest.json"}


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def known_hashes(manifest_path: Path) -> set[str]:
    if not manifest_path.exists():
        return set()
    data = json.loads(manifest_path.read_text(encoding="utf-8"))
    return {entry["sha256"] for entry in data.get("entries", [])}


def inventory(inbox: Path, manifest: Path) -> list[dict[str, str]]:
    known = known_hashes(manifest)
    items: list[dict[str, str]] = []
    for file_path in inbox.rglob("*"):
        if not file_path.is_file() or "processed" in file_path.relative_to(inbox).parts:
            continue
        if file_path.name.lower() in SKIP_NAMES:
            continue
        extension = file_path.suffix.lower()
        if extension not in DIRECT | CONVERT:
            continue
        digest = sha256(file_path)
        items.append(
            {
                "source_path": file_path.relative_to(inbox.parent).as_posix(),
                "sha256": digest,
                "status": "known" if digest in known else "new",
                "handling": "copy-direct" if extension in DIRECT else "convert-to-png-copy",
            }
        )
    return items


def main() -> None:
    parser = argparse.ArgumentParser(description="List add-reference inbox candidates without changing files.")
    parser.add_argument("--inbox", type=Path, default=Path("inbox"))
    parser.add_argument("--manifest", type=Path, default=Path("inbox/processed-manifest.json"))
    args = parser.parse_args()
    print(json.dumps(inventory(args.inbox, args.manifest), ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
