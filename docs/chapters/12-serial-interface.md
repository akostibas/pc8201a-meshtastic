# Chapter 12: Serial Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 205-220). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
•                                      _.J

                          CHAPTER 12

            PC-8201A has 3 channels of Serial Interface. They are
    used by RS-232C, SIO1, SIO2. The difference bet~een SIO1 and
    SIO2 is only the shape of connector.

    This chapter describes how to control the Serial Port.

                    ...,_ ..., .,

       12.1   HARDWARE OF SERIAL INTERFACE~     -4

               UARTC6402)   and   PPIC81C55)    control  the  Serial
       Interface.                             1
                    Since they are shared by 3 channels, Only one
       channel is available at a time. Refer to the •pc-8201A USER'S
       GUIDE• about capacity of the hard~are.

                                    -- -2~6 -

        12.1.1     I/O Port                     ·?

        12.1.1.1     Channel Select -- (System~Control Port)

        I/O Address and Data Pattern
                 msb 7     6        5 -- 0
                   +----+----+------------+
                   :SRI2:SRI1l XXXXXXXXXX:           OUT "'X90
                   +----+----+------------+
                  SRI2/1       Serial Interface Select.
                           SRI2 SRI1              User
                                0    0          Not Used
                               0     1          SI02 (Disk Driver)
                               1     0          SI01
                               1     .1         RS-232C

                  Note: Current status of this port is saved
                        in SYSSTAT C"'XFE44) by System ROM.

                                             "-i
        12.1.1.2    UART Mode Control

                                             -~
             msb 7 - S      4      3         1
               ·:+-------+----+----+----+---+---+
                  xxxxx lCLS2:CLS1: PI :EPE:sas:        OUT "XD8
               +-------+----+----+----+---+---+
               S8S       Stop Bit Select
                                 0 = 1 bit
                                 1 = 2 bits 00
                          (*) When Data length is 5 bits,
                                Stop Bits is 1.5 bit.
               EPE       Even Parity Enable
                                 0 = Odd Parity
                                 1 = Even Parity
                         (Meaningless if Pl= 1)
               PI        Parity Inhibit
                                 0 = Parity Enable.
                                 1 = Parity Disable
               CLS2/1    Character Length Select
                                 "800 = 5 bits
                                 "B01 = 6 bits
                                 "B10 = 7 bits
                                 "811 = 8 bits

                                             -..:•1   .::t
    I
        12.1.1.3    UART Status Read

        I/O Address and Data Pattern
   .,                                        _,_      .;.J

              msb           4       3        2          1    0   lsb
                +-------+----+----+----+----+------+
                : XXXXX :TBRE: PE : FE l OE :dcd/dr-:                  IN "'XDB
                +-------+----+----+----+----+------+
                dcd/dr-   OCO/OR on off C0=on/1=off)
               OE         Over--r-un Err-or- (!=Detected)
               FE         Framing Err-or- Cl=Detected)
               P~         Parity    Err-or- (!=Detected)
               TBRE       Transmit Buffer- Register Empty
                          1 = Ready to receive data to transmit.

                                        \

                                                                 I

       · 12.1.1.4 UART Saud Rate <PP!' 81CSS Timer Section)

        I/O Addre"ld Data Definition
                                            J
              msb 6      54   3   2   1   0 lsb
                +---+---+---+---+---+---+~--+
               . :M2 :T13:T12:T11:T10:r09:T00:        OUT AXBO
                +---+---+---~---+---+---+---+
                    :T06lT05lT04lT03:T02:T01:T00:     OUT AXBC
                ;---+---+---+---+---+---+---+

               e ·Specify timer output Mode
                       AB00 = Single   Square Wave
                       AB01 = Continuous Square Wave
                       AB10 = Single Pulse On
                       AB11 = Continuous Pulse

               1:
                    set a Baud Rate use blow value.

                --------+---------+-------~-+
                ud Rate : AXBC     ., AXBO
                                        I

                --------+---------+---------+
                    75      00          48
               ·--------+-~-------+---------+
                   150 . :  68          45
               ·--------+--------+---~-----+
                   300      00          42
              -~-------+---------+---------+
                   600      00          41
              --------+---------+-~-------+
                  1200      80          40
              ---------+---------+---------+
                  2400      40          40
              ---------+--------+-~-------+
                 2400      40        40
              ---------+---------+---------+
                 4800      20          40
             ----------+---------+---------+
                 9600      10         40
             ----------+---------+---------+
                19200      08         40
            -----------+---------+---------+
                      Fig 11.1

                                       :-,   .   .,
                   NOTE:

                       It is impossible to read the current UART
               status directly. ROM #0
               always saves the new stat~s jn RAM when it is changed.
               Refer to Chapter
                   12.3.

        12.1.1.5   UART DATA I/O Port

    :   I/O Port and Data Pattern         .....

            msb                     lsb
            +--+--+--+--+--+--+--+--+
            :D7lD6:Ds:D4:D3:D2:D1:00: IN/OUT Axes
            +--+--+--+--+--+--+--+--+

                 Note:
                 If the data length is less than 8 bits,        Output
        data must be right justified.    Input data is right justified
        by UART.

     ,   12.2.1     How To Initialize Serial Port

                    The basic sequence to initialize    Serial   Port   is   as
         follows.

         1.   Select Channel
         2.   Set Baud Rate.
         3.   Set transfer mode.

         Following Sample program     shows   the   Initialization   sequence
         more detailed.

                 The sample program listed blow explains how        to
         initialize   serial port.    This sample program Initialize
         RS-232C Channel as 9600bps, even party,7 bit data length,1
         stop bit and no control for Xon/Xoff,SI/SO. And it Updates
         work area for ROM#0 can be use the same mode.   You may skip
         that portion if you want. They is no problem even if you skip
         the updating the data,because ROM#0 always initialize RS-232C
         Port when entering to Term mode or "OPEN "COM:"" ·of Basic
         command is issued by the Mode string.

                                                    -~f
           12.2.1.1    Sample Program  How To Initialize SERIAC Port

     i .

           ; Sample Program Initialize Serial Port •
                                                     .
           ; Data in system area ~hich you must update.
           SERMOO    EQU     ""XF406               ; 6 bytes for MODE string.
             '•              "'XF407               ; Parity Mode •
           ',•               "XF408                ; Word Length •
           •                 "XF409                ; Stop bits •
           '•                "'XF40A               ; XON/XOFF contorl •
            •'               "'XF408               ; -SI/SO contro 1 •
           'INHDSP
           INHIBIT
           COMACT EQU        "'XFE43               ; current user IO for
                                                   ; serial port.
                                                   ,•  "'800 = Not used •
                                                       "'801 = SI02
                                                   ,•  "810 = SI01
                                                  ,•   "811 = RS-232C
           SYSSTAT EQU       "XFE44                ; SCP port status.
           BAUORT EQU        "XFE4A                ; Baud Rate Table entry
           address.
           INHB.IT EQU       "XFE4·1              ; 0 inhibits XONIXOFF control.
           • I/O Port Address •
           '
           SCP       EQU     "X90                  ; System Control Pert.
           PORTS     EQU     "'XBA                 ; RTS/OTR set port.
           TIMEL     EQU     "XBC                  ; Timer Set Low.
           T-IMEH    EQU     "XBO                 ,• II    I I High •

           RTSDTR    EQU     "X3F                 ; RST/OTR data for RS-232C.
                                                  ; Use "XFF for SI01/2.

           INITSERI:
           ; ENTRY: CCJ = USER IO.
           ;         CBJ = Baud rate specifier. ASCII Number (1 to 9)
           ;                Same Number of "STAT" of TELCOM.
                  See if Serial Port is available.

                     LOA     COMACT               ; Get current user IO.

tf
                                                        ·J
i
! .
                         JZ    SELECT                ,•' then branch.
                         CMP   C                       • SAME USER?
            ..          JZ
                     ·sTc
                        RET
                               SELECT
                                                    .,'• Th~:m branch.
                                                  ·.-, Set Error.FLG.
                                                     • Re~urn to caller.
                                                     '
             SELECT:
             ;    Reserve Serial Port-------
                     DI                          ; Inhibit all disturbance.
                     MOV     A,C                 ; GET USER ID.
                     STA     COMACT              ; Set User ID. Be sure reset
                                                 ; Use ID to @0 after all task
                                                 ; finished,else the serial
                                                 ; port
                                                 ; can not be shared to
                                                ; another user.
                     RRC                         ; Move Bit0-1 to Bit 6-7
                     RRC
                     MOV     C,A                ,• Save it.
                     LOA    SYSSTAT            •   Get current SCP status.
                     ANI     "'B00111111       ',• cancel channel contro 1 •
                     ORA    C                 ,• Set new channel control
                                                • bits •
                     OUT    SCP                •' Select channe 1 •
                     STA    SYSSTAT          ',• Update SCP status.,
             ·--
             ,   Set BAUD RATE--------------

             SETBAUO:
                        MOV    A,B                  ,• Get BAUD RATE IO.
                        STA    SERMODE            •    Update Baud rate Specifier.
                        SBI    •1 •                 '• Convert to Binary Number.
                        RLC                       ,•' *2,Because table entry is
                                                     • 2 bytes •
                        LXI    H,TIMTBL            '•
                        MOV    C,B                ',• CCJ = Offset
                        MVI    B,0
                        DAD    B
                        SHLO   BAUORT             • Save entry point for
                                                  ,•' Music routine.
                                                   ,• Music routine in ROM #0
                                                  •,  destroy temporary changes
                                                      the timer count and
                                                  ,• reinitializes it with
                                                  • finish •
                                                  .
                                                  ', Refer Chapter 12.3
                        MOV    A,M                ,• Get Lot..1er value.

                   OUT     TIMEL                •
                   INX     H                    '
                   MOV     A,M                  ; Get Higher Value.
                   OUT     TIMEH
                   MVI     A,"XC3             .• ; -l'o 9tart timer.
                   OUT     ""X88                 ; Uee this value to
                                                 ; etart Timer •.
                                                      ~

        ; SET TRANSFER MOOE.
        MOOE:
                   IN     PORTS                 ,•
                   ANI    RTSOTR                •, IF 232C RTSOTR=AX3F to
                                                 ,•activate RtS/DTR,
                   OUT     PORTB
                   IN      "XCS                  •, Dummy read to clear
                                                ,• Receive Buffer Register •
                  MVI      A,"800001110          ,• 7bit,Even Parity,1 stop bit.
                  OUT      008H                 • Set Mode.
                                                '
        ,•      Update SERMODE
                   LHLI                         ; Set PiR
                   MVI                          ; Set Parity check mode.
                   INX
                   MVI                          ; Set Word length.
                   INX
                   MVI                          ; Set Stop bit length.
                   INX
                   MVI                          ; Set XON/OFF control mode.
                   INX
                   MVI                          ; Set SI/SO control Mode.
                   XRA                          ; Set CF=0
                   STA                          ; Disable XON/XOFF control.
                   EI
                   RET
        TIMTBL: DB         "X00, "X48           ,•          75 bps
                08         "X68,"X45            ,•         150
                   OB      "X00, "X42           •          300
                   OB      "X00, "X41           •,'        600
                   OB      AX80,"X40             ,•       1200
                   OB      "X40,"X40            ,•        2400
                   DB      "X20,"X40            ,•        4800
                   OB      "'X10,"X40           ,• 9600
                   DB      "X08,"'X40            ,• 19200

                                               ....-,
        12.2.2     SEND A Data To T~e Serial Port

    ~             The sample program shown blo~ describes how to send
        data to the serial port. It performs no XON/NOFF and no SI/SO
        contro 1.

        ; SEND A data to the serial port
        ,•
        : ENTRY: CCJ = DATA TO BE SEND
        ,•

        WRITE:
                 IN       "'XD8               ; Get UART status.
                 CPI      "800010000          ; See if transmitter buffer
                                    r--.      ; register Empty?
                 JZ       WRITE               ; Wait TBR become empty.
                 MOV      A,C                 ; Get character to send •
                 OUT      ....XC8             ; Send it to the serial port.
                 RET

                                                                                I
                                               --f
            12.2.3   Read A Data From Serial Port.

   ·•   ~           Sample program shown blow~explains how to read data
            from serial port by RST6.5. This sample only read data form
            serial port with RST6.5,no XON/XOFF and no SI/SO control is
            performed.

            :** Read a data from Serial Port.
            ;Read a data By RST6.5

                     ORG    "'X3C                    ,• Entry point of RST6.5
            RST65:   DI                                                         ~-,:-
                                                                                ~~,.
                     JMP    READ                                                &~
                                                                                -r~
                                                                                 ti
                                                                                r
                     ORG    ????                                                t[~

            READ:                                                                ~
                     PUSH   H                        ,• Save registers.          ti
                     PUSH   D                                                    ~
                     PUSH   B                                                    i~
                     PUSH   PSW                                                  i
                     IN     "'XC8                       ,• Read the data
                     MOV    L,A                       ,• Save it •
                     IN     "'XD8                      ,• Get error status •
                     ANI    "'B00001110              ,• Strip error bit.
                     MOV    H,A                       ,•
                     SHLO   BUFFER
                     POP    PSW                      ,• Restore Registers.
                     POP    B
                     POP    D
                                                                                  t~
                     POP    H                                                     r
                                                                                  ;~
                     EI                                                           '
                                                                                  ~';

                     RET                                                          ~
                                                                                   l
                                                                                   }
            BUFFER   OS     1                         ,• Got Data.
                     OS     1                        ,• Error status .
                                                                                   ~~
                                                                                   [
                                                                                   V

                                                                                   ~
                                                                                   i,;

                                                                                   ~
                                                                                   t
                                                                                   ~

                                                                                   r

                                            -~   ··t
        12.3     AVAILABLE SYSTEM AREA.

   ~-           You may want to-use the sy~tem area for your use.  In
        this section, the available work area of ROM #0 is described.
        Make sure to keep the compatibility with System ROM,   if you
        want use this area.

        Serial input Buffer from AXFE4C to AXFFC3, is reserved by
        System ROM as SERIAL Input Buffer. And You can use it for
        your own routine.

        SERMOD    saves their RS-232C mode string

                This area has 6 bytes data which indicates the RS-232C
        String Mode, specified by "STAT" command in TELCOM or OPEN
        "COM:" command in BASIC. The contents are following.

        SERMOD    at AXF406 0S6        ,• RS232C String mode Buffer
                     "'XF406           • Baud rate specifier (1 to 9)
                     "'XF407       ·'• PArity Mode CN/E/0/I)
                     "XF408         ,'• Word length specifier ( 5 to 8)
                     AXF409            • Stop bit (1/2)
                     AXF40A           '• Xon off control (X/N)
                     "XF408          '• SI/SO control CS/N)
                                   '
        INHIBIT Cat "XFE42>
                  This byte is the XON/XOFF Inhibit      Flag.   0   inhibit
                  XON/XOFF ~ontrol ,else enabled.

        COMMACT ("XFE43 Byte)

                  This byte indicate who is using serial port as blow.
                  Please reset to 0 after using the serial         port,
                  otherwise the serial port is not available for another
                  user.

                          "X00 = No user
                          "X01 = SI02
                          AX02 = SI01
                          "X03 = RS-232C

          CMPNT     (at "XFE46) 0S1 ;      Character -count in Suffer.
                               This byte ha!!I. the character         count     in   Seri a 1
                   Buffer.
    i.:                                     . ...   . ,:J

                   This byte indica·te last read character displacement.

          UTAOR     <"XFE47 Byte>
                   This   byte   indicate                   last   written       character
                   displacement.

          BAUORT   C"'XFE4A)
                   This points the tab 1e of the Baud rate..                 Refer to   the
                   Chapter 12.2.1.1 ·sample Program.

```
