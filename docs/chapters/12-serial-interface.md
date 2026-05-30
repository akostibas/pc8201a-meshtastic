# Chapter 12: Serial Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 205-220). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as authoritative.

PC-8201A has 3 channels of Serial Interface. They are used by RS-232C, SIO1, SIO2. The difference between SIO1 and SIO2 is only the shape of connector.

This chapter describes how to control the Serial Port.

## 12.1 Hardware of Serial Interface

UART (6402) and PPI (81C55) control the Serial Interface.

Since they are shared by 3 channels, only one channel is available at a time. Refer to the "PC-8201A USER'S GUIDE" about capacity of the hardware.

### 12.1.1 I/O Port

#### 12.1.1.1 Channel Select — (System Control Port)

I/O Address and Data Pattern:

```
msb 7     6        5 -- 0
  +----+----+------------+
  :SRI2:SRI1: XXXXXXXXXX :           OUT "X90
  +----+----+------------+
```

SRI2/1 — Serial Interface Select:

| SRI2 | SRI1 | User              |
|------|------|-------------------|
| 0    | 0    | Not Used          |
| 0    | 1    | SIO2 (Disk Driver)|
| 1    | 0    | SIO1              |
| 1    | 1    | RS-232C           |

Note: Current status of this port is saved in SYSSTAT ("XFE44) by System ROM.

#### 12.1.1.2 UART Mode Control

```
msb 7 - 5      4      3      2    1    0
  +-------+----+----+----+---+---+
  : XXXXX :CLS2:CLS1: PI :EPE:SBS:        OUT "XD8
  +-------+----+----+----+---+---+
```

**SBS** — Stop Bit Select:
- 0 = 1 bit
- 1 = 2 bits

(*) When Data length is 5 bits, Stop Bits is 1.5 bit.

**EPE** — Even Parity Enable:
- 0 = Odd Parity
- 1 = Even Parity

(Meaningless if PI = 1)

**PI** — Parity Inhibit:
- 0 = Parity Enable
- 1 = Parity Disable

**CLS2/1** — Character Length Select:
- "B00 = 5 bits
- "B01 = 6 bits
- "B10 = 7 bits
- "B11 = 8 bits

#### 12.1.1.3 UART Status Read

I/O Address and Data Pattern:

```
msb           4       3        2          1    0   lsb
  +-------+----+----+----+----+------+
  : XXXXX :TBRE: PE : FE : OE :dcd/dr-:                  IN "XD8
  +-------+----+----+----+----+------+
```

**dcd/dr-** — DCD/DR on/off (0=on / 1=off)

**OE** — Overrun Error (1=Detected)

**FE** — Framing Error (1=Detected)

**PE** — Parity Error (1=Detected)

**TBRE** — Transmit Buffer Register Empty:
- 1 = Ready to receive data to transmit.

#### 12.1.1.4 UART Baud Rate (PPI 81C55 Timer Section)

I/O Address and Data Definition:

```
msb 6      5 4   3   2   1   0 lsb
  +---+---+---+---+---+---+---+
  :M2 :T13:T12:T11:T10:T09:T00:        OUT "XB0
  +---+---+---+---+---+---+---+
      :T06:T05:T04:T03:T02:T01:T00:    OUT "XBC
  +---+---+---+---+---+---+---+
```

Specify timer output Mode:
- "B00 = Single Square Wave
- "B01 = Continuous Square Wave
- "B10 = Single Pulse On
- "B11 = Continuous Pulse

Set a Baud Rate using the value below:

<!-- TODO(tier-b): baud-rate table garbled — re-OCR from source page ~208. Header clipped to "ud Rate"; rows may contain duplicate/misread values. Raw OCR preserved below. -->

```
--------+---------+---------+
ud Rate : "XBC     : "XB0
--------+---------+---------+
    75      00          48
--------+---------+---------+
   150      68          45
--------+---------+---------+
   300      00          42
--------+---------+---------+
   600      00          41
--------+---------+---------+
  1200      80          40
---------+---------+---------+
  2400      40          40
---------+---------+---------+
  2400      40          40
---------+---------+---------+
  4800      20          40
----------+---------+---------+
  9600      10          40
----------+---------+---------+
 19200      08          40
-----------+---------+---------+
```

Fig 11.1 <!-- TODO(tier-b): figure label reads "Fig 11.1" in source — likely mislabeled; should be Fig 12.1 -->

NOTE: It is impossible to read the current UART status directly. ROM #0 always saves the new status in RAM when it is changed. Refer to Chapter 12.3.

#### 12.1.1.5 UART DATA I/O Port

I/O Port and Data Pattern:

```
msb                     lsb
+--+--+--+--+--+--+--+--+
:D7:D6:D5:D4:D3:D2:D1:D0: IN/OUT "XC8
+--+--+--+--+--+--+--+--+
```

Note: If the data length is less than 8 bits, output data must be right justified. Input data is right justified by UART.

## 12.2 Software Description

### 12.2.1 How To Initialize Serial Port

The basic sequence to initialize Serial Port is as follows:

1. Select Channel
2. Set Baud Rate.
3. Set transfer mode.

The following sample program shows the initialization sequence in more detail.

The sample program listed below explains how to initialize serial port. This sample program initializes the RS-232C Channel as 9600 bps, even parity, 7 bit data length, 1 stop bit and no control for Xon/Xoff, SI/SO. And it updates the work area so that ROM #0 can use the same mode. You may skip that portion if you want. There is no problem even if you skip the updating of the data, because ROM #0 always initializes the RS-232C port when entering Term mode or when the `OPEN "COM:"` BASIC command is issued via the Mode string.

#### 12.2.1.1 Sample Program: How To Initialize Serial Port

```asm
; Sample Program: Initialize Serial Port
;
; Data in system area which you must update.
SERMODE   EQU     "XF406               ; 6 bytes for MODE string.
          ;        "XF407               ; Parity Mode
          ;        "XF408               ; Word Length
          ;        "XF409               ; Stop bits
          ;        "XF40A               ; XON/XOFF control
          ;        "XF40B               ; SI/SO control
; INHDSP
; INHIBIT
COMACT    EQU     "XFE43               ; current user IO for serial port.
                                       ;  "X00 = Not used
                                       ;  "X01 = SIO2
                                       ;  "X10 = SIO1
                                       ;  "X11 = RS-232C
SYSSTAT   EQU     "XFE44               ; SCP port status.
BAUDRT    EQU     "XFE4A               ; Baud Rate Table entry address.
INHIBIT   EQU     "XFE41               ; 0 inhibits XON/XOFF control.
; I/O Port Address
SCP       EQU     "X90                 ; System Control Port.
PORTB     EQU     "XBA                 ; RTS/DTR set port.
TIMEL     EQU     "XBC                 ; Timer Set Low.
TIMEH     EQU     "XB0                 ; Timer Set High.

RTSDTR    EQU     "X3F                 ; RTS/DTR data for RS-232C.
                                       ; Use "XFF for SIO1/2.

INITSERI:
; ENTRY: C = USER IO.
;        B = Baud rate specifier. ASCII Number (1 to 9)
;               Same Number as "STAT" of TELCOM.

        ; See if Serial Port is available.
                  LDA     COMACT               ; Get current user IO.
                  ORA     A                    ; No one use Serial I/O?
                  JZ      SELECT               ; then branch.
                  CMP     C                    ; SAME USER?
                  JZ      SELECT               ; Then branch.
                  STC                          ; Set Error FLG.
                  RET                          ; Return to caller.

SELECT:
;    Reserve Serial Port
                  DI                           ; Inhibit all disturbance.
                  MOV     A,C                  ; GET USER ID.
                  STA     COMACT               ; Set User ID. Be sure reset
                                               ; User ID to 0 after all task
                                               ; finished, else the serial
                                               ; port can not be shared to
                                               ; another user.
                  RRC                          ; Move Bit0-1 to Bit 6-7
                  RRC
                  MOV     C,A                  ; Save it.
                  LDA     SYSSTAT              ; Get current SCP status.
                  ANI     "B00111111           ; cancel channel control
                  ORA     C                    ; Set new channel control bits
                  OUT     SCP                  ; Select channel
                  STA     SYSSTAT              ; Update SCP status.

;   Set BAUD RATE
SETBAUD:
                  MOV     A,B                  ; Get BAUD RATE ID.
                  STA     SERMODE              ; Update Baud rate Specifier.
                  SBI     '1'                  ; Convert to Binary Number.
                  RLC                          ; *2, Because table entry is
                                               ; 2 bytes
                  LXI     H,TIMTBL
                  MOV     C,B                  ; C = Offset
                  MVI     B,0
                  DAD     B
                  SHLD    BAUDRT               ; Save entry point for
                                               ; Music routine.
                                               ; Music routine in ROM #0
                                               ; temporarily changes
                                               ; the timer count and
                                               ; reinitializes it when
                                               ; finished.
                                               ; Refer Chapter 12.3
                  MOV     A,M                  ; Get Lower value.

                  OUT     TIMEL
                  INX     H
                  MOV     A,M                  ; Get Higher Value.
                  OUT     TIMEH
                  MVI     A,"XC3               ; To start timer.
                  OUT     "X88                 ; Use this value to start Timer.

; SET TRANSFER MODE.
MODE:
                  IN      PORTB
                  ANI     RTSDTR               ; IF 232C RTSDTR="X3F to
                                               ; activate RTS/DTR,
                  OUT     PORTB
                  IN      "XC8                 ; Dummy read to clear
                                               ; Receive Buffer Register
                  MVI     A,"B00001110         ; 7 bit, Even Parity, 1 stop bit.
                  OUT     "XD8                 ; Set Mode.

;      Update SERMODE
                  LHLD    SERMODE              ; Set ptr  <!-- TODO(tier-b): several MVI operands illegible in OCR; register/value fields blank in source -->
                  MVI     ...                  ; Set Parity check mode.
                  INX     H
                  MVI     ...                  ; Set Word length.
                  INX     H
                  MVI     ...                  ; Set Stop bit length.
                  INX     H
                  MVI     ...                  ; Set XON/OFF control mode.
                  INX     H
                  MVI     ...                  ; Set SI/SO control Mode.
                  XRA     A                    ; Set CF=0
                  STA     INHIBIT              ; Disable XON/XOFF control.
                  EI
                  RET

TIMTBL: DB       "X00,"X48            ;          75 bps
        DB       "X68,"X45            ;         150
        DB       "X00,"X42            ;         300
        DB       "X00,"X41            ;         600
        DB       "X80,"X40            ;        1200
        DB       "X40,"X40            ;        2400
        DB       "X20,"X40            ;        4800
        DB       "X10,"X40            ;        9600
        DB       "X08,"X40            ;       19200
```

### 12.2.2 Send a Data to the Serial Port

The sample program shown below describes how to send data to the serial port. It performs no XON/XOFF and no SI/SO control.

```asm
; SEND a data to the serial port
;
; ENTRY: C = DATA TO BE SENT
;

WRITE:
         IN       "XD8               ; Get UART status.
         CPI      "B00010000         ; See if transmitter buffer
                                     ; register Empty?
         JZ       WRITE              ; Wait TBR become empty.
         MOV      A,C                ; Get character to send.
         OUT      "XC8               ; Send it to the serial port.
         RET
```

### 12.2.3 Read a Data From Serial Port

The sample program shown below explains how to read data from serial port by RST6.5. This sample only reads data from serial port with RST6.5; no XON/XOFF and no SI/SO control is performed.

```asm
;* Read a data from Serial Port.
; Read a data by RST6.5

         ORG     "X3C                    ; Entry point of RST6.5
RST65:   DI
         JMP     READ

         ORG     ????                    ; <!-- TODO(tier-b): ORG address illegible in source scan -->

READ:
         PUSH    H                       ; Save registers.
         PUSH    D
         PUSH    B
         PUSH    PSW
         IN      "XC8                    ; Read the data
         MOV     L,A                     ; Save it.
         IN      "XD8                    ; Get error status
         ANI     "B00001110              ; Strip error bits.
         MOV     H,A
         SHLD    BUFFER
         POP     PSW                     ; Restore Registers.
         POP     B
         POP     D
         POP     H
         EI
         RET

BUFFER   DS      1                       ; Got Data.
         DS      1                       ; Error status.
```

## 12.3 Available System Area

You may want to use the system area for your own use. In this section, the available work area of ROM #0 is described. Make sure to keep compatibility with System ROM if you want to use this area.

The Serial Input Buffer from "XFE4C to "XFFC3 is reserved by System ROM as Serial Input Buffer. You can use it for your own routine.

**SERMOD** saves the RS-232C mode string.

This area has 6 bytes of data which indicates the RS-232C String Mode, specified by the `STAT` command in TELCOM or the `OPEN "COM:"` command in BASIC. The contents are as follows:

```asm
SERMOD    EQU     "XF406
          DS      6                   ; RS-232C String mode Buffer
          ; "XF406                   ; Baud rate specifier (1 to 9)
          ; "XF407                   ; Parity Mode (N/E/O/I)
          ; "XF408                   ; Word length specifier (5 to 8)
          ; "XF409                   ; Stop bit (1/2)
          ; "XF40A                   ; Xon/off control (X/N)
          ; "XF40B                   ; SI/SO control (S/N)
```

<!-- TODO(tier-b): source shows "XF40B" as "XF408" for SI/SO — likely OCR duplicate; cross-check with source page. -->

**INHIBIT** (at "XFE42):
This byte is the XON/XOFF Inhibit Flag. 0 inhibits XON/XOFF control; otherwise enabled.

**COMACT** ("XFE43, Byte):
This byte indicates who is using the serial port as follows. Please reset to 0 after using the serial port, otherwise the serial port is not available for another user.

| Value | User    |
|-------|---------|
| "X00  | No user |
| "X01  | SIO2    |
| "X02  | SIO1    |
| "X03  | RS-232C |

**CMPNT** (at "XFE46, DS 1): Character count in Buffer.
This byte has the character count in the Serial Buffer.

<!-- TODO(tier-b): one sentence appears garbled/clipped here in source — "This byte indicate last read character displacement." may belong to a different label (e.g. UTARD/"XFE47 area). Re-OCR to confirm. -->

This byte indicates the last read character displacement.

**UTADR** ("XFE47, Byte):
This byte indicates the last written character displacement.

**BAUDRT** ("XFE4A):
This points to the table of the Baud rate. Refer to Chapter 12.2.1.1 sample program.
