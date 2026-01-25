# Synchronous FIFO (Verilog)

## 📌 Overview
This project implements a **parameterized synchronous FIFO** in Verilog along with a **comprehensive testbench**.  
The FIFO operates in a **single clock domain** and uses a **count-based mechanism** to detect **FULL** and **EMPTY** conditions.

This project is designed for:
- Digital Design / RTL interviews
- Strong understanding of FIFO fundamentals
- Preparation before asynchronous FIFO and Physical Design projects

---

## ✨ Features
- Single-clock synchronous FIFO
- Parameterized **DEPTH** and **WIDTH**
- Count-based FULL and EMPTY detection
- Correct handling of simultaneous read & write
- Natural pointer wrap-around (no modulo operator)
- Fully synthesizable RTL
- Directed + random testbench with waveform dumping

---

## ⚙️ Design Parameters
```verilog
parameter DEPTH = 16;
parameter WIDTH = 8;
