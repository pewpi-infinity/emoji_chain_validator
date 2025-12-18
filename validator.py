import json
import sys

GRAMMAR_FILE = "../emoji_grammar_core/emoji_grammar.json"

def load_grammar():
    with open(GRAMMAR_FILE, "r", encoding="utf-8") as f:
        return json.load(f)

def validate(chain, grammar):
    known = set()
    for section in grammar.values():
        known.update(section.keys())

    unknown = [c for c in chain if c not in known and c not in ["=", "×", "→"]]
    return unknown

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python validator.py \"☢️♠️🧱\"")
        sys.exit(1)

    chain = sys.argv[1]
    grammar = load_grammar()
    unknown = validate(chain, grammar)

    if unknown:
        print("❌ INVALID EMOJIS:", "".join(unknown))
    else:
        print("✅ VALID EMOJI CHAIN:", chain)
