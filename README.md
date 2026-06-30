# RTL-to-Physical Design Implementation of a Synchronous FIFO using OpenROAD

## Overview

This repository demonstrates the complete **ASIC implementation flow** of a parameterized **Synchronous FIFO** using an open-source EDA toolchain. The project begins with RTL written in Verilog HDL and proceeds through synthesis, floorplanning, placement, clock tree synthesis (CTS), timing optimization, routing, RC extraction, and static timing analysis using the **SkyWater SKY130 HD** standard cell library.

The objective of this project is to gain hands-on experience with the RTL-to-Physical Design flow while meeting timing constraints across multiple PVT corners.

---

## Key Features

* Parameterized synchronous FIFO
* Verilog RTL implementation
* Functional verification using a Verilog testbench
* Logic synthesis using **Yosys**
* Floorplanning and pin placement
* Tap cell insertion
* Global and detailed placement
* Clock Tree Synthesis (CTS)
* Timing optimization
* Global routing
* Detailed routing
* RC extraction using OpenRCX
* Multi-Corner Multi-Mode (MMMC) Static Timing Analysis
* DEF generation

---

# Design Specifications

| Parameter       | Value              |
| --------------- | ------------------ |
| FIFO Type       | Synchronous FIFO   |
| Data Width      | 8 bits             |
| FIFO Depth      | 16 Entries         |
| Clock Frequency | 100 MHz            |
| Clock Period    | 10 ns              |
| Technology      | SkyWater SKY130 HD |
| RTL Language    | Verilog HDL        |

---

# Design Architecture

The FIFO consists of:

* FIFO Memory Array
* Write Pointer
* Read Pointer
* Occupancy Counter
* Full Flag Logic
* Empty Flag Logic
* Read/Write Control Logic

```
                 +-----------------------------+
 Data In -------->|                             |
 Write Enable --->|                             |
 Read Enable ---->|      Synchronous FIFO       |
 Clock ---------->|                             |
 Reset ---------->|                             |
                  |                             |
                  +-------------+---------------+
                                |
          +---------------------+----------------------+
          |                     |                      |
      Data Out               Full Flag             Empty Flag
```

---

# ASIC Design Flow

```
RTL Design
    │
    ▼
Logic Synthesis
    │
    ▼
Floorplanning
    │
    ▼
Pin Placement
    │
    ▼
Tap Cell Insertion
    │
    ▼
Global Placement
    │
    ▼
Detailed Placement
    │
    ▼
Clock Tree Synthesis
    │
    ▼
Timing Optimization
    │
    ▼
Global Routing
    │
    ▼
Detailed Routing
    │
    ▼
RC Extraction
    │
    ▼
Static Timing Analysis
```

---

# Timing Constraints

The design was implemented using the following SDC constraints:

| Constraint         |   Value |
| ------------------ | ------: |
| Clock Period       |   10 ns |
| Input Delay        |    2 ns |
| Output Delay       |    2 ns |
| Clock Uncertainty  |  0.2 ns |
| Maximum Transition |    1 ns |
| Maximum Fanout     |      20 |
| Output Load        | 0.05 pF |

---

# Synthesis Summary

Logic synthesis was performed using **Yosys**.

### RTL Statistics

| Metric        |    Value |
| ------------- | -------: |
| Wires         |       53 |
| Wire Bits     |      430 |
| Memory Blocks |        1 |
| Memory Size   | 128 bits |
| Processes     |        1 |

The FIFO memory was successfully inferred during synthesis and mapped to standard-cell based storage during technology mapping.

---

# Floorplanning Results

| Parameter                  |           Value |
| -------------------------- | --------------: |
| Die Size                   | 110 µm × 110 µm |
| Core Area                  |     7807.49 µm² |
| Initial Standard Cell Area |     5640.41 µm² |
| Initial Utilization        |          72.2 % |
| Standard Cell Instances    |             576 |
| Tap Cells Inserted         |             102 |

---

# Placement Results

| Parameter              |       Value |
| ---------------------- | ----------: |
| Standard Cell Area     | 6013.30 µm² |
| Final Design Area      | 6436.17 µm² |
| Final Utilization      |      82.4 % |
| Placement Legalization |  Successful |

---

# Clock Tree Synthesis (CTS)

Clock Tree Synthesis was performed using TritonCTS.

### CTS Summary

| Parameter                | Value |
| ------------------------ | ----: |
| Clock Period             | 10 ns |
| Clock Buffers Inserted   |    17 |
| Clock Sinks              |   149 |
| Maximum Clock Tree Level |     4 |
| Clock Path Depth         |     2 |

---

# Timing Optimization

Post-CTS timing optimization was carried out to eliminate timing violations.

### Results

* No setup violations detected
* No hold violations detected
* Timing successfully repaired
* Positive timing slack maintained

---

# Global Routing

Global routing was successfully completed.

### Routing Summary

| Parameter         |                Value |
| ----------------- | -------------------: |
| Routed Nets       |                  605 |
| Total Wire Length |            23,549 µm |
| Total Vias        |                4,429 |
| Congestion        | No Global Congestion |

---

# Detailed Routing

Detailed routing was performed using TritonRoute.

The routing process completed successfully and progressively reduced routing violations during optimization. Further optimization can be performed in future revisions to achieve a completely clean signoff-quality routed database.

---

# RC Extraction

Parasitic extraction was performed using **OpenRCX**.

Generated outputs include:

* SPEF files
* RC network
* Coupling capacitances
* Extracted parasitic delays

---

# Multi-Corner Multi-Mode (MMMC) Timing Analysis

Static Timing Analysis was performed across multiple Process-Voltage-Temperature (PVT) corners.

| Corner |  Setup Slack |   Hold Slack | Status |
| ------ | -----------: | -----------: | :----: |
| **TT** | **+5.00 ns** | **+0.24 ns** | ✅ PASS |
| **SS** | **+2.34 ns** | **+0.70 ns** | ✅ PASS |
| **FF** | **+6.41 ns** | **+0.07 ns** | ✅ PASS |

### Timing Summary

* Positive setup slack across all analyzed corners
* Positive hold slack across all analyzed corners
* Successfully meets the 100 MHz timing target
* Timing closure achieved for TT, SS and FF corners

---

# Project Directory

```
sync_fifo/

├── rtl/
├── scripts/
├── synthesis/
├── reports/
├── results/
├── logs/
├── def/
├── constraints/
└── README.md
```

---

# Tools Used

* Verilog HDL
* Yosys
* OpenROAD
* OpenSTA
* TritonCTS
* TritonRoute
* OpenRCX
* GTKWave
* SkyWater SKY130 HD PDK
* Git
* GitHub

---

# Skills Demonstrated

* RTL Design
* FIFO Architecture
* Logic Synthesis
* Static Timing Analysis (STA)
* Multi-Corner Multi-Mode (MMMC) Analysis
* SDC Constraint Development
* Floorplanning
* Pin Placement
* Tap Cell Insertion
* Global Placement
* Detailed Placement
* Clock Tree Synthesis (CTS)
* Timing Optimization
* Global Routing
* Detailed Routing
* RC Extraction
* DEF Generation
* Open-Source ASIC Design Flow

---

# Future Work

* Generate final GDSII layout
* Perform DRC and LVS signoff
* Add power planning
* IR-drop analysis
* Antenna rule checking
* Power analysis
* Multi-mode timing analysis

---

# Author

**Tanuj Patnaik Manapuram**

B.Tech, Electronics and Communication Engineering
National Institute of Technology Rourkela

Interested in Static Timing Analysis (STA), Physical Design and ASIC Implementation.

---
