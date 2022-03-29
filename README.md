# EKKO

This is an open-source RISC-V soft-core microcontroller targeting the ZYBO FPGA board. It uses the [Ibex RISC-V soft-core](https://github.com/lowRISC/ibex) and the following features:

* AXI Bus
* Timer
* I2C
* RISC-V debug support (using the [PULP RISC-V Debug Module](https://github.com/pulp-platform/riscv-dbg)) via JTAG pins on PMOD header JD; the pinouts are:

| PMOD header JD |            |
| ------------ | ------------ |
| 1  : TRST_N  | 7  : TMS     |
| 2  : TDO     | 8  : TDI     |
| 3  :         | 9  :         |
| 4  : TCK     | 10 : RESET_N |
| 5  : GND     | 11 : GND     |
| 6  : VREF    | 12 : VREF    |

The architecture is presented in the following picture.

[![EKKO](https://github.com/mrdiogodias/ekko/blob/master/doc/figures/ekko_overview.png)](https://github.com/mrdiogodias/ekko)

The SDK is available here: [EKKO SDK](https://github.com/mrdiogodias/ekko-sdk)
