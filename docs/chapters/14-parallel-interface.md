# Chapter 14: Parallel Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 223-227). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                                  --
                         CHAPTER 14
                     PARALLEL INTERFACE

        This chapter describes ho~ to control the
Printer Interface of the PC-8201A.       It is the
Centronics compatible a 8-bit parallel interface.

14.1.1     Physical Interface Of PC-8201A
      . PC-8201A has the     Centronics compatible
parallel   interface.   It uses 26-pin connector.
Refer to the PC-8201A USER'S GUIDE about the Pin
connection and ~ignal name.

14.1.2     I/O Port For PRINTER Interface.

14.1.2.1    Port A---- Data Out Put Port For Printer.

   lsb 7     6   S .4    3   2   1   0 lsb
       +---+---+---+---+---+---+---+---+
       :Po7:Po6:Pos:Po4:Po3:Po2:Po1:Po0: ouT Axs9
       +---+---+---+---+---+---+~--+---+

                  P07 to P00               DATA output to Pr-inter.

                  NOTE: This port is used by another user.
   •                                                        - -'
       14.1.2.2     Port C ---- BUSY,SLCT Signal Read

          msb 7    6   5   4       3       2           1       0 lsb
            +--+--+--+--+--+----+----+----+
             :xx:xx:xx:xx:xx:susv:sLCT: xx: IN Axse
            +--+--+--+--.+--+----+----+----+

                           BUSY                    0       Pr-inter READY
                                                   1       Printer BUSY
                           SLCT --- 0 deselect
                                    1 Select

       14.1.2.3    SPCCSystem Control Port> --- STROBE Output
                   Port

          msb 7    6   5       4       3       2       1    0 lsb
            +--+--+----+--+--+--+--+--+
            :xx:xx:PsTs:xx:xx:xx:xx:xx: ouT Ax90
            +--+--+----+--+--+--+--+--+

                           PSTB --- 0 Strobe OFF
                                    1 Strobe ON

       14.1.3         Basic Theory Of Writing A Data To Centronics

               The basic sequence to write
                                               - ....   data   to     the
       Centronics printer is as follows.
       1.     If Printer i9 bu9y, wait a while.         Other~ise      go
              ahead.
       2.     Output a byte to the data lines and hold it.
       3.     Change the strobe level to low.
       4.     Wait a adequate duration holding the DATA.
       s.     A1 1 has been done, then finish else repeat            from
              ( 1).

       The timing chart illustrates the sequence.

       Para 11 e 1     __ xxxxxxxxxxxxxx ________ _
        DATA                  ->:T1:<- ->: T2 l<-
       DATA
                           -------+
                                 ->: T3 +-------------------
                                        :<-
        STROBE                     +-----+

                                         -------·--+
       BUSY
                          -------------+                    +-----
                             T1,T2 >= 1.0 uSec
                             1.0 uSec < T3 < 600uSec
                             Fig 14.1

               Refer to the Manual           Qf   Printer   about    the
       actual Duration of Tl to T3.

          14.2       SOFTWARE SPECIFICATION

      1   ;4.2.1       How To Write A Byte To The Printer.

                 Tiny program shown blow explains how to send a
           character to the Parallel port. That sample Program does
           same function as Basic command,
                       LPRINT •ABCDEFGHIJ•

            ,•
             ,•
           ,•
                  600000
            ;-- Ec;uater
           SCP   EQU          "'X90                 ; System Control Port.
           PORTA EQU          "'XB9                 ; Printer Data Port.
           PORTC EQU          "'XBB                 ; Printer Status Port.
           SYSSTAT            EQU         "'XFE44           ; SPC status.

           START:
                      LXI     H,BUF                 ; Set PTR.
                      MVI     C,10+2                ; Set data length.
           PRINT:
                      IN      PORTC                  ; Get Printer status.
                      ANI     6                     ; Strip BUSY,SLCT bits.
                      XRI     2                      ; See if ready.
                      JNZ     PRINT                 ,• if not,then wait.
                      DI                            ; Inhibit disturb for Port A
                                                    ; of 81CSS.
                       MOV    A,M                   ; Get character to Print.
                       OUT    PORTA                   Put data on the DATA line.
                       LOA    SYSSTAT                 Get SCP status.
                       MOV    B,A                     Save It.
                     · ORI    ""800100000             Set STROBE.
                       OUT    SCP
                       MOV    A,B
                       OUT    SCP
                      MOV     8, ""X03              ; Please set appropriate
                                                    ; value for your Printer.

             WAIT:
                     OCR   8
                     JNZ   WAIT
                     EI
       ...
     .'.
                     INX   H
                                             ....    ~
                                                    ; Point to Next
                     OCR   C
                     JNZ   PRINT
                     RET
             BUF:    08    'ABCDEFGHIJ'
                     DB    13,10
                     END

                                                                      •

                                                         /

```
