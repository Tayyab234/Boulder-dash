# Boulder-dash
Boulder Dash (Assembly Edition)
A minimalist re-creation of the classic Boulder Dash DOS game in x86 assembly language. The game is split into two main phases: cave rendering and interactive gameplay. Developed using NASM and designed to run in DOSBox or any compatible x86 environment.

📦 Features
Reads and parses cave structure from a text file (cave1.txt).

Displays game grid with custom symbols (Rockford, boulders, diamonds, exit, etc.).

Arrow key controls to move Rockford.

Score increases upon collecting diamonds.

Game ends on reaching the exit or getting crushed by a boulder.

Instant boulder crush logic for simplicity.

ESC key exits the game anytime.

Error handling for file not found or invalid file size.

Includes visual layout and hidden cursor for better user experience.

🔄 Symbols Mapping
Symbol	Meaning
x	Dirt
R	Rockford
T	Target (Exit)
B	Boulder
D	Diamond
W	Wall

 How to Run
Assemble with NASM:
Run in DOSBox:
bash
nasm -f bin main.asm -o game.com
bash
dosbox game.com
Make sure cave1.txt is in the same directory and correctly formatted (20x78 lines = 1600 bytes with CR+LF line endings).

🧠 Controls
Arrow Keys – Move Rockford

ESC – Exit game
