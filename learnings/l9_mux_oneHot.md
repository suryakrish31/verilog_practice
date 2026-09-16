# High-Speed One-Hot Multiplexer Analysis
## Problem Summary
Design a 16-bit, 4:1 multiplexer using a guaranteed one-hot select vector (sel[3:0]) to achieve the minimum possible propagation delay from inputs to output, without using high-level behavioral constructs (case, if-else, ? :).
1. Redundant Protection Logic & Timing Slack
The Pitfall: Adding explicit protection logic like (|sel) & (...) creates a parallel 4-input OR reduction tree (OR4) that feeds a late-stage gating cell (AND2) across all output bits.
The Impact: Since the Sum-of-Products (SOP) expression already naturally evaluates to 0 when sel == 4'b0000, the explicit |sel check adds 1 to 2 redundant CMOS gate delays to every bit of the 16-bit output bus, directly reducing timing slack (F 
max).
2. Standard-Cell Realization (AOI Mapping)
And-Or-Invert Logic: Clean SOP expressions for one-hot select logic map directly to standard AOI2222 (And-Or-Invert) cells combined with an Inverter.
Gate Depth Comparison:
2:1 Mux Tree (case/if-else): O(log2N) depth. A 4:1 Mux requires 2 stages of MUX2 cells (4 gate delays).
Unoptimized One-Hot ((|sel) & SOP): OR4 + AOI2222 + INV + AND2 (3 gate delays).
Optimal One-Hot (Pure SOP): Single AOI2222 + Inverter (2 gate delays).
Scaling Advantage: The pure SOP structure maintains a constant O(1) gate depth (2 gate delays) as input bus widths scale, whereas Mux trees get deeper.
3. Multi-Hot Fault Behavior
Mux Tree: Resolves multi-hot inputs via fixed priority decoding based on the tree structure.
One-Hot SOP Mux: If a multi-hot fault occurs on sel, the output evaluates to a bitwise OR of the active input buses (in_A | in_B). In high-speed datapath design, this tradeoff is accepted because avoiding priority-decoding logic saves area and gate delays.