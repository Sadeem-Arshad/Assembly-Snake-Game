#  Snake Game (x86 Assembly)

A **classic Snake Game implemented in x86 Assembly Language** using BIOS interrupts and running in **DOS environment**.
The game features real-time keyboard control, score tracking, food generation, collision detection, and a complete game UI including title screen and animations.

This project demonstrates **low-level programming concepts**, including direct hardware interaction, BIOS interrupts, memory management, and real-time game logic.

---

#  Project Overview

This Snake Game is built entirely in **16-bit x86 Assembly** and runs in **real mode**.
The game uses BIOS interrupts (`INT 10h`, `INT 16h`, `INT 1Ah`) to manage:

* Screen display
* Keyboard input
* Random number generation using system timer

Players control the snake using **arrow keys**, collect food to increase their score, and avoid collisions with the walls or the snake’s own body.

---

# 🎮 Game Features

* Classic **Snake gameplay**
* **Real-time keyboard input** using arrow keys
* **Dynamic snake growth** when food is eaten
* **Random food generation**
* **Score and high score tracking**
* **Wall collision detection**
* **Self-collision detection**
* **Interactive title screen with animated letters**
* **Game Over screen with replay option**
* **Quit confirmation system**
* **Countdown before gameplay starts**
* **Thanks-for-playing exit screen**

---

#  Controls

| Key     | Action                    |
| ------- | ------------------------- |
| ⬆ Arrow | Move Up                   |
| ⬇ Arrow | Move Down                 |
| ⬅ Arrow | Move Left                 |
| ➡ Arrow | Move Right                |
| ESC     | Quit Game                 |
| Y       | Confirm Quit / Play Again |
| N       | Continue Playing          |

---

#  Technical Details

### Language

* **x86 Assembly (16-bit)**

### Environment

* **DOS / DOSBox**
* BIOS Interrupts used:

  * `INT 10h` → Screen display
  * `INT 16h` → Keyboard input
  * `INT 1Ah` → System timer for randomness
  * `INT 21h` → Program termination

### Game Mechanics

* **Snake Body Storage**

  * Arrays store snake segment coordinates:
  * `snake_x[100]`
  * `snake_y[100]`

* **Movement System**

  * Snake body shifts forward every frame
  * Head moves based on direction variable

* **Collision Detection**

  * Wall collision
  * Self collision

* **Food System**

  * Randomized coordinates
  * Prevents spawning on snake body

* **Score System**

  * Score increases when food is eaten
  * High score persists during runtime

---

# 🧠 Concepts Demonstrated

This project demonstrates several **low-level programming concepts**:

* BIOS interrupt programming
* Direct screen manipulation
* Keyboard interrupt handling
* Game loop design
* Memory management
* Stack usage
* Real-time input handling
* Procedural animation effects

---

#  Contributors

Developed by:

**Hamza Sheikh** (24L-2500)
**Sadeem Arshad** (24L-2502)

FAST National University of Computer and Emerging Sciences (FAST-NUCES), Lahore.

---

#  Acknowledgment

This project was developed as part of **low-level programming practice** to understand **x86 assembly and BIOS-level programming** through game development.

---

If you like this project, consider giving the repository a **star**!
