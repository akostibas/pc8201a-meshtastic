# Chapter 14: Parallel Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 223-227). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.
> Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.

This chapter describes how to control the Printer Interface of the PC-8201A. It is the Centronics compatible 8-bit parallel interface.

## 14.1.1 Physical Interface of the PC-8201A

The PC-8201A has the Centronics compatible parallel interface. It uses a 26-pin connector. Refer to the PC-8201A USER'S GUIDE for pin connections and signal names.

## 14.1.2 I/O Port for the Printer Interface

### 14.1.2.1 Port A — Data Output Port for Printer

<!-- TODO(tier-b): port/register addresses garbled — re-OCR from source page 223 -->
```text
   msb 7   6   5   4   3   2   1   0 lsb
     +---+---+---+---+---+---+---+---+
     :Po7:Po6:Po5:Po4:Po3:Po2:Po1:Po0:  OUT Axs9
     +---+---+---+---+---+---+---+---+
```

P07 to P00 — DATA output to Printer.

> **NOTE:** This port is also used by another user.

### 14.1.2.2 Port C — BUSY, SLCT Signal Read

<!-- TODO(tier-b): port/register addresses garbled — re-OCR from source page 223 -->
```text
   msb 7   6   5   4   3       2       1   0 lsb
     +--+--+--+--+--+----+----+----+
     :xx:xx:xx:xx:xx:susv:sLCT: xx:  IN Axse
     +--+--+--+--+--+----+----+----+
```

<!-- TODO(tier-b): bit label "susv" at bit 2 is garbled — likely BUSY; re-OCR from source page 223 -->

- BUSY — 0: Printer READY; 1: Printer BUSY
- SLCT — 0: Deselect; 1: Select

### 14.1.2.3 SCP (System Control Port) — STROBE Output Port

<!-- TODO(tier-b): port/register addresses garbled — re-OCR from source page 223 -->
```text
   msb 7   6     5   4   3   2   1   0 lsb
     +--+--+----+--+--+--+--+--+
     :xx:xx:PsTs:xx:xx:xx:xx:xx:  OUT Ax90
     +--+--+----+--+--+--+--+--+
```

<!-- TODO(tier-b): bit label "PsTs" at bit 5 is garbled — likely PSTB; re-OCR from source page 223 -->

- PSTB — 0: Strobe OFF; 1: Strobe ON

## 14.1.3 Basic Theory of Writing Data to Centronics

The basic sequence to write data to the Centronics printer is as follows:

1. If the Printer is busy, wait a while. Otherwise go ahead.
2. Output a byte to the data lines and hold it.
3. Change the strobe level to low.
4. Wait an adequate duration holding the DATA.
5. All has been done, then finish; else repeat from (1).

The timing chart illustrates the sequence.

<!-- FIGURE 14.1: parallel I/O timing — needs vision re-OCR from source page 224 -->
```text
        Parallel __ xxxxxxxxxxxxxx ________ _
          DATA                ->:T1:<- ->: T2 l<-
          DATA
                          -------+
                                ->: T3 +-------------------
                                       :<-
          STROBE                  +-----+

                                        -------·--+
          BUSY
                         -------------+                    +-----
                            T1,T2 >= 1.0 uSec
                            1.0 uSec < T3 < 600uSec
                            Fig 14.1
```

Refer to the manual of the Printer for the actual duration of T1 to T3.

## 14.2 Software Specification

### 14.2.1 How To Write A Byte To The Printer

The tiny program shown below explains how to send a character to the parallel port. The sample program performs the same function as the BASIC command `LPRINT "ABCDEFGHIJ"`.

```asm
        ;-- Equates
SCP     EQU     'X90            ; System Control Port.
PORTA   EQU     'XB9            ; Printer Data Port.
PORTC   EQU     'XBB            ; Printer Status Port.
SYSSTAT EQU     'XFE44          ; SCP status.

START:
        LXI     H,BUF           ; Set PTR.
        MVI     C,10+2          ; Set data length.
PRINT:
        IN      PORTC           ; Get Printer status.
        ANI     6               ; Strip BUSY,SLCT bits.
        XRI     2               ; See if ready.
        JNZ     PRINT           ; If not, then wait.
        DI                      ; Inhibit disturb for Port A
                                ; of 8155S.
        MOV     A,M             ; Get character to Print.
        OUT     PORTA           ; Put data on the DATA line.
        LDA     SYSSTAT         ; Get SCP status.
        MOV     B,A             ; Save it.
        ORI     ""800100000     ; Set STROBE. <!-- ? binary literal garbled — re-OCR from source page 225 -->
        OUT     SCP
        MOV     A,B
        OUT     SCP
        MOV     B,'X03          ; Please set appropriate
                                ; value for your Printer.
WAIT:
        DCR     B
        JNZ     WAIT
        EI
        INX     H               ; Point to Next.
        DCR     C
        JNZ     PRINT
        RET
BUF:    DB      'ABCDEFGHIJ'
        DB      13,10
        END
```
