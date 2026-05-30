# Chapter 9: LCD Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 154–183). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> **Do not treat numeric/tabular values here as authoritative.**

## 9.1 Overview

The LCD (LR-202C), full bit map screen which consists of 240 × 64 dots, displays 40 characters per line and 8 lines per screen. A character on the LCD consists of 6 by 8 pixels. The LCD is driven by 10 Segment Drivers (HD44102B) with 200 bytes Display RAM and 2 Common Drivers (HD44023B). Segment Drivers are selected by Port A/B of PPI (81C55).

<!-- FIGURE 9.1: LCD block layout showing B1–B10 arranged in two rows across 240 dots × 64 dots — needs vision re-OCR from source page 155 (target: mermaid or table) -->
```text
                 :<------- 240 dots-------------------->:
            -----+-------~-------------------------------+
                       I
                       I

                    B1 : B2       B3       B4      B5

     64 dots+---------------------------------------+
                       I
                       I

                   B6:     B7       B8         B9             B10

        -----+---------------------------------------+
                      Fig 9.1
```

## 9.2 Construction of LCD

The LCD is divided into the following IC blocks. Each block has its own Segment Driver with 200 bytes Display RAM. And each IC block can display 50 × 32 dots. However, B5 and B10 display only 40 × 32 dots. Of course, you can write dots on the remaining area of Display RAM of B5 and B10 with no error, but they will never appear on the screen.

The Display RAM may be regarded as the VRAM in the traditional desk top type personal computer. Setting a Bit On/Off in the Display RAM means setting/resetting a dot on the LCD.

Refer to following sections for how to control each Segment Driver.

## 9.3 I/O Port Related to LCD

### 9.3.1 Block Select — PPI 81C55 Port A/B

<!-- TODO(tier-b): verify register bit table against source page 156 -->
```text
msb 7   6   5   4   3   2   1   0 lsb
  +---+---+---+---+---+---+---+---+
  |PA7|PA6|PA5|PA4|PA3|PA2|PA1|PA0|          OUT 'XB9
  +-------------------------------+
  | X | X | X | X | X | X |PB1|PB0|          OUT 'XBA
  +------------------------------+
  PA0 to PA7 is associated to BLOCK1 to BLOCK8
  PB0, PB1 to BLOCK9, 10 respectively.
  0 = Not Select / 1 = Select
```

Description: Selecting a LCD Block (same meaning as selecting a Segment Driver IC) which you want to access. You cannot select two blocks at a time.

### 9.3.2 LCD Command Set

There are 5 commands to control the Segment Driver IC. These commands are executed via Port `'XFE`.

#### 9.3.2.1 Display ON/OFF

<!-- TODO(tier-b): verify register bit table against source page 156 -->
```text
msb 7   6   5   4   3   2   1    0   lsb
  +---+---+---+---+---+---+---+------+
  | 0 | 0 | 1 | 1 | 1 | 0 | 0 | DISP |     OUT 'XFE
  +---+---+---+---+---+---+---+------+

  DISP:    Display ON/OFF
                   0 = Display Off
                   1 = Display On
```

Description: DISP decides whether the data in Display RAM is displayed on the screen. This port does not affect the contents of Display RAM.

#### 9.3.2.2 Set Address Counter

<!-- TODO(tier-b): verify register bit table against source page 157 -->
```text
msb 7   6   5   4   3   2   1   0 lsb
  +---+---+---+---+---+---+---+---+
  |PG1|PG0|OF5|OF4|OF3|OF2|OF1|OF0|
  +---+---+---+---+---+---+---+---+

  Select PAGE
   PG1    PG0
    0      0          PAGE0
    0      1          PAGE1
    1      0          PAGE2
    1      1          PAGE3
  OFn means 'OFfset counter' in each PAGE.
  It must be from 0 to 49.
```

The Display RAM is divided into 4 (0 to 3) pages and each page contains 50 bytes (0 to 49) as shown at next page. The Segment Driver has a PAGE counter and OFFSET Counter. These counters are set by this command. The OFFSET counter works as the loop counter; its value runs from 0 to 49. The OFFSET counter is automatically Incremented/Decremented after a read/write operation. The counter mode is described below. The Page counter is not changed by a read/write operation.

<!-- FIGURE 9.2: PAGE/OFFSET Display RAM map showing 4 pages (address bits 'B00/'B01/'B10/'B11) each spanning OFFSET 0–49 (0–39 for B5/B10) — needs vision re-OCR from source page 157 (target: mermaid or table) -->
```text
                              OFFSET counter
        PAGE           0<------------------->49(39 if B5/B10)
        counter-   +---+-------------------+
                   : lsb:                         |
                                                  |
        'B00       |
                   |
                           |
                           |        PAGE 0
                   :msb|
                   +---+---~---------------+
                   | lsb                          |
                                                  |
        'B01       |
                   |                PAGE 1
                   |msb
                   +-----------------------+
                   : lsb
        'B10       |
                   |                PAGE 2
                   :msb
                   +-----------------------+
                   :msb
        'B11                       PAGE 3
                   : lsb
                   +-----------------------+
                   Fig 9.2
```

#### 9.3.2.3 Set Starting Page

<!-- TODO(tier-b): verify register bit table against source page 158 -->
```text
msb 7    6    5   4   3   2   1   0 lsb
  +----+----+---+---+---+---+---+---+
  |SPG1|SPG0| 1 | 1 | 1 | 1 | 1 | 1 |          OUT 'XFE
  +----+----+---+---+---+---+---+---+

  SPG1/0:    Specify the Starting Page to be displayed on LCD.
            SPG1 SPG0       Order of Display Page
            0     0         0 -> 1 -> 2 -> 3
            0     1         1 -> 2 -> 3 -> 0
            1     0         2 -> 3 -> 0 -> 1
            1     1         3 -> 0 -> 1 -> 2
```

Description: Assume that each LCD block is divided into 4 pages corresponding with the Display RAM. The combination between the Page of LCD Block and Display RAM page can be changed. The "SET STARTING PAGE" defines the mapping between the Page in Display RAM and the Page of LCD Block.

Example: Assume that Starting Page is set to 2. Then the mapping between Display RAM and LCD PAGE becomes as shown below.

<!-- FIGURE 9.3: LCD Block page-mapping diagram showing Starting Page=2 mapping — needs vision re-OCR from source page 159 (target: mermaid or table) -->
```text
        -LCD BLOCK
        Upper    +-----------------------+

                     PAGE2 in Display RAM
                      is displayed here

                +-----------------------+
                     PAGE3 in Display RAM
                      is displayed here

                +-----------------------+
                     PAGE0 in Display RAM
                      is displayed here

                +-----------------------+
                     PAGE1 in Display RAM
                      is displayed here

        Lower   +-----------------------+
                Fig 9.3
```

#### 9.3.2.4 Select Address Counter Mode

<!-- TODO(tier-b): verify register bit table against source page 160 -->
```text
msb 7   6   5   4   3   2   1   0
  +---+---+---+---+---+---+---+---+
  | 0 | 0 | 1 | 1 | 0 | 0 | 1   |U/D|   OUT 'XFE
  +---+---+---+---+---+---+---+---+

        U/D (Up/Down count) --- 0 = Up Count
                                1 = Down count
```

Description: Set OFFSET Counter Mode.

### 9.3.3 Read Status — Read the Status of Segment Driver

<!-- TODO(tier-b): verify register bit table against source page 160 -->
```text
msb 7        6       5        4       3-0   lsb
 +----+-------+------+-----+-----+
 |BUSY|UP/DOWN|ON/OFF|RESET|XXXX|   IN 'XFE
 +----+-------+------+-----+-----+
 RESET
    0            -----    Status of the RST pin
                          Normal
    1                     RST is low level
                          (BUSY must be 1)
 ON/OFF
    0            -----    Display ON/OFF
                          Display OFF
    1                     Display ON
 UP/DOWN
    0            -----    Mode of Address counter
                          Down counter
    1                     Up counter
 BUSY
    0            -----    Normal
    1                     Operating Command or
                          Writing/Reading a data.
```

### 9.3.4 Write/Read Display Data

<!-- TODO(tier-b): verify register bit table against source page 161 -->
```text
  +--+--+--+--+--+--+--+--+
  |D7|D6|D5|D4|D3|D2|D1|D0|          IN/OUT 'XFF
  +--+--+--+--+--+--+--+--+
```

Description: Read the data from the Display RAM that is pointed to by the PAGE and OFFSET counter. If you want to read some portion of the Display RAM, use this command after setting the PAGE counter and OFFSET counter by the "Set Address Counter" command and "Set Page Counter" command described before. Note that one dummy read must be done before using this command in order to get correct data.

## 9.4 Software for LCD

This section describes not only how to handle the LCD without reading the routines stored in ROM #0 about LCD, but also how to maintain the bookkeeping area for LCD in the RAM.

### 9.4.1 How To Initialize the LCD

What should be done in initialization is the following:
1. Set up Address counter. Usually Page 0, Offset 0.
2. Set up Offset Counter Mode.
3. Set up Starting Page.
4. Select Display ON/OFF.

The tiny program shown below initializes LCD's all Segment Drivers as follows:

- PAGE COUNTER = 0
- OFFSET COUNTER = 0
- UP COUNTER MODE
- STARTING PAGE = 0
- DISPLAY ON

Note: Whenever the power is turned on, LCD is initialized by the reset pulse of the hardware. At that time, Display is turned OFF, Offset Counter is set to count up mode. Another status is not determined.

The ROM #0 always reinitializes LCD as Display ON, Starting Page = 0 and Offset counter count up mode when a character is displayed.

#### 9.4.1.1 Sample Program For LCD Initialization

```asm
; Initialize Segment driver.

; Equates
PORTA   EQU     'X089
PORTB   EQU     'X08A
LCDCOM  EQU     'X0FE
LCDSTAT EQU     'X0FE

LCDINIT:
        DI                      ; Inhibit disturbance for Port A/B
        CALL    SELALL          ; Select all Segment Drivers.
        CALL    LCDBUSY         ; Wait until LCD become Ready.
        XRA     A
        OUT     LCDCOM          ; Reset Address Counter.
        CALL    LCDBUSY
        MVI     A,'X38          ; Offset counter Up mode.
        OUT     LCDCOM
        CALL    LCDBUSY
        MVI     A,'X3E          ; Set starting PAGE=0
        OUT     LCDCOM
        CALL    LCDBUSY
        MVI     A,'X39          ; Display ON.
        OUT     LCDCOM

LCDBUSY:
; Wait until LCD become Ready.
        IN      LCDSTAT         ; Get LCD status.
        RLC                     ; Move MSB to CF.
        JC      LCDBUSY         ; Wait if LCD is busy.
        RET

SELALL:
; Select all Segment Drivers
        MVI     A,'XFF
        OUT     PORTA           ; S9h
        IN      PORTB           ; Get current status.
        ORI     03              ; Select block 9,10.
        OUT     PORTB
        RET
        END
```

### 9.4.2 How To Write A Character

Writing a character on the LCD is performed by writing some bit patterns in the Display RAM of the Segment Driver.

Basic sequence of writing a character on the LCD is as follows:

1. Select LCD Block (Segment Driver) which you want to PUT a character.
2. Set the Offset counter mode. (Usually Up mode)
3. Set the Address where 1st byte should be written.
4. Write the Bit pattern.
5. Set Starting PAGE counter.
6. Insure Display ON.

See the next sample program.

#### 9.4.2.1 Sample Program Of Writing A Character On The LCD

This sample program shows how to write a character on the LCD. This routine updates the pointers which are used by System ROM, ROM #0, to maintain the system state.

```asm
; Sample program to write a character on LCD.
; This program performs same function as the following BASIC program:
;
; 10 LOCATE 0,0
; 20 PRINT "A"
; 30 END

CSRY    EQU     'XF3E5                  ; Cursor Y position (1 to 8)
CSRX    EQU     'XF3E6                  ; Cursor X position (1 to 40)
LCTEY   EQU     'XFEB9                  ; Character Y Position (0 to 7)
LCTEX   EQU     'XFEBA                  ; Character X Position (0 to 39)
PORTA   EQU     'XB9                    ; Segment Driver Select Port.
PORTB   EQU     'XBA                    ; ditto
LCDCOM  EQU     'XFE                    ; LCD command Port.
LCDSTAT EQU     'XFE                    ; LCD Status Port.
LCDIO   EQU     'XFF                    ; LCD data I/O Port.
        ORG     'XF000                  ; 614400

LOCATE:
; LOCATE 0,0
        LXI     H,'X0101                ; To set cursor position (0,0)
        SHLD    CSRY
        LXI     H,'X0000
        SHLD    LCTEY

PREP:
;-- Select Block 1 to write (1,1)
        DI                              ; Inhibit disturbance for
                                        ; Port A/B of 81C55.
                                        ; You need not do DI as far as
                                        ; no one changes the data port of
                                        ; 81C55. You have to consider
                                        ; other INT routines.
        MVI     A,'X01
        OUT     PORTA                   ; Select Block 1
        IN      PORTB                   ; Get current status.
        ANI     'B11111100              ; Deselect Block 9/10.
        OUT     PORTB
        CALL    LCDBUSY                 ; Wait until LCD become ready.
        MVI     A,0
        OUT     LCDCOM                  ; Page 0, offset 0.

        CALL    LCDBUSY
        MVI     A,'B00110010            ; Offset counter Up mode.
        OUT     LCDCOM
CHROUT:
        LXI     H,FONTA                 ; Get start Address of Font A.
        MVI     C,'X06                  ; Set Font size.

WRITE:
; Write data to Display RAM of LCD
; ENTRY:   [HL] = Font start address.
;          [C]  = Length of Font.
        CALL    LCDBUSY                 ; Wait until LCD become Ready.
        MOV     A,M                     ; Get font pattern to send.
        OUT     LCDIO                   ; Write to Display RAM of LCD.
        INX     H                       ; Update PTR.
        DCR     C                       ; Bump Counter.
        JNZ     WRITE                   ; To send next pattern.
                                        ; Offset counter is Auto
                                        ; increment Mode, so we don't
                                        ; care about OFFSET counter.
        LXI     H,CSRX                  ; Update Cursor PTR.
        INR     M                       ; No check for end of line in
                                        ; this program.
        LXI     H,LCTEY
        INR     M

;---- Set starting page --------
        MVI     A,'X0FF                 ; Select all Blocks.
        OUT     PORTA
        IN      PORTB
        ORI     'B00000011
        OUT     PORTB
        CALL    LCDBUSY                 ; Wait until LCD become Ready.
        MVI     A,'X3F                  ; Starting page 0.
        OUT     LCDCOM
        MVI     A,'B00111001            ; Insure display ON.
        OUT     LCDCOM
        EI
        RET

LCDBUSY:
        IN      LCDSTAT                 ; Get LCD status.
        RLC                             ; Move msb to CF.
        JC      LCDBUSY
        RET

FONTA:  DB      'X3C,'X12,'X11         ; Font data for 'A'
        DB      'X12,'X3C,'X00
        END
```

### 9.4.3 How To Set/Reset A Dot On The LCD

The sample program shown below explains how to set/reset a dot on the LCD. It does the same function as the following BASIC program:

```basic
100 CLS
110 FOR Y=9 TO 22
120   FOR X=60 TO 80
130     PSET(X,Y)
140   NEXT X
150 NEXT Y
160 '
170 FOR Y=14 TO 18
180   FOR X=64 TO 76
190     PRESET(X,Y)
200   NEXT X
210 NEXT Y
220 END
```

#### 9.4.3.1 Sample Program For SET/RESET Dot

```asm
; Sample program for SET/RESET a Dot.

PORTA   EQU     'XB9                ; LCD block select.
PORTB   EQU     'XBA                ; ditto
LCDCOM  EQU     'XFE                ; LCD command.
LCDSTAT EQU     LCDCOM              ; LCD status.
LCDIO   EQU     'XFF                ; LCD data I/O.

PSET:
        DI                          ; Disable all interrupts
                                    ; to keep correct block select.
        XRA     A                   ; To set SET flag.
        STA     SR                  ; Set/Reset Flag.

        LXI     B,'X140E            ; [B]=20 X count, [C]=14 Y count.
        LXI     H,'X0A09            ; [H]=X Position, [L]=Y Position.
PSET1:
        PUSH    H                   ; Save (X,Y) Position.
        PUSH    B                   ; Save X,Y count.
        CALL    MAIN
        POP     B                   ; Restore X,Y count.
        POP     H                   ; Restore X,Y position.
        INR     L                   ; Advance Y position.
        DCR     C                   ; Bump Y counter.
        JNZ     PSET1
PRESET:
        MVI     A,'XFF              ; To set SR Flag.
        STA     SR                  ; Set Unplot Flag.
        LXI     B,'X0C06            ; [B]=12, [C]=06
        LXI     H,'X0E00            ; [H,L]=(14,13)
PRESET1:
        PUSH    H                   ; Save X,Y Position.
        PUSH    B                   ; Save X,Y counter.
        CALL    MAIN
        POP     B                   ; Restore X,Y counter.
        POP     H                   ; Restore X,Y position.
        INR     L                   ; Advance Y position.
        DCR     C                   ; Bump Y counter.
        JNZ     PRESET1
        RET
MAIN:
;   [H] = X position
;   [L] = Y Position
;   [B] = X count
;   [C] = Y count
        PUSH    H                   ; Save X,Y Position.
        CALL    DOT                 ; Plot/Unplot a dot at (X,Y)
        POP     H                   ; Retrieve Position.
        INR     H                   ; Advance X Position.
        DCR     B                   ; Bump X counter.
        JNZ     MAIN
        RET
DOT:
        CALL    LMAIN
        LDA     SR                  ; Get SR flag.
        ORA     A                   ; See if set/reset?
        JNZ     RESET               ; Branch if Reset.
        MOV     A,E                 ; Get MASK pattern.
        ORA     D                   ; [A] = data to write.
        JMP     DISP
RESET:
        MOV     A,E                 ; Get Mask Pattern.
        XRI     'XFF                ; Reverse MSK pattern.
        ANA     D                   ; [A] = data to write.

DISP:
        MOV     D,A
        CALL    WRITE
        DI
        MVI     A,'XFF              ; Select all Blocks.
        OUT     PORTA
        IN      PORTB
        ORI     'B00000011
        OUT     PORTB
        CALL    LCDBUSY             ; See if LCD Busy.
        MVI     A,'B00111111        ; Starting Page 0
        OUT     LCDCOM
        CALL    LCDBUSY
        MVI     A,'B00111001        ; Display ON.
        OUT     LCDCOM
        EI
        RET

LMAIN:
; ENTRY: [H] = X position in Block-1
;        [L] = Y Position in Block-1
; Reg:
        PUSH    H                   ; Save X,Y position.
        PUSH    H
        CALL    SEL2                ; Select Block-2.
        CALL    SETADR              ; Set Address of Display RAM.
        CALL    READ                ; Read the LCD.
        POP     H                   ; Retrieve X,Y position.
        CALL    GETMSK              ; Get Mask Pattern.
        POP     H                   ; Retrieve (X,Y) Position.
        CALL    SETADR
        RET
WRITE:
; Func: Output [D] to LCD.
; Reg: A and Flags.
        CALL    LCDBUSY
        MOV     A,D                 ; Get Data to Write.
        OUT     LCDIO
        NOP                         ; Must be EI at final.
        RET
READ:
; Entry: None
; Exit:  [D] = Current Data in Display RAM.
; Reg:   A, D and Flags.
        CALL    LCDBUSY             ; Wait until LCD become Ready.
        IN      LCDIO               ; Dummy Read. You must do this
                                    ; to get correct data.
        CALL    LCDBUSY
        IN      LCDIO               ; Get Valid Data.
        MOV     D,A                 ; Save it.
        RET
GETMSK:
; Entry: [L] = Y Position
; Exit:  [E] = Mask Pattern.
; Reg:   A, L, E and Flags.
        MOV     A,L                 ; Get Y position.
        ANI     'B00000111
        MOV     L,A                 ; Set counter.
        MVI     A,'B80
MSK1:
        RLC
        DCR     L                   ; Bump counter.
        JP      MSK1                ; Branch if not finished.
        MOV     E,A                 ; Save Mask pattern.
        RET
SETADR:
; ENTRY: [H] = X Position on Block-2
;        [L] = Y Position on Block-2
; Register:
;        A, H, L and Flags.
        MOV     A,L                 ; Get Y position.
        RAL                         ; Move Bit4/3 to Bit7/6.
        RAL
        RAL
        ANI     'B11000000          ; Get page.
        ORA     H                   ; [A] = Page and OFFSET.
        MOV     L,A                 ; Save it.
        CALL    LCDBUSY             ; Wait until LCD become Ready.
        MOV     A,L                 ; Retrieve Address.
        OUT     LCDCOM
        RET
LCDBUSY:
; Entry: None
; Func:  Wait until LCD become Ready.
; Exit:  None
; Reg:   A and Flags.
        IN      LCDSTAT             ; Get LCD status.
        RLC                         ; Set Busy FLG to CF.
        JC      LCDBUSY             ; Wait if LCD is BUSY.
        RET
SEL2:
; Select Block-2
; Reg: A and Flags.
        DI
        MVI     A,'B00000010        ; Select Block-2
        OUT     PORTA
        IN      PORTB
        ANI     'B11111100
        OUT     PORTB
        RET

SR:     DB      00                  ; Set/Reset flag. 0=set / FF=reset.
        END
```

### 9.4.4 How To Define A Character

This section describes how to define the User Definable characters in PC-8201A, and how to store them in a portion of RAM where ROM #0 can use these new Fonts. In this section, BASIC command will be used to do some operations.

#### 9.4.4.1 Structure Of Character And How To Define It

One character consists of 6 × 8 dots. Vertical 8 dots is handled by a byte. So in order to define a character, you must define sequential 6 bytes of data. The data `'X3C, 'X12, 'X11, 'X12, 'X3C, 'X00` define "A" as follows:

```asm
DB      ('X3C, 'X12, 'X11, 'X12, 'X3C, 'X00)
        ; CG pattern for 'A'
```

<!-- FIGURE 9.4: Character dot-matrix diagram showing DATA Pattern (6 columns × 8 rows bit table) alongside Font Pattern (* dot display) for character "A" — needs vision re-OCR from source page 175 (target: markdown table or ASCII grid) -->
```text
DATA Pattern                                     Font pattern
        0    1   2    3   4   5               0   1   2   3   4   5
lsb +---+---+---+---+---+---+           +---+---+---+---+---+---+
 0  : 0 : 0   1 : 0 : 0 : 0
    +---+---+---+---+---+---+
                                                    : * :
                                            +---+---+---+---+---+---+
 1  : 0 : 1 : 0 : 1 : 0 : 0 :
    +---+---+---+---+---+---+
                                                  * :   : * :
                                            +---+---+---+---+---+---+
 2  : 1 : 0 : 0 : 0 : 1 : 0             : * :               * :
    +---+---+---+---+---+---+           +---+---+---+---+---+---+
 3  : 1 : 0 : 0 : 0   1   0           : * :     :   : * :   :
    +---+---+---+---+---+---+           +---+---+---+---+---+---+
 4  : 1   1   1 : 1 : 1               : * : * : * : * : * :
    +---+---+---+---+---+---+           +---+---+---+---+---+---+
 5    1 : 0 : 0 : 0 : 1 : 0
    +---+----+---+----+---+---+
                                            : * :           : * :
                                            +---+---+---+---+---+--+
 6                       1 : 0            : * :            : * :
    +---+---+---+---+---+---+             +---+---+---+---+---+---+
 7  : 0 : 0 : 0 : 0 : 0 : 0

msb +---+---+---+---+---+--+            +---+---+---+---+---+---+

                      Fig 9.4
```

### 9.4.5 How To Store Your Own CG

This section explains how to store USER CG into RAM which can also be used by ROM #0.

Assume that you have to define Fonts as described in the previous section. Each Font consists of 6 bytes. Font Data has been BSAVEed in the RAM file named "FONT.CO", whose start address is `'XYYZZ`.

You can make "FONT.CO" in the following sequence:

1. Reserve area for "FONT.CO" by CLEAR command in BASIC.

   ```basic
   CLEAR <length>, <startaddress>
   ```

2. Load "FONT.CO" into RAM.

   ```basic
   BLOAD "FONT"
   ```

3. Register the top address of the CG.

   ```basic
   POKE 'X065216, <Start Address (High byte)>
   POKE 'X065215, <Start Address (Low byte)>
   ```

After this sequence, ROM #0, for instance BASIC, can use the newly defined CG.

## 9.5 Available System Work Area

This section explains how to use the system Character Generator and how to use the available System work area.

### 9.5.1 How To Use The CG In System ROM

You might want to use the CG of ROM #0 instead of making new CG by yourself. In such a case, this section will help you.

The Character Generator of characters whose code is from `'X20` to `'X7E` are stored in the highest portion of ROM #0, from `'X7887` to `'X7837`. Each Character consists of 5 bytes. The sample program shown below explains how to get the character pattern and how to expand it into the standard shape, 6 × 8 pixels. Assume that this program is written to be stored as the CO file in the RAM files and will be executed with ROM #0.

```asm
; ENTRY [A] = Character Code ('X20 to 'X7E)

EXPAND:
        SUI     A,'X20
        MOV     C,A
        ADD     C               ; *2
        ADD     A               ; *4
        ADD     C
        MOV     C,A             ; [C] = offset from base of CG.
        MVI     B,'X00
        LXI     H,CGADR
        DAD     B
        LXI     B,TEMP
        MVI     D,'X5           ; Set font data length.
NEXT:
        MOV     A,M             ; Get Font data.
        STAX    B
        INX     H
        INX     B
        DCR     D
        JNZ     NEXT
        ORA     A
        STA     TEMP+5
        RET
```

### 9.5.2 VRAM Area In System Work Area

The area from `'XFBC0` to `'XFE3F` in the RAM is reserved for the VRAM area of the LCD. It is divided into 2 portions. Each portion can hold the character codes displayed on the LCD at a time. So each portion has 320 bytes. The attribute data is not saved in this area. Only the character code is stored.

- 1st: `'XFBC0`–`'XFCFF` — Keep previous Page in TELCOM.
- 2nd: `'XFD00`–`'XFE3F` — Current Displayed.

The character code of the character displayed at location (1,1) on the LCD display is stored at `'XF000`, and the code of the character at (2,1) is stored at `'XFBC1`, and so on. So the code of the left-lowest character, (40,8), is stored at `'XFCBF`<!-- TODO(tier-b): verify this address — source says 'XFC3F which may conflict with the 1st-region end 'XFCFF; re-check source page 182 -->. This rule is used in the standard program in ROM #0. For instance, BASIC, TEXT and TELCOM use that area like a VRAM in the traditional desk-top personal computer. The menu screen also utilizes that area. But you can use this area as you like. The data in this area does not affect the information on the LCD display, as long as you use your own display routine.

### 9.5.3 Reverse The Attribute Of The Specified Area

ROM #0 has the Reverse Attribute Table in Work Area.

The attribute data is kept in the area from `'XFA60` to `'XFA87`. Each bit represents each character box on the LCD. (Therefore only 40 bytes are needed to handle the attribute of the whole LCD screen.) When the bit is off (0), it shows that the character box is displayed in normal mode. When the bit is turned on (1), that character box is displayed in Reverse mode. The relation between the Attribute bit and Character Box is shown below. The relation of the reverse attribute bit and each character box is as follows:

<!-- TODO(tier-b): verify attribute table against source page 183 -->
```text
+---------------------------------------------+
|(1,1)|(2,1)|(3,1)|           |(39,1)|(40,1)|
+---------------------------------------------+
|(1,2)|(2,2)|(3,2)|           |(39,2)|(40,2)|
+---------------------------------------------+

+---------------------------------------------+
|(1,8)|(2,8)|(3,8)|           |(39,8)|(40,8)|
+-----------------------------------------+
'XFA60   Bit0            (01,1)
         Bit1            (02,1)
         Bit2            (03,1)
         Bit3            (04,1)
         Bit4            (05,1)
         Bit5            (06,1)
         Bit6            (07,1)
         Bit7            (08,1)
'XFA61   Bit0            (09,1)
         Bit1            (10,1)
         ...
'XFA87   Bit0            (33,8)
         Bit1            (34,8)
         Bit2            (35,8)
         Bit3            (36,8)
         Bit4            (37,8)
         Bit5            (38,8)
         Bit6            (39,8)
         Bit7            (40,8)
```
