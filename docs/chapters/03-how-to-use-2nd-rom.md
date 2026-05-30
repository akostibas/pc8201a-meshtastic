# Chapter 3: How To Use 2nd Rom

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 27-48). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                      CHAPTER 3
                  HOU TO USE 2ND ROM

        When you want to make some programs stored in 2nd ROM,
there are a lot of matters should be attended and stored in
the 2nd ROM. The matters are interrupt jump tables and power
on/power off sequences.     You have to implement these tables
and sequences in order to process the ROM bank switching
smoothly.   Otherwise, PC-8201A will run away on switching the
ROM bank.    First half sections describe      the   interrupt
functions and power sequence.
        And you have to know the rules to handle the files and
data in ·RAM, too.   If you will use the routines in ROM #0 to
handle the RAM, you need not to care about the detail rules.
(You can get the information about the RAM file handling
routines in ROM #0 at the Chapter 8 and another technical
manual that has already been available by NEC HE in Chicago.
Please request it if you have not gotten it yet.) The last
half of this chapter describes how to use the routines in ROM
#0 from 2nd ROM, ROM *1·        (Hereafter ROM #1 sometimes
represents 2nd ROM.)
        If you want to make I/O control routines and store
them in 2nd ROM, you have to understand Chapter 9 to 14. If
you utilize the ROM #0's I/O routines, the last half of this
chapter and another manual will help you.

,_, ..

                    3.1   CONSIDERATION OF INTERRUPT

                            Basically, PC-8201A has     some  interrupt    service
                    routines in that system. The main purpose of. interrupts are
                    smooth processing in Power off trap, reading data from
                    Bar-code reader, communicating through UART(RS-232C) and using
                    Interval timer.

                    The interrupt table is located in the zero page area.

                               POUER OFF TRAP        NMI            "'X0024
                               BARCODE READER        RST 5.5        '"'X002C
                               UART                  RST 6.5        ""X0034
                               INTERVAL TIMER        RST 7.5        "'X003C

                            The Interval timer interrupt has the highest priority,
                    and UART has the second one. The lowest interrupt is used for
                    Barcode reader. The reason why the internal timer has the
                    highest priority is to scan the key and to co~nt the
                    auto-power off counter for saving the battery power. PC-8201A
                    has the ·Auto-Power Off• function·. Usually, this function is
                    executed after 10 minutes has past since last key stroke was
                    detected. (This interval can be set by the •pouER• command in
                    BASIC. Refer •pc-8201A Reference Manual  ) The interval .time
                    is used to count this period.

                               The interrupt hook table is located from ""XF386 to
                    "'XF394.    And that table is constructed in the following fig.

                               Interrupt hook table in RAM area
                               "XF386           POWER ON SEQUENCE
                               "XF389           BARCODE READER INPUT SEQUENCE
                               "XF38C           UART INPUT SEQUENCE
                               "XF38F           TIMER SEQUENCE and KEY
                                                        SCANNING SEQUENCE
                               '"'XF392         POWER FAILURE SEQUENCE

         /

       3.1.1    Power Off Trap       (ADDRESS "'X4CFA>

                This interrupt is Non maskable. When power switch is
       turned off, this interrupt occurs. The following sequence is
       the algorism of this interrupt.

                1: Disable the interrupt
                2: Call hook table
                3: Reset Key wait counter
                4: Cancel Time counter
                5: Out a data to the.Auto power off port
                6: HLT

       The detail bit assignment        of       the       auto       power       off       port   1s
       following.
                PORT ADDRESS    "'XBA <OUT>
                        81CS5 port B

          MSB        7   6       5           4         3          2           1         0

                Bit 7                RTS output
                Bit 6                DTR output
                Bit 5                BELL
                                             0:Ring be 11
                                             1:Stop be 11
                Bit 4            Auto power off
                                         0:0ff
                                         1:0n
                Bit 3            DCO/RO select
                Bit 2            Melody control
                                         0:0n
                                         1:0ff
                Bit 1            LCD chip select #1
                Bit 0            LCD ch1p· select #0

                rf.Chapter 9 to 15 about more                detail       information              of
                this port.

~-
t

             3.1.2     Barcode Reader

                        (ADDRESS AXF389 with Disable interrupt)

                        This interrupt is using RST 5.5. If you do not use
            barcode·    reader program, this interrupt should do "RETURN"
            soon.

                 ,,-

       3.1.3    UART

                 (ADDRESS AX6E00 with Disable interrupt)

               This interrupt is using RST 6.5.  This interrupt is
       caused by UART.     (Serial communication device 6402) This
       interrupt occurs when the data in 6402 receive buffer is
       available.

       The algorism of this interrupt is shown below.
                1: Disable the interrupt
                2: Call hook table
                3: Read data from 6402
                4: Read error status from 6402
                S: Xon/Xoff control check
                6: SI/SO control check
                7: Return to previous process
                PORT ADDRESS    AxDs couT>
                UART control port

          MSB        7   6     s     4       3   2         1   0

                Bit 7           Not used
                Bit 6           Not used
                Bit- S          Not used
                Bit 4           Character length select ~2
                Bit 3           Character length select #1
                Bit 2           Parity inhibit
                                         0:Parity generation Check
                                         11Parity generation check,
                                             Inhibit
                Bit 1           Even parity enable
                                        0:0dd parity
                                        1:Even parity
                Bit 0           Stop bit select
                                        0:Stop bit 1 bit
                                        !:Stop bit 1.5 bit
                                           in case of DATA Length 1s 5
                                        !:Stop bit 2 bit
                                           1n case of DATA Length
                                           is not 5

                    PORT ADDRESS          "'XCS (OUT)
                    UART data I/O port

              MSB
                    -----------------~-----------------------------
                       7     6     5    4     3     2    1     0
                    ----------------------------------------------
                    Bit 7                 Data #7
                    Bit 6                 Data #6
                    Bit 5                 Data *5
                    Bit 4                 Data #4
                    Bit 3                 Data #3
                    Bit 2                 Data #2
                    Bit 1                 Data *1
                    Bit 0                 Data *0

                    rf. Chapter 12 and 15 about more    detail   information
                    about UART.
                                                                  •

                                   ,,,-

        3.1.4       Interval Timer (ADDRESS AX1EBE ~ith Disable Interrupt)

                This interrupt is using RST 7.5.       This is   the
       interrupt from interval timer.       (Timer device 1990) This
       ·interrupt is also used for the key scanning.
               In the system's initialization, the interval timer
       which is controlled by 1990, is set up as 4m second mode. The
       port for 1990 is illustrated below.

       PORT ADDRESS

       Calendar clock (1990) control port

           MSB            7       6       5    4         3       2      1       0

                    Bit 7                 Not used
                    Bit 6                 Not used
                    Bit 5                 Not used
                    Bit 4                 Data output
                    Bit 3                 Shift clock
                    Bit 2                 Command output i2
                    Bit 1                 Command output #1
                    Bit 0                 Command output #0
          Command #2             Command #1   Command #0
                1                     0            0             timing 64Hz
                1                     0            1             Timing 256Hz
                1                     1            0             Timing 2048Hz
                1                     1            1             TEST mode

                    In the initialization routine, the command is                   set   .UP
       as AX05.       It means 4m second interval.

                    rf.       Chapter 15 for more information about 1990

               The follow¼ng step             is   the       algorism   about       interval
       timer sequence.

                1: Disable the interrupt
                2: Call hook table
                3: Maek RST 7.5,RST 5.5
               4: Reverse cursor character for cureor blink
               5: Key matrix scanning
               6: Return to the interrupted process

                                           /

               When you would like to use 2nd ROM, you must write the
       following information into the· 2nd ROM's special reserved
       area. The special reserved area is located from AX0000 to
       AX0047.   These area will be used for 2nd ROM starting jump
       instruction and IO code, and the file name of 2nd ROM.    This
       name is displayed like a one of the RAM files on Menu screen
       by 1st ROM, ROM #0. The following figure is the explanation
       about 2nd ROM special reserved area.

        ADDRESS          CODE
        AX0000 JMP       START      ,• 2nd ROM start address
        AX0003
        AX0024           RET        ,• Non maskable interrupt
        AX002C           RET          ,• Barcode reader interrupt
        AX0034           RET         ,• UART interrupt
        AX003C           RET         ,• Interval timer interrupt
        AX003F                      ,• Reserved for RST interrupt
        AX0040           DB         'A'
        AX0041           DB         '8'        ,• IO code for 2nd ROM
        AX0042           DB         '2NDROM'; File name which displayed in
                                            ,• the menu
        AX0048 START:                        ; 2nd ROM code
                S P E C I AL        R E S A R V E 0       ADORE S S

                If these data are implemented correctly, the name will
       appears on the 1st ROM's menu screen. So it's easy to switch
       the ROM and execute the program in it. When you want to start
       the programs in 2nd ROM from the Menu mode of ROM #0, move the
       cursor to 2nd ROM's file name on the screen.       Then please
       press return key.      The system will fall into the 2nd ROM
       program.

      3.3   THE METHOD TO USE 1ST ROM ENTRY FROM 2ND ROM

              If you want to use the routines in 1st ROM from 2nd
      ROM, at the first, you have to create a special routine in the
      higher memory location of RAM (AX8000-AXFFFF> and use it. That
      routine swltches the ROM bank with using bank switching method,
      and calls the routine in 1st ROM.  It is very important for you
      that the interrupts must be disabled before you change the ROM
      banks. And in addition, as the following sections will tell
      you, you have to change the hook table for Power down interrupt
      that was changed by 2nd ROM to restart the current process in
      2nd ROM program at next power-on. With this hook table for 2nd
      ROM, the power down in ROM #0 will cause the fatal       error.
      Power-off interrupt can not be prohibited. And you have to
      consider about the contents of the routine which you will call.
      The reason is that some routines in the 1st ROM routine may
      enable the interrupts in some parts of their code even if you
      disable the interrupts just before switching the ROM banks to
      call 1st ROM entry. Therefore you had better change the all
      hook tables in the current book keeping area.    I suggest that
      all hook table should be replaced with previout contents which
      were stored by 1st ROM, just before calling ROM bank-switching
      routine ,and.restored just after coming back from 1st ROM.

      The following program is the sample which uses   1st   ROM   entry
      points from 2nd ROM.

      3.3.1     Sample
         ,•       TITLE   Using 1st ROM entry from 2nd ROM
        ,•
        ,•
        ;         This sample will enable to use 1st ROM entry from
        ;         2nd ROM.
        ;        ·Some routines in 1st ROM might enable interrupts,
        ;         so all interrupt
        ;         hook table should be replaced with RET code.
        ;         And restore them after done the 1st ROM calling •
        ,•
          •      Entry    CENTRYJ:1st ROM entry address
        ',•      Exit     for return condition of 1st ROM
        ,•
        ; <<< SYSTEM define label >>>
       BNKCRL    EQU      "X0A1             ; Bank control port
       STATUS    EQU      "X0A0             ; Bank status port
        ; <<< Main routine>>>
                 ORG      "X8000            ; This routine must be stay
                                            ,• "X8000-~XFFFF
       ROM1ST: SHLD       WORKH             ; Save register HL
               LXI        H,RET2NO          ; Return address from 1st ROM
               PUSH       H                 ; Push stack top
               LHLD       ENTRY             ; Pick up 1st. ROM entry
                                            ; address
                 PUSH     H                 ; Push stack top
                 LHLD     WORKH             ; Restore HL
                 PUSH     PSW               ; Save all register
                 DI                         ; Disable interrupt
                 IN       STATUS            ; Get current bank status
                 ANI      "811111110        ; Switch 1st·ROM data set up
                 OUT      BNKCRL            ; Bank select
                                            ; Now "X0000-"X7FFF are
                                            ; 1s·t ROM
                 EI                         ; Enable.interrupt
                 POP      PSW               •
                 RET                        ;' Jump 1st ROM entry
       .' <<< Return from 1st ROM>>>
       RET2NO: PUSH       PSW               . Save a 11 register
               IN         STATUS            '• Get current bank status
               ORI        "'B00000001        ' Switch 2nd ROM data set up
               OUT        BNKCRL             • Bank select
                                            '• Now "X0000-"X7FFF are
                                            '• 2nd ROM
                 POP      PSW               ' Pick up a 11 register

                RET                      ,•
        ; <<< SYSTEM WORK AREA>>>
       ENTRY:   ow     AX0000            I 1st ROM entry address
       WORKH:   OW     AX0000            ; HL register saving area
                END

                •

        3.4    SEQUENCES IN THE 2ND ROM

        1.    INITIALIZE
                      This sequence sets     up   CSPJ(Stack   Pointer),
              power-on trap and other interrupt routines.        Then it
              copies the book-keeping area and system area.      finally
              some peripherals will be initialized by this routine.

       2.     RETURN TO MENU

                      At the first, this sequence selects   the standard
              RAM, RAM #0 and resets the power-off trap.    Then it jumps

       3.     POWER DOWN

                      When power is turned off,       the   control   is
              transferred to this sequence.   In this sequence, you must
              save all registers and circumstances which should be saved
              in the stack. So the stack-pointer is most important to
              resume the current processing on the next power-on.
                  The RAM bank number is always stored in RAM #0.      On
              turning   on,   the   1st ROM and RAM #0 is selected
              automatically. And the bank-switching procedure will     be
              called in Power on sequence if t~e number of the RAM bank
              was not identical to the RAM #0 in the powe~ down
              sequence. After changing the RAM bank, all registers will
              be restored and pending· procedure will be         resumed.
              Therefore in the stack, the address of the process which
              was abandoned by Power down trap should be stored.
                  In addition, in order to resume the abandoned process
              with 2nd ROM, you have to do special power on/power off
              sequence. In power off trap, you should the set the start
              routine of the special power-on sequence which switches
              the ROM bank.   I recommend to use the hook, AXF38F.
              Usually,  •JUMP to POWER FAIL SEQUENCE• command is st~red
              here.  In 2nd ROM, however, you have to rewrite this hook
              table and call the special power down routine here.    In

t.

                 it, the address of special power-on routine on the stack.
                 In this case, the following information should.be stacked
                 before •HLT• command is executed.

                       resuming   address

                       starting address of
                        the ROM switching
                         routine
                       Contents of Pointers
                                              <-- CS°TAKSVJ

                     CSTAKSVJ keeps the SP's value at •HLT·.
                     Fig 3.1

            4.   POWER ON

                          At the first, .the initializing routine in ROM #0
                 checks the RAM bank number in BANK (AXF308) when power-off
                 was exe~uted. When power-off was done in non-standard RAM
                 bank, RAM bank-switching routine is called and switched.
                 Then, the registers' contents will be restored.     If the
                 address of the process which should be resumed was
                 stacked, the address will be picked up and executed. When
                 the power-down was detected in ROM #1, the address of the
                 special ROM switching routine ought to be stacked above
                 the address of the process should be resumed. Therefore,
                 after switching the ROM, the abandoned process will be
                 resumed.

        The following figure are the general 2nd ROM                routine   control
        sequence.

                          : MENU   mode
                                                   .      ROM:
                                          of     1st

                                                            A

                             :- select 2nd ROM
                             I
                             I
                             V
               ---------------------------------------~---
                 :--------------
                         INITIALIZE                     RETURN

                                                            :-Return
                     I
                     I

                     : Main routine of 2nd ROM

                                                            I
                                                            I
                            +-Turn off power switch:

                         POWER DOWN : .                POWER ON .

                                                           ...
                                                           :-Turn on
                                                                 power   switch
                            V

                            P O WE R       0 F F

                             Fig 3.2

rJ

             3.5    SUMMARY -- IMPORTANT NOTICE

                    If you want to make 2nd ROM program, you     should   take
            care of the following manner.

            1.     Interrupt vector
                           If you do not want to use interrupt, all interrupt
                   table should be set with only ·RET• code. But I suggest
                   you that you had better use interval     timer interrupt,
                   because of saving the battery poWer by using auto power
                   off function.    The counter for this auto power off
                   function is counted by this interval timer interrupt.   If
                   you do not use this function, the battery consumption may
                   be more larger than now.

            2.     Bank of RAM
                           Do not switch the ROM bank when PC, Program
                   Counter, points a routine in that ROM. You can guess the
                   reason and it's not so hard to imagine these bank
                   switching will cause the fatal problem for system. At the
                   worst case, the all files which you stored will be lost.
                   And also you should be careful in stack area, too.

            3.     PC-8201A book keeping area
                           The book keeping area are very important for this
                   system, so you never change that area without careful
                   consideration. Please read Chapter 7 ·aoOK KEEPING AREA•.

            4.     Power on/off sequence
                           Please use power off interrupt to detect the power
                   down.   I suggest that you had better use the real time
                   interrupt service.to poll the power down signal.

               If you want to use 1st ROM entry from 2nd ROM, please
       take care of the following point. The all routines rewrite
       some work area sometimes. So, if you use 1st ROM entry from
       2nd   ROM   witho~t   understanding that routine's internal
       specification, the system might be crashed.      In addition,
       interrupts and ·stack area are other important points. Refer
       to 2.3 •The method to use 1st ROM Entry from 2nd ROM• and its
       sample program.

       3.6     SAMPLE

                 TITLE   2nd ROM sample header and useful routine

        ; <<< SYSTEM define label >>>
       BANK      EQU     "'XF3DB             ; Bank save area
       ATIDSV    EQU     "'XF382             •
       PWHOK     EQU     "'XF386             ': Power on hook table
       RST55     EQU     "'XF389             ; Rst 5.5 hook table
       STAKSV    EQU     "'XF9AE             •
       AUTOID    EQU     ""X9C0B              '•
       SAVSTK    EQU     "'XFA00             '•
       STATUS    EQU     "'XA0               ;' Bank status
       BNKCRL    EQU     "'XA1               : Bank control
       PWPORT    EQU     "'XB8               ; 81C55 chip select
       PORTS     EQU     ""XBA               ; 81CSS port 8
       FREE      EQU     "'X????             ; You must set your ram
                                             : free portion address
        ; <<< Main routine>>>

       START:
                 JMP     INIT                : 2nd ROM start address
                 ORG     "'X0024             ; Non maskable interrupt
                                             : table
                 JMP     POWER               ; Power down trap
                 ORG     ""X002C             ; RST S.5
                 JMP     BARCOO              ; Barcode reader interrupt
                                             : table
                 ORG     "'X0034             ; RST 6.5
                 JMP     UART                ; UART interrupt table
                 ORG     "'X003C             ; RST 7.5
                 JMP     TIMER               ; Timer interrupt table
                 ORG     "'X0040             ; IO code for 2nd ROM
                 OB      'AB'                ; AB is ID code for 2nd ROM
                 DB      '2NOROM'            ; File name which
                                             ; displayed in the MENU
       ; <<< Initialization of 2nd ROM program>>>
       !NIT:     LHLO    SAVSTK              ; Set stack pointer

                SPHL                       •,
                CALL     SETTRP            ; Set hook for resume
                                           ; 2nd-ROM's program,
                                           ; and other routine into RAM.
                CALL     HINIT             ; Hardware initialization
                JMP      MAIN              ; Goto main routine
        ,•
        ; <<< Hardware initialize routine>>>
       HINIT:   RET                        ;
        •
         ,•'
        ; <<< MAIN ROUTINE OF 2ND ROM>>>
        ,•
        ,•
       MAIN:                               ; Main routine
       ; <<< Set up hook>>>
       ; Set up hook table for 2nd ROM
       SETTRP: MVI     A,"'800000001        • Select standard RAM
               OUT     BNKCRL              '• Select!
               LXI     H,DTBL              •' Set some codes into RAM
               LXI     D,PWHOK            '•, for power on sequence
               MVI     B,TBLEND-DTBL       •,
               CALL    COPY                ,
                                           •
               LXI     H,TBLHOK           ,• Return code table
              .LXI     D,FREE             ,
                                          •   Free area of RAM portion
               LXI     B,HOKE-TBLHOK      • Set length
               CALL    COPY             ,'•
               RET                     ,•
       ,• CDEJ <- CHLJ
       COPY:    MOV      A,M               • Read CHLJ
                STAX     0                  '•, Save CDEJ
                INX      H                       •
                INX      D                    ',• Next address set
                OCR      B                      •, Decrement counter
                JNZ      COPY                 ,• Loop until done
                RET                        ,•
       •
       ;' The following code will be copied in RAM
        ; portion for re-power on sequences
        ; these part are interrupt hook table •
       ,•
       DTBL     EQU      $
                MVI      A,'"'800000001    ; These code will be
                                           ; copied into RAM
                OUT      BNKCRL            ; Bank select!

                                    45 -
~

                     JMP     Pl.JON              ; Jump power on trap
            BANK!:   OS      1                  ,•
            TSLENO   EQU     $

            ;                                         -
             ; The following code will be copied
             ; in RAM portion for return 1st ROM
            ,•
            TBLHOK   EQU     $
            RETSB:   XRA     A                  ; Clear A
                     OUT     BNKCRL             ; Select 1st ROM and
                                                ; standard RAM
                     JMP     "'X0000            ; Return!
            HOKE     EQU     $

            ; <<< RETURN >>>
            RETURN: MVI      A,"'800000001      ; Select standard RAM
                    OUT      BNKCRL             ,•
                    MVI      A,"B00000000        ,•
                    STA      BANK               ,•
                    LXI      H,"'X0000            ; Reset
                    SHLD     ATIOSV              ,•
                    LXI      H,RTBL             ; Rewrite code table
                    LXI      O,PWHOK            ; Interrupt hook table set
                    LXI      B,RTBLE-RTBL       ; Set length
                    CALL     COPY               ,•
                    JMP      RETSB              ; Return to 1st
                                                ; ROM's menu mode
            ,•
            ; The following code will be copy
            ,• in standard ram portion
            •
            '
            RTBL     EQU     $
                     RET                        ; Power on hook
                     NOP
                     NOP
                     EI                         ; RST S.S hook
                     RET
                     NOP
            RTBLE    EQU     $

            ; <<< Power on >>>
            PWON:    CALL    HINIT              •,
                     LOA     BANKI-DTBL         ; Select old RAM bank
                     OUT     BNKCRL             •
                     LHLD    STAKSV              '; Restore stack pointer
                     SPHL                       ,•
                     POP     PSW                 ,•
                     POP     8                  •,

                                                     .
                   POP    0                   ,•
                   POP    H                   ,•
                   RET                        ; Resume old program
        ; <<< POWER DOWN TRAP >>>
       POWER:      PUSH   PSW                 ,•
                   IN     PWPORT              ; Read power down port
                   ANA    A                   ; Check
                   JM     NTPWFL              ; No power down
                   POP    PSW                 ,•
                   DI                         ; Disable interrupt
                   PUSH   H                           ; Save HL
                   PUSH   0                   ; Save DE
                   PUSH   8                   ; Save BC
                   PUSH   PSW                 ; Save AF
                   LXI    H,"X0000
                   DAO    SP                  ; Now I know stack address
                   SHLO   STAKSV              ; Save stack
                   MVI    A,0FFH              ; Reset interva 1 ·timer
                                              ; counter
                   STA    PWRINT              ; Set up for next power on
                   IN     STATUS              ; Save current RAM bank status
        remember
                                              ; this and select RAM bank.
                   MOV    8,A                 ; Save it
                   MVI    A,"800000001        ; Select standard RAM
                   OUT    BNKCRL              ; Select!
                   MOV    A,B                 ; Resave old status
                   STA    BANKI-OTBL          ,•
                   MVI    A,"S00000001        ; Select RAM bank 1
                   OUT    SNKCRL              •,
                   MVI    A,0                 ; Set up to come back
                                              ; to 2nd ROM
                   STA    BANK                •
                   LXI    H,AUTOIO             ',•
                   SHLD   ATIDSV              ,•
                   IN     PORTS                ,•
                   ORI    "800010000           ,•
                   OUT    PORTS               ,•
                   HLT                        ; Never 90 on
        •,
        NTPWFL: POP       PSW
                RET                           ,•

       ; <<< BARCOOEREAOER interrupt>>>
       BARCOO: RET                    ; Return soon
        ; <<< UART interrupt>>>

        UART:    RET                     ; Return soon
        ; <<< Interval Timer interrupt >>>
        TIMER:   LOA   PWRINT            ; Pick up timer value
                 OCR   A                 ; :oecrement ! !
                 STA   PWRINT            ; Save it
                 RET                     ;
        ; <<< System work area>>>
       PWRINT: 08      AX0FF             ; Timer counter n   * 1/256Hz
                 ENO

```
