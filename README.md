# 🧩 Sudoku Game in NASM Assembly (x86, Linux)

This project is a complete terminal-based **Sudoku game** built entirely using **x86 NASM Assembly**, with no dependencies on high-level libraries or frameworks. It is designed for **Linux** systems and demonstrates low-level programming concepts such as system calls, memory layout management, screen rendering, and real-time validation logic.

The game allows users to solve a classic 9x9 Sudoku puzzle interactively via keyboard input, validating every move for compliance with Sudoku rules (row, column, and 3×3 subgrid uniqueness). It’s a challenging and educational example of what can be accomplished at the assembly level.

---

## 🚀 Features

- 🎮 **Fully interactive** gameplay in the terminal
- 🧠 **Real-time validation** of player inputs (no row/column/grid duplicates)
- 🧾 **Pre-filled puzzle** with fixed and editable cells
- 🖥️ **Board rendering** using direct system calls (no ncurses or libraries)
- ⌨️ **Keyboard-driven input** with coordinate-based placement
- ⚙️ Built with **pure NASM Assembly (x86)** targeting **Linux (ELF32)** format
- 💬 **Error messages** and prompts handled via syscall-driven I/O
- 🧪 **Great for learning** low-level programming, debugging, and OS interaction

---

## 📷 Screenshot

