# Chapter 13: Barcode Reader

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 221-222). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

This chapter explains the electric specification and basic theory of operation of the Barcode Reader.

The Barcode Reader program included in the PC-8201A Personal Application Kit assumes that operation is done with the HEOS-3071 (produced by HP Corp.).

## 13.1 Electric Specification

Refer to the "PC-8201A USER'S GUIDE" about the shape and pin connection of the BAR Code interface and electric specification.

You may connect any Bar Code Pen to this interface. But NEC recommends the products of YHP (YOKOGAWA HP) or (MECANO Kogyo) and it is better that the Pen has the Power switch, for saving the electric power of the PC-8201A.

The data line of Barcode Reader is connected to Pin-2 of BCR. And this pin is connected to the RST5.5 of CPU (80C85) and Port C-3 of 81C55 as shown below.

<!-- FIGURE 13.1: barcode reader pin/connection diagram — LOST in OCR, needs vision re-OCR from source page 221-222 -->

```text
             .   ~~B

             ~ G-~G-~e - - , 1?1~
                     5 ,...,___
                            7711
                 'Ice.                          Fi'i~ {3.1
```

While the Bar-code Reader is powered on, PIN-2 is kept as low level, and RST5.5 is High.

BLACK BAR is represented by logical Low, SPACE BAR by High respectively.

## 13.2 Theory of Operation

This section describes the basic sequence of reading data from the Bar-code Reader.

1. If power on, RST5.5 is activated. At the first point of the RST5.5 routine which is interrupted by RST5.5 disable all interrupts.
2. Poll the Bar-Code DATA port. And calculate the duration of same status and save the status and duration.
3. If Low level continues too long, assume that Power off and enable.
4. Decode the gotten data and transfer the data to the upper routine.
