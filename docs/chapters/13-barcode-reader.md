# Chapter 13: Barcode Reader

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 221-222). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
      ,:   ....                                                        ··.~
                                                                              _,.
                                                                              ......... -----··--

                                                   CHAPTER 13

                          This chapter explains Electric specification and Basic
                  theory of Operation of the Barcode Reader.
                          The Barcode Reader program included in· the PC-8201A
                  Personal Application Kit assumes that operation is done uith
                  the HEOS-3071 ( pr-educed by HP Corp.) . ·

                  13.1   ELECTRIC SPECIFICATION

                          Refer to the "PC~8201A USER'S GUIDE" about the shape
                  and Pin Connection of the BAR Code i~te~face a~d elect~ic
                  specification.
                          You may connect any Bar Code Pen to this interface.
                  But NEC recommends the products of YHP(YOKOKAWA HP) or (MECANO
                  Kogyo) and it is better that the Pen has the Power switch, for
                  saving the electric power of the PC-8201A.
                          The data line of Barcode Reader is connected to the
                  Pin-2 of BCR.     And this pin is connected to the RSTS.S of
                  CUP(80C85) and Port C-3 of 81C55 as sho~n blow •

                             .   ~~B

                             ~ G-~G-~e - - , 1?1~
                                     5 ,...,___
                                            7711
                                 'Ice.                          Fi'i~ {3.1

l.·

                      While the Bar-code Re.ader ~is p01.1er-ed on, PIN-2 is        kept
            as 101.1 1eve 1 , and RSTS.5 lS High.
                    BLACK BAR is represented by logical Low, SPACE BAR                by
      . J
            High respective 1y·.                ..   -"

            13.2   THEORY OF OPERATION
                    This section describes the            basic   sequence     of   the
            reading data from Bar-code Reader.
            1.   If power- on. RSTS.5 is activated. At the fir-st point of
                 the RSTS.5 routine which is inter-r-upted by RSTS.5 disable
                 a 11 inter-r-upt.
            2.   Pole the Bar- Code DATA por.t. · And calculate the          duration
                 of same status and save the status and Duration.
            3.   If Low level continues too long assume that Po1.1er- off           and
                 enable
            4.   Decode the got.Data and transfer the        data   to   the    upper-
                 r-outine.

```
