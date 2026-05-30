# Chapter 7: Ram Organization

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 79-101). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
     ~PTER 7
     ~GANIZATION

     ~   FILES

     ~pter 2 to understand the whole of the

      I are stored with the fixed order.  It
     .Jes, the BASIC programs which has the
     j at the bottom of the RAM   area, near
     ~II files, the suffix is ".00") are
      files.    And CO files,    the Machine
     ,CO" are saved above the DO files, near
     (llustration will help you understand

-~

        1.   There are S files in RAM.

                   AXFFFF ~---------------
                           :Bookkeeping           I
                                                  I
                                                      ""
                                              I
                             Area             I

                          ----------------
                          -----------------
                          :Free area &        I
                                              I

                          :Data area          lUpper

                             MACHIN.CO

                                              ,.
                                              I

                             DIARY.DO

                                              I
                                              I

                             MEMO.DO          :Lower

                             GRAPH.BA
                                                      V

                             GAME.BA          I
                                              I

                                              : <- BOTTOM

                          Fig 7.1.

    2.   Add new BASIC file, GOLF.

                                               •   --

                               ----------------- <---
                           A   I
                               I   MACHIN.CO
                                                    Moved
                   Upper
                               -----------------        up

                               I
                               I   DIARY.DO

                               -----------------
                               I
                               I   MEMO.DO

                               ---------------- <---
                               I
                               I
                               I
                               I   GOLF.BA    :<-- Added here
                               ---------------- <---·
                Lower          I
                               I   GRAPH.BA
                                                    Not
                           I
                           I

                           V
                               -----------------
                               I
                               I
                                                     Changed
                                                          I
                                                         .I
                               I
                               I   GAME.BA

                               ----------------- <---
                               Fig 7.2

   3.   Add new ASCII file, ADORES.
                                                     --~

                        ,.
                             ----------------- <--
                                                I
                                                I

               Upper-        l MACHIN.CO        I
                                                .'

                             ----------------- Moved
                                                           up
                             : DIARY.DO
                                                            ,.I
                                                            I
                                                            I

                             : MEMO.DO
                                                     <--
                             : ADORES.DO             <-- Inserted
                                                           here
                                                     <---
                   Lower-      GOLF.BA
                             -------------- Not
                      V                      changed
                               GRAPH.BA

                             : GAME.BA
                             -----------------<----
                             Fig 7.3

                                       -·82 -
                                                 -4

        Add new CO file, CHAR.CO

                       ...   : CHAR.CO          l<-- Inserted here

                             ----------------- <---
               Upper         : MACHIN.CO

                             : DIARY.DO

                             l MEMO.DO

                                                 Not changed
                             : ADORES.DO

                             I
                             I

                   Lower : GOLF.BA

                      V
                             : GRAPH.BA

                             l GAME.BA

                             ----------------<----
                             Fig 7.4

               A new BA file is created above the old BA files.
       Otherwise a new DO file is stored below the lowest DO file,
       just above the BA files. A new CO file is made just ABOVE the
       CO files. (Just below the address which is pointed by VARTAB.
       Refer to "Bookkeeping area".)

               And you know that the non-registered BA file is
       created between the BA files and DO files, as described in "BA
       file" of "What is RAM files·.

                      ex.
                      Non-registered program is created just
                      under the ASCII file.

                                               I   A
                                               I

                               : ASCII1.DO
                                                       Upper
                                               I
                                               I

                                non-registered:
                                program

                              -----------------        Lower
                              : BASIC2.BA          V

                      Fig 7.5 Position of non-registered program

                The   detail   information· about    the    directory
        configuration is described in ·Directory structure· • The
        bookkeeping area and the directory area are situated at the
        top of RAM area.

                       "'XFFFF   ----------------- <---.

                       "'XF977                        I
                                                      I
                                  I              I    I
                                  I              I    I

                                 : Directory area: bookkeeping
                                 I
                                 I                     area
                       "'XF84F

                       "'XF380   ----------------- <---

                       Fig 7.6 Directory position

        7.2   BOOKKEEPING AREA

               The book-keeping area is lQcated at the top of the RAM
       area.   The area is divided into 3 parts. The first part,
       lowest part from AXF380 to AXFBBF, includes the pointers and
       flags for RAM file handling. And many BASIC interpreter's
       flags, pointers and temporary data area are here.      As you
       know, the directory area is included in this part.
               The second part, AXFBC0 to AXFE3F, is used for the
       line buffer. of LCD display.      BASIC uses this area in the
       Screen Editor function, also. But the concept of this line
       buffer is different from the VRAM in the traditional disk top
       personal computer. Only the character- codes are stored in
       this buffer. There is no attribute data. The attribute data
       is stored in another table.       Refer to the chapter     9,
       explanation about the LCD driver.
               The third part, AXFE40 to AXFFFF, is reserved by BIOS.
       The switches and data storage for RS-232C, Key Board and other
       I/O drivers are stored here.

                 AXFFFF   ----------------
                          I'

                          : Part III       BIOS's data

                AXFE40    ----------------
                          ',
                          l Part II        LCD buffer

                AXFBC0    -----------------
                          I'              : BASIC's data
                          : Part I        :. File handling data
                                             Directory
                AXF380    -----------------
                Fig 7.7 Bookkeeping area

                                 -~-

       7.2.1   Part I ( For RAM File Handl1ng And BASIC>

                   NOTE:                 ..
                       In this section, the articles about        the
               pointers and flags for BASIC are omitted, because this
               document is written for the programmer who wants to
               understand the many good features in PC-8201A, in
               order to utilize this machine with 2nd ROM or user's
               machine language program. Not written for the people
               who wants to understand the internal specification of
               PC-8201A's   BASIC   interpreter.   So I think this
               document is unfriendly for such kind of people.
               Please refer to another manuals and textbook if you
               need understand the BASIC interpreter.

               There are many important pointers are stored in this
       area for RAM file handling. When some of them are mis-handled
       in your routine, all RAM files might be deleted at next
       operation of the standard ROM,ROM #0, for instance, power-on
       or next SAVE command in BASIC. Because the standard programs
       (BASIC, TEXT and TELCOM) and operating system (represented by
       Menu), believe that these pointers point the right address.
       So if a pointer which should point the lowest address of the
       DO files, points one byte smaller than it should point
       correctly, TEXT might not invoke any DO files in it. Please
       understand the purpose of each pointer and make sure that each
       pointer has a right value any time.

               The important pointers for RAM files are listed below.
               ADDRESS <Hex>   NAME            SIZE (Decimal)
               F380            FSIOSV          2
               F384            HIMEM           2
               F459            STKTOP          2
               F450            TXTTAB          2
               F84F            DIRTBL          33
               F870            NULDIR          11
               F87B            SCROIR          11
               F886            EOTOIR          11
               F891            USROIR          231
               F9B0            BOTTOM          2
               FA9A            MEMSIZ          2
               FABF            FRETOP          2
               FAE1            ASCTAB          2

                  FAE3           8INTAB           2
                 .FAES           VARTAB           2
                  FAE7           ARYTAB           2
                  FAE9           STREND           2
                  FB63           FILTAB           2
                  FB67           NULBUF           2

       7.2.1.1     FSIDSV

                 ADDRESS         "'XF380
                 SIZE            2 bytes
                 Purpose         First power on or not
                          If this FSIDSV is not identical' with FRSTID
                 ("'X8A4D), the initialization routine falls into the
                 ·coLD START• routine.    In this case, the all data and
                 files in PC-8201A are cleared.         The ·coLD START•
                 routine    sets   FRSTID    here    after    done   the
                 initialization.    And no one may not change this ID
                 value.

       7.2.1.2     HIMEM

                 ADDRESS         "'XF384
                 SIZE            2 Byte

                 PURPOSE         Highest memory available memory

                         This pointer keeps the highest memory address
                 available for BASIC. The area between the address in
                 this pointer and "'XF380 is reserved for the machine
                 language file or another user's special working area.
                 No standard program will break the data in this area
                 except POKE statement in BASIC.   (The •poKE• statement
                 can write on anywhere in the RAM which is selected
                 now. So be careful with the address in POKE statement

                       when you use it for s~ori~g your machine language
                       program or character data into RAM area.) The "HIMEM"
                       can be changed by the second parameter of "CLEAR"
                       statement in BASIC.    Refer to the PC-8201A BASIC
                       reference manual.

       7.2.1.3          TXTTAB

                       ADDRESS        AXF450
                       SIZE           2 bytes
                       PURPOSE        Pointer to beginning of current
                                      BA file
                       This pointer is valid in BASIC mode.       In
               another mode, TEXT or TELCOM mode, this pointer keeps
               the latest value used in BASIC.  In BASIC mode, the
             • address of the first link pointer is stored here. And
               this value won't be changed in BASIC mode unless
               "LOAD" command is executed to load another BASIC
               program, or "NEU" command.   Almost internal routine
               for BASIC interpreter refers to this pointer to know
               the top of the current program. And this pointer 1s
               very important when a BA file is deleted, too. You
               cannot kill a BA file in BASIC mode when this TXTTAB
               points the BA file.      Refer to "How to delete a BA
               file".

       7.2.1.4         STKTOP

                  ADDRESS             AXF459
                  SIZE                2 bytes
                  PURPOSE             Top location to use for the stack
                          Initially set up by INIT routine in ROM #0
                  according to memory size to allow for 256 bytes of
                  string space. This value will be changed by a CLEAR
                  command with the first argument.      The difference
                  between MEMSIZ and STKTOP means total string space.

                 ,,-
            .

                   The 2 byte space between MEMSIZ and FILTAB is kept for
                   ·vAL• function in BASIC. The ·vAL• function sets ·0·
                   at the end of the strings on evaluating the strings.
                   So this 2 bytes area prevent to over-write the FCB
                   area above the FILTAB.

       7.2.1.5     OIRTBL

                 ADDRESS          "XF84F
                 SIZE             33 bytes
                 PURPOSE          directory for program in ROM
                         The names and pointers for the programs 1n ROM
                 are stored here. They are BASIC, TEXT and TELCOM. If
                 you don't want to use these standard programs, you can
                 use this area for your programs. This area will be
                 kept until   •coLO START• is invoked.       Refer   to
                 ·oirectory construction.·

       7.2.1.6     NULOIR

                 ADDRESS         . "XF870
                 SIZE              11 bytes
                 PURPOSE          Directory for non-registered program
                         This area is kept for internal use.        The
                 "non-registered program· that means the BASIC program,
                 just typed after selecting BASIC, uses this area for
                 pointing the starting address.      There is a detail
                 explanation about the 'non-registered· program in the
                 previous section,   'BA file".    And also, refer to
                 "Directory Construction".

       7.2.1.7      SCRDIR                       •

                   ADDRESS          "'XF87B
                   SIZE             11 bytes
                   PURPOSE          Directory for SCRAP
                          The TEXT editor can do •sELECT•, •cur·, •copy•
                 and    •pAsr•.    This   directory is used for this
                 ·temporary file•, SCRAP,     in TEXT.     This file is
                 created    when some characters are ·sELECT.ed and
                 •coPY.ed or •cur·.   (Refer to PC-8201A user's guide
                 •sELECT•, •cur•, ·copy• and •PAST  ) This file is kept
                 even if you exit from TEXT. And you can use it in
                 another programs, BASIC, TELCOM and so on.    If you CUT
                 or COPY without SELECT, the starting address points
                 Control-Z.     It means that the SCRAP files is empty.
                 Refer to •Do file• and •Directory Construction".

       7.2.1.8     EDTOIR

                 ADDRESS            "'XF886
                 S-IZE              -11 byte!!
                 PURPOSE            Directory for EDIT in BASIC
                         The EDIT command in BASIC makes a temporary DO
                 file.   This slot is used for this file. Refer to •no
                 file· and ·Directory Construction·.

       7.2.1.9     USRDIR

                 ADDRESS            "XF891
                 SIZE               231 bytes
                 PURPOSE            Directory for user's files (21 slots)
                         This area is used for BA files, DO files and
                 CO files which user makes. 21 files can be registered

                                /
                                             •
                   here at most. The end of directory area is indicated
                   by ·--xFF·, ·Directory search stopper·. Refer to·
                   Directory Construction·.

        7.2.1.10     BOTTOM

                   ADDRESS           "'XF9B0
                   SIZE              2 bytes
                   PURPOSE           Bottom address of RAM
                           The lowest available RAM address is saved
                   here.   You can know how many RAM chips are installed
                   in this RAM bank easily by checking this pointer.

       7.2.1.11     MEMSIZ

                  ADDRESS            "'XFA9A
                  SIZE               2 bytes

                  PURPOSE            Highest location in Memory
                            This pointer points the top ~f the string
                  space.     The area between the MEMSIZ and FRETOP+l is
                  ca 11 ed ·used string space·, and the area between the
                  FRETOP and STKTOP +1 is ·Free string space·.

       7.2.1.12     FRETOP

                  ADORESS            "'XFABF
                  SIZE               2 bytes
                  PURPOSE            Top of the string free space
                             The highest address (closer to ... XFFFF) of   the

                                                                                     -   I

                   string free area is kept in thi9 pointer.          The lowest
                   address is kept by STKTOP + 1.

       7.2.1.13     ASCTAB

                  ADDRESS            ... XFAE1
                  SIZE               2 bytes
                  PURPOSE            Pointer to start of ASCII files
                          This pointer points     the    first   byte    of    the
                  first 00 <ASCII> file.

       7.2.1.14     BINTAB

                  ADDRESS            ... XFAE3
                  SIZE               2 byte9
                  PURPOSE            Pointer to 9tart of COMMAND file
                             The lowest address of the   first   CO     file    is
                  kept here.

       7.2.1.15     VARTAB

                  ADDRESS           ... XFAES
                  SIZE              2 bytes
                  PURPOSE           Pointer to simple variable space.
                       This pointer keeps the start address                    of
               VARIABLE TABLE area just above the CO files.

        7.2.1.16      ARYTA8

                    ADDRESS           "XFAE7
                    SIZE              2 bytee

                    PURPOSE           Pointer to beginning of array table
                            The ARRAY TABLE is allocated just above the
                    VARIABLE TABLE. This points the beginning address of
                    this ARRAY TABLE.

        7.2.1;17     STREND

                  ADDRESS             "XFAE9
                  SIZE                2 bytee
                   PURPOSE            End of storage in use
                          This pointer keepe just above the address of
                  ARRAY .TABLE.   The area between this pointer and the
                  stack pointer can be used as the FREE area.

                  Note:
                  When you ~ill use this FREE area, you have to consider
                  about the stack area. As the stack pointer points the
                  current bottom of the stack area, you had better about
                  120 bytes for the feature etack operation.

       7.2.1.18      FILTAB

                  ADDRESS             "XFB63
                  SIZE                2 bytes
                  PURPOSE             Point to address of file data
                              This points to the   starting   address   of   the

                       /

                   file data area.  1
                                       The file data area consists of the
                                             1
                   FCB address. If MAXFILES command in BASIC was not
                   executed after 'COLO START", this table has 4 bytes.
                   The first 2 bytes points the NULL files buffer.
                   CNULBUF points the same address.) The second 2 bytes
                   points the #1 file's FCB address.       Refer to the
                   following section about FCB.

       7.2.1.19     NULBUF

               ADDRESS            AXFB67
               SIZE               2 bytes
               PURPOSE            Points to address of file #0 buffer
                       The buffer for file #0 , sometimes called
               NULBUF, is allocated just above the file data table,
               pointed by FILTAB.

                   AXFFFF   -----------------               I
                                                            I

                                 Bookkeeping                I
                                                            I

                                                        : <--- AXF380
                            ----------------- -
                                User's machine
                                 area
                                    or
                                Device code
                                                                <-- HIMEM

                                FCB                     l·
                                                        I
                                 C#1 -- #n)             I

                                                        : <-:-- Address is
                                                                     stored in FILTAB
                                Nul buffer
                                <Fi 1e #0 >             I
                                                        I

                                                        : <-- NULBUF
                            I
                            I

                            : FCB address               I
                                                        I

                                                    : <-- FILTAB
                                ( 2 Bytes)
                            ---------------
                              Used        : <-- MEMSIZ
                                String area

                            ---~-----------
                              Free        : <-- FRETOP
                                String area
                                                    I
                                                  • I

                            I
                            I                       : <-- STKTOP
                            : Stack area            I
                                                    I
                            I
                            I                       :<- Stack Pointer
                                                    I
                                                    I

                                Free area           I
                                                    I

                                                    : <-- STRENO
                            I
                            I

                            : Array data
                                                    : <-- ARYTAB

                                      - 96

                                              /
.I
 I

 : Simple        I
                 I

 l Variables     I
                 I
·,
 I               l <-- VARTAB.
 -----------------
 : CO fi 1es     I
                 I

                 l <-- BINTAB
,-----------------
l DO fi 1es      I
                 I

                 l <-- ASCTAB
                 I
                 I

     BA files    I
                 I

.I
                 l<-- TXTTAB
                 I
                 I
'
                 :<-- BOTTOM

tig 7.8 Pointers and ROM configuration

        7.2.2   Part II < VRAM Area For LCD)
                   ADDRESS
                   SIZE          640 by~es
                   PURPOSE       VRAM
                         This area is used for the VRAM of LCD (liquid
                 Quristal Display).     In this area, the data is stored
                 as the character code.   C ANSI character code.   Refer
                 to •APPENDIX A4• in PC-8201A Reference Manual.> The
                 LCD driver, installed just below the LCD panel, gets
                 this character code and displays it on the LCD. The
                 320 characters C 40 by 8) can be shown on the LCD
                 panel at a time.       So only second 320 bytes, from
                 AXFD00 to AXFE3F, are used for VRAM.    The first 320
                 bytes, from AXFBD0 to AXFCFF, are used only when TERM
                 mode is selected in TELCOM.   (You can find •PREv• at
                 the bottom of the screen in TERM mode. The ·PREV•
                 shows you the previous screen in TERM mode. Refer to
                 ·chapter 8 TELCOM• in PC-8201 User's Guide. The
          PREVIOUS• is the first TERM SUBCOMMANDS.>
                         The data in VRAM appears when LCD· driver is
                 turned on.    Refer to Chapter 9 about the control
                 sequence for LCD management.·

       7.2.3    Part III ( Bookkeeping Area For BIOS)

                ADDRESS

                        This area includes the data area for RS-232C
                driver, the buffers relevant to Key Board driver and
                working area for LCD driver. Refer to Chapter 9 - 15
                to know how to use the peripheral drivers and the data
                in this area.

       7.2.4       FQ Control Block)

               YJ the FILTAB points the lowest address of the
       file  con~ata area.     It doe~ NOT mean FCB. The FILTAB
       points tht of the starting address of the FCBs, FCB
       Offset, ifile is opened.

                   e~B and FCB

                   Dnory (in hexadecimal)
                   F: 6E F1 77 F2
                   Tht 2 bytes (AXF16E) points the starting address
                   o1 FCB of #0 file (NULL buffer). The second 2
                   b)'XF277) is the top address of the FCB for the
                   fi.    These starting addresses are called FCBOFF
                   CFset address).
              T~area for NUL and file #1 are allocated by the
      INITIALIZ~ine in ROM #0. The 2nd and more FCB area will
      be allocatthe BASIC language, MAXFILES command.    Refer
      to PC-820»rence manual.

      The FCB ca of 9 ~ytes parameter area and 256 bytes
      buffer ancept for NULBUF. NULBUF consists of only 256
      bytes bufna. The purpose and the size of the parameters
      ar• listew. Since this FCB can support the Floppy Disk
      file, you =ind some meaningless parameters for RAM files.
      Of cause, 1n use them for own your purpose if you wish.

      (1) FL.MOO

      Address:      FCBOFF+0
      Size:         1 byte

                    The file mode of the FCB.  If this byte is not
                 se~is FCB is not used in BASIC.   If you obey the
                 BA.rule, you have to set non zero value here when
                 yo~ that fi 1 e.
               1     INPUT on 1 y
               2     OUTPUT only
               8     APPEND only

        (2) FL.FCA
       ADDRESS:            FCSOFF + 1
       SIZE:               1 byte
                   The· first cluster allocated to file.    In   RAM   file
                   handling, this parameter has no meaning.

        C3) FL.LCA
       ADDRESS:           FCBOFF + 2
       SIZE:              1 byte
                  The last cluster accessed. For RAM file open, this
                  and next byte is used for the storage of the Directory
                  address of·that RAM file.

       <4> FL.LSA
       ADDRESS            FCBOFF + 3
       SIZE               1 byte
                  The last sector accessed. For RAM file open, this and
                  previous byte is used for the storage of the Directory
                  address of that RAM file.

       CS) FL.OSK
       ADDRESS:           FCBOFF + 4
       SIZE               1 byte
                  Disk* of the file or Device IO.     The table    listed
                  below is the Device IO table in PC-8201A.
                  Device name     IO number
                  LCD             ""XFF
                  C CRT           ""XFE )
                  CAS             ""XFD
                  COM             ""XFC
                  < WANO          ""XFB )
                  LPT             ""XFA
                  RAM             ""XF9
                  CRT and WANO is option I/O.

       C6> FL.SLB

       ADDRESS:            FCBOFF + 5
       SIZE:               1 byte
                   Size of last buffer read.
                                               -.
        (7) FL.BPS

       ADDRESS:           FCBOFF + 6
       SIZE:              1 byte
                  The position in buffer for both PRINT and INPUT with
                  the file        One of the most important parameter in
                  FCB.        *·
       (8) FL.FLG

       ADDRESS:           FCBOFF + 7
       SIZE
                  This byte and next byte are used for the offset
                  address of the RAM file which is opened now. For
                  example, in the •INPUT• mode file, this offset address
                  is advanced by 256 bytes when the block-read command
                  reads 256 bytes from the file into the buffer in FCB.
                  So in reading or writing to the RAM file (00 file),
                  the starting address and this offset show the next
                  byte should be read or written.

       (9) FL.OPS

       ADDRESS:           FCBOFF + 8
       SIZE:              1 byte
                  High byte of the offset address for RAM   file.   Refer
                  to FL.FLG.

       C10>FL.BUF
       ADDRESS:           FCBOFF + 9
       S~ZE:               256 bytes
                  Buffer for the file.

```
