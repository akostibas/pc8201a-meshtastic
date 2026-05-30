# Chapter 10: Keyboard Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 184–191). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as authoritative.

The Keyboard matrix of PC-8201A is as follows.

<!-- FIGURE 10.1: keyboard matrix — LOST in OCR, needs vision re-OCR from source page 184 (target: table) -->

```text
                                                           i--?A.1
                                                       l
                                                ·i-------·'----f80
                                      Fig 10.1
```

The abbreviation PAn (PA7, PA6, …, PA0) and PBn means the bit of PORT A and B of 81C55. Please refer to the following sections about I/O ports. And also, KDn (KD7, KD6, …, KD0) represents the bit of the KEYIN, Input port for the Keyboard.

Note: `•;•` means \<SHIFTED CODE\> / \<UNSHIFTED CODE\>

## 10.1.2 Keyboard Strobe — Part A/B of 81C55

<!-- TODO(tier-b): verify register-map table against source page 185 -->

```text
msb 7   6   5 4 3 2 1 0 lsb
  +---+---+---+---+---+---+---+---+
  :KS7:KS6:KS5:KS4:KS3:KS2:KS1:KS0:   OUT 'XB9
  +-------------------------------+
  : X : X : X : X : X : X : X :KS8:   OUT 'XBA
  +-------------------------------+
```

KS8 … KS0 — KEYBOARD Strobe

- 0 = Strobe OFF
- 1 = Strobe ON

```text
msb 7   6   5 4 3 2 1 0 lsb
  +---+---+---+---+---+---+---+---+
  :KD7:KD6:KD5:KD4:KD3:KD2:KD1:KD0:   IN 'XEB
  +---+---+---+---+---+---+---+---+
```

<!-- TODO(tier-b): verify OUT/IN port addresses ('XB9, 'XBA, 'XEB) against source pages 185–186 -->

KD7 … KD0 — Keyboard data

- 0 = Depressed
- 1 = Not depressed

Read the strobed column of the keyboard. Please refer to KEY MATRIX shown before to understand the relation between KDn and key on the keyboard.

Key scan must be performed done by the interrupt, RST 7.5. The RST 7.5 pin of 80C55 is connected to the TP pin (No. 10) of calendar-clock (UPD1990). So that interrupt occurs every 4 msec in the standard system.

## 10.2 Software for Keyboard Operation

Basic Keyboard read sequence is as follows.

1. Turn on the strobe pulse to the desired column you want to read.
2. Read the column from KEYIN port.
3. Strobe off.

The following sample program shows how to read the Keyboard in detail.

### 10.2.1.1 Sample Program Reading Keyboard

The following sample program reads every column and saves the data into KYBUF (Keyboard Buffer).

```asm
;
; Read CURRENT KEYBOARD STATUS
;
; Note: Make sure Keyboard strobe is
;       not disturbed while reading the keyboard.
;       You have to take care of the other interrupts.
;
; Equates
PORTA   EQU     'XB9        ; Keyboard Strobe Port
PORTB   EQU     'XBA        ;   ditto
KEYIN   EQU     'XEB        ; Keyboard data Port

        ORG     'XF000
READKEY:
        LXI     B,KYDATA    ; Get PTR for buffer
        MVI     A,'XFF      ; Disable normal key strobe
        OUT     PORTA
        IN      PORTB       ; Get PortB Status
        ANI     'XFE        ; Set B0=Off
        OUT     PORTB       ; Activate Strobe for
                            ;   Special key
        IN      KEYIN       ; Read keyboard
        STAX    B           ; Save Data
        IN      PORTB       ; Get Status of Port B
        ORI     'X01        ; Set B0=On
        OUT     PORTB       ; Strobe off
        MVI     A,'B11111110
NOMAL:
        INX     B           ; Prepare PTR for key Buffer
                            ;   for next data
        OUT     PORTA       ; Strobe On
        MOV     D,A
        IN      KEYIN       ; Get data
        STAX    B           ; Store it
        MVI     A,'XFF
        OUT     PORTA       ; Strobe off
        MOV     A,D         ; Retrieve strobe data
        RLC                 ; Strobe for next column
```

<!-- TODO(tier-b): page break here; continuation of READKEY routine from source page 187 — raw fragment below -->

```text
      • JC    NOMAL
        RET                            ; All done return to caller.

                                ·-  ,• PB0
      ' DS    1                           column
        DS     1                    ,• PA0 ditto
        DS     1                       • PA1     ditto
        DS     1                       '• PA2    ditto
        DS     1                        '• PA3 ditto
        DS     1                        '• PA4 ditto
        DS     1                       •' PA5 ditto
        DS     1                       '• PA6 ditto
        DS    1                        ,•' PA7 ditto
                                         •, Be careful that
                                        •, Bit OFF means key
                                          • is depressed
        END
```
