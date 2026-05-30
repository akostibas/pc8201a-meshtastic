# Chapter 3: How To Use 2nd ROM

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 27–48). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as authoritative.

When you want to make some programs stored in 2nd ROM, there are a lot of matters that should be attended to and stored in the 2nd ROM. The matters are interrupt jump tables and power on/power off sequences. You have to implement these tables and sequences in order to process the ROM bank switching smoothly. Otherwise, PC-8201A will run away on switching the ROM bank. The first half of the sections describes the interrupt functions and power sequence.

And you have to know the rules to handle the files and data in RAM, too. If you will use the routines in ROM #0 to handle the RAM, you need not care about the detail rules. (You can get the information about the RAM file handling routines in ROM #0 at Chapter 8 and another technical manual that has already been made available by NEC HE in Chicago. Please request it if you have not gotten it yet.) The last half of this chapter describes how to use the routines in ROM #0 from 2nd ROM, ROM #1. (Hereafter ROM #1 sometimes represents 2nd ROM.)

If you want to make I/O control routines and store them in 2nd ROM, you have to understand Chapters 9 to 14. If you utilize the ROM #0's I/O routines, the last half of this chapter and another manual will help you.

## 3.1 Consideration of Interrupt

Basically, PC-8201A has some interrupt service routines in its system. The main purposes of interrupts are smooth processing in Power off trap, reading data from the Bar-code reader, communicating through UART (RS-232C), and using the Interval timer.

The interrupt table is located in the zero page area.

<!-- TODO(tier-b): verify interrupt vector table layout against source page ~30 -->

| Function          | Interrupt  | Address   |
|-------------------|------------|-----------|
| POWER OFF TRAP    | NMI        | `"X0024`  |
| BARCODE READER    | RST 5.5    | `"X002C`  |
| UART              | RST 6.5    | `"X0034`  |
| INTERVAL TIMER    | RST 7.5    | `"X003C`  |

The Interval timer interrupt has the highest priority, and UART has the second. The lowest interrupt is used for the Barcode reader. The reason why the interval timer has the highest priority is to scan the key and to count the auto-power off counter for saving the battery power. PC-8201A has the "Auto-Power Off" function. Usually, this function is executed after 10 minutes have passed since the last key stroke was detected. (This interval can be set by the `POWER` command in BASIC. Refer to the *PC-8201A Reference Manual*.) The interval timer is used to count this period.

The interrupt hook table is located from `"XF386` to `"XF394`. That table is constructed as follows:

<!-- TODO(tier-b): verify interrupt hook table layout against source page ~30 -->

| Address   | Hook                               |
|-----------|------------------------------------|
| `"XF386`  | POWER ON SEQUENCE                  |
| `"XF389`  | BARCODE READER INPUT SEQUENCE      |
| `"XF38C`  | UART INPUT SEQUENCE                |
| `"XF38F`  | TIMER SEQUENCE and KEY SCANNING SEQUENCE |
| `"XF392`  | POWER FAILURE SEQUENCE             |

### 3.1.1 Power Off Trap (ADDRESS `"X4CFA`)

This interrupt is Non-maskable. When the power switch is turned off, this interrupt occurs. The following sequence is the algorithm of this interrupt.

1. Disable the interrupt
2. Call hook table
3. Reset Key wait counter
4. Cancel Time counter
5. Out a data to the Auto power off port
6. HLT

The detail bit assignment of the auto power off port is as follows.

```
PORT ADDRESS  "XBA  <OUT>
              81C55 port B
```

<!-- TODO(tier-b): verify port bit-assignment table against source page ~31 -->

| Bit | Description |
|-----|-------------|
| 7   | RTS output |
| 6   | DTR output |
| 5   | BELL — 0: Ring bell, 1: Stop bell |
| 4   | Auto power off — 0: Off, 1: On |
| 3   | DCO/RO select |
| 2   | Melody control — 0: On, 1: Off |
| 1   | LCD chip select #1 |
| 0   | LCD chip select #0 |

Refer to Chapters 9 to 15 for more detailed information about this port.

### 3.1.2 Barcode Reader (ADDRESS `"XF389` with Disable interrupt)

This interrupt uses RST 5.5. If you do not use the barcode reader program, this interrupt should do `RETURN` immediately.

### 3.1.3 UART (ADDRESS `"X6E00` with Disable interrupt)

This interrupt uses RST 6.5. This interrupt is caused by UART (Serial communication device 6402). This interrupt occurs when the data in the 6402 receive buffer is available.

The algorithm of this interrupt is shown below.

1. Disable the interrupt
2. Call hook table
3. Read data from 6402
4. Read error status from 6402
5. Xon/Xoff control check
6. SI/SO control check
7. Return to previous process

```
PORT ADDRESS  "XD5  <OUT>
UART control port
```

<!-- TODO(tier-b): verify UART control port bit-assignment table against source page ~32 -->

| Bit | Description |
|-----|-------------|
| 7   | Not used |
| 6   | Not used |
| 5   | Not used |
| 4   | Character length select #2 |
| 3   | Character length select #1 |
| 2   | Parity inhibit — 0: Parity generation check, 1: Parity generation check inhibit |
| 1   | Even parity enable — 0: Odd parity, 1: Even parity |
| 0   | Stop bit select — 0: Stop bit 1 bit; 1: Stop bit 1.5 bit (if DATA Length is 5); 1: Stop bit 2 bit (if DATA Length is not 5) |

```
PORT ADDRESS  "XC5  <OUT>
UART data I/O port
```

<!-- TODO(tier-b): verify UART data port bit-assignment table against source page ~32 -->

| Bit | Description |
|-----|-------------|
| 7   | Data #7 |
| 6   | Data #6 |
| 5   | Data #5 |
| 4   | Data #4 |
| 3   | Data #3 |
| 2   | Data #2 |
| 1   | Data #1 |
| 0   | Data #0 |

Refer to Chapters 12 and 15 for more detailed information about UART.

### 3.1.4 Interval Timer (ADDRESS `"X1EBE` with Disable Interrupt)

This interrupt uses RST 7.5. This is the interrupt from the interval timer (Timer device 1990). This interrupt is also used for key scanning.

In the system's initialization, the interval timer, which is controlled by 1990, is set up as 4 ms second mode. The port for 1990 is illustrated below.

<!-- TODO(tier-b): verify calendar clock port bit-assignment table against source page ~33 -->

```
PORT ADDRESS  (see Chapter 15)
Calendar clock (1990) control port
```

| Bit | Description |
|-----|-------------|
| 7   | Not used |
| 6   | Not used |
| 5   | Not used |
| 4   | Data output |
| 3   | Shift clock |
| 2   | Command output #2 |
| 1   | Command output #1 |
| 0   | Command output #0 |

| Command #2 | Command #1 | Command #0 | Function |
|-----------|-----------|-----------|----------|
| 1 | 0 | 0 | Timing 64 Hz |
| 1 | 0 | 1 | Timing 256 Hz |
| 1 | 1 | 0 | Timing 2048 Hz |
| 1 | 1 | 1 | TEST mode |

In the initialization routine, the command is set up as `"X05`. It means a 4 ms second interval.

Refer to Chapter 15 for more information about 1990.

The following steps are the algorithm for the interval timer sequence.

1. Disable the interrupt
2. Call hook table
3. Mask RST 7.5, RST 5.5
4. Reverse cursor character for cursor blink
5. Key matrix scanning
6. Return to the interrupted process

## 3.2 Special Reserved Area of 2nd ROM

When you would like to use 2nd ROM, you must write the following information into the 2nd ROM's special reserved area. The special reserved area is located from `"X0000` to `"X0047`. This area will be used for the 2nd ROM starting jump instruction and IO code, and the file name of 2nd ROM. This name is displayed like one of the RAM files on the Menu screen by 1st ROM, ROM #0. The following figure explains the 2nd ROM special reserved area.

```asm
        ADDRESS          CODE
        "X0000  JMP     START      ; 2nd ROM start address
        "X0003
        "X0024           RET       ; Non maskable interrupt
        "X002C           RET       ; Barcode reader interrupt
        "X0034           RET       ; UART interrupt
        "X003C           RET       ; Interval timer interrupt
        "X003F                     ; Reserved for RST interrupt
        "X0040           DB     'A'
        "X0041           DB     'B'        ; IO code for 2nd ROM
        "X0042           DB     '2NDROM'   ; File name displayed in the menu
        "X0048  START:              ; 2nd ROM code
```

```
        S P E C I A L   R E S E R V E D   A D D R E S S
```

If these data are implemented correctly, the name will appear on the 1st ROM's menu screen. So it is easy to switch the ROM and execute the program in it. When you want to start the programs in 2nd ROM from the Menu mode of ROM #0, move the cursor to the 2nd ROM's file name on the screen. Then press the return key. The system will fall into the 2nd ROM program.

## 3.3 The Method to Use 1st ROM Entry from 2nd ROM

If you want to use the routines in 1st ROM from 2nd ROM, you must first create a special routine in the higher memory location of RAM (`"X8000`–`"XFFFF`) and use it. That routine switches the ROM bank using the bank switching method, and calls the routine in 1st ROM. It is very important that interrupts must be disabled before you change the ROM banks. And in addition, as the following sections will tell you, you have to change the hook table for the Power down interrupt that was changed by 2nd ROM to restart the current process in 2nd ROM program at the next power-on. With this hook table for 2nd ROM, the power down in ROM #0 will cause a fatal error. Power-off interrupt cannot be prohibited. And you have to consider the contents of the routine which you will call. The reason is that some routines in the 1st ROM may enable the interrupts in some parts of their code even if you disable the interrupts just before switching the ROM banks to call a 1st ROM entry. Therefore you had better change all hook tables in the current book keeping area. I suggest that all hook tables should be replaced with previous contents which were stored by 1st ROM, just before calling the ROM bank-switching routine, and restored just after coming back from 1st ROM.

The following program is the sample which uses 1st ROM entry points from 2nd ROM.

### 3.3.1 Sample

```asm
;       TITLE   Using 1st ROM entry from 2nd ROM
;
;
;       This sample will enable the use of 1st ROM entry from
;       2nd ROM.
;       Some routines in 1st ROM might enable interrupts,
;       so all interrupt hook tables should be replaced with RET code.
;       And restore them after done the 1st ROM calling.
;
;       Entry    [ENTRY]: 1st ROM entry address
;       Exit     for return condition of 1st ROM
;
; <<< SYSTEM define label >>>
BNKCRL  EQU     "X0A1           ; Bank control port
STATUS  EQU     "X0A0           ; Bank status port
; <<< Main routine >>>
        ORG     "X8000          ; This routine must stay in
                                ; "X8000-"XFFFF
ROM1ST: SHLD    WORKH           ; Save register HL
        LXI     H,RET2ND        ; Return address from 1st ROM
        PUSH    H               ; Push stack top
        LHLD    ENTRY           ; Pick up 1st ROM entry
                                ; address
        PUSH    H               ; Push stack top
        LHLD    WORKH           ; Restore HL
        PUSH    PSW             ; Save all registers
        DI                      ; Disable interrupt
        IN      STATUS          ; Get current bank status
        ANI     "B11111110      ; Switch 1st ROM data set up
        OUT     BNKCRL          ; Bank select
                                ; Now "X0000-"X7FFF are
                                ; 1st ROM
        EI                      ; Enable interrupt
        POP     PSW
        RET                     ; Jump 1st ROM entry
; <<< Return from 1st ROM >>>
RET2ND: PUSH    PSW             ; Save all registers
        IN      STATUS          ; Get current bank status
        ORI     "B00000001      ; Switch 2nd ROM data set up
        OUT     BNKCRL          ; Bank select
                                ; Now "X0000-"X7FFF are
                                ; 2nd ROM
        POP     PSW             ; Pick up all registers
        RET
; <<< SYSTEM WORK AREA >>>
ENTRY:  DW      "X0000          ; 1st ROM entry address
WORKH:  DW      "X0000          ; HL register saving area
        END
```

## 3.4 Sequences in the 2nd ROM

1. **INITIALIZE**

   This sequence sets up SP (Stack Pointer), power-on trap and other interrupt routines. Then it copies the book-keeping area and system area. Finally, some peripherals will be initialized by this routine.

2. **RETURN TO MENU**

   At first, this sequence selects the standard RAM, RAM #0, and resets the power-off trap. Then it jumps to the menu.

3. **POWER DOWN**

   When power is turned off, the control is transferred to this sequence. In this sequence, you must save all registers and circumstances which should be saved in the stack. So the stack pointer is most important to resume the current processing on the next power-on.

   The RAM bank number is always stored in RAM #0. On turning on, the 1st ROM and RAM #0 is selected automatically. And the bank-switching procedure will be called in the Power on sequence if the number of the RAM bank was not identical to RAM #0 in the power down sequence. After changing the RAM bank, all registers will be restored and the pending procedure will be resumed. Therefore, in the stack, the address of the process which was abandoned by the Power down trap should be stored.

   In addition, in order to resume the abandoned process with 2nd ROM, you have to perform a special power on/power off sequence. In the power off trap, you should set the start routine of the special power-on sequence which switches the ROM bank. I recommend using the hook `"XF38F`. Usually, a "JUMP to POWER FAIL SEQUENCE" command is stored here. In 2nd ROM, however, you have to rewrite this hook table and call the special power down routine here. In it, the address of the special power-on routine is placed on the stack. In this case, the following information should be stacked before the `HLT` command is executed.

<!-- FIGURE 3.1: Stack diagram showing stacked items before HLT — needs vision re-OCR from source page ~40 (target: mermaid) -->

```text
                      resuming   address

                      starting address of
                       the ROM switching
                        routine
                      Contents of Pointers
                                             <-- [STAKSV]

                    [STAKSV] keeps the SP's value at HLT.
                    Fig 3.1
```

4. **POWER ON**

   At first, the initializing routine in ROM #0 checks the RAM bank number in BANK (`"XF308`) when power-off was executed. When power-off was done in a non-standard RAM bank, the RAM bank-switching routine is called and switched. Then, the registers' contents will be restored. If the address of the process which should be resumed was stacked, the address will be picked up and executed. When the power-down was detected in ROM #1, the address of the special ROM switching routine ought to be stacked above the address of the process to be resumed. Therefore, after switching the ROM, the abandoned process will be resumed.

The following figure shows the general 2nd ROM routine control sequence.

<!-- FIGURE 3.2: Control-flow diagram for 2nd ROM power-on/power-off/initialize/return sequence — needs vision re-OCR from source page ~41 (target: mermaid) -->

```text
                      : MENU mode
                                                  .      ROM:
                                         of     1st

                                                           A

                            :- select 2nd ROM
                            I
                            I
                            V
              -----------------------------------------
                :--------------
                        INITIALIZE                     RETURN

                                                           :-Return
                    I
                    I

                    : Main routine of 2nd ROM

                                                           I
                                                           I
                           +-Turn off power switch:

                        POWER DOWN :               POWER ON

                                                          ...
                                                          :-Turn on
                                                               power switch
                           V

                           P O W E R   O F F

                            Fig 3.2
```

## 3.5 Summary — Important Notice

If you want to make a 2nd ROM program, you should take care of the following matters.

1. **Interrupt vector**

   If you do not want to use interrupt, all interrupt tables should be set with only `RET` code. But I suggest that you had better use the interval timer interrupt, because of saving the battery power by using the auto power off function. The counter for this auto power off function is counted by this interval timer interrupt. If you do not use this function, the battery consumption may be larger than normal.

2. **Bank of RAM**

   Do not switch the ROM bank when the PC (Program Counter) points to a routine in that ROM. You can guess the reason — it is not hard to imagine that these bank switchings will cause fatal problems for the system. At the worst case, all files which you stored will be lost. And also you should be careful about the stack area, too.

3. **PC-8201A book keeping area**

   The book keeping area is very important for this system, so you should never change that area without careful consideration. Please read Chapter 7 "BOOK KEEPING AREA".

4. **Power on/off sequence**

   Please use the power off interrupt to detect the power down. I suggest that you had better use the real time interrupt service to poll the power down signal.

If you want to use 1st ROM entry from 2nd ROM, please take care of the following point. All routines rewrite some work areas sometimes. So, if you use 1st ROM entry from 2nd ROM without understanding that routine's internal specification, the system might be crashed. In addition, interrupts and stack area are other important points. Refer to Section 3.3 "The Method to Use 1st ROM Entry from 2nd ROM" and its sample program.

## 3.6 Sample

```asm
;       TITLE   2nd ROM sample header and useful routine

; <<< SYSTEM define label >>>
BANK    EQU     "XF3DB          ; Bank save area
ATIDSV  EQU     "XF382          ;
PWHOK   EQU     "XF386          ; Power on hook table
RST55   EQU     "XF389          ; RST 5.5 hook table
STAKSV  EQU     "XF9AE          ;
AUTOID  EQU     "X9C0B          ;
SAVSTK  EQU     "XFA00          ;
STATUS  EQU     "XA0            ; Bank status
BNKCRL  EQU     "XA1            ; Bank control
PWPORT  EQU     "XB8            ; 81C55 chip select
PORTS   EQU     "XBA            ; 81C55 port B
FREE    EQU     "X????          ; You must set your RAM
                                ; free portion address
; <<< Main routine >>>

START:
        JMP     INIT            ; 2nd ROM start address
        ORG     "X0024          ; Non maskable interrupt
                                ; table
        JMP     POWER           ; Power down trap
        ORG     "X002C          ; RST 5.5
        JMP     BARCODE         ; Barcode reader interrupt
                                ; table
        ORG     "X0034          ; RST 6.5
        JMP     UART            ; UART interrupt table
        ORG     "X003C          ; RST 7.5
        JMP     TIMER           ; Timer interrupt table
        ORG     "X0040          ; IO code for 2nd ROM
        DB      'AB'            ; AB is ID code for 2nd ROM
        DB      '2NDROM'        ; File name displayed in the MENU

; <<< Initialization of 2nd ROM program >>>
INIT:   LHLD    SAVSTK          ; Set stack pointer
        SPHL                    ;
        CALL    SETTRP          ; Set hook for resume
                                ; 2nd ROM's program,
                                ; and other routine into RAM.
        CALL    HINIT           ; Hardware initialization
        JMP     MAIN            ; Goto main routine

; <<< Hardware initialize routine >>>
HINIT:  RET                     ;

; <<< MAIN ROUTINE OF 2ND ROM >>>
;
;
MAIN:                           ; Main routine

; <<< Set up hook >>>
; Set up hook table for 2nd ROM
SETTRP: MVI     A,"B00000001    ; Select standard RAM
        OUT     BNKCRL          ; Select!
        LXI     H,DTBL          ; Set some codes into RAM
        LXI     D,PWHOK         ; for power on sequence
        MVI     B,TBLEND-DTBL   ;
        CALL    COPY            ;
                                ;
        LXI     H,TBLHOK        ; Return code table
        LXI     D,FREE          ;
                                ; Free area of RAM portion
        LXI     B,HOKE-TBLHOK   ; Set length
        CALL    COPY            ;
        RET                     ;

; [DE] <- [HL]
COPY:   MOV     A,M             ; Read [HL]
        STAX    D               ; Save [DE]
        INX     H               ;
        INX     D               ; Next address set
        DCR     B               ; Decrement counter
        JNZ     COPY            ; Loop until done
        RET                     ;

; The following code will be copied in RAM
; portion for re-power on sequences;
; these parts are interrupt hook table.
;
DTBL    EQU     $
        MVI     A,"B00000001    ; These code will be
                                ; copied into RAM
        OUT     BNKCRL          ; Bank select!
        JMP     PWON            ; Jump power on trap
BANK1:  DS      1               ;
TBLEND  EQU     $

;
; The following code will be copied
; in RAM portion for return to 1st ROM
;
TBLHOK  EQU     $
RETSB:  XRA     A               ; Clear A
        OUT     BNKCRL          ; Select 1st ROM and
                                ; standard RAM
        JMP     "X0000          ; Return!
HOKE    EQU     $

; <<< RETURN >>>
RETURN: MVI     A,"B00000001    ; Select standard RAM
        OUT     BNKCRL          ;
        MVI     A,"B00000000    ;
        STA     BANK            ;
        LXI     H,"X0000        ; Reset
        SHLD    ATIDSV          ;
        LXI     H,RTBL          ; Rewrite code table
        LXI     D,PWHOK         ; Interrupt hook table set
        LXI     B,RTBLE-RTBL    ; Set length
        CALL    COPY            ;
        JMP     RETSB           ; Return to 1st
                                ; ROM's menu mode

; The following code will be copied
; in standard RAM portion
;
RTBL    EQU     $
        RET                     ; Power on hook
        NOP
        NOP
        EI                      ; RST 5.5 hook
        RET
        NOP
RTBLE   EQU     $

; <<< Power on >>>
PWON:   CALL    HINIT           ;
        LDA     BANK1-DTBL      ; Select old RAM bank
        OUT     BNKCRL          ;
        LHLD    STAKSV          ; Restore stack pointer
        SPHL                    ;
        POP     PSW             ;
        POP     B               ;
        POP     D               ;
        POP     H               ;
        RET                     ; Resume old program

; <<< POWER DOWN TRAP >>>
POWER:  PUSH    PSW             ;
        IN      PWPORT          ; Read power down port
        ANA     A               ; Check
        JM      NTPWFL          ; No power down
        POP     PSW             ;
        DI                      ; Disable interrupt
        PUSH    H               ; Save HL
        PUSH    D               ; Save DE
        PUSH    B               ; Save BC
        PUSH    PSW             ; Save AF
        LXI     H,"X0000
        DAD     SP              ; Now I know stack address
        SHLD    STAKSV          ; Save stack
        MVI     A,0FFH          ; Reset interval timer
                                ; counter
        STA     PWRINT          ; Set up for next power on
        IN      STATUS          ; Save current RAM bank status
                                ; remember this and select RAM bank.
        MOV     B,A             ; Save it
        MVI     A,"B00000001    ; Select standard RAM
        OUT     BNKCRL          ; Select!
        MOV     A,B             ; Resave old status
        STA     BANK1-DTBL      ;
        MVI     A,"B00000001    ; Select RAM bank 1  <!-- ? -->
        OUT     BNKCRL          ;
        MVI     A,0             ; Set up to come back
                                ; to 2nd ROM
        STA     BANK            ;
        LXI     H,AUTOID        ;
        SHLD    ATIDSV          ;
        IN      PORTS           ;
        ORI     "B00010000      ;
        OUT     PORTS           ;
        HLT                     ; Never go on

NTPWFL: POP     PSW
        RET                     ;

; <<< BARCODE READER interrupt >>>
BARCODE: RET                    ; Return soon

; <<< UART interrupt >>>
UART:   RET                     ; Return soon

; <<< Interval Timer interrupt >>>
TIMER:  LDA     PWRINT          ; Pick up timer value
        DCR     A               ; Decrement!!
        STA     PWRINT          ; Save it
        RET                     ;

; <<< System work area >>>
PWRINT: DB      "X0FF           ; Timer counter n * 1/256 Hz
        END
```
