# Chapter 2: Memory Map

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 13-26). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.
> Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.

## 2.1 Overview

The PC-8201A has the following memory capacity. The value specified with "Max" means the maximum capacity that is greatly expanded by adding RAM/ROM chips or RAM cartridge.

- ROM: 32K bytes (Max 64K bytes)
- RAM: 16K bytes (Max 96K: 32K bytes × 3 banks)
  - 2 banks are equipped on the main board of the PC-8201A and 1 bank is provided with the RAM cartridge.

And the PC-8201A has three useful programs in the standard ROM, ROM #0. These programs are N82-BASIC, TEXT and TELCOM.

- **N82-BASIC:** Microsoft BASIC, specialized for PC-8201A.
- **TEXT:** Simple and powerful word processor.
- **TELCOM:** Communication program with other digital computers via RS-232C.

The simple memory map of PC-8201A is illustrated in the next figure. This illustration is one of the standard patterns. Refer to Chapter 15 to understand the hardware expansibility, the detail configuration of memory and how to change the memory configuration.

<!-- FIGURE 2.1: PC-8201A Memory Map — needs vision re-OCR from source page 14 (target: mermaid or table) -->
```text
                         Bank .0       Bank 1    Bank 2        Bank 3
            AXFFFF    -----------
                           RAM
                           STANDARD:
                            #1                   CRAM         CRAM
            AXC000    -----------                #2)           #3)
            AXBFFF    ----------
                       '
                     • I

                           RAM     I
                                   I
                           (option):
                           *1

           AX8000     -----------           ----------      -----------
           AX7FFF     ----------- --------- ----------      -----------
                           ROM         ROM       RAM          RAM
                           STANDARD:
                            #0         #1         *2           #3

                 0   ----------- -------- ---------         ~--------
                     Main memory                            RAM cartridge
                     Fig 2.1 PC - 8 2 0 1 A            ME MO R Y     MA P
```

The RAM #2 and RAM #3 can be located both at the low address range, from 0x0000 to 0x7FFF, and the high address range, from 0x8000 to 0xFFFF. This selection can be done by PORT access. Refer to section 2.3.

## 2.2 Bank Switching Architecture

The heart of the PC-8201A is the Intel 80C85, which is an 8-bit processor whose address bus is 16 bits wide. Thus, the 80C85 can access 64K of memory at a time. In the PC-8201A, however, a special memory access function called memory-bank switching is supported, so the 64K barrier in 8-bit microprocessors can be overcome in the PC-8201A.

The RAM in the PC-8201A is divided into units referred to as "BANKs". One bank can contain a maximum of 32K bytes of memory, while the RAM can be expanded to hold a maximum of three banks (RAM #1, RAM #2, RAM #3).

The RAM #2 and RAM #3 can be located in two different positions: the lower position is from 0x0000 to 0x7FFF, and the higher position is from 0x8000 to 0xFFFF. And RAM #3 is detachable, because it is provided in a RAM cartridge. The bank-switching is executed every 32K bytes. Because of this limitation it is impossible to access the lower half of RAM #1 and the lower half of RAM #2 at the same time. In other words, you cannot set up this kind of memory allocation: the lower half of RAM #2 (from 0x8000 to 0xBFFF) and the upper half of RAM #1 (from 0xC000 to 0xFFFF) as 32K of memory. The variety of memory allocation is illustrated and explained in Chapter 15. The explanation of the software specification for bank-switching is shown in the next section.

The RAM #2 and RAM #3 can be protected by a "PROTECT SWITCH". The "PROTECT SWITCH" for RAM #2 is equipped at the rear panel. Refer to page 1-3 in the PC-8201A User's Guide. RAM #3 has its switch at the side of the cartridge. Unfortunately, RAM #1 has no such protect function. When you use this protect switch, you cannot use that RAM bank in the usual way (for instance, BASIC), because the PC-8201A uses the highest RAM area, from 0xF380 to 0xFFFF, to save the current status of the PC-8201A at all times.

All RAM chips consist of CMOS and are backed up by battery. All data and program files stored in RAM will be kept even if the power switch is turned off. If you make a special utility for 2nd ROM or a special RAM configuration, you have to consider this Power-down sequence. Refer to Chapter 3 to understand the Power-off trap in ROM #0.

### 2.2.1 Bank Switching Hardware

The "bank-switching" is performed by the OUT instruction. The OUT instruction outputs 8-bit data to the I/O port. The port address and bit assignment of the 8-bit data are shown below.

<!-- TODO(tier-b): table garbled — verify against source page 17 -->
```text
           PORT ADDRESS 0xA1 (OUT)
                   Bank control

     MSB      7     6     5        4     3     2     1     0

           Bit 7              not used
           Bit 6              not used
           Bit 5              not used
           Bit 4              not used
           Bit 3           High address
              (0x8000 - 0xFFFF) selection #2
           Bit 2           High address
              (0x8000 - 0xFFFF) selection #1
           Bit 1           Low address
              (0x0000 - 0x7FFF) selection #2
           Bit 0           Low address
              (0x0000 - 0x7FFF) selection #1

  High address #2     High address #1
         0                  0       Bank #0 (RAM #1)
         0                  1       not used
         1                  0       Bank #2 (RAM #2)
         1                  1       Bank #3 (RAM #3)
  Low address #2       Low address #1
         0                  0       Bank #0 (ROM #0)
         0                  1       Bank #1 (ROM #1)
         1                  0       Bank #2 (RAM #2)
         1                  1       Bank #3 (RAM #3)
```

The current status of the memory — the status of bank-switching — can be examined by the IN instruction. The IN instruction reads an 8-bit data value from the specified I/O port. See the next figure for the port address and bit assignment of the data.

<!-- TODO(tier-b): table garbled — verify against source page 18 -->
```text
           PORT ADDRESS 0xA0 (IN)
                   Bank status

     MSB   -------------------------------------------------
              7     6     5     4     3     2     1     0

           Bit 7             Serial interface status #2
           Bit 6             Serial interface status #1
           Bit 5             Not used
           Bit 4             Not used
  *2
           Bit 3             High address (0x8000 - 0xFFFF) status
           Bit 2             High address (0x8000 - 0xFFFF) status
  *1
           Bit 1             Low address  (0x0000 - 0x7FFF) status
  *2
           Bit 0             Low address  (0x0000 - 0x7FFF) status
  *1

           Serial I/F #2              Serial I/F #1
                   0                            0         Not used
                   0                            1         SIO port
                   1                            0         Floppy disk port
                   1                            1         RS-232C port

           High address #2    High address #1
                   0                  0         Bank #0 (RAM #1)
                   0                  1         Not used
                   1                  0         Bank #2 (RAM #2)
                   1                  1         Bank #3 (RAM #3)
           Low address #2    Low address #1
                   0                  0         Bank #0 (ROM #0)
                   0                  1         Bank #1 (ROM #1)
                   1                  0         Bank #2 (RAM #2)
                   1                  1         Bank #3 (RAM #3)
```

Refer to Chapter 12 for information about the Serial Interface.

### 2.2.2 Bank Switching Software

The bank-switching capability is used in Menu mode. The "BANK" command, assigned to Function key 10 (Shift+F.5), uses this function. This function falls into the bank handler routine, CHGBNK, at 0x7EAB. CHGBNK checks the current bank status, tests whether the bank really exists, saves the new bank number in BANK (0xF308), changes the bank status and jumps to address 0. Jumping to address 0 causes a "COLD START" if the bank has not ever been used or if the flag named FSIOSV has a wrong value (refer to section 3.2 Bookkeeping area). Otherwise, jumping to address 0 causes a "WARM START".

In order to test the existence of another bank, CHGBNK reads the contents of address 0xE000 in the destination bank, modifies that value, restores it, and re-reads it. If that bank really exists, the value read first and the value re-read last will not be identical.

The reason why CHGBNK jumps to address 0 is, as you might already notice, to set up the bookkeeping area. As described in Chapter 7, all standard programs and the operating system use this area every time to keep the current status. This area contains very important pointers, flags and interrupt routines. So without setting up this area, that bank cannot be handled with ROM #0 correctly.

If you use a bank only with your special application program, which does not use the pointers or interrupt routines in the bookkeeping area, you might think you need not care about the bookkeeping area. But please do not forget that "SHIFT+F.5" at the menu level can change the bank at any time. I recommend that you keep the current rules about bank-switching in ROM #0 and set up the bookkeeping area.

Refer to Chapter 4 "HOW TO USE 2ND/3RD RAM" for more detailed documentation.

## 2.3 General Memory Mapping of Internal Software Use

You know that ROM #0, addressed from 0 to 0x7FFF, is used for standard programs and the operating system. (Sometimes "standard programs" refers specifically to BASIC, TEXT and TELCOM. "Operating system" also refers to "Menu". But there is no explicit border line between the "standard programs" and "operating system". These words are used sometimes to explain the concept of the PC-8201A's built-in software.) Also, some parts of the RAM memory area are reserved and used by those standard programs and the operating system. The memory map of the RAM area is shown on the next page. Each part of the reserved area is pointed to by pointers in the "book-keeping area", located at the highest part of the RAM memory, from 0xF380 to 0xFFFF. The following 2 items are also included in the book-keeping area:

- Interrupt routine
- System work area

<!-- FIGURE 2.2: PC-8201A RAM Area Memory Map — needs vision re-OCR from source page 22 (target: mermaid or table) -->
```text
        Fig 2.2 PC - 8201A RAM AREA MEMORY MAP
AXFFFF   -----------------I
         : Bookkeeping    I
                           ·I
              ar-ea         I

AXF3s0· -------------~---I
       · : User- machine       I

            stored ar-ea :<- CHIMEMJ        "'XF384
         : File control        I
                               I
         : block ar-ea     :<- CFILTABJ     "'XFB63
         : 2 Bytes space:
         : String ar-ea    : <- CMEMSIZJ    "'XFA9A
              (used)

         : String ar-ea    : <- CFRETOPJ    "'XFABF
              (fr-ee)

         : Staci< ar-ea    :<- CSTKTOPJ     "'XF459
                           :<- Stack Pointer-
         I                 I
         I   Fr-ee ar-ea   I

                           :<- CSTRENDJ     "XFAE9
         -----------------
         I
         I Ar-r-ay stored  I
                           I

              ar-ea        :<- CARYTABJ     "'XFAE7
         -----------------
           Simple          I
                           I

             variable ar-ea :<- CVARTABJ    "XFAES
             .co files     I
                           I

              ar-ea        :<- CBINTABJ     "'XFAE3
         -----------------
         : EDIT ar-ea      I
                           I

         : for- BASIC      :<- CEOTDIRJ+1   "F886+1
         : Paste buffer-   I
                           I

         : for- TEXT       :<- CSCRDIRJ+1   "XF87B
         : .DO files       I
                           I

              ar-ea        : <- ~ASCTABJ    "'XFAE1
         : non-registered:
         l BASIC file     :<-CNULDIRJ+1     "'XF870+1

     : .BA fi 1es
         ar-ea         : <-CTXTENDJ    "XFA88
     : Cur-r-ent BA
        file           l<-CTXTTABJ     "XFASO
     : .BA fi 1es      I
                       I
        ar-ea          l<-CBOTTOMJ+1   "XF980+1
                      I <-CBOTTOMJ     "XF980
```

Brief explanation of the pointers appearing in the figure above:

| Pointer     | Description                                         |
|-------------|-----------------------------------------------------|
| [BOTTOM]    | Bottom address of RAM                               |
| [TXTTAB]    | Beginning of the current BASIC program              |
| [TXTEND]    | End of the current BASIC program                   |
| [NULDIR]    | Non-registered BASIC program                       |
| [ASCTAB]    | Lowest address of ASCII files                      |
| [SCRDIR]    | SCRAP file                                         |
| [BINTAB]    | Lowest address of binary files                     |
| [VARTAB]    | Simple variable space                              |
| [ARYTAB]    | Start of array table                               |
| [STREND]    | End of array table                                 |
| [STKTOP]    | Top of stack space                                 |
| [FRETOP]    | Top of string free space                           |
| [MEMSIZ]    | Highest location in memory                         |
| [HIMEM]     | Highest memory available to BASIC (same as CLEAR's 2nd parameter) |

Refer to Chapter 5 "UNDERSTANDING THE RAM FILE CONCEPT", "DIRECTORY STRUCTURE" and "RAM ORGANIZATION". In those chapters, the concept of files and a detailed explanation of the pointers are described.

## 2.4 Sample

```asm
        TITLE   Bank switching program

;
;       This sample will only change the bank of
;       RAM addressed from 0x8000 to 0xFFFF.
;       You had better check that the bank which
;       you want to switch really exists. And you
;       should save the next bank# at the
;       bookkeeping area, BANK.
;
;       Entry    None
;       Exit     None
;                Bank will be changed
;
;       Bank rotation #1 -> #2 -> #3 -> #1 ->

; <<< SYSTEM labels >>>
SYSTEM   EQU      0x0000             ; Reset address
CONTRL   EQU      0x0A1              ; Bank control port
STATUS   EQU      0x0A0              ; Bank status port
; <<< Bank switching program >>>
         ORG      0x0100             ; This program must be
                                     ; stored between 0x0000
                                     ; and 0x7FFF
CHECK:   DI                          ; Disable interrupt
         IN       STATUS             ; Read current bank status
         MOV      B,A                ; Save current bank status
         ANI      0b00001100         ; Pick up high bank status only
NEXTB:
         ADI      0b00000100         ; Set next bank data
         CPI      0b00000100         ; This pattern was not used!
         JZ       NEXTB              ; Set up next bank data
                                     ; for lap around
         MOV      C,A                ; Save new bank data
         MOV      A,B                ; Remember old bank status
         ANI      0b11110011         ; Do not change bit data
                                     ; without RAM bank data
         ORA      C                  ; Set new RAM bank
         OUT      CONTRL             ; Select bank

         EI                          ; Enable interrupt
         JMP      SYSTEM             ; We must update bookkeeping area.
                                     ; Jump to 0x0000 is the best way.
         END
```
