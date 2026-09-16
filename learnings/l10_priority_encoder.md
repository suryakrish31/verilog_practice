# Priority Encoder: Summary

Core concept: Priority encoding resolves multiple simultaneous set bits by scanning from MSB down — first 1 wins. Different from a plain encoder (which assumes one-hot input).

Invalid-case handling (in=0):

Primary reason to define out even when valid=0: avoid inferred latches and X-propagation into downstream logic.
Power/toggle-avoidance is a valid but secondary justification — only matters if out feeds something that isn't properly gated by valid.
Know which reason is primary before citing the secondary one — interviewers probe this.

SOP equation bug (masking): When deriving priority logic as sum-of-products by hand, each lower-priority term must explicitly AND in the complement of every higher-priority bit — a bit only "shows through" if nothing above it is set. Naive OR-ing without masking silently leaks lower-priority bits through. This is the general rule for any priority-encoded combinational logic.

Structural vs behavioral tradeoff: Chose structural (explicit 2:1 mux instances) over casex/priority-if — shows gate-level thinking, makes critical path explicit and countable.

Scaling to 8-bit — tree vs. chain:

Linear chain (cascading 2:1 muxes across all 8 inputs) → critical path grows with N.
Tree structure (two 4-bit encoders + merge mux) → critical path grows much more slowly as width increases.
General principle: when combining N things pairwise with an associative operation, a tree beats a linear chain, and the gap widens as N grows. Applies broadly — carry-lookahead adders, wide muxes, reduction trees.

Merge logic for tree composition: Upper half wins ties (MSB = highest priority, per spec). Final index = {1'b1, msb_block.out} if MSB half valid, else {1'b0, lsb_block.out}. Prepending the half-selector bit as the new MSB is what computes the +4 offset for the upper half.