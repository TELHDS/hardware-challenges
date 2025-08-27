# 8-bit Ripple Carry Adder Challenge

## Overview
Design an 8-bit ripple carry adder that efficiently computes the sum of two 8-bit binary numbers with carry propagation.

## Requirements

### Functional Requirements
- **Inputs**: 
  - `a[7:0]` - First 8-bit operand
  - `b[7:0]` - Second 8-bit operand  
  - `cin` - Carry input
- **Outputs**:
  - `sum[7:0]` - 8-bit sum result
  - `cout` - Carry output

### Performance Targets
- **Maximum Delay**: 10ns
- **Area Budget**: 80 equivalent gates
- **Power Budget**: 50mW @ 100MHz

### Design Constraints
- Use only basic logic gates (AND, OR, XOR, NOT)
- Must be synthesizable Verilog 2005
- No behavioral modeling (always blocks with delays)
- Module name must be exactly `adder_8bit`

## Algorithm
A ripple carry adder chains together full adders where the carry output of each stage becomes the carry input of the next stage.

### Full Adder Logic
For each bit position i:
- `sum[i] = a[i] ⊕ b[i] ⊕ carry_in[i]`  
- `carry_out[i] = (a[i] & b[i]) | (carry_in[i] & (a[i] ⊕ b[i]))`

## Test Cases
Your design will be tested with:
- All zeros: 0 + 0 + 0 = 0
- Simple addition: 15 + 17 + 0 = 32
- Maximum values: 255 + 255 + 1 = 511 (with overflow)
- Random test vectors (1000+ cases)
- Edge cases with carry propagation

## Evaluation Criteria

### Functionality (50%)
- Must pass all test vectors
- Correct handling of carry propagation
- Proper overflow behavior

### Delay (20%) 
- Critical path from inputs to outputs
- Target: < 10ns (excellent: < 5ns)

### Area (15%)
- Gate count and resource utilization
- Target: < 80 gates (excellent: < 60 gates)

### Power (15%)
- Dynamic power estimation at 100MHz
- Target: < 50mW (excellent: < 30mW)

## Implementation Tips
- Consider carry-look-ahead optimizations
- Balance area vs speed trade-offs
- Use efficient gate structures
- Minimize signal transitions for power

## Submission Format
Submit a single Verilog file containing your `adder_8bit` module. The file should be clean, well-commented, and synthesizable.
