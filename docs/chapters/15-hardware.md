# Chapter 15: Hardware

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 228-258). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                          ....

               CHAPTER 15

     !r to another technical manual about the detail
speci~n of PC-8201A's hardware. That manual has already
been oy NECHE, Chicago. Please contact with them.    In
this r, only most important data is listed up.

                     15.1                SYSTEM SLOT
                     15.1.1                Assignment Of Signal
 .. · ----. _:. ·,· -t· ...-'..:··-··.                                                          ··~   ...-i   -----=;-.-......---------~~~- -
                                    ·_System Slot

                                                                  S\"STc.\l SLOT

                                                         I                         i
                                            Pin number   I   Sigr:a/ name          I
                                                                                            Remarks
                                                         I                         I
                                                    1          voo                       +S V

                                                   2           voo                       +S V

                                                   3           AOO
                                                                                I Adc:-ess/Oata 0
                                                4              AC4                      Addra:s/Oata 4

                                               .5             .A.01                     Address/Data 1

                                               6              ACS                       Address/Data S

                                               7              A02                      Address/Cata 2

                                               8              A06                      AddressiOata 6

                                               9              A03                      Address/Data 3

                                               10            A07                       Address/Data 7

                                               11            NC                        No C0nr.e~ion

                                               12            NC                        No C;:nnec:io r.

                                              13             AS                    Address 8

                                              14             A12                   .O..dcr ass 12
                                                                            I

                                                                   Fig 15.1

                                                                                                                     ,,,.-

                   ...

                Pin number
                             I   Signal name

                                   A9
                                               I           Remarks

                                                   Address 9
                     15

                     16            A13             Address 13

                     17            A10             Address 10

                     18            A14             Addresl i4

                     19            Al 1            Address 11

                     20            Ai5         I   Acld:-es~ 15

                     21            A16
                                               i   No Conr:ec::ion

                     22            A18             No Connec:tion

                     23            A17             No Connec:ion

                     24            A19             f'!o C::-~ae::=:i

                     25            NC              Ne C,nnec:ion
            .
                     26            NC              No Connec:tion

                     27            RO              Read                     .,
                                   WR              Write
                 . 28
                     29            10/M            10 OR Memory

                     30            ALE             Address Late."I Enable

                     31            HOLO            HOLO

                     32            HOLOA           HO LO Acknowtedge

                                        Fig 15.2

                                                                            ·&.--·fl
                                                                                       -··.r~
                                                         --:4               ---'!

           Pin number
                        I   Signal name

                              INTR
                                          I           Remarks

                                              INTERRUPT
                33

                34             INTA           INTen Ackncwlec;e
                                          I
                                              R~----
                35            RESET       I    ::.c. l

                37            ROME            RCM e:iat:le
                        I
                38      I     E               E:iacle

                39            BANK;:;:3       FIAM Cassette Selec: signal

                40            NC              No Connec:ion

                41            .HAORO          High Address Disable

                42            LAORO           Low Address Disable

                43            CLJ<            Clock

                44            POWER           RAM Protec: signal

                45            GNO             Ground

                46            GNO             Ground

                47            NC              No Connection

                48            NC              No Connection

                                      Fig 15.3

           15.1.2   Explanation Of Pin

     • 1s.1.2.1         Function Of Signal

       1.       Vdd COut)
                        If you don't use the BCD, this Pin can supply with
                the current of 50mA or so.

       2.       A00-A07 <In/Out)
                    Lower 8 bits of the memory address Cor I/O address)
                appear- on the bus during the first clock cycle of a
                machine cycle.  It then becomes the data bus during the
                other cycles.

       3.       A8-A15 COut)
                    The most significant 8 bits of the memory address or
                the I/O address. The output goes off during Hold mode,it
                then becomes •H• level, because it is connected to a pull
                up resister (100k Ohm). inside.

       4.       /RO COut/3-state)
                           The read control signal, 3-state during Hold mode.

       5.- /WR COut/3-state)
                           The write   control    signal,   3-state   during     Hold
                mode.

       6.       IO/M COut/3-stater
                    When     this   signal   is   •H•   level   and   IL.      level,

            /

                respectively, the CPU have access          to   the I/O and the
                memory. 3-state during Hold mode.

       f                                       -~
           7.   ALE (Out/3-state)
                     It is     used to strobe     the    address     information
                ( A00-A07).    3-state during Hold mode.

           8.   HOLD CIn)
                     The CPU, upon receiving the hold request,        will
                relinquish the use of the bus as soon as the completion of
                the current bus transfer. When the Hold is acknowledged,
                the /RO, /WR,    IO/M, ALE lines are 3-stated and the
                A08-A015 lines are •H• level.

           9•   .HLDA <Out >
                        It indicates that the CPU has received the HOLD
                request and that it will relinquish the bus in the next
                clock cycle.

      10 •      I NTR CIn >
                    The general purpose interrupt.  It is sampled only
                during the next to the last clock cycle of an instruction
                and during Hold and Halt states.

      11.       /INTA <Out)
                    It is used instead of (and has the same timing as) /RO
                during the instruction cycle after an INTR is accepted.

      12.       RESETO (Out)
                     It indicates CPU is being reset.    Can    be   used   as   a
                system reset.

            13.    READY Cin)

                               If it is •L ·, the CPU 1.,,i 11 wait an integra 1 -number of
                           clock. cycles for it to go •H• before completing the read
...... _. ----• ..._'-!, ..or w~j_t!t_ eye 1.e.       ...     ;;;i              --~  ~..___ _.._ -.:.;
                    ...

            14.    /ROME (Out)
                       The enable signal for external ROM cartridge or
                  general purpose. When the upper 4 bits of the I/O address
                  1 s 8, it goes • L

                                   4liHf38

                          IOIM    I ~~1
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
                           Al3     ,a    Ys          ~
                           Ai2           Y' I        Rrr
                                   (     y71
                                              I      L.c!5

                                  Fig 15.4

           15.    E <Out>
                      It is used as a memory enable signal of the read or
                  urite cycle. Eis the logical OR (active high) of /RO and
                  /WR.

                                  Fig 15.5

        16.   /BANK 3 (Out)
                  The memory enable signal of        external        RAM    cartridge.
              (See next section)
    I                                          -~

        17.   HAORSO <IN)
                  If it is .H.,the memory of        high   address         (AX8000    to
              AXFFFF) in PC is disabled.      (See next section)

        18.   LAORSO (IN>
                  If it is .H.,the memory of LOW address ("'X0 to "'X7FFF)
              in PC is disabled.  (See next section)

        19.   CLK (Out)
                       2.5MHz clock output.     It is the same phase as              CPU
              clock.

        20.   POWER (Out)
                  It is the signal /RESET     (connected        to    the    CPU)     is
              reversed.

           15.1.3   DC Characteristics

            -------------------~----------------------
                  Symbol            Drive capacity (mA)
     •       -;00:;o;---------------4~4--=..---~--------
                                               .
             ----------------------------------------
              A8-A1S                  4.4
              /RD,/WR,IO/M
              ALE,RESETO             4.4
              HLOA,/INTA,CLK         2.0
              E,/ROME,/BANK 3        1.1

                    Fig 15.6

                                               ,/

             15.1.4    AC Characteristics

                                                                                                                                                                                                   ··-<   ---~----·
    . j ·_
              ----                                                                                                                .-
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
                      - .--                                      ,.                ~                                                                                                ..."' - ·--
                                                                                                                                                                                    -    :i- -

                              L
                                                                                                                                                                                     ~
                                                                                                                                                                                     c
                                                                                      '-1

                                                                   I
                                                          I- I- - -                                          -I                                                 -
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
                              -                                                                                      .!                                                                  loo{
                                                                               r.:-....                                                                                                  ~

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

                                                                                            Fig 15.7

                                                                                                                                                              ......
                                                  I X >< -·                 lJ                   I
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

                                                                                         Fis 15.8

                                                                                         - 238 -                                                          /

-
        "
            --- --
                                                   I       min       (l\S)                   typ CnSl               l'IIGl:(            CnS,       --
                                                                                                                                                   ··-~-,..., - __..._...
                                                                                                                                                                ------.     -----~
                     1
                               ta~             l                                         -    J407

    .                          tl..GX          I   t
                                                             112
                                                                                                        .
                               t,u.                I
                                                   I
                                                             rr2                                                I
                               i,:.u.
                                               i
                                               I
                                               !
                                               I
                                                                 7i.                 I                          I
                                                                                                                I
                                  t~           !             16:?                    I                          I
                                                             142
                               t,4~           I             :r·1                     I
                                                                                     !                          I
                                                                                                                !                              I
                                  t..:        I             i ...,-  ~           II                             i
                                                                                                                !
                                                                                                            i            ,. ..
                               tAD            I                                  I                              I
                                                                                                                                   ~

                               =~~            I                                  I                          I
                                                                                                            I
                                                                                                                          -.· -
                                                                                                                        -o.;

                              t:11)            II                                                           I
                                                                                                            I
                                                                                                                        334-
                                               ;
                         !
                         :     tc:                           !2S                 I                          I
                             . t~.
                               ,
                                           I
                                              I
                                                             163                              .
                              t~CM         i           I

                                                                 0                                                                             I
                                                                                                            1
                                           I
                                                                                                                                               '
                              tw0&.
                                          I                                      I
                                                                                                            I              7S                  I
                              ta.         I
                                          I
                                                             13              I                              I                                  I
                              two         I                  88              I                              I
                                                                                                            I
                              to,,        Il
                                                            srs              I                              r
                         I

                         :    t:,D:v      'i                                 !                              '
                                                                                                            !         '-~?-
                         l
                         !    ':ART
                                          I
                                          r                                  I                                        ....,:...,, -~:
                         I    ~
                              ·~:...:fY
                                          I                                  I                                            H
                              t~--r:      1·                /{0
                                                                             I
                                                                             I
                                                                             I

                              t';rrl-!
                                          I                      0           I
                                                                             I
                                          I                                  I

                                                                         Fig 15.9

F

               15.2       MEMORY CONTROL CIRCUIT
                           In this section, RAM #n means the chip number                                on   the
                           main board.
     ... .I
                      .                                 -,~   .       .l

                      The memory of PC-82~1A corisists of RAM 16K and ROM 32K
              bytes,and can be expanded to 48K bytes on optional RAM socket
              CRAM Chip #2- i7) and to 32K bytes on user ROM socket CROM #1)
              in PC.

                      Show the composition of memory in Fig 15.11 RAM Chip
              (#0- #7) and ROM C#0- #1) is connected to the same DATA bus
              and their out~uts are controlled by /CE and /BANK signal.
              There are five banks of BANK #0(available ROM #0), SANK
              #1(user ROM #1), STORAMCavailable RAM #0- #1 and optional RAM
              #2-#3) ,BANK #2 (optional RAM #4- *7) and BANK *3 <RAM
              cartridge). Show the bank cont~ol circuit in Fis 15.12 Sy
              means of this, you can assign each back to the memory address
              in 64K bytes area of CPU shown in Fis 15.13 and Fi9 15.10.

                                   Address          STDRAM                        EANK#2
                                                                           r - - - - - - - - -- ~I
                               /\X FFi=t=. ·
                                                    RAM~l                          R~M~7
                              I\X Eeaa
                                  Dr:F;:                                                       i
                                                                                               i
                                                    RAM le                        RAM#&
                              ~ C0ee                                   I

                              I\X BFFt=        r                  -   -J

                                                    RAM#2                         RAt-'f #!"
                              /\~ Aa-sa_.
                              /\X 9FF F
                                                                                                   I

                                                                                                   ..
                                                    RAM~3                        RAM;:4            I

                              /\t.ieee
                                                                                                   I

                 .Address· ··· --·- · ·•··
    :- . .-

                                 ~i--·_m_,~_-RAM·-~----~·~!]~ ....... ~~;;:· 1.
                                                                  Ruf,!
                                                                2.0Nl<l#l i
                                                                           I
                                                                           I
                                                                                         ?.~r-1
                                                                                     :.~N7:r~
                                                                           !
                                          (D
                                                       ,.----·-----·---------------~
              •f\"y
                 V' - -

                                                   I;
                        --
                    :-.-~,-

                                      I
                                 :~-i -----. ---··
              :\~ C~2::J                  F.AM                    P.;M                  RAM
                                      ffiii!:lr i               :ANi<='2           i·8~Nl#3
                                  I!               I           :....---            _!- - - -

                                  ,,
                                  I
                                  I

                                  -----------------------
                                      ,,;-,               ------ ----- --·-
                                          ·-=..i

                                       --~~t:'.f. - •-- -
                                  r Si'i:AAM                   -------~
                                                                  ~M
                                                               Siuii;:.l.1

                                                                                "Th« 0 ~ Niiliffl ~:,:: !ii''!
                                       -- -----·. ---· -------·--              ;! opi:0,-..1i iff'..:,,,r;,.

                                                         Fis 15.10

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
                            I       31: I                                                           I                  ...?-,
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

                                                                        Fig 15.11

. .--.. --. -·. - 'f"
                                                                          -            . ..f
                                                                                                                               ··:~

                           IAIJ'
                        LADRS
                             OIM '
                                   ~
                                         !       ',001r.Q   4-0Hl'TS-·    t:.G - . - . ·-- -
                                                            ,...___                     Ya..,_-----~
                           A!la              I              jro rG/               . Yi-y,------~
                                                                                  ,.
                                                                                                     ~
                                                                                                                :,l,N K.;t I

                            At1 --,----.W                                                           _{___/-- ~

                           .4Z2              I1             ,1=~
                                                                    2Q;----.:

                                                              •., J"'H:
                                                                  .. l  ,.~            :n ,
                                                                                        Ya     I               _
                                                                                                               !l't.i(;:.;-4

                           ,&,               .
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

                                                            ~ank Control C;,-e.wf:

                                                            Fig 15.12

                                        ~I ' @2 '1@1·1:-;®
                                         _~CD;     I f · ©lCVt®tI                                  I i

                                           LAERII O I O I O I O I o/ 0 I I I '
                                          UDR2 I O I O I O I f I l I I I O I (          I

                                          HADRI j O I I   , Io r I I I0 0               I

                                          HADR2 I O ~ 0   I I0 0 I I I0 0

                                                             Fi9 15.13

r:

                           The way of bank conversion by software        control
                   illustrates in next section. When PC is reset, it becomes any
                   mode (before reset)of the composition No.1-3. But in the case
                   of nothing of optional RAM BANK #2- #3, it can become only
                   No.1 mode.  If optional ROM is~ins~alled, another composition
                   No.4-6 are possible. Further, as it becomes the mode of 64K
                   bytes full RAM by optional RAM BANK #2- #3, you can use a
                   CP/M, etc.

     ·--~                                - 244 -

           15.3   I/O ADDRESS

    -f .    (Address is expressed in Binary.) l
             I/O address:In/Out: I/O device:Operation
            -----~------------------------------------------
             00000000 -:
                                           user
                  V
             01011111
             01100000
                                           NEC reserve
                  V ·.
             01111111
            -----------------------------------------------·
             1000XXXX    0   NEC reserve CROM cartridge
                                  : or general purpose) A decoded
                                  : signal appears on /ROME pin.
             1001XXXX         0    D-FF     System Control
                                            *Cassette Motor Control,
                                            *Clock Command Strobe
                                            *Printer Strobe
                         .,
                          I
                                            *Serial I/F Select
            ----------------------------------------------~:
             1010XXXX : 0 : O-FF l Bank Control
            -----------------------------------------------·
             1010XXXX    I   3-S :
                                   -Buff: Bank Status
                                           *Bank Status
                                           *Serial I/F Select
                                               Status
            -----------------~---------------------------
             1011X000 :I/O PPI
                                   81C55    Command/Status Resister
             1011X001         0             Port A Output
                                             *LCD Chip Select
                                             *Keyboard Scan Data
                                             *Clock Command/Data
                                           :------------------------

                                       - 24S -

            :-----------
              1011x010   0
                                            ------------------------
                                             Port 8 Output
                                              *LCD Chip Select
                                              *Buzzer Control
           ·'                                 *RS-232C Control
                                              *Auto Power Off
                                                   Control
                 1011X011         I
                                            ------------------------
                                             Port C Input
                                              *Clock Data
                                              *Printer Status
                                              *BCR Data
                                              *RS-232C Status
           , 1011X100             0         Timer Resister-
                                                   Clower 8 bits)
                                            *Lower 8 bits of counter-
                 1011X101         0
                                           .------------------------
                                           : Timer Resister
                                           :      (upper 8 bits)
                                           l*Upper- 6 bits of counter
                                           l*Mode Select
                 1100XXXX   :I/O1 UART:
                                      6402: Data Urite/Data Read
                --------------~:
                 1101XXXX : 0:
                                           :-----------------------
                                             Control
                 1101XXXX   f I       3-S-:
                            I
                            I
                            I .
                                       Buff: Input Port
                            I                 *UART Status
                                              *Low Power Signal
                ~----------------------~-----------------------
                 1110XXXX : I : 3-S-:
                                      Buff: Keyboard Input
            -----------------------------------------------:
             1111XXX0 : 0: LCOC: Command Write/Status
                                        Read
            ---------------;
             1111XXX1 : 0 :
                                  :------------------------:
                                  : Data Ur-ite/Data Read
           ~-----------------------------------------------
                      Fig 15.14

           15.3.1     Detail Information About I/O
                 This following is the particulars of each function.
         The I/O address is shown in the number which is used really in
     · ~ system;                        -   ~.t

           15.3.1.1    Reserve Area

                      As this area is reserved for NEC,don't use it.

       15.3.1.2        System Control

                      11 0 0 1 0 0 0 0: OUT AX90

                       7    6       5        4    3

                      :SELA:SELB:PSTB:TSTB:REMOTEI
                    ----------------      ------------
                    REMOTE CASSETTE MOTOR CONTROL
                       0         motor Off
                       1         motor On
                    TSTB        CLOCK COMMAND STROBE
                       0         Strobe Off
                       1         Strobe On
                    PSTB     PRINTER STROBE
                       0      Strobe Off
                       1      Strobe On
                    SEL A SEL B          SERIAL INTERFACE SELECT
                       0        0         Not used
                       0        1         SI02
                       1        0         SIOl
                       1        1         RS-232C

           15.3.1.3    Bank Control

                      :1 0 1 0 0 0 0 1l     OUT ~Al 4       ~

                                3       2         1   · 0
                  ---------------------------------
                          lHAR02lHARD1lLAOR2lLADR1l

                  LADR 2     LAOR 1     SELCT ADDRESS AX0 To AX7FFF
                       0       0         Bank #0 <ROM #0)
                       0        1        Bank #1 · <ROM #1)
                       1       0         Bank #2 <RAM #4 - #7)
                       i       1         Bank #3 <RAM cartridge)
                  HADR 2     HADR 1     SELECT ADDRESS
                                          (AX8000 TO AXFFFF>
                       0       0         Standard RAM CRAM #0 - #3)
                       0       1         Not Used                     •
                       1       0         Bank #2 CRAM #4 - #7)
                       1       1         Bank #3 CRAM Cartridge)

                               -    ·---- 248 -
                                                                                I

           15.3.1.4           Bank Status

       .!             :   1 0 1 0 0 0 0 0: IN "XA0             .-4

                          7       6           3    2   1   0

                  BIT 1               BIT 0       STATUS OF ADDRESS
                                                      <"'X0 TO "X7FFF)
                              0        0           Bank #0 <ROM #0)
                              0        1           Bank #1 <ROM #1)
                              1        0           Bank #2 CRAM #4 - #7).
                              1        1           Bank #3 (RAM cartridge)
                  BIT 3               BIT 2       STATUS. OF ADDRESS
                                                      <"X8000 TO "XFFFF)
                          0            0           Standard RAM CRAM #0 - #3)
                          0            1           Not Used
                          1            0           Bank #2 <RAM #4 - #7)
                          1            1           Bank #3 (RAM cartridge)
                  BIT 7               BIT 6       STATUS OF SERIAL INTERFACE
                          0            0          Not used
                          0            1          SI02
                          1            0          S101
                          1            1          RS-232C

           15.3.1.5    PIO 81CSS Address

                  *Command I Status Resister
                                                 -~ .   d           ..
                      :1 0 1 1 1 0 0 0: IN/OUT Axes

                  *Port A output

                      :1 0 1 1 1 0 0 1: OUT AXB9

                       7   6     s    4   3      2      1       0

                      lPA7lPA6:PA5:PA4lPA3:PA2lPA1:PA0:

                      lP07:P06lP05lP04lP03:P02:P01lP01:

                      lKS7:KS6lKS5:KS4lKS3lKS2lKS1lKS0:

                                     :ccK:co0:c2 :c1 :ce :

       PA7 to PA0              LCD Chip Select
       P07 to P00              Printer Data Port
       KS7 to KS0              Keyboard
       C2 to C0                Clock command Output Port·
                                                            .
       CO0                     Clock Data Output Port
       CCK                     Calendar Shift Clock
         0                     Clock Off
         1                     Clock On

       *Port B Output

                  :1 0 1 1 1 0 1 0:                  OUT ""XBA

                                       - 2se -

                    7   6   5   4      3   2    1     0
               ----------------------------------
               :---:---:        :DcD1:--:       :
               :RTS:DTR:BELL:APO:RD        :MC:PB1:PB0:
           •   ---------~-----------~--~~----:---
               ----------------------------------
                                           · :Kss:
               ----------------------------------
               PB1 -- PB0           LCD Chip Select

               MC                   MEMORY CONTROL OUTPUT
                0                    On
                1                    Off

               OCO/RO               OCO/RO SELECT OF THE RS-232C
                0                    Ring Detect
                1                    Data- Carrier Detect

               AP0                  AUTO POWER OFF OUTPUT
                0                   Output Off.
                1                   Output On
               BELL                 BUZZER OUTPUT
                0                   Ring
                1                   Not Ring

               DTR                  RS-232C OTR output Active Low

               RTS               RTS output Active Low

                                - 251

           *'Pol"'t C Input

                     :1 0 1 1 1 0 1 1:        IN "'XBB
                                               _..J  J
                                5    4    3      2       1   0
                   .-----------------------------------
                            I   :   :        I    :
                              :osR:CTSLBCR:BUSYiSLCT:cor:
                    ----~------------------------------
       CDI                    Clock Data Input Port
       SLCT                   PRINTER BUSY
           0                   Printer Ready
           1                   P,-intel"' Busy
       BCR                    Bar Code Reade,- Data Input Port

       CTS                    CTS Input Active Low

       DSR                    RS-232C OSR Input Active Low

           *81CSS Timer Resister

                   :1 0 1 1 1 1 0 0: OUT/IN AXBC
                  -----------------                            -~.       ~

                       7       6       5       4       3       2         1       0
                  ---------------------------------
                  lTL7lTL6lTLSlTL4lTL3lTL2lTL1lTL0:

                  TL7 -- TL0               Timer Counter Lower 8 bit

                   :1 0 1 1 1 1 0 1: OUT/IN AXBO

                   7       6       S       4       3       2         1       0

                   lM2:M1:THS:TH4lTH3:TH2lTH1lTH0:
                                                                                 •
                  THS -- TH0 Timer Counter Upper 6 bit

                   M2              M1
                   0               0               This-mode transmits a single-
                                                   square wave which the first
                                                   half of the number of count
                                                   is high and remaining 1s low.
                                                   (Mode 0)
                   0               1               This mode continually transmits
                                                   a Mode 0 type square wave.
                                                   (Mode 1)
                   1               0               Thi9 mode transmits a L-pulse
                                                   (single pulse) during one
                                                   clock when finishing the
                                                   terminal count.
                                                   (Mode 2)
                   1               1               This mode c6ntinually transmits
                                                   a Mode 2 type pulse.
                                                   (Mode 3)

           15.3.1.6       UART Data I/O Port

                      -------------------
                      :1 1 0 ~ 1 0 0 0: IN1qur ?fC8
                      UART DATA PORT

       15.3.1.7           UART Control Port

                  *Command Write

                      :1 1 0 1 1 0 0 0:   our AxDs

                                :cLS2:CLS1lPI:EPE:ses:

                  SBS          STOP BIT SELECT
                      0         Stop bit length is 1 bit
                      1         Stop bit length is 1 bit.
                                If data length is S bits,
                                stop bit length is 1,5 bits.
                                lh the other case, it is 2 bit.

                  EPE          EVEN PARITY ENABLE
                      0         Odd Parity
                      1         Even Parity

                  Pl           PARITY INHIBIT
                      0         Generate parity and check
                      1         Inhibit generating parity

                    and check

           CLS 2   CLS 1    CALENDAR  LENGTH SELECT
    ~                              ,~
                                      .   "'
           0       0         Data Length s bits
           0        1        Data length
                                       . 6 bits
            1      0         Data length 7 bits
            1      1         Data length 8 bits

                    *Status read

                    :1 1 0 1 1 0 0 0: IN AXO8
     ..i
                    -----------------            -    .....
                      7            4    3   2    1        0

                    :LPS:     ITBRE:PElFE:OE:--:- /--:
                                                     :oco1 RD:

           DCO/RO           Data Carrier Detect/Ring Detect

            0                On
            1                Off

           OE               Overrun Error
            1                Detected

           FE               Framing Error
            1                Detected

           PE               Parity Error
            1                Detected

           TBRE             Transmitter Buffer register Empty
            1                ready to receive data to transmit

           LPS              LOW POWER SIGNAL
            1                low power voltage

           15.3.1.8     Keyboard Input

                      :1 1 1 0 1 0 0 0:   IN -.iXE8~ .

       15.3.1.9        LCDC Address

                  * Command Write /Status Read

                      :1 1 1 1 1 1 1 0:   IN/OUT AXFE

                  * Data Write/Read
                      :1 1 1 1 1 1 1 1:   IN/OUT AXFF

```
