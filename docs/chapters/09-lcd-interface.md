# Chapter 9: Lcd Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 154-183). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
r
!

                           CHAPTER 9

             This chapter describes how to    control   LCD   (Liquid
            Crystal Display) of PC-8201A.

    9.1   OVER VIEU

            The LCD (LR-202C>, full bit map screen which consists
      of 240 * 64 dots, displays 40 characters per line and 8
      lines per screen. A character on the LCD consists of 6 by 8
      pixels.   The.LCD is driven by 10 Segment Drivers (HD441026)
      with 200 bytes Display RAM and 2 Common Drivers (HD44023b).
      Segment Drivers are selected by Port A/8 of PPI (81C55).

    9.2   CONSTRUCTION OF LCD

         .  The LCD is divided into the following IC blocks. Each
      block has i.ts own Segment Driver with 200 bytes Display RAM.
      And each IC block can display 50 * 32 dots. However, BS and
      B10 displays only 40 * 32 dots. Of course, you can write
      dots on the remaining area of Display RAM of B5 and 810 with
      no error, but they will never appear on the screen.

                                                       •
                                                   .   ·•
                     :<------- 240 dots-------------------->:
                -----+-------~-------------------------------+
                           I
                           I

                        81 : B2       B3       .
                                              84      BS

         64 dots+---------------------------------------+
                           I
                           I

                       B6:     B7       BS         89             810

            -----+---------------------------------------+
                          Fig 9.1

                The Display RAM may be regarded as the VRAM 1n the
         traditional desk top type personal computer. Setting a Bit
         On/Off in the Display RAM means setting/resetting a dot on
         the LCD.

               Refer to        following      sections      how     to   control ·each
         Segment Driver.

            . 9.3     I/O PORT RELATED TO LCD             ..

              9.3.1    BLOCK SELECT      PPI 81CSS         .    PORT A/8
                                                  ··-   .....

                      msb 7   6   5   4   3   2   1   0 lsb
                        +---+---+---+---+---+---+---+---+
                         lPA7lPA6lPASlPA4lPA3lPA2lPA1lPA1:                 OUT ""X89
                        +-------------------------------+
                        : X l X l X l X: X l X lP81lPB0l                   OUT ""XBA
                        +------------------------------+
                        PA0 to P87 is associated to 8LOCK1 to BLOCKS
                        P80,PB1 to BLOCK9,10 respectively.
                        0 = Not Select/ 1 = Select
                        Oescr-iption:
                        Selecting a LCD Block C same meaning as selecting a
                        Segment Driver IC) .which. you want to access. You
                        cannot select two blocks at a time.

        9.3.2        LCD COMMAND SET

               There are 5 commands to control the Segment Driver IC.
       These commands are executed via Port ~XFE.

       9.3.2.1         Display ON/OFF.

                    msb 7   6   5   4   3   2   1    0   lsb
                      +---+---+---+---+---+---+---+------+
                      : 0 : 0 : 1 : 1 : 1 : 0 : 0 : DISP :     OUT "'XFE
                     +---+---+---+---+---+---+---+------+

                     DISP:    Display ON/OFF
                                      0 = Dieplay Off
                                      1 = Display On
                     Description:
                     DISP decides ~hether the data in Display RAM
                     is displayed on the screen.
                     This port doesn't effect the contents of Display RAM.

                /
                                                  -
            9.3.2.2    Set Address Counter

                    msb 7   6   5   4   3   2   ·f · 0 lsb
                      +---+---+---+---+---+---+---+---+
                      lPG1lPG0lOFS:OF4lOF3:0F2:oF1:oF0:
                      +---+---+---+---+---+---+---+---+

                      Select PAGE
                       PGl    PG0
                        0      1          PAGE0
                        0      1          PAGE1
                        1      0          PAGE2
                        1      1          PAGE3
                      OFn means 'OFfset counter' in each PAGE.
                      It must be from 0 to 49.

                   The Display RAM is divided into 4( 0 to 3) pages and
           each page contains 50 bytes (0 to 49) as shown at next page.
           Segment driver has PAGE counter and OFFSET Counter.      These
           counter is set by this command. The OFFSET counter works as
           the loop counter, it's value· from 0 to 49. The OFFSET counter
           is   automatically Incremented/Decremented after read/write
           operation. The counter mode is described blow. Page counter
           is not changed by read/write operation.

•
                                                     ,I

                                      OFFSET counter-    .
                PAGE           0<------------------->49(39 if BS/810>
                counter-   +---+-------------------+
                           : 1sb:                         I
                                                          I
                "800       I
                           I
                                   I
                                   I        PAGE 0
                           :msbl
                           +---+---~---------------+
                           l lsb                          I
                                                          I
                "B01       I
                           I                PAGE 1
                           lmsb
                           +-----------------------+
                           : 1sb
                "'B10      I
                           I                PAGE 2
                           :msb
                           +-----------------------+
                           :meb
                "'B11                       PAGE 3
                           : 1sb
                           +-----------------------+
                           Fig 9.2

                                       /
r

            9.3.2.3    Set Starting Page.

                    msb 7    6    5   4   3 -- 2 . 1
                                                  ~
                                                      0 lsb
                      +----+---+---+---+---+---+---+---+
                      lSPG1lSPG2l 1 : 1 : 1 : 1 l 1 : 1 :          OUT "XFE
                     ·+----+----+---+---+---+---+---+---+

                      SPG1/0:    Specify the Starting Page to be
                                 display on LCD.
                                SPG1 SPG0       Order of Display Page
                                0     0         0 -> 1 -> 2 -> 3
                                0     1         1 -> 2 -> 3 -> 0
                                1     0         2 -> 3 -> 0 -> 1
                                1     1         3 -> 0 -> 1 -> 2

                      Description:
                      Assume that each LCD block is divided into 4 pages
                      corresponding with the Display RAM. The combination
                      with the Page of LCD Block and Display RAM page can
                      changed.   The •sET STARTING PAGE. defines the mapping
                      bet~een the Page in Display RAM and the Page of LCD
                      Block.

                      Ex.
                      Assume that Starting page is ~et to 2. Then mapping
                      bet~een Display RAM and LCD PAGE becomes as shown as
                      follows.

                -LCD BLOCK
                Upper    +-----------------------+
                                             .,
                             PAGE2 in Display RAM
                              is displayed here

                        +-----------------------+
                             PAGE3 in Display RAM
                              is displayed here

                        +-----------------------+
                             PAGE0 in Display RAM
                              is displayed here

                        ..+-----------------------+
                         I

                             PAGE1 in Display RAM
                              i9 displayed here
                         I
                         I

                Lower   +-----------------------+
                        Fig 9.3

                                             ....
        9.3.2.4    Select Addre9s Counter Mode

                m9b 7   6   5   4   3   2   1   0
                  +---+---+---+---+---+---+---+---+
                  : 0 : 0 : 1 : 1 : 0 : 0 : 1       :u10: ouT AXFE
                  +---+---+---+---+---+---+---+---+

                        U/O(Up/Oown count) --- 0 Up Count
                                               1 Down count
                  Description:
                    Set OFFSET Counter Mode.

                                  -· 162 -
                                               .,
        9.3.3    Read Status        Read The Status Of Segment Driver.

                msb 7        6       5        4   -·~ 3   - 0   1sb
                 +----+-------+------+-----+-----+
                 lBUSYlUP/DOWNlON/OFFlRESETlXXXX: IN AXFE
                 +----+-------+------+-----+-----+
                 RESET
                    0
                            -----    Sta~us of the RST pin
                                     Normal
                        1            RST is low 1evel
                                     (BUSY must be 1)
                 ON/OFF
                    0
                            -----    Display ON/OFF
                                     Display OFF
                    1                Display ON
                 UP/DOWN
                    0
                            -----    Mode of Address counter
                                     Down counter
                    1                Up   counter
                 BUSY
                    0
                            -----    Normal
                    1                Operating Command or
                                     Writing/Reading a data.

                                                .,.
          9.3.4   ~rite/Read Display Data

     ..                                 -·~-. .
                                             ~-
                   +--+--+--+-~+--+--+--+--+
                   :O7lO6lDSlD4lO3:D2lD1:O0:          IN/OUT "'XFF
                  ·+--+--+--+--+--+--+--+--+

                   Description:
                  Read the data from the Display RAM that is pointed by
                  PAGE and OFFSET counter. If you want read some portion
                  of the Display RAM, use this command after Setting t~e
                  PAGE   counter and OFFSET counter by ·set Address
                  Counter· command and ·set Page       Counter'   command
                  described before.    Note that one dummy read must be
                  done before using this command in order to get a
                  correct data.

          9.4     SOFTWARE FOR LCD

      ;           This section describes not ohly how to handle the LCD
          without reading the routines stored in ROM #0 about LCD, but
          also how to maintain the book-keeping area for LCD in the RAM.

          9.4.1    How To Initialize The LCD.

                    What should be done in initialization is following.
                   1) Set up Address counter. Usually Page 0, Offset 0.
                   2) Set up Offset Counter Mode.
                   3) Set up Starting Page.
                   4) Select Display ON/OFF.

                  The tiny program shown        blow      initializes   LCD's   all
          Segment Drivers as below.

                    PAGE COUNTER= 0
                    OFFSET COUNTER= 0
                    UP COUNTER MOOE
                    STARTION PAGE= 0
                    DISPLAY 0N

                    Note:
                    Whenever the power is turned on, LCD is initialized by
                    the reset pulse of the hard wear. At that time,
                    Display is turned OFF, Offset Counter is set to count
                    up mode. Another status is not determined.

                    The ROM #0 always reinitializes LCD as Display ON,
                    Starting Page = 0 and Offset counter count up mode
                    when a character is displayed.

                                              .,..
        9.4.1.1     Sample Program For LCD Initialization.

       . ,•                                          ---'
         ; ·In it i a 1 i ze Segment driver •
        ,•

        ·---
        ,    Eciuaters
       PORTA   EQU           "X089
       PORTS   EQU           "X08A
       LCDCOM EQU            "X0FE
       LCDSTAT EQU           "X0FE

       LCDINIT:
                   DI                            ; Inhibit disturbance for Por~
       A/8
                   CALL      SELALL             ; Select      all Segment Driver.
                   CALL      LCOBUSY            ; Yait      until LCD become Ready.
                   XRA       A
                   OUT       LCOCOM .           ; Reset Address Counter.
                   CALL      LCOBUSY
                   MVI       A,"X38             ; Offset counter Up mode.
                   OUT       LCDCOM             ;
                   CALL     LCOBUSY
                   MVI      A,"X3E              ; Set starting PAGE=0
                   OUT      LCOCOM
                   CALL     LCOBUSY
                   MVI      A, ""X39            ; Display ON.
                   OUT      LCDCOM              ,•

       LCOBUSY:,
       ; Uait until LCO become Ready.
               IN      LCDSTAT                  ; Get LCD status.
               RLC                              ; Move MSB to CF.
               JC      LCOBUSY                  ; Wait if LCD is busy.
               RET

       SELALL:
       ; Select all Segment Drivers

              ,-

                MVI     A, "XFF         ,•
                OUT     PORTA           : S9h
                IN      PORTS           ; Get current status.
                ORI     03              ; Select block 9,10.
                OUT   - PORTS
                RET
                ENO

        9.4.2   How To Write A Character.

               Writing a character on-the!LCO is performed by writing
       some Bit patterns in the Display RAM of Segment Driver.

                  Basic sequence of writing a character on the·LCO is as
       follows.

       1.   Select LCD Block(Segment Driver) which you want to    PUT   a
            character.
       2.   Set the Offset counter mode.(Usually Up mode)
       3.   Set the Address where 1st byte should be written.
       4.   Write the Bit pattern.
       S.   Set Starting PAGE counter
       6.   Insure Display ON.

                  rf.   Next sample program.

                            ,,.-
        9.4.2.1
                                               -   .       .
                   Sample Program Of Writing A Character On The LCD.

               This Sample program shows how to write a character on
       the LCD.    This routine updates the pointers which is used by
       System ROM, ROM #0, to maintain the system circumstance.

        ; Sample program to write a character on LCD.
        ; This program performs same function as the ·following BASIC
        ; program •
        •
        '; 10 LOCATE 0,0
        ; 20 PRINT "A"
          30 END
       CSRY       EQU      ""XF3ES                       ; Cursor Y position
                                                       •       (1 to 8)
       CSRX       EQU      ""XF3E6                      '; Cursor X position
                                                         •     (1 to 40)
       LCTEY      EQU      "'XFEB9                     ;' Character Y Position
                                                         •     (0 to 7)
       LCTEX      EQU      ""XFEBA                     ;' Character X Position
                                                               (0 to 39)
       PORTA      EQU      ""XB9                       ; Segment Driver Select
                                                       ; Port.               •
       PORTS   EQU         ""XBA                       ; ditto
       LCOCOM EQU          "'XFE                       ; LCD command Port.
       LCDSTAT EQU         "'XFE                       ; LCD Status Port.
       LCOIO   EQU         ""XFF                       ; LCD data I/O Port.
               ORG         ""XF000                     ; 614400

       LOCATE:
       ; LOCATE 0,0
               LXI         H, ""X0101                  ; To set cursor position
                                                       •
                                                       •  (0,0)
                  SHLO     CSRY                        •
                  LXI      H, ""X0000                  '
                  SHLO     LCTEY

       PREP:
       ;-- Select Block 1 to write (1,1)
               DI                      ; Inhibit disturbance for
                                       ; Port A/B of 81C55.
                                       ; You need not do DI as
                                       ; far as no one

r
                                                           "
                                                      ; changes the data port of
                                                      ; 81CSS. You have to consi~er
                                                      ; other INT routines.
                         MVI        A,"X01
          •
                         OUT        PORTA             ,•,• Select
                                                            -·    Block 1
                         IN         PORTS             ; Get current status.
                         OUT        PORTS
                         CALL       LCDBUSY           ; Wait until LCD become ready.
              .          MVI
                         OUT
                                    A,0
                                    LCDCOM
                                                      ; Page 0,offset 0.
                                                      •,

                         CALL       LCOBUSY           ,•
                         MVI        A,"800110010      ; Offset counter Up mode.
                         OUT        LCOCOM
              CHROUT:
                         LXI        H,FONTA           ; Get start Address of Font A.
                         MVI        C,"X06            ; Set Font size.
                   •
              WRITE:
              ,•
              ; Write data to Display RAM of LCD
              ,•
              ; ENTRY:        CHLJ = Font start address.
              ;               CCJ ·= Length of Font.
                         CALL      LCDBUSY            ; Wait until LCD become Ready.
                         MOV       A,M                ; Get font Pattern to send.
                         OUT       LCOIO              : Write to Display RAM of LCD.
                         INX       H                  ; Up date PTR.
                         OCR       C                  ; Bump Counter.
                         JNZ       WRITE              ; To send next pattern.
                                                      ; Offset counter is Auto
                                                      ; increment Mode, so ~e don't
                                                      ; care about OFFSET counter.
                         LXI       H,CSRX             ; Up date Cursor PTR.
                         INR       M                  ; No check for end of line in
                                                      ; this program.
                         LXI -     H,LCTEY
                         INR       M

              ;---- Set starting page--------
                         MVI       A,AX0FF; Select all Block.
                         OUT       PORTA
                         IN        PORTS

                                                    ...
                  ORI    "'800000011
                  our·   PORTB
                  CALL   LCOBUSY               • Wait unti 1 LCD become Ready •
                  MVI    A, "'X3F.             ,, St~rting page 0 •
                                               .•
                  OUT    LCOCOM
                  MVI    A,"X00111001           Insure display ON •
                  OUT    LCOCOM
                  EI
                  RET

       LCOBUSY:
                  IN     LCOSTAT               ,• Get LCD status •
                  RLC                           Move msb to CF •
                  JC     LCOBUSY
                  RET

       FONTA:     OB     "'X3C, ""X12, "'X11   ,• Font data for   I   A   I

                  OB     "'X12,""X3C,"'X00
                  ENO

                                                   t
         9.4.3    How To Set/reset A Dot On The LCD.

                  TheSample program shown blow explains   how   to
        set/re5et     dot on the LCD. It does same function as the
                        a
        following·BASIC program.

                  100 CLS
                  110 FOR Y=9 TO 22
                  120   FOR X=60 TO 80
                  130     PSET<X,Y)
                  140   NEXT X
                  150 NEXT Y
                  160'
                  170 FOR Y=14 TO 18
                  180   FOR X=64 TO 76
                  190      PRESETCX,Y)
                  200   NEXT X
                  210 NEXT Y
                  220 ENO

        9.4.3.1    Sample Program For SET/RESET Dot •

        ,•
        ; Sample program for SET/RESET a Dot •
        ,•

        PORTA   EQU         "XB9               ,• LCD block select •
        PORTS   EQU         "XBA               •, I I
        LCDCOM EQU          ""XFE                LCD command •
        LCDSTAT EQU         LCDCOM              • LCD status •
                                                , LCD data I/O.
        LCOIO   EQU         ""XFF

        PSET:
                  DI                            •, Disable a 11 interrupt
                                               ,• to keep correct block
       select.
                  XRA       A                   ,• To set SET flag.
                  STA       SR                 ,• Set/Reset Flag •

                                                                      /
                                                     ..
                  LXI     B., "X140E          ..., CBJ=20 X count,CCJ=14 y
       count.
                LXI       H,"'X0A09           ,• CHJ=X Position,CLJ= Y
       Position.
       PSETl:
                PUSH      H                   ~.,, Save CX,Y) Position.
                PUSH      B                   •     Save X,Y count •
               ·CALL      MAIN
                POP       B                    ,• Restore X,Y count •
                POP       H                   ,• Restore X,Y position
                INR       L                    •,
                                                Advance Y position.
                OCR       C                   • Bump Y counter •
                JNZ       PSETl               '
       PRESET:
                  MV.I    A,"XFF               •    To set SR Flag.
                  STA     SR                  ,'• Set Unplot Flag •
                  LXI     B,"X0C06            •     CBJ=12,CCJ=06
                  LXI     H,"'X0E00           '• <CHJ,CLJ>=<14,13>
       PRESET1:                                '
                  PUSH    H                     • Save X,Y Position.
                  PUSH    B                   ,•' Save X,Y counter •
                  CALL    MAIN
                  POP     B                     •, Restore X,Y counter.
                  POP     H                   ,• Restore X,Y position.
                  INR     L                     • Advance Y position.
                  OCR     C                    '• Bump Y counter •
                  JNZ     PRESET!              '
                  RET
       MAIN:
        •
        '•,       CHJ = X position
        ,•        CLJ = y Position
        ,•        CBJ = X count
        ,•        CCJ = y count
                  PUSH    H                   • Save X.Y Position.
                  CALL    DOT                 ,•' Plot/Unplot a dot at CX,Y)
                  POP     H                       • Retrieve Position.
                  INR     H                    •' Advance X POSITION.
                  OCR     B                     ',• Bump X counter •
                  JNZ     MAIN                 ,•
                  RET
        DOT:
                  CALL    LMAIN
                  LOA     SR                   •, Get SR flag.
                  ORA     A                   •, See if  set/reset?
                  JNZ     RESET                ,• Branch if Reset.
                  MOV     A,E                 ,• Get MASK pattern .

                                                     ..
                 ORA    D                   a   •f   CAJ = data to write.
                 JMP    DISP
        RESET:
                 MOV    A,E                     ,• Get Mask Pattern.
                 XRI    ""XFF                   ,• Reverse MSK pattern •
                 ANA    D                        •, CAJ = data to write.

        DISP:
                 MOV    D,A
                 CALL   WRITE
                 DI
                 MVI    A, ""XFF                ,• Select all Block.
                 OUT    PORTA
                 IN     PORTS
                 ORI    ""800000011
                 OUT    PORTS
                 CALL   LCDBUSY                 ,• See if Led Busy.
                 MVI    A,"'800111111           • Starting Page 0
                 OUT    LCDCOM                  '
                 CALL   LCDBUSY
                 MVI    A,'"'800111001          ,• Display ON.
                 OUT    LCDCOM
                 EI
                 RET

        LMAIN:
         • ENTRY: CHJ·= X po!lition in Block-1
        '•        CLJ = y Position in Block-1
        '• Reg:
        '
                 PUSH   H                       ,• Save X,Y position.
                 PUSH   H
                 CALL   SEL2                    • Select Blocl<-2.
                 CALL   SETADR                  ,'• Set Address of Display RAM.
                 CALL   READ                     ,• Read· the LCD.
                 POP    H                       •,   Retrieve X,Y position.
                 CALL   GETMSK                   ,• Get Mask Pattern.
                 POP    H                       ,• Retrieve CX,Y> Position
                 CALL   SETADR
                 RET
        WRITE:
        ,• Fune: Output CODATJ to LCD.
         ,•
         ,• Reg: A and Flags.
                 CALL   LCOBUSY
                 MOV    A,D                     ,• Get Data to r..1rite •

                                                         •

                      OUT        LCOIO                   ·•
                      NOP                           ; Must be EI at final.
                      RET
        READ:
                                                        -l
              Entry: Non
              Exit:     COJ = Current Data in Display RAM.
              Reg:    A,O and Flags.
                      CALL       LCOBUSY           ; Wait until LCD become Ready.
                      IN         LCOIO             ; Dummy Read.You must do this
        to                   .
                                                    ; get correct data.
                      CALL       LCOBUSY           •
                      IN         LCOIO             ;' Get Valid Data.
                      MOV        O,A               ; Save it.
                      RET
       GETMSK:
       ; Entry: CLJ ·= ·y Position
        ,•
        ; Exit:        CEJ = Mask Pattern •
        ,•
        ; Reg~        A,L,E and Flags.
                       MOV       A,L               ; Get Y position.
                       ANI       "B00000111        ,•
                       MOV       L,A               ; Set counter.
                      .MVI       A,"B80
       MSK1:
                      RLC
                      OCR        L                 ; Bump counter.
                      JP         MSK1              ; Branch if not finished.
                      MOV        E,A               ; Save Mask pattern.
                      RET
       SETAOR:
        •
        ',•   ENTRY: CHJ = X Position on Block-2
       ,•            CLJ = y Position on Block-2
       ,•
         •
       ',• Register:
       ,•             A,H,L and Flags •
                      MOV        A,L                    Get Y position.

r·
                        RAL                       ; ; Mbve Bi t4/3 to Bi t7 /6.
                        RAL
                        RAL
                        ANI      "'81100'e000        ; Get page.
                        ORA      H                   ; CAJ = Page and OFFSET.
                        MOV      L,A              "' ; Save it.
                        CALL     LCOBUSY             ; Wait until LCD become Ready.
                        MOV      A,L                 ; Retrieve Address.
                        OUT      LCOCOM
                        RET
            LCOBUSY:
            ; Entry: Non
             ,•
             •    Fune: Wait unti 1 LCD become Ready.
            ,'•
              ,• Exit: Non
             ,•
               • Reg:  A and Flags~
            ,•'
                        IN      LCDSTAT            ; Get LCO status.
                        RLC                        ; Set Busy FLG to CF.
                        JC      LCOBUSY            ; Wait if LCD is BUSY.
                        RET
            SEL2:
            ; Select Block-2
            ;
            ; Reg:      A and Flags •
            •
            '
                       OI
                       MVI      A,"'800000010      ; Select Block-2
                       OUT      PORTA
                       IN       PORTS
                       ANI      "'811111100
                       OUT      PORTS
                       RET

            SR:         DB      00                ; Set/Reset flag.
                                                  ; 0=set/FF=r~set.
                       ENO

      · 9.4.4    How To Define A Characte·r

               This section describes how to define        the   User
       DefinabJe characters in PC-8201A.- And how to store them 1n a
       portion of RAM where ROM #0 can use this your new Fonts.    In
       this section, BASIC command will be used to do some operation.

       9.4.4.1    Structure Of Character And How To Define It.

               One character consists of 6 * 8 dots. Vertical 8 dots
       is handled by a byte. So in order to define a character, you
       must define Sequential 6 bytes of data. The data AX3C,  AX12,
       AX11, AX12, AX3C, AX00 define "A" as follows.

                    08     <"'X3C, "'X12, "'Xif~ "'X12, "'X3C, "X3C, "'X00 >
                           : CG pattern for- 'A'

        DATA Pattern                                     Font pattern
                0    1   2 · 34   s               0   1   2   3   4   S
        lsb +---+---+---+---+---+---+           +---+---+---+---+---+---+
         0 : 0 : 0    1 I 0 : 0 : 0
            +---+---+---+---+---+---+
                                                        : * :
                                                +---+---+---+---+---+---+
         1 : 0 I 1 I 0: 1·: 0 I 0 I
            +---+---+---+---+---+---+
                                                      * : : * :
                                                +---+---+---+---+---+---+
        2   : 1 : 0 I 0 : 0 I 1 I 0             : * :              * :
            +---+---+---+---+---+---+           +---+---+---+---+---+---+
        3   : 1 : 0 l 0 : ·0   1    0           : * : : : : * : :
            +---+---+---+---+---+---+           +---+---+---+---+---+---+
        4   : 1   1    1 I 1 I 1                : * : * : * : * : * :
            +---+---+---+---+---+---+           +---+---+---+---+---+---+
        s     1 : 0 : 0 I 0 I 1 : 0
            +---+----+---+----+---+---+
                                                : * :          -: * :
                                                +---+---+---+---+---+--+
        6                      1 I 0            : * :           ·: * :
            +---+---+---+---+---·+---+          +---+--~+---+-~-+---+---+
        7  I 0 I 0 : 0 I 0 I 0 I 0                   . I
                                                         I

       msb +---+---+---+---+---+--+            +---+---+---+---+---+---+

                          Fig 9.4

                                         -~   -~
        9.4.5   How To Store The Your Own CG

               This section explains how to store USER CG in   to   RAM
       which also can be used by ROM #0. ,t

               Assume that you have to define Fonts as described in
       the previous section.     Each Font consists of 6 bytes. Font
       Data has been BSAVEed in the RAM file named "FONT.CO", uhose
       start address is AXYYZZ.

       You can make "FONT.CO" in the following sequence.
       1.   Reserve area for "fONT.CO" by CLEAR command in BASIC.

                CLEAR <length>, <startaddress>
       2.   Load "FONT.CO" into RAM

                BLOAO "FONT"

       3.   Register the top address of the CG.
                POKE A065216,<Start Address (High byte))
                POKE A065215,<Start Address (Low byte))

       After this sequence, ROM #0, for instance, BASIC, can use    the
       new Defined CG.

                                                                 ,,•·

                                                    ..•
       9.S      AVAILABLE SYSTEM WORK AREA

               This section explains· how t6 use the system Character
       Generator and how to use the available System work area.

       9.S.1     How To Use The CG In System ROM.

               You might want to use the CG of ROM #0 instead of
       making new CG by yourself.   In such a case, this Section will
       help you.

               The Character Generator of characters whose code 1s
       from AX20 to AX7E, are stored in the highest portion of the
       ROM i0, from AX7887 to AX7837. Each Character consists of 5
       bytes:   The sample program shown blow explains how to get the
       character pattern and how to expand it into the standard
       shap•, 6 * 8 pixels. Assume that this program is written to
       be stored as the CO File in the RAM files and will be executed
       with ROM #0 •

       •,
       ; ENTRY CAJ = character Code (AX20 to AX7E)
       ,•
       EXPAND:
                  SUI     A,AX20              ,•
                  MOV     C,A                 ,..
                  ADO     C                   ; *2
                  ADO     A                   ; *4
                  ADO     C
                  MOV     C,A                 ; CCJ offset from base of CG.
                  MVI     B,"'X00             ,•
                  LXI     H,CGAOR
                  DAO     B
                  LXI     8,TEMP
                  MVI     O, "'XS             ; Set font data length.
       NEXT:
                  MOV     A,M                 ; Get Font data.
                  STAX    8
                  INX     H
                  INX     B
                  OCR     D

                                         ··--•
                JNZ   NEXT
                ORA   A
                STA   TEMP+S
                RET
     .                                    -...i

                                                  •

                                                -··'
       9.5.2    VRAM AREA IN SYSTEM Work Area

               The area from XFBCO to XFE3F in the RAM,    is reserved
       for VRAM area of the LCD. ~rt is divided into 2 portions.
       Each portion can be hold. the character codes displayed on the
       LCD at a time.      So the each portion has 320 bytes. The
       attribute data is not saved in this.area. Only the character
       code is stored.
       1st      "'XFBC0-"'XFCFF     ;   Keep previous Page
                                    ;   in TELCOM.
       2nd      "'XFD00-"XFE3F      ;   Current Displayed

               The character code of the character displayed at the
       location (1,1) on the LCD display is stored at "'XF000, and the
       code of the character at (2,1) is stored at "'XFBC1 , and so
       on.   So the code of the left-lowest character, (40,8) is
       stored at "XFC3F. This.rule is used in the standard program
       in ROM #0. For instance, BASIC, TEXT and TELCOM use that area
       like a VRAM in the traditional disk top personal computer.
       The menu screen also utilize that area. But You can use this
       area as you like. The data in this area does not effect the
       information on the LCD display, as far as you use your o~n
       display routine.

                                         •.

                                                              •

                                  "'.' 182 -

                       ..   .
        9.5.3   Reverse The Attribute Of The Specified Area,

                 ROM #0 has the Reverse Attribute Table in Work Area.

                Th~ at~ribute ~ata-is ~ept i~ the area from AXFA60 to
       AXFA87, · Each bit represents the each character Box on LCD.
       (Therefore only 40 bytes can be handle the attribute of whole
       LCD screen.) When the bit is off (0), it shows that the
       character Box is displayed in normal mode.    And the bit is
       turned on, 1, that character Box is displayed in Reverse mode,
       The relation between the Attribute bit and Character Box is
       shown blow.     The relation of the reverse attribute bit and
       each character box is as follows.

       +---------------------------------------------+
       :c 1,1):( 2,1)l( 3,1):           : <39, 1 ) : C40 , 1 >:
       +--------------------------------------------+
       :< 1,2):( 2,2):( 3,2):           : <39 , 1 ) : <40 , 1 ) :
       +--------------------------------------------+

       +--------------------------------------------+
       :c 1,8)1( 2,8)1( 3,8):          : <39 , 8 >I <40 , 8 > :
       +--------~-----------------------------+
       AXFA60   Bit0            (01,1)
                Bit1            (02,1)
                Bit2            (03,1)
                Bit3            (04,1)
                Bit4            (05,1)
                BitS            (06,1)
                Bit6            (07,1)
                Bit?            (08,1)
       AXFA61   Bit0            (09,1)
                Bit1            (10,1)
                                     I
                                 .   I

       AXFA87 Bit0              (33,8)
               Bit1             (34,8)
               Bit2             (35,8)
               Bit3             (36,8)
               Bit4             (37,8)
               Bit5             (38,8)
               Bit6             (39,8)
               Bit?             (40,8)

```
