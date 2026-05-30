# Chapter 10: Keyboard Interface

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 184-191). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                                                               •,:.;,   ;.,:·
                                                                        '

                                                  --~
                                            ·-    -
                  - .. -·
                     :.     -:.

         ....

                                     CHAPTER 10

                  The Keyboard matrix of PC-8201A is as follows.

                                                            i--?A.1
                                                        l
                                                 ·i-------·'----f80
                                       Fig 10.1

                                        ..   J.
               The abbreviation PAn (PA7, PA6,  , PA0) and PBn
       means the bit of· PORT A and B of 81CSS. Please refer to the
       follo~ing sections about I/O ports. And also, KDn (K07, KO6
        , KD0) represents the bit of the KEYIN, Input port for the
       Keyboard.                         -'                      4

                Note:   •;• means <SHIFTED CODE>/ <UNSHIFTED CODE)

                                             f

       10.1.2     KEYBOARD STROBE----- PART A/8 Of 81CSS

                 msb 7   6   s 4 3 2 1 0 lsb
                   +---+---+---+---+---+---+---+---+
                   :KS7lKS6:KSSlKS4:KS3:KS2lKS1:KS0:   OUT AXB9
                  +-------------------------------+
                  : X: X: X: X: X : X: X :KSS: OUT AXBA
                  +-------------------------------+
                  KSS  . KS0 KEYBOARD Strobe
                          0 = Strobe OFF
                          1 = Strobe ON

                                               .   .       "
            .msb     7     6    s4   3   2   1   0 1sb
                                                       .

                   +---+---+---+---+---+---+---+---+
                   :KD7lKD6:KDSlKD4:KD3:KD2lKD1:KD0:            IN AXEB
                   +---+---+---+---+---+---+---+---+

                   KD7  KD0 ---- Keyboard data
                             0 = Depressed
                             1 = Not depressed

               Read the strobed column of the keyboard. Please refer
       to KEY MATRIX shown before to understand the relation between
       KDn and Key on the key board.

               Key scan must be per-for-med
       done by the interrupt, RST 7.5. The RST 7.5 Pin of 80C55 is
       connected to the TP PinCNo.10) of calendar- clock CuPO1990).
       So that interrupt occurs every 4 msec in the standard system.

        10.2
                                             ,.
                 SOFT WARE FOR KEYBOARD OPERATION.

                  Basie Keyboard read se~uenee is as follows.

       1.   Turn on the strobe pulse to the desired column you want to
            read.
       2.   Read the column from KYIN port.

       3.   Strobe off

       The following Sample program shows how to read the Keyboard in
       detail.

                                                    .   '
        10.2.1.1       Sample Program Reading Keyboard.

               Following Sample program read the every             column    and
       save the data into the KYBUF(Keyboard Buffer) •

        ,•
        ; Read CURRENT KEY BOARD STATUS •
        ,•
          ; Note: Make sure Keyboard strobe is
          •       not disturbed while reading the key board •
        ',•       You have to care of the other interrupts •
       ,•
       ; Equator
       PORTA    EQU         "X89                ; Keyboard Strobe Port
       PORTS    EQU         "XBA               •    ditto
       KEVIN    EQU         "XES               '; Keyboard data Port.

                  ORG       "XF000
       REAOKEY:
                  LXI       B,KYOATA           ; Get PTR for buffer.
                  MVI       A,"XFF             ; Disable normal key strobe
                  OUT       PORTA              ,•
                  IN        PORTS              ; Get PortB Status.
                  ANI       "XFE                ; SET B0=0ff.
                  OUT       PORTS              ; Activate Strobe for
                                               ,• Special key •
                  STAX      B                  ; Save Data.
                  IN        PORTS              ; Get St8tue of Port B.
                  ORI       "X01               ; Set B0=0n.
                  OUT       PORTS              ; Strob9 off.
                  MVI       A,"B11111110
       NOMAL:
                  INX       B                  ; Prepare PTR for key Buffer
                                               ; for next data.
                  OUT       PORTA              ; Strobe On
                  MOV       D,A
                  IN        KEYIN              ; Get data.
                  STAX      B                  ; Store it.
                  MVI       A,"XFF
                  OUT       PORTA              ; Strobe off.
                  MOV       A,D                ; Retrieve strobe data.
                  RLC                          ; Strobe for next column.

KEYBOAROCE
                                               1
                                ....       ....
                                           .
      • JC    NOMAL
        RET                            ; All done return to caller.

                                        •
                                ·- ,• PB0
      ' OS    ·1                           column
        OS     1                    ,• PA0 ditto
        OS     1                       • PA1     ditto
        OS     1                       '• PA2    ditto
        OS     1                        '• PA3 ditto
        OS     1                        '• PA4 ditto
        OS     1                       •' PAS ditto
        OS     1                       '• PA6 ditto
        OS    1                        ,•' PA7 ditto
                                         •, Be careful that
                                        •, Bit OFF means key
                                          • is depressed •
                                       '
        SNO

```
