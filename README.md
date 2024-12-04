# SUDUKO.ASM
Project Title: Sudoku Game in Assembly Language
#Overview
This project is an implementation of the classic Sudoku puzzle game in assembly language. The primary goal is to provide an interactive experience where users can solve Sudoku puzzles directly within a DOSBox environment. This project demonstrates problem-solving skills and the ability to use low-level programming to create a functional game.

#Key Features
Sudoku Board Setup:

A 9x9 grid is used to represent the Sudoku board.
The board is initialized with predefined numbers in some cells (the puzzle).
Empty cells are denoted by a specific placeholder value (e.g., 0 or _).
User Interaction:

Users can input numbers into empty cells using keyboard inputs.
A prompt-based system guides the user for row, column, and number input.
#Validation:

Each user entry is validated to ensure it adheres to Sudoku rules:
Numbers (1-9) must not repeat in any row, column, or 3x3 sub-grid.
Invalid inputs are flagged, and the user is prompted to retry.
Completion Check:

The program continuously checks if the puzzle is solved.
Once the board is correctly completed, the program displays a congratulatory message.
#Assembly-Specific Features:

Efficient memory management for the board using registers and arrays.
Clear separation of logic for board initialization, input handling, and validation.
Use of assembly language instructions for low-level computations and data manipulations.
Learning Objectives
Understand the principles of puzzle-solving using logic and algorithms.
Gain hands-on experience with assembly programming for input handling and logic implementation.
Develop an appreciation for creating complex systems in resource-constrained environments.
Implementation Details
Platform: NASM Assembly Language, DOSBox environment.
Registers: Used for managing current row, column, and number during user input and validation.
Data Structures:
A 9x9 array in memory for the Sudoku board.
Flags and counters for validation and completion checks.
Functions:
Displaying the board on-screen.
Accepting and processing user inputs.
Validating Sudoku rules.
Checking for puzzle completion.
Challenges and Innovations
Handling input and output efficiently in an assembly environment.
Implementing complex Sudoku logic without high-level constructs.
Ensuring optimal performance with minimal memory usage.
Conclusion
This project is a testament to the versatility of assembly language and the creativity required to solve complex problems in a low-level programming environment. The Sudoku game serves as both an engaging project and a tool for improving problem-solving and programming skills
