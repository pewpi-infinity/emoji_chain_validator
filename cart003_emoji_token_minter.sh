#!/data/data/com.termux/files/usr/bin/bash
set -e

CART_NAME="emoji_token_minter"
REPO_NAME="$CART_NAME"

mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

git init
git config user.name "Infinity"
git config user.email "infinity@research.local"

cat > minter.py << 'PY'
import random
import json
import time

EMOJI_SETS = {
    "anchor": ["🧱"],
    "suit": ["♠️", "♦️", "♣️", "♥️"],
    "domain": ["☢️", "🍄", "⚛️"],
    "state": ["⭐", "✨", "💥"]
}

def mint():
    return (
        random.choice(EMOJI_SETS["anchor"]) +
        random.choice(EMOJI_SETS["domain"]) +
        random.choice(EMOJI_SETS["suit"]) +
        random.choice(EMOJI_SETS["state"]) +
        random.choice(EMOJI_SETS["anchor"])
    )

if __name__ == "__main__":
    token = mint()
    record = {
        "token_id": token,
        "epoch": random.choice(["🌱 Genesis","⚛️ Coherence","♾️ Plateau"]),
        "issued": "symbolic-now"
    }

    with open("minted_token.json", "w", encoding="utf-8") as f:
        json.dump(record, f, ensure_ascii=False, indent=2)

    print("🧱 MINTED TOKEN ID:", token)
PY

git add minter.py
git commit -m "Initialize emoji token minter"

echo "✅ CART 003 COMPLETE — token minter ready"
