# Chapter 2: Memory Map

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 13-26). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                           CHAPTER 2

2.1   OVERVIEW
        The PC-8201A has the following memory capacity.    The
value specified with "Max" means the maximum capacity that is
greatly expanded by adding RAM/ROM chips or RAM cartridge.
                  ROM       32K byte~
                        C Max 64K bytes)
                  RAM       16K bytes
                        ( Max 96 K: 32k bytes x 3 bank)
                              2 banks are equipped on Main
                              board of PC-8201A and 1 bank
                              is provided with RAM cartridge.

        And PC-8201A has three useful programs in the standard
ROM, ROM #0.     These programs are CN82->BASIC , TEXT and
TELCOM.

        N82-BASIC: Microsoft BASIC, specialized
                   for PC-8201A.
        TEXT:       Simple and powerful word
                    processor
        TELCOM:     Communication program with
                    other digital computers
                    via RS-232C.

        The simple memory map of PC-8201A       is   illustrated   in

       the next figure. This illustration is a one of the standard
       pattern. Refer to Chapter 15 ~o understand the hardware
       expansibility, the detail configuration of memory and how to
       change the memory configuration.

f
I

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

                             The RAM it2 and RAM i3 can be located both low
                     address, from 0 to AX7FFF, and high address, from
                     AX8000 to AXFFFF. This selection can be done by PORT.
                     access. Refer to chapter 2.3.

        2.2   BANK SWITCHING ARCHITECTURE

               The heat of PC-8201A is the Intel 80C85, which is 8
       bit processor and whose address bus is 16. Thus, the 80C85
       can access 64K of memory at a time.    In PC-8201A, however,
       special memory access function called memory-bank switching is
       supported. So the 64K barrier in 8-bit microprocessor can be
       tricked in PC-8201A.
               The RAM in the PC-8201A is divided into units referred
       to as ·sANKs·. One bank can contain a maximum of 32K bytes of
       memory, while the RAM can be expanded to hold a maximum of
       three banks. CRAM #1, RAM *2, RAM #3)
               The RAM #2 and RAM #3 can be located in two different
       positions, lower position is from AX0000 to AX7FFF and higher
       position is from AX8000 to AXFFFF) And RAM #3 is detachable,
       because it is provided in RAM cartridge. The bank-switching
       is executed every 32K bytes. For the sake of this limitation
       it is impossible to access the half part of RAM #1 and half
       part of RAM #2 at a time.  In other words, you cannot set up
       the this kind of memory allocation, lower half of RAM #2, from
       AX8000 to AXBFFF, and higher part of RAM #1, from AXC000 to
       AXFFFF as 32K of memory. The variety of memory allocation is
       illustrated and explained kindly in       Chapter   15.    The
       explanation about the software specification in bank-switching
       is shown in the next section.

                The RAM #2 and RAM #3 can be protected by a   •PROTECT
       SUITCH•.    The •pRQTE-CT SWITCH• for RAM #2 is equipped at the
       real panel. Refer to the page 1-3 in PC-8201A User's guide.
       The RAM #3 has it at the side of the cartridge. But
       unfortunately, RAM #1 has no such a protect function~      When
       you use this protect switch, you cannot use that RAM bank in
       usual way, for instance, BASIC. Because, PC-8201A uses the
       highest RAM area, from AXF380 to AXFFFF to save the current
       status of PC-8201A every time.

                All RAM chips consists of CMOS and are back-uped by
       battery.    All data and program files stored in RAM will be
       kept, even if the power switch is turned off._ If you make a
       special utility for 2nd ROM or special RAM configuration, you
       have to consider about this Power-down sequence.      Refer to
       chapter 3 to understand the Power-off trap in ROM #0.

        2.2.1      Bank Switching Hardware
                The ·bank-switching· is· performed by OUT instruction.
        The OUT instruction outputs 8 bit data to.the I/O port. The
        port address and that bit assign of the 8 bit data is shown
        below.

                   PORT ADDRESS AXA1 (OUT)
                           Bank control

             MSB      7     6     5        4     :·   3   2   1   0

                   Bit 7              not used
                   Bit 6              not used

                   .Bit 5             not used
                   Bit 4              not used
                   Bit 3           High address
                      (AX8000 - AXFFFF) selection #2
                   Bit 2           High address

                      C"X8000 - "'XFFFF> selection #1
                   Bit 1           Low address
                      C"'X0000 - AX7FFF) selection #2
                   Bit 0           Low address
                      ("X0000 - "'X7FFF> selection #1

F'
'

                  High address #2     High address #1
                         0                  0       Bank #0 CRAM #1)
                         0                  1       not used
                          1                 0       Bank #2 <RAM #2)
                          1                 1       Bank 13 CRAM 13)
                  Low address #2       Low address #1
                         0                  0       Bank #0 <ROM #0)
                         0                  1       Bank #1 CROM #1)
                          1                 0       Bank #2 CRAM #2)
                          1                 1       Bank 13 CRAM #3)

                The current status of the memory, the status of
        bank-switching, can be examined by IN instruction. The IN
        instruction reads a 8 bit data from the specified I/O port.
        See next figure about the Port address and bit assignment of
        the data.

                   PORT_ADDRESS ~XA0H CIN>
                           Bank status

             MSB   -----------------~-------------------------------
                      7     6     5     4     3     2     1     0

                   Bit 7             Serial interface status #2
                   Bit 6             Serial interface status +n
                   Bit 5             Not used
                   Bit 4             Not used
       *2
                   Bit 3   ---       High address C... X8000 - ""XFFFF> status
                   Bit 2             High address C... X8000 - ... XFFFF> status
       ft1
                   Bit 1             Low address    C... X0000    ... X7FFF> status
       tt2
                   Bit 0             Low address    C... X0000 - "'X7FFF> status
       *1

                   Serial I/F #2              Serial I/F #1
                           0                            0         Not used
                           0                            1         SIO port
                           1                            0         Floppy
                                                                    disk port
                           1                            1         RS-232C port

                   High address #2    High address #1
                           0                  0         Bank #0 CRAM #1)
                           0                  1         Not used
                           1                  0         Bank #2 CRAM #2)
                           1                  1         Bank #3 CRAM #3)
                   Low a·ddress #2    Low address #1
                           0                  0         Bank #0   CROM #0)
                           0                  1         Bank #1   CROM #1)
                           1                  0         Bank #2   CRAM #2)
                           1                  1         Bank #3   CRAM #3)
                           Refer to Chapter 12 about Serial Interface.

        2.2.2   Bank Switching Software

               The bank-switching capability is used in Menu mode.
        The •BANK• command, arranged in Function key 10 (Shift+ F.S)
       uses this function.  This function falls into the Bank handler
       routine, CHGBNK, AX7EAB. The CHGBNK checks the current bank
       status, tests whether the bank really exists, save the new
       bank # in BANK (AXF308), changes the bank status and jumps to
       the address 0. Jumping to address 0 causes ·coLO START• if
       the bank has not ever used or the flag named FSIOSV has a
       wrong value. (Refer to the section 3.2 Bookkeeping area.)
       Otherwise, Jumping 0 does ·wARM START·.

                In or.der to test the existence of the another bank,
       CHGBNK reads the contents of the address, AXE000, in that
       destination bank, modifies that value, restores it, and
       re-reads it.      If that bank were really in exist, the value
       read first and the value re-read last are not identical.

               The reason why CHGBNK jumps·into the address 0 is, you
       might already notice, to set up the bookkeeping area. As
       described in Chapter 7, all standard programs and operating
       system uses this area every time to keep the current status.
       This area contains very important pointers,        flags   and
       interrupt routines.    So without setting up this area, that
       bank cannot be handled with ROM #0 correctly.

               If you use a bank only with your - special application
       program, which does not use the pointers on interrupt routines
       in the bookkeeping area, you might think that you need not
       care about the bookkeeping area. But please do not forget
       that ·sHIFT+F.s• in menu level can change the bank any time.
       I recommend that you will keep the current rules about
       Bank-switching in ROM #0, and set up the bookkeeping area.

               Refer chapter 4 •HOW TO USE 2ND/3RD RAM• to   get   more
       detail documents.

        2.3   GENERAL MEMORY MAPPING OF INTERNAL SOFTWARE USE

               You know that the ROM #0 addressed from 0 to AX7FFF is
       used for standard programs and operating systems. (Sometimes,
       ·standard programs· represents BASIC,      TEXT   and   TELCOM
       especially.    •operating system· also represents ·Menu·. But
       there is no explicit border line between the ·standard
       programs· and ·operating system·.      But I do sometimes use
       these words to explain the concept of the PC-8201A's built-in
       software.) Also, Some parts of the RAM memory area are
       reserved and used by that standard programs and operating
       system.   The memory map about the RAM area is figured at next
       page. The each part of the - reserved area is pointed by
       pointers in the ·book-keeping area·, located at the highest
       part of the RAM memory, from AXF380 to AXFFFF.        And the
       following 2 items are included in the book-keeping area, too.

                        Interrupt routine
                        System work area

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

                Brief explanation about pointers which appear at the
        previous page.

                 CBOTTOMJ Bottom address of RAM
                 CTXTTABJ Beginning of the current BASIC program
                 CTXTENOJ End of the current BASIC program
                 CNULOIRJ Non-registered BASIC program
               · CASCTABJ Lowest address of ASCII files
                 CSCROIRJ SCRAP file
                 CBINTABJ Lowest address of binary files
                 CVARTABJ Simple variable space
                 CARYTABJ Start of array table
                 CSTRENOJ End of Array table
                 CSTKTOPJ Top of stack space
                 CFRETOPJ Top of string free space
                 CMEMSIZJ Highest location in memory
                 CHIMEMJ Highest memory available to BASIC
                          (The same as CLEAR's 2nd parameter)
               rf. Chapter ·5 •uNOERSTANOING THE RAM FILE CONCEPT•,
               ·otRECTORY STRUCTURE• and •RAM ORGANIZATION•.     In
               those chapters, the concept of the files and detail
               explanation about the pointers are described.

        2.4   SAMPLE

                 TITLE   Bank switching pro~ram

        ;
        ,•        This sample will only change the bank of
        ;         RAM addressed from AX8000 to AXFFFF.
        ;       · You had better check that the bank which
        ;         you want to switch really exists. And you
         ,•       should save the next bank# at the
         ,•       bookkeeping area, BANK •
        ,•
        ,•      Entry    None
        ,•      Exit     None
       ,•                Bank will be changed
       ,•
       ;        Bank rotation #1 -> #2 -> #3 -> #1 ~>

       ; <<< SYSTEM labels>>>
       SYSTEM   EQU      AX0000             ; Reset address
       CONTRL   EQU      "'X0A1             ; Bank control port
       STATUS   EQU      "'X0A0             ; Bank status port
       ; ·<<< Bank switching program>>>
                ORG      "'X0100            ; This program must be
                                            ; stored between "'X0000
                                            ; and AX7FFF
       CHECK:   DI                           ; Disable interrupt
                IN       STATUS              ; Read current bank status
                MOV      B,A                ; Save current bank status
                ANI      "'B00001100        ; Pick up high bank status
                                            ,• only
       NEXTB:
                ADI      "'800000100        ; Set next bank data
                CPI      "'B00000100        ; This pattern was not used!
                JZ       NEXTB              ; Set up next bank data
                                            ; for lap around
                MOV      C,A                ; Save new bank data
                MOV      A,B                 ; Remember old bank status
                ANI      "'811110011        ; Do not change bit data
                                            ,• without RAM bank data·
                ORA      C                  ; Set new RAM bank
                OUT      CONTRL             ; Select bank

             EI                        : Enable interrupt
             JMP   SYSTEM             : We must update book
                                       keeping area •
                                     : Jump AX0000 is the
             END                      best way •

       •

```
