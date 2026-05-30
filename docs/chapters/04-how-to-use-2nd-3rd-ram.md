# Chapter 4: How To Use 2nd 3rd Ram

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 49-59). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                           CHAPTER 4
                      HOW TO USE 2ND/3RD RAM

            When you want to change the bank of ~AM, the most
 simple method is to do OUT instruction and to jump AX0000 for
 warm start. Because book keeping area management is too
 difficult to do by yourselves, I think. But if you would not
  1 ike to do war·m start, you must manage the book keeping and
 system parameter by yourself and use the spe~ial RAM bank
 handling routine. You can easily guess that when the bank of
 RAM is changed, PC, the program counter must stay lower than
  '"'X7FFF. Because bank switch is completely change the code of
-RAM which address '"'X8000 to '"'XFFFF. But the area from AX0 to
  '"'X7FFF is used for ROM. The only one way is to make a special
 RAM bank switch routine in all RAM banks with same address.
 The following illustration will help you to understand. this
 curious method.

   POP      HL           POP    HL       ;Pick up return address
   MOV      A,NEXT       MOV    A,NEXT   ;set next bank status
   OUT      '"'XA1       OUT '"'XA1      ;change bank
   PUSH     H            PUSH H          ; set return address
  RET                                    ;return to specified addres
         RAM #0          RAM #1
            Fig 4.1

    Same routine is stored in the same position of 2 RAM banks •
. Refer to next
  section to write a program at another bank.

                                          ·- STACK POINTER ,too.
        In addition you must take care of the

       4.1 - READ AND WRITE TO ANOTHER RAM BANK

               These are two methods to read /write another bank of
       RAM. The first is more simple than second one. But the first
       method is some limitation of that performance, because this
       method ·uses ROM #1. And the second method is more complex,
       but this is more powerful. The size of the second method is
       longer than the first one.

               These are very useful routines in the 1st ROM.    These
       are GETBNK and PUTBNK.

       4.1.1.1    GETBNK CAX7EECJ

                This routine reads one byte from other banks of RAM.
       The GETBNK routine temporarily changes the specified RAM bank,
       reads a byte pointed by CHLJ, and returns to the original
       bank.    Interrupt should be disabled before calling the GETBNK
       routine.

                 Entry   CBJ = Bank number
                                 AX00:Main bank
                                 AX08:Bank #2
                                 AX0C:Bank #3
                         CHLJ = Address which byte to read
                 Exit    CDJ = Byte data which read
                 Altered registers
                         CAJ,CCJ,CDJ,CFJ

        4.1.1.2    PUTBNK CAX7EESJ

               The PUTBNK routine writes one byte at the specified
       address pointed by CHLJ in the specified RAM bank. Similar to
       the GETBNK routine, original bank will be. selected after
       writing that data. Before using the PUTBNK routine, interrupt
       should be disabled.

                  Entry    CBJ = Bank number
                                   "'X00:Main bank
                                   "'X08:8ank #2
                                   "'~0C:8ank #3
                           CHLJ = Location where the byte is stored
                           COJ = Byte data to be stored
                  Exit     None
                  Altered registers
                          CAJ, CCJ, CFJ .
                             •

       4.1.2   Method 2 CUSING YOUR ORIGINAL COOEJ

                  When  your code is located      in   upper   address
       (AX8000-AXFFFF), and you want to read/write a lot of data in
       another· bank of RAM, you had better change the target RAM bank
       at the lower position of the memory.

               (1) Your c6de 1s in RAM #1. And data you want to

                         AXFFFF   -------- --------
                                           Your       RAM
                                           code       #2

                         AX8000   -------- --------
                         AX7FFF   --------
                                           ROM

                         AX0000   --------
                           Fig 4.2
               (2) Change the Bank.

                         AXFFFF   ---------
                                       Your
                                                  I
                                        code      I
                                  I
                                  I
                                  I
                                                  :<--
                                  I   •·

                         AX8000   --------               Handle
                         AX7FFF   ---------               some
                                                  '
                                                  I        data
                                      RAM 12:
                                                  I
                                                  I

                                                  :<--

                           Fig 4.3

                                  ~···

                (3) Then change again into previous
                    Bank configuration.

               In this case, _you have to disable     to   all   interrupts
       before changing the BANK.

                When  your   code    is   · located   lower    addres
        (AX0000-AX7FFF), for instance, running a program in 2nd ROM,
       please use next method to handle the data in other RAM banks.

                (1) The program in 2nd ROM is running with RAM #1.

                           AXFFFF   ---------- ---------        \
                                    :standard:
                                    I
                                    I              RAM
                                    : RAM           *2
                           AX8000   ---------- ---------        .
                                                                ,

                           AX7FFF   ----------
                                          2nd
                                           ROM

                           AX0000   ----------
                               Fig 4.4

               (2) Read or Write RAM *2 by bank switching
                   during all interrupts prohibited.

                           ~XFFFF   ---------- -----------
                                          RAM    : RAM
                                           #2    :standard
                                    I
                                    I .

                           AX8000   ---------- -----------
                           AX7FFF   ----------
                                          2nd
                                           ROM

                           AX0000   ----------
                              Fig 4.5
               (3) S~itch again, and resume the previous processing.

                                          55 -
3RD 'RAN

     TITLE   Read Write routine·for another BANK of RAM

     This sampl·e will access another bank of RAM.
     There are two routines in this source program.
,.   .The another one is to access in block of data to use
     One is having access in byte by byte by using

·special bank switching.
 In the architecture of bank, bank 1 (Standard RAM)
 is not able to be switch low address
 C""X0000H-""X7FFF).

     Entry   HL:Address to be accessed
             C :Bank number
     Exit    B :Data which be read
 Entry       HL:Address to be accessed
             C :Bank number
     Exit    B :Data to be written
 Entry       HL:Start address to be changed
             A :Bank number
             DE:Start address i~ current bank
             BC:Byte length to be read
 Exit        None
 Entry       HL:Start address to be written
             A :Bank number.
             DE:Start address in current bank
             BC:Byte length to be written
 Exit        None

 Bank number
         Bank *1 (Standard RAM) :"X00
         Bank *2 CRAM #2)      :""X08
         Bank 13 CRAM #3)      :"X0C

fSTEM label define       >>>
 EQU     ""X0A1                 •, Bank control port
 EQU     ""X0A0                 ,• Bank status port
 ORG         ""X0000            ,• This program can be located
                                 ,• any place
                                ,• This switch should be change
                                ,• according to the situation
 EQU         -1                 • High address C"'X8000-"XFFFF)
                                 '

                                                  -
       SLOW     EQU      0                  ; Low address     (AX0000-AX7FFF)
        ; <<< Byte access routine>>>
       BYTER:   DI                          ; Disable interrupt
                IN       STATUS             ; Read current bank status
                PUSH     PSW                ; Save current bank status
                ANI      AB11110011         ; Clear high address of bank
                                            ; switch
                ORA      C                  ; Set new data of bank
                PUSH     PSW                ; Save curre"t bank
                MOV      A,C                : Pick up new bank data
                RAR                         ,•
                RAR                              Shift 2 bit
                MOV      C,A                     Restore bank data
                POP      PSW                     Pick up current bank
                ANI      AB11111100              Clear low address of bank
                                                 switch
                ORA      C                       Set new data or bank
                ENDIF
                OUT      BNKCRL            ; Select new bank!
                MOV      B,M               ; Read data from some bank
                POP      PSW               ; Pick up before bank
                OUT      BNKCRL            ; Select before bank
                EI                         ; Enable interrupt
                RET                        ,•
       BYTEW:   DI                         ; Disable interrupt
                IN       STATUS            ; Read current bank status
                PUSH     PSW               ; Save current bank status
                ANI      "'811110011       ; Clear high address·o-f bank
                                           ; switch
                ORA      C                 ; Set new data of bank
                PUSH     PSW               ; Save current bank
                MCV      A,C               ; Pick up new bank data
                RAR                        ,•
                RAR                        ; Shift 2 bit
                MOV      C,A               ; Pick up current bank
                ANI      "'B11111100       ; Clear low address of bank
                                           ; switch
                ORA      C                 ; Set new data of bank
                ENOIF
                OUT      BNKCRL            ; Bank switch!

                MOV      M,8                ;    Write data
                POP      PSW                ;    Pick up before bank
                OUT      BNKCRL             ;    Select before bank
                EI                          ;    Enable interrupt
                RET                         ,•
        ; <<< Block access routine    >>>
        BLOCKR:- DI                         ; Disable interrupt
                PUSH     8                  ; Save length
                MOV      C,A                ; Set up bank number
                IN       STATUS             ; Read current bank status
                STA      CURBNK             ; Save current bank
                ANI      "B11110011         ; Clear high address of bank
                                            ; switch
                ORA      C                  ; Set new data of bank
                PUSH     PSW                ; SAve current bank
                MOV      A,C                ; Pick up new bank data
                RAR                         •
                RAR                         ;' Shift 2 bit
                MOV      C,A                 ; Restore bank data
                POP      PSW                ; Pick up current bank
                ANI      "811111100         ; Clear low address of bank
       switch
                ORA      C                  ; Set new bank data
                ENDIF
                POP      B                  ; Pick up length
       NEXTR:
                LDAX     D                  ; Read data
                MOV      M,A                ; Write data
                INX      D
                INX      H                  ; Next position of data
                DCX      B                  ; Decrement counter
                JNZ      NEXTR              ; Loop until dQne
                LOA      CURBNK             ; Set previous bank
                OUT      BNKCRL             ; Select previous bank
                EI                          ; Enable interrupt
                RET                         •
                                            '
       BLOCKW: DI                           ; Disable interrupt
                PUSH     B                  ; Save length
                MOV      C,A                ; Set up bank riumber
                IN       STATUS             ; read current bank status
                STA      CURBNK             ? Save current bank
                ANI      "B11110011         ; Clear high address of bank

        swit
                IRA     C                 ; Set new data of bank
                :LSE
                'USH    PSW               ; Save current bank
                'OV     A,C               ; Pick up new bank data
                 AR                       •;• Shift 2 bit
                 AR
                ,ov     C,A               ; Restore bank data
                'OP     PSW               ; Pick up current bank
                ,NI     ""B11111100       ; Clear low address of bank
       switch
                )RA     C                 ; Set new bank ~ata
                ~NOIF
                ,op     B                 ; Pick up length
      NEXTW:
                MOV     A,M               ; Pick up data
                STAX    D                 ; Write data
                INX     H                 ,•
                INX     D                 ; Next position of data
                DCX     B                 ; Decrement counter
                JNZ     NEXTW             ; Loop until done
                LOA     CURBNK            ; Restore previous bank*
                OUT     BNKCRL            ; Select previous bank
                RET                       •
                                          '
     : <<< ~stem work area       >>>
     CURBNK: DB     ... X00               ; ~urrent bank data
                ENO

```
