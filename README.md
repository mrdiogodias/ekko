# EKKO

## Overivew

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

## Architecture

The architecture is presented in the following picture.

[![EKKO](https://github.com/mrdiogodias/ekko/blob/master/doc/figures/ekko_overview.png)](https://github.com/mrdiogodias/ekko)

## Resource utilization

|  Component | Slice LUTs | Slice Registers | Slice | LUT as Logic | LUT as Memory |
|:----------:|:----------:|:---------------:|:-----:|:------------:|:-------------:|
|    Ibex    |    2870    |       949       |  887  |     2822     |       48      |
|  Debugger  |    1016    |       902       |  402  |      964     |       52      |
|     AXI    |     294    |       376       |  242  |      294     |       0       |
| I2C Master |     238    |       327       |  107  |      238     |       0       |
|    Timer   |     208    |       204       |   95  |      208     |       0       |

## SDK

The SDK is available here: [EKKO SDK](https://github.com/mrdiogodias/ekko-sdk)
