# Chapter 15: Hardware

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 228–258). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as **authoritative**.

Refer to another technical manual for the detailed specifications of PC-8201A's hardware. That manual has already been published by NECHE, Chicago. Please contact them. In this chapter, only the most important data is listed.

## 15.1 System Slot

### 15.1.1 Assignment of Signal

<!-- TODO(tier-b): verify Fig 15.1–15.3 pin tables against source pages 228–229 before treating as authoritative -->

**Fig 15.1 — System Slot pin assignments (pins 1–14)**

| Pin number | Signal name | Remarks           |
|------------|-------------|-------------------|
| 1          | VDD         | +5 V              |
| 2          | VDD         | +5 V              |
| 3          | AD0         | Address/Data 0    |
| 4          | AD4         | Address/Data 4    |
| 5          | AD1         | Address/Data 1    |
| 6          | AD5         | Address/Data 5    |
| 7          | AD2         | Address/Data 2    |
| 8          | AD6         | Address/Data 6    |
| 9          | AD3         | Address/Data 3    |
| 10         | AD7         | Address/Data 7    |
| 11         | NC          | No Connection     |
| 12         | NC          | No Connection     |
| 13         | A8          | Address 8         |
| 14         | A12         | Address 12        |

**Fig 15.2 — System Slot pin assignments (pins 15–32)**

| Pin number | Signal name | Remarks              |
|------------|-------------|----------------------|
| 15         | A9          | Address 9            |
| 16         | A13         | Address 13           |
| 17         | A10         | Address 10           |
| 18         | A14         | Address 14           |
| 19         | A11         | Address 11           |
| 20         | A15         | Address 15           |
| 21         | A16         | No Connection        |
| 22         | A18         | No Connection        |
| 23         | A17         | No Connection        |
| 24         | A19         | No Connection        |
| 25         | NC          | No Connection        |
| 26         | NC          | No Connection        |
| 27         | RD          | Read                 |
| 28         | WR          | Write                |
| 29         | IO/M        | IO or Memory         |
| 30         | ALE         | Address Latch Enable |
| 31         | HOLD        | HOLD                 |
| 32         | HOLDA       | HOLD Acknowledge     |

**Fig 15.3 — System Slot pin assignments (pins 33–48)**

| Pin number | Signal name | Remarks                        |
|------------|-------------|--------------------------------|
| 33         | INTR        | INTERRUPT                      |
| 34         | INTA        | INTerrupt Acknowledge          |
| 35         | RESET       | RESET                          |
| 37         | ROME        | ROM Enable                     |
| 38         | E           | Enable                         |
| 39         | BANK3       | RAM Cassette Select signal     |
| 40         | NC          | No Connection                  |
| 41         | HADRS       | High Address Disable           |
| 42         | LADRS       | Low Address Disable            |
| 43         | CLK         | Clock                          |
| 44         | POWER       | RAM Protect signal             |
| 45         | GND         | Ground                         |
| 46         | GND         | Ground                         |
| 47         | NC          | No Connection                  |
| 48         | NC          | No Connection                  |

### 15.1.2 Explanation of Pin

#### 15.1.2.1 Function of Signal

1. **VDD (Out)**
   If you don't use the BCD, this pin can supply a current of 50 mA or so.

2. **AD0–AD7 (In/Out)**
   Lower 8 bits of the memory address (or I/O address) appear on the bus during the first clock cycle of a machine cycle. It then becomes the data bus during the other cycles.

3. **A8–A15 (Out)**
   The most significant 8 bits of the memory address or the I/O address. The output goes off during Hold mode; it then becomes 'H' level, because it is connected to a pull-up resistor (100 kΩ) inside.

4. **/RD (Out/3-state)**
   The read control signal; 3-state during Hold mode.

5. **/WR (Out/3-state)**
   The write control signal; 3-state during Hold mode.

6. **IO/M (Out/3-state)**
   When this signal is 'H' level and 'L' level, respectively, the CPU has access to the I/O and the memory. 3-state during Hold mode.

7. **ALE (Out/3-state)**
   It is used to strobe the address information (AD0–AD7). 3-state during Hold mode.

8. **HOLD (In)**
   The CPU, upon receiving the hold request, will relinquish the use of the bus as soon as the completion of the current bus transfer. When the Hold is acknowledged, the /RD, /WR, IO/M, ALE lines are 3-stated and the A08–A015 lines are 'H' level.

9. **HLDA (Out)**
   It indicates that the CPU has received the HOLD request and that it will relinquish the bus in the next clock cycle.

10. **INTR (In)**
    The general purpose interrupt. It is sampled only during the next to the last clock cycle of an instruction and during Hold and Halt states.

11. **/INTA (Out)**
    It is used instead of (and has the same timing as) /RD during the instruction cycle after an INTR is accepted.

12. **RESETO (Out)**
    It indicates the CPU is being reset. Can be used as a system reset.

13. **READY (In)**
    If it is 'L', the CPU will wait an integral number of clock cycles for it to go 'H' before completing the read or write cycle.

14. **/ROME (Out)**
    The enable signal for external ROM cartridge or general purpose. When the upper 4 bits of the I/O address is 8, it goes 'L'.

<!-- FIGURE 15.4: /ROME decode logic circuit — present in OCR as noise; needs vision re-OCR from source page ~232 (target: logic gate schematic) -->

```text
                          4liHf38

                  IOIM  ~  ~~1
                           Gr
                           1-
                                         ~
                                         CONi;;oL
                               Y! I .
                  Tis
                  _A/4
                           IGZ
                           IC
                                 Y.: I
                                 y4.
                                      1
                                         ----
                                         5.J.Ni<
                                         d'"IJ~
                                         ,4o2D
                   Al3     ,a    Ys      ~
                   Ai2           Y' I    Rrr
                           (     y71
                                      I  L.c!5
```

15. **E (Out)**
    It is used as a memory enable signal of the read or write cycle. E is the logical OR (active high) of /RD and /WR.

<!-- FIGURE 15.5: E signal logic diagram — not recoverable from OCR; needs vision re-OCR from source page ~232 -->

16. **/BANK3 (Out)**
    The memory enable signal of external RAM cartridge. (See next section.)

17. **HADRS (In)**
    If it is 'H', the memory of high address (XX8000 to XXFFFF) in the PC is disabled. (See next section.)

18. **LADRS (In)**
    If it is 'H', the memory of low address (XX0000 to XX7FFF) in the PC is disabled. (See next section.)

19. **CLK (Out)**
    2.5 MHz clock output. It is the same phase as the CPU clock.

20. **POWER (Out)**
    It is the signal /RESET (connected to the CPU) reversed.

### 15.1.3 DC Characteristics

<!-- TODO(tier-b): verify Fig 15.6 drive-capacity values against source page ~233; do not treat OCR'd numbers as authoritative -->

```text
Fig 15.6 — DC Characteristics (Drive capacity)

Symbol               Drive capacity (mA)
------               -------------------
AD0–AD7              4.4
A8–A15               4.4
/RD, /WR, IO/M
ALE, RESETO          4.4
HLDA, /INTA, CLK     2.0
E, /ROME, /BANK3     1.1
```

### 15.1.4 AC Characteristics

<!-- FIGURE 15.7: AC characteristics timing diagram — LOST in OCR, needs vision re-OCR from source page ~234 (target: timing diagram) -->

```text
                                                                   ··-<   ---~----·
. j ·_
      ----                                                              .-
                                        ~,I
        .:

              ""'t-
                                       .....
                                                             "Z'

                                                             -=~
                                                                       2:
                                                                                  n
                                                                                  "M

                                                                                       I
                                                                                                              ,J

                                                                                       ~
                                                                                       <'
                                                                                       Q,
                                                                                                                                                                 -
                                                                                                                                                                 :-' .z.
                      - .--                                      ,.                ~                                                                        ..."' - ·--
                                                                                                                                                            -    :i- -

                              L
                                                                                                                                                             ~
                                                                                                                                                             c
                                                                                          '-1

                                                                   I
                                                          I- I- - -                                          -I                                 -
                       i
                        i-
                                         I                                     I
                                                                                                                 '                      .... I

                                        i                                                                                                    I

                                                           i I I
                      i-
                                                                                                                 I
                                                                                                                 !              ~
                                                                                                                                             !
                                                          '          I
                                                          i                                                                                  '
                                                                                                                                             '
                              -                                                                                      .!                                                             loo{
                                                                               r.:-....                                                                                             ~

                      :-J
                      f-.
                                                                     I~
                                                                     : I
                                                                         r-~
                                                                           -
                                                                          ..
                                                                               ~-~
                                                                               ~
                                                                                          1I                  ;'
                                                                                                                             '
                                                                                                                             !
                                                                                                                                         ...
                                                                                                                                           t
                                                                                                                                                                         I
                                                                                                                                                                                     >-
                                                                                                                                                                                     <,.;

                                                                                                                                                                                     -
                                                                                                                                                                                     ~
                                                                                                                                                                                     t:.:
                                         I
                                                              ~I
                                                              I.I.lo
                                                                                                                                             IJ
                                                                                                                                             I             '
                                                                                                                                                                                     C:

                                                              ~I
                                                              c::.
                                                              ~                               ,.                                             I
                                                                                                                                                                           -;
                                                                                                                                                                                                         >

                                                      .
                                                     ,.                                       I                                              .
                                                 ~                                  ~       ..:                                          ..:                   ).

                                                                                    ~                                                                          J
                              .___                                                  Q                                     -:-
                                                                                    i::i                                  I
                      f-                         ~                                  -<                                    ,...
                                                                                                                           ':                    ....~
                                               ..;:
                                                                                            -,
                                                                                     .... ...
                                                                                             :..                 ~         :1oo
                                                                                                                          .:.

                                                          -              ~
                                                                               ,-
                                                                                                       I
                                                                                                                                   '                                1
                                                                                                                                                                    I

                                                                                                                                                                    iI
                              I                                                                                                                                     I

                                                               =                     ...                                               ~
                                                                                                                                       ,_
                                                                                                                                       lz
                                                                                                                                                                         .
                                                                                                                                                                         >-
                                                                                                                                                                         ~
                                  ...,:ilC                      C
                                                               0.
                                                                                     C)
                                                                                        C
                                                                                                           I.I
                                                                                                                                                                         Q:.
                                                                                                           ~
                                                                                    Q                                                  '.~
                                  ~                            <                    <                                                  Ci:
```

<!-- FIGURE 15.8: AC characteristics timing diagram (continued) — LOST in OCR, needs vision re-OCR from source page ~235 (target: timing diagram) -->

```text
                                  -·~ •'
                                  ·<                                                                              ~'.
                                                                                                                                   I

            - •---
·~,..·.-:'7... --- ·:·   I-                            I
                                                                                                                                    I
                              .
                              '                    -I
                                                   ~                                         f
                                                                                             ~       - ....                   ... -
                                                                                                                             -·
                                                                                                                                  _.i
                                                                                                                                   II
                                  ... --            ...                                                                            •
                                  f- .
                                                                                                                            I
                                  -,     I                                                                        I
                                                                                                                  i

                                  ~

                                  i
                                  l-
                                         L - - .... -                      ,
                                                                                                                  I
                                                                                                                  1
                                                                                                                  i
                                                                                                                  '
                                                                                                                            ,.
                                                                                                                                             i'
                                                                                                                                             !

                                                                               a- - -·
                                                                                                               1:!
                                                                                             1
                                                             !
                                  _      __.JI

                                                                               ~
                                                                               <

                                  c-,
                                         -
                                                                               Q

                                                                                                        I   Ji.
                                                                                                 --- .- ~ -fr
                                                                                                                                                  I
                                                                                                                                                  I
                                  l-                                                                                                              i
                                                                ~                                                           I -;                  I
                                                                ~
                                                                Q
                                                                Q                                       --.
                                                                                                          '
                                                                                                           i!

                                                                                                                            i.
                                                                ~

                                                                          J It                            !'
                                                                                                                                                      ;
                                                                                                                            - ,-, -
                                                                                                                              I

                                                                          i ~!~ f
                                                    .;;
                                                           .
                                                           ~
                                                                    .:,
                                                                                                                            .....I, ,.,
                                                                                                                              I         I"'"!
                                                                                                                                          ~:
                                                   .                                                                         !

                                  ...-
                                                                                                        .,., 4'         I

                                                                                                      - ,- - l
                                                                               Q
                                         i.....

                                                    t                          ~         f
                                                                                         I
                                                                                                            : ... I
                                                                                                       • :~ I
                                                                                                                              :;
                                                                                         I ::                                           I

                                                   -· r~                           ""1
                                                                                         I""'
                                                                                         I              . ~ Ii    , I
                                                                                                                                        i

                                         I                     II                        I                              I
```

**Fig 15.9 — AC Characteristics parameter table**

<!-- TODO(tier-b): verify Fig 15.9 AC timing parameter values against source pages 236–237; do not treat OCR'd numbers as authoritative -->

```text
                                               min (ns)    typ (ns)    max (ns)
                     1
                               tAX                          407

                               tLGX           t    112

                               tALL               112

                               tALU                          74

                                  tC               162
                                                   142
                               tAS               171

                                  tAC           i...                   (illegible)

                               tAD                                     (illegible)

                               =~~                                     (illegible)

                              tID                                       334

                         :    tC                   125

                             . tRL               163

                              tACM                  0

                              tWDA                                      75

                              tAL               13

                              tWD               88

                              tDW               575

                         :    tDOW                                      (illegible)

                         !    tART                                      (illegible)

                         !    tREADY                        H

                              tSRT              160

                              tSTH               0
```

## 15.2 Memory Control Circuit

In this section, RAM #n means the chip number on the main board.

The memory of PC-8201A consists of RAM 16K and ROM 32K bytes, and can be expanded to 48K bytes on optional RAM socket (RAM Chip #2–#7) and to 32K bytes on user ROM socket (ROM #1) in the PC.

The composition of memory is shown in Fig 15.11. RAM Chip (#0–#7) and ROM (#0–#1) is connected to the same DATA bus and their outputs are controlled by /CE and /BANK signals. There are five banks: BANK #0 (available ROM #0), BANK #1 (user ROM #1), STDRAM (available RAM #0–#1 and optional RAM #2–#3), BANK #2 (optional RAM #4–#7), and BANK #3 (RAM cartridge). The bank control circuit is shown in Fig 15.12. By means of this, you can assign each bank to the memory address in the 64K bytes area of the CPU as shown in Fig 15.13 and Fig 15.10.

<!-- FIGURE 15.10: Memory bank address map diagram — LOST in OCR, needs vision re-OCR from source page ~241 (target: memory map / address layout diagram) -->

```text
                              Address          STDRAM                        BANK#2
                                                                     r - - - - - - - -- ~I
                          /\X FFFF
                                              RAM#7                          RAM#7
                         /\X E800
                             DFFF                                                        i
                                                                                         i
                                              RAM#6                          RAM#6
                         /\X C000                                  I

                         /\X BFFF        r                  -   -J

                                              RAM#2                         RAM#5
                         /\X A800
                         /\X 9FFF
                                                                                             I

                                                                                             ..
                                              RAM#3                        RAM#4            I

                         /\X 8000
                                                                                             I

         Address         (continued)

                           ~i--_m_,~_-RAM·-~----~·~!]~ ....... ~~;;:· 1.
                                                          Ruf,!
                                                        2.0NK#1 i
                                                                   I
                                                                   I
                                                                                 ?.~r-1
                                                                             :.~N7:r~
                                                                   !
                                    (D
                                                 ,.----·-----·---------------~
          •fy
             V' - -

                                             I;
                    --
                :-.-~,-

                                  I
                             :~-i -----. ---··
          :\~ C~2::J              F.AM                    P.;M                  RAM
                                  ffiii!:lr i           :ANi<='2           i·8~Nl#3
                              I!               I       :....---            _!- - - -

                              ,,
                              I
                              I

                              -----------------------
                                  ,,;-,               ------ ----- --·-
                                      ·-=..i

                                   --~~t:'.f. - •-- -
                              r Si'i:AAM               -------~
                                                          ~M
                                                       Siuii;:.l.1

                                                                        "Th« 0 ~ Niiliffl ~:,:: !ii''!
                                   -- -----·. ---· -------·--          ;! opi:0,-..1i iff'..:,,,r;,.
```

<!-- FIGURE 15.11: Memory composition circuit diagram — LOST in OCR, needs vision re-OCR from source page ~242 (target: schematic showing RAM/ROM chips, CE/BANK connections) -->

```text
·--.,..~--   ----~'~="J~.~--··------~·~1~;~~-----_-__
          ---~IQ~~,_ .. ·
          ..        I~ l: ~-
                                                                -. ~ ~~~ ,.- ----
                                                                              l ~ I

                                                                                 -x
                                                                                                i I
                                                                                                11
                                                              i_-
                                                                                 ~-, ~-
                       ~) :,d~"i C',: !,'__J*.
                       -
                       ,., ~
                       =   I ! i.
                                    ;it
                                                  :r. -                  ~-
                                                                              -    -··-----
                                                                                        71
                                                                                  .. ._..:J ,..
         !
         ;
         '·
         ;
         :

              I---'-i~i ~~!,1·___. -
                            ~           1
         I
         i                                                I                               '-"   ,
         ';                •-r.lt
                       'ill~~-=~f',
                                         J                I
                                                          : !,                 1:~~:<
                                                                                 g        -¾~ '
                                                                                  :t-~<"'0:···,----
                                                                                                              I
                                                                                                              I
         !
           I                      I
                                1&:                                            I ~-
                                                                               ! ~
                                                                                                I
                                                                                                              l
                            I       31: I                                                      I                  ...?-,
         i
         i
         i
                                    ~                               1
                                                                                   ;;
                                                                                     ~
                                                                                                          I
                                                                                                          I
                                                                                                              I   ·s
                                                                                                                   :=
                                                                                                          I
         '                                                                                                i
                                                                                                                   :
                                                                                                                   C:
                                                                                                                  -~
         I                                                                                                        ·;:;
                                                                                                                   :
                                                                                                                    ~
                                                                                                                    s
         lI
                                                                                                                  (..:

                      • c-~;-
              ~--~o::::i:~,,----      !! -'            o_      ~:1:J, •
                                                                                        ~-~--~
              ------,11~ ~~ '~l
                                          ~1,                       ,-/ ~'fii :1"~..-----.
                                                                                ~-.
                                                                                                                         I-·

                                    ~                               1_ _ _:i::..·----...L....~

              ~------,J                                   JJ
                                                                                                    il
                                                                                                    I !
```

<!-- FIGURE 15.12: Bank control circuit schematic — LOST in OCR, needs vision re-OCR from source page ~243 (target: bank control logic schematic) -->

```text
                   HADRS
                LADRS
                     OIM
                           ~
                                 !       ',001r.Q   4-0Hl'TS-·    t:.G - . - . ·-- -
                                                    ,...___                     Ya..,_-----~
                   A16              I              jro rG/               . Yi-y,------~
                                                                         ,.
                                                                                             ~
                                                                                                        :,l,N K.;t I

                    Al7 --,----.W                                                           _{___/-- ~

                   .A22              I1             ,1=~
                                                          2Q;----.:

                                                    •., J"'H:
                                                        .. l  ,.~            :n ,
                                                                              Ya     I               _
                                                                                                     !l't.i(;:.;-4

                   ,A,               .
                                     ll
                                                    i.. ,.,
                                                    I ~; I           ,·
                                                                          a    "I i . D
                                                                                 -y,;·             - - -;•.'.t(,S•-
                                                                    i         --1LJ                      -

                                           --+0--1
                                                 i

                 ,;..:..·J:<
                   ~           ---..:.. I
                                                                             i   ~i,,::J?
                                                                                               .
                                                 I                           ;
                . :n?          --=5\:-1
                 :t-~:u --;--.:,___,./
                                    'f.,./o.;~

                                                    Bank Control Circuit
```

**Fig 15.13 — Bank select register bit assignments**

<!-- TODO(tier-b): verify Fig 15.13 bank register table against source page ~243 -->

```text
                        @2  @1 :-; @  |
                         CD;     f · ©lCVt®t  |

                          LADR1  O | O | O | O | O | O | 1 | 1
                          LADR2  O | O | O | 1 | 1 | 1 | O | (illegible)

                          HADR1  O | 1 | O | 1 | 1 | O | O

                          HADR2  O | O | 1 | O | O | 1 | 1 | O | O
```

The way of bank conversion by software control is illustrated in the next section. When the PC is reset, it becomes any mode (before reset) of composition No. 1–3. But in the case of no optional RAM BANK #2–#3, it can become only No. 1 mode. If optional ROM is installed, another composition No. 4–6 is possible. Further, as it becomes the mode of 64K bytes full RAM by optional RAM BANK #2–#3, you can use CP/M, etc.

## 15.3 I/O Address

(Address is expressed in Binary.)

<!-- TODO(tier-b): verify Fig 15.14 I/O address table against source pages 245–246 before treating as authoritative -->

**Fig 15.14 — I/O Address Map**

```text
I/O address    : In/Out : I/O device     : Operation
------------------------------------------------------------
00000000
     to          --      user             --
01011111
------------------------------------------------------------
01100000
     to          --      NEC reserve      --
01111111
------------------------------------------------------------
1000XXXX    :   O   : NEC reserve (ROM cartridge
                        or general purpose). A decoded
                        signal appears on /ROME pin.
------------------------------------------------------------
1001XXXX    :   O   : D-FF          : System Control
                                       *Cassette Motor Control
                                       *Clock Command Strobe
                                       *Printer Strobe
                                       *Serial I/F Select
------------------------------------------------------------
1010XXXX    :   O   : D-FF          : Bank Control
------------------------------------------------------------
1010XXXX    :   I   : 3-S-Buff      : Bank Status
                                       *Bank Status
                                       *Serial I/F Select Status
------------------------------------------------------------
1011X000    : I/O   : PPI 81C55     : Command/Status Register
1011X001    :   O   :               : Port A Output
                                       *LCD Chip Select
                                       *Keyboard Scan Data
                                       *Clock Command/Data
1011X010    :   O   :               : Port B Output
                                       *LCD Chip Select
                                       *Buzzer Control
                                       *RS-232C Control
                                       *Auto Power Off Control
1011X011    :   I   :               : Port C Input
                                       *Clock Data
                                       *Printer Status
                                       *BCR Data
                                       *RS-232C Status
1011X100    :   O   :               : Timer Register (lower 8 bits)
                                       *Lower 8 bits of counter
1011X101    :   O   :               : Timer Register (upper 8 bits)
                                       *Upper 6 bits of counter
                                       *Mode Select
------------------------------------------------------------
1100XXXX    : I/O   : UART 6402     : Data Write/Data Read
------------------------------------------------------------
1101XXXX    :   O   :               : Control
1101XXXX    :   I   : 3-S-Buff      : Input Port
                                       *UART Status
                                       *Low Power Signal
------------------------------------------------------------
1110XXXX    :   I   : 3-S-Buff      : Keyboard Input
------------------------------------------------------------
1111XXX0    :   O   : LCDC          : Command Write/Status Read
1111XXX1    :   O   :               : Data Write/Data Read
------------------------------------------------------------
```

### 15.3.1 Detail Information About I/O

This following is the particulars of each function. The I/O address is shown in the number which is used in the actual system.

#### 15.3.1.1 Reserve Area

As this area is reserved for NEC, don't use it.

#### 15.3.1.2 System Control

```
1 0 0 1 0 0 0 0    OUT AX90
```

| Bit | 7    | 6    | 5    | 4    | 3      | 2–0 |
|-----|------|------|------|------|--------|-----|
|     | SELA | SELB | PSTB | TSTB | REMOTE | —   |

**REMOTE** — CASSETTE MOTOR CONTROL
- 0 = Motor Off
- 1 = Motor On

**TSTB** — CLOCK COMMAND STROBE
- 0 = Strobe Off
- 1 = Strobe On

**PSTB** — PRINTER STROBE
- 0 = Strobe Off
- 1 = Strobe On

**SELA / SELB** — SERIAL INTERFACE SELECT

| SELA | SELB | Selection   |
|------|------|-------------|
| 0    | 0    | Not used    |
| 0    | 1    | SIO2        |
| 1    | 0    | SIO1        |
| 1    | 1    | RS-232C     |

#### 15.3.1.3 Bank Control

```
1 0 1 0 0 0 0 1    OUT AXA4
```

| Bit | 3     | 2     | 1     | 0     |
|-----|-------|-------|-------|-------|
|     | HADR2 | HADR1 | LADR2 | LADR1 |

**LADR2 / LADR1** — SELECT ADDRESS AX0 to AX7FFF

| LADR2 | LADR1 | Bank            |
|-------|-------|-----------------|
| 0     | 0     | Bank #0 (ROM #0)          |
| 0     | 1     | Bank #1 (ROM #1)          |
| 1     | 0     | Bank #2 (RAM #4–#7)       |
| 1     | 1     | Bank #3 (RAM cartridge)   |

**HADR2 / HADR1** — SELECT ADDRESS (AX8000 to AXFFFF)

| HADR2 | HADR1 | Bank                        |
|-------|-------|-----------------------------|
| 0     | 0     | Standard RAM (RAM #0–#3)    |
| 0     | 1     | Not Used                    |
| 1     | 0     | Bank #2 (RAM #4–#7)         |
| 1     | 1     | Bank #3 (RAM Cartridge)     |

#### 15.3.1.4 Bank Status

```
1 0 1 0 0 0 0 0    IN AXA0
```

| Bit | 7    | 6    | 5–4 | 3    | 2    | 1    | 0    |
|-----|------|------|-----|------|------|------|------|
|     | BIT7 | BIT6 | —   | BIT3 | BIT2 | BIT1 | BIT0 |

**BIT1 / BIT0** — STATUS OF ADDRESS (AX0 to AX7FFF)

| BIT1 | BIT0 | Status                      |
|------|------|-----------------------------|
| 0    | 0    | Bank #0 (ROM #0)            |
| 0    | 1    | Bank #1 (ROM #1)            |
| 1    | 0    | Bank #2 (RAM #4–#7)         |
| 1    | 1    | Bank #3 (RAM cartridge)     |

**BIT3 / BIT2** — STATUS OF ADDRESS (AX8000 to AXFFFF)

| BIT3 | BIT2 | Status                      |
|------|------|-----------------------------|
| 0    | 0    | Standard RAM (RAM #0–#3)    |
| 0    | 1    | Not Used                    |
| 1    | 0    | Bank #2 (RAM #4–#7)         |
| 1    | 1    | Bank #3 (RAM cartridge)     |

**BIT7 / BIT6** — STATUS OF SERIAL INTERFACE

| BIT7 | BIT6 | Status      |
|------|------|-------------|
| 0    | 0    | Not used    |
| 0    | 1    | SIO2        |
| 1    | 0    | SIO1        |
| 1    | 1    | RS-232C     |

#### 15.3.1.5 PIO 81C55 Address

**Command / Status Register**

```
1 0 1 1 1 0 0 0    IN/OUT AXB8
```

**Port A Output**

```
1 0 1 1 1 0 0 1    OUT AXB9
```

| Bit | 7   | 6   | 5   | 4   | 3   | 2   | 1   | 0   |
|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|     | PA7 | PA6 | PA5 | PA4 | PA3 | PA2 | PA1 | PA0 |
|     | PD7 | PD6 | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|     | KS7 | KS6 | KS5 | KS4 | KS3 | KS2 | KS1 | KS0 |
|     |     |     |     | CCK | CD0 | C2  | C1  | C0  |

- **PA7 to PA0** — LCD Chip Select
- **PD7 to PD0** — Printer Data Port
- **KS7 to KS0** — Keyboard
- **C2 to C0** — Clock Command Output Port
- **CD0** — Clock Data Output Port
- **CCK** — Calendar Shift Clock
  - 0 = Clock Off
  - 1 = Clock On

**Port B Output**

```
1 0 1 1 1 0 1 0    OUT AXBA
```

| Bit | 7   | 6   | 5    | 4   | 3      | 2  | 1   | 0   |
|-----|-----|-----|------|-----|--------|----|-----|-----|
|     | RTS | DTR | BELL | APO | DCD/RD | — | MC  | PB1 | PB0 |

<!-- TODO(tier-b): bit layout of Port B register is garbled in OCR (source page ~250); verify column assignments against source scan, especially DCD/RD and KSS bits -->

```text
               :---:---:        :DcD1:--:       :
               :RTS:DTR:BELL:APO:RD        :MC:PB1:PB0:
               ----------------------------------
                                           · :Kss:
```

- **PB1 – PB0** — LCD Chip Select
- **MC** — MEMORY CONTROL OUTPUT
  - 0 = On
  - 1 = Off
- **DCD/RD** — DCD/RD SELECT OF THE RS-232C
  - 0 = Ring Detect
  - 1 = Data Carrier Detect
- **APO** — AUTO POWER OFF OUTPUT
  - 0 = Output Off
  - 1 = Output On
- **BELL** — BUZZER OUTPUT
  - 0 = Ring
  - 1 = Not Ring
- **DTR** — RS-232C DTR output, Active Low
- **RTS** — RTS output, Active Low

**Port C Input**

```
1 0 1 1 1 0 1 1    IN AXBB
```

| Bit | 7   | 6   | 5   | 4   | 3   | 2    | 1    | 0   |
|-----|-----|-----|-----|-----|-----|------|------|-----|
|     | —   | —   | DSR | CTS | BCR | BUSY | SLCT | CDI |

- **CDI** — Clock Data Input Port
- **SLCT** — PRINTER BUSY
  - 0 = Printer Ready
  - 1 = Printer Busy
- **BCR** — Bar Code Reader Data Input Port
- **CTS** — CTS Input, Active Low
- **DSR** — RS-232C DSR Input, Active Low

**81C55 Timer Register**

```
1 0 1 1 1 1 0 0    OUT/IN AXBC
```

| Bit | 7   | 6   | 5   | 4   | 3   | 2   | 1   | 0   |
|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|     | TL7 | TL6 | TL5 | TL4 | TL3 | TL2 | TL1 | TL0 |

- **TL7 – TL0** — Timer Counter Lower 8 bits

```
1 0 1 1 1 1 0 1    OUT/IN AXBD
```

| Bit | 7  | 6  | 5   | 4   | 3   | 2   | 1   | 0   |
|-----|----|----|-----|-----|-----|-----|-----|-----|
|     | M2 | M1 | TH5 | TH4 | TH3 | TH2 | TH1 | TH0 |

- **TH5 – TH0** — Timer Counter Upper 6 bits
- **M2 / M1** — Mode Select

| M2 | M1 | Mode description |
|----|----|------------------|
| 0  | 0  | Mode 0: Transmits a single square wave where the first half of the count is high and the remaining half is low. |
| 0  | 1  | Mode 1: Continually transmits a Mode 0 type square wave. |
| 1  | 0  | Mode 2: Transmits a single L-pulse during one clock when finishing the terminal count. |
| 1  | 1  | Mode 3: Continually transmits a Mode 2 type pulse. |

#### 15.3.1.6 UART Data I/O Port

```
1 1 0 0 1 0 0 0    IN/OUT AXC8
```

UART DATA PORT

#### 15.3.1.7 UART Control Port

**Command Write**

```
1 1 0 1 1 0 0 0    OUT AXDS
```

<!-- TODO(tier-b): verify UART command write address "AXDS" — may be AXD8; check against source page ~253 -->

| Bit | 7 | 6 | 5    | 4    | 3  | 2   | 1   | 0   |
|-----|---|---|------|------|----|-----|-----|-----|
|     | — | — | CLS2 | CLS1 | PI | EPE | SBS | —   |

**SBS** — STOP BIT SELECT
- 0 = Stop bit length is 1 bit
- 1 = Stop bit length is 1 bit. If data length is 5 bits, stop bit length is 1.5 bits. In the other case, it is 2 bits.

**EPE** — EVEN PARITY ENABLE
- 0 = Odd Parity
- 1 = Even Parity

**PI** — PARITY INHIBIT
- 0 = Generate parity and check
- 1 = Inhibit generating parity and check

**CLS2 / CLS1** — CALENDAR LENGTH SELECT

| CLS2 | CLS1 | Data length |
|------|------|-------------|
| 0    | 0    | 5 bits      |
| 0    | 1    | 6 bits      |
| 1    | 0    | 7 bits      |
| 1    | 1    | 8 bits      |

**Status Read**

```
1 1 0 1 1 0 0 0    IN AXD8
```

| Bit | 7   | 6–5 | 4    | 3  | 2  | 1  | 0–1    |
|-----|-----|-----|------|----|----|----|--------|
|     | LPS | —   | TBRE | PE | FE | OE | DCD/RD |

- **DCD/RD** — Data Carrier Detect / Ring Detect
  - 0 = On
  - 1 = Off
- **OE** — Overrun Error (1 = Detected)
- **FE** — Framing Error (1 = Detected)
- **PE** — Parity Error (1 = Detected)
- **TBRE** — Transmitter Buffer Register Empty (1 = ready to receive data to transmit)
- **LPS** — LOW POWER SIGNAL (1 = low power voltage)

#### 15.3.1.8 Keyboard Input

```
1 1 1 0 1 0 0 0    IN AXE8
```

#### 15.3.1.9 LCDC Address

**Command Write / Status Read**

```
1 1 1 1 1 1 1 0    IN/OUT AXFE
```

**Data Write / Read**

```
1 1 1 1 1 1 1 1    IN/OUT AXFF
```
