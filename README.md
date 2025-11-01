# Guess the Number — RISC‑V (RARS)

A tiny console game in **RISC‑V assembly** for the **RARS** simulator.

The program picks a random number in [0, 100], gives you **3 attempts**, and provides graded hints:
- Difference **1–4** → “high” or “low”
- Difference **>4** → “too high” or “too low”

> **Note:** As requested, the assembly **code is unchanged**; this repo only adds structure and documentation.

## Files
```
riscv-guess-the-number/
├─ guess_number.s          # RISC‑V assembly (as provided, unchanged)
├─ README.md
├─ LICENSE
├─ .gitignore
└─ .editorconfig
```

## How to Run (RARS)
1. Download **RARS** (RISC‑V Assembler and Runtime Simulator) `rars.jar`.
2. Open `guess_number.s` in RARS.
3. Assemble and run (F3/F5). Use the console for input/output.

### CLI (optional)
```bash
java -jar rars.jar nc guess_number.s
```

## Syscalls used (RARS)
- `a7 = 4`  → print string (expects address in `a0`)
- `a7 = 1`  → print integer (expects value in `a0`)
- `a7 = 5`  → read integer (returns in `a0`)
- `a7 = 42` → random integer in range [`a0`, `a1`]
- `a7 = 10` → exit

## Gameplay Flow
- Displays instructions
- Generates random number in **0–100** into `s0`
- Repeats:
  - Shows **remaining attempts**
  - Reads a guess
  - Compares and prints **low / too low / high / too high**
  - Decrements attempts
- Win: prints “You Won!”
- Lose: prints “You Lost!” and reveals the correct answer

## Licence
MIT — see `LICENSE`.

_Last updated: 2025-11-01_
# guess-the-number
