# Chapter 5: Understanding The Ram File Concept

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 60-75). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                      CHAPTERS

S.1 ·suMMARY
        Usually, the RAM files are controlled by the ROM #0,
settled  in ROM socket #0 at the shipment. There are many
rules to·use the RAM file. Unless you replace this ROM #0
with your own ROM, ROM #0 checks the RAM file organization and
pointers in the bookkeeping area sometimes, even if you don't
use BASIC, TEXT or TELCOM.      (For instance, at Power on and
·sank• command in menu.) If you ignore the standard rules for
RAM file handling, ROM #0 will flush not only the files which
were made by your own application program ,but also the files
which were made by BASIC and TEXT in ROM #0.  In order to save
your files from such kinds of accidents, please read following
chapters about .the RAM file handling and understand the
standard rules in PC-8201A.
        The two situations were considered for this section.
Someone wants to handle RAM files with the machine language
subroutine in the BASIC m·ode.  In this case, opening the file
will be done by a BASIC command, OPEN. And the file will be
closed and deleted by CLOSE and KILL command in BASIC. So the
machine   language   subroutine    will make up the lacking
facilities in BASIC commands. For instance, Insert a data at
the middle of the opened file.     In this case, you had better
care about a few pointers only.         You needn't know the
directory structure.
         But another person might try to make a his (or her)
original application program without using BASIC. He (or She)
might open a file, save data, append data, insert data, delete
data and erase a file with his ( or her) own application.   In
this case, the name of the data file should be registered by
that application program. So that programmer need to.know the
Directory configuration and many parts of the         pointers
playing.

                This section is written for supporting both of them.
       The programmer who wants to make a original application
       without BASIC, needs much more information than a user who
       uses BASIC.     But too much data. sometimes confuses a novice
       programmer who wants to make a subroutine for BASIC main
       program.    After long consideration, I decided to obey the
       famous common saying, •The greater serves for the lesser·.
       Therefore I serve everything what I know. Please find what
       you want to know in.the following section.
               In these chapters, I tried to describe each section
       independently.    You,   ho~ever, might meet unknown words
       sometimes. Please refer to another section or another chapter
       at that time.     I hope you will make many good application
       programs with this document.

       5.2     WHAT IS RAM FILE?
                In PC-8201A, you can have many files in RAM area at a
       time ,like files on the floppy disk. The files are classified
       into three suffixes:.OO(cument) .; ,BA(sic) and     .CO(mmand).
       Hereafter .OO(cument) file is abbreviated 00 file, BA(sic)
       file is BA file, and .CO(mmand) file is CO file.            And
       sometimes the word •ASCII file· is used in place of ·oo file·.

       5.2.1    DO File <ASCII File)

               The 00 file is created by BASIC, TEXT and TELCOM.  Of
       course, you can load. a 00 file from I/O in menu mode.     In
       BASIC, the ·oPEN• command handles the 00 file.       The OPEN
       command with.FOR OUTPUT• option makes a new 00 file. OPEN
       with ·FOR APPEND• opens the 00 file ·in order to add the data
       after the last data that has already been entered. When there
       is no file whose name is same as the specified in the ·oPEN•
       with •FOR APPEND•, that OPEN command works as the OPEN with
       FOR OUTPUT. The OPEN with FOR INPUT opens the specified file
                The •sAvE• command with •,A• option or •sAvE• command
       with the file descriptor followed the suffix, ·.oo· stores a
       BASIC· program as a 00 file.    This 00 file is~ sometimes,
       called as ASCII (saved program) file.    ( Note: A SAVE command
       without ·,A• option creates a BA file.) In this case, the
       BASIC program in the BASIC files area is saved into the 00
       files area in the ASCII format. So you can read it in TEXT
       mode.c•sAvE• command without •,A• or without the suffix, •.oo•
       only registers the file name with the suffix,        ·.BA• and
       changes some pointers. It does not make a new file. Please
       refer to next section about BA files.      And I think almost
       BASIC interpreter have this •ASCII save function· for the disk
       files. Refer to BASIC reference manual if you have another
       disk top personal computer's manual.   )

                                              I        A
                                              I
                                                                 Upper
                                              I
                        ''                    I
                                              I   •
                         I 00 files           I   •

                                                                 Lower
                         non-registered                V
                         ·BASIC program
                              or
                         9aved BASIC
                          program
                           •A.BA•

                       ----------------- <-- TXTTAB

               Type BASIC program in BASIC mode.
               Do •sAvE• command.
                       SAVE .TEsr· ,A
                          or   •
                       SAVE .TEST.oo·

                                                      ....
                                                             :Up,:,er
                         DO file!!

                       ------------       I
                                          I

                         TiST.00          : <-- New 00 f i 1e
                                                                  is inserted
                                                             :Lower
                         non-registered                      V
                          BASIC program
                            or
                         saved BASIC
                          program
                          'A.BA•
                       ----------------- <-- TXTTAB

                       Fig 5.1 SAVE with ".DO" or·',A" option

       is the ·scRAP• file used in TEXT, and another is the •EDIT•
       file used in BASIC.     The screen oriented text editor in
       PC-8201, named TEXT, has wonderful functions called ·ccp·.
       The CCP functions mean SELECT, CUT, COPY and PASTE.        (The
       detail   information about these functions are explained in the
       PC-8201A user's guide.) The CUT command or COPY command after
       SELECT command makes a temporary DO file. This DO files can
       be invoked by PASTE key many times. Though this file cannot
       be found in menu level, this file wi 11 be kept unti 1 n'ext
       SELECT-COPY or SELECT-CUT will be executed and is not broken
       by the PASTE key.
               And more good feature is in this DO file.   Since the
       contents of this DO file is treated as the data from keyboard,
       this file can be used in BASIC. After saving a part of a file
       in SCRAP with SELECT-COPY function, return to Menu, and invoke
       BASIC. The contents of this •scRAP• file will appear by
       .PAST• key. Cin the PC-8201A user's guide, this temporary 00
       file is called •PASTE buffer·.)

               Another one, •EDIT• file, is created by EDIT command
       in BASIC.    The EDIT command in BASIC falls into the TEXT
       editor with the BASIC file. At that time, the BASIC program
       is translated in to ASCII format file, .EDIT•, and original
       BASIC file is killed. This file is erased when the EDIT mode
       is finished by double ESC or F.S, converted into BASIC file
       and saved. So no one can find this file at the menu level.

                The DO file usually consist of the •ASCII• characters.
       And you cannot use the 3 Control Characters, NULL (0),
       sometimes abbreviated as      •Az·.>
                                          The Control-Z is used as the
       End of DO file. So if you store it as a one of the data in
       the middle of the DO file, the standard programs, BASIC, TEXT
       and TELCOM ,will regard that Control-Z as the End of that 00
       file.    The data after that Control-Z will be lost. Otherwise
       the NULL is used to fill    the hole dug by MAKHOL.       After
       copying or inserting the data in to the hole, some routines
       tries to find the end of the data by finding the NULL. T~en a
       routine squeezes the NULLs. Therefore the NULL in the middle
       of the DO file might cause the serious problems.     similarly,
       the Back Space has special meaning in DO file. Please don't
       use there three Control characters in the DO file.      BASIC's
       PRINT* command cannot save these control characters in to the
       DO file.
               NOTE:   MAKHOL and    MASOEL   are   name   of   the   routine

                                       •   4

                stored in ROM i0. Refer to 'Useful Routines for RAM
                file han~ling in ROM i0'.

                ex.    When DO file is made. in PC-8201A
               2.     SAVE command with ',A• creates a DO file in BASIC.
               3.     UPLOAD and DOWN LOAD sends or receives a     DO   file
                      through RS-232C in TELCOM.
               4.     DO file can be saved or loaded from   CASSETTE     and
                      RS-232C in MENU.
               5.     OPEN with 'FOR OUTPUT' registers the file name and
                      insert only End of file character as the 00 file
                      in BASIC.

r

           5.2.2   BA File
                   The BA file is made in BASIC mode or made by LOAD
           function in Menu mode·.      There are two types of BA file in
           PC-8201A. One-is a ·saved· BASIQ program, and another is
           ·non-registered·      BASIC     program.      Sometimes     the
           ·non-registered· is called the ·un-saved· BASIC program,
           because ·un-saved· will make sense more than ·non-registered·
           for a person who knows BASIC very well.     The BASIC program
           typed just after selecting BASIC mode in menu level, is called
           ·non-registered· "BASIC file, since the name of the program has
           not been registered in the directory area yet. But after
           executing ·sAvE· command in BASIC mode, that ·non-registered·
           BASIC program becomes a ·saved· BASIC program. (In the point
           of view, "SAVE• command in BASIC, the word ·un-saved". and
           ·saved" are suitable,     I think.) The ·sAVE" command in BASIC
           ·register·s the file name and the starting address in the
           directory area. Then the file name can be seen on the display
           screen of the MENU or by •Files· command in the BASIC mode.
                   Meanwhile the ·LoAo• function in MENU can create a
           "saved• BA file directly.      The "LOAD• function can read a
           BASIC program from the cassette, and can ·register" its name
           in the directory area.      So after "LOAO"ing in Menu, the
                   ex.    The flow diagram of making BASIC program
                   1.    Select BASIC in menu level
                   2.    Type BASIC program ·
                             10 PRINT •HELLO•
                             20 ENO
                   3.    In this point, this BASIC      program   is   called
                         ·non-registered· program.

                   4.    If you return to menu level now, this program is
                         reserved.   You cannot find this program in Menu
                         mode in this time. Next time you select BASIC in
                         menu mode, LIST command shows you this program
                         agaiM. This program will be kept unless you do
                         NEW command, LOAD ASCI.I saved file in RAM or LOAD.
                   5.    Do "SAVE• command.
                             SAVE ·rEsr·
                                or

                        SAVE .TEST.BA •.

                        < SAVE ·TEST.oo·
                            or
                          SAVE "TEST.,A has another meaning.)

                    "registered· program. This program is called "BA"
                    non-registered program area.

               Just after doing SAVE, you can list the program with
       LIST command.    So you might be confused. But don't worry
       about it.    The following illustration will help you to
       understand not only why LIST command just after SAVE command,
       can list the "saved" program, but also why PC-8201A can have
       many BASIC programs at a time, I hope.

                1.   You are in MENU mode

                        -----------------
                         I
                         I

                         l 00   files
                        ----------------- "'XUUUU
                         I                     I
                         I                     I

                        : saved BA file :
                                                   <- BOTTOM
                                                      C"'XF980)

                        Fig 5.2
               2.    Select BASIC in MENU and TYPE a BASIC program.
                     LIST shows you the non-registered BASIC program.

                        -----------------
                         : 00 files

                        ---------------I AXYYYY
                                               I

                          non-reg i!,tered:
                          BASIC program l
                        ----------------- <-- ("XUUUU)
                                                TXTTAB
                             saved BA
                               file

                        Fig S.3

           3.   Return to menu by MENU command

                        -----------------
                             00 files
                        ----------------- "'XYYYY
                            non-registered:
                            BASIC program:
                        ----------------- "'XUUUU
                        I                   I
                        I                   I

                        : Saved BA file:
                        Fig 5.4

           4.   Select BASIC    again.     LIST  command   lists   the
                non-registered BASIC program which you typed in (2).

                       --------- ------
                                 -------
                        I
                        I

                        : DO files
                       ---~-------------
                       I               I
                                         AXYYYY
                       .1                   I

                            non-registered:
                             program
                                                   C"XUUUU>
                        : Saved BA files:
                       Fig S.S

                                    69 :-

   S. · SAVE •TEST•. TXTTAB sti 11 points the pragram typed   in   <2>.
        So the same list appears on the screen by LIST •

                                               ..
                                     ""XFFFF
               -----------------
                 DO files
               ----------------- ""XYYYY
                  TEST.BA

                                    (AXUUUU)
                 Saved BA
                  files

               ----------------- AX8000
               _Fig 5.6

   6.   MENU and s·elect BASIC again or-· execute NEW commandin BASIC.
        Now, LIST command lists nothing.        Type new BASIC program,
        again. LIST lists the pr-ogr-am that you typed just now •

                  I
                • I                           ... XFFFF

                -----------------
                 : 00 files

                ----------------- . . xzzzz
                      non-r-eg i ster-ed: .
                       pr-ogr-am ar-ea:

                                     C... XYYYY)
                 l TEST.BA

                ----------------- . . xuuuu
                                         I
                                         I

                 : Saved BA files:
                Fig 5.7

   7.                                           •
        LOAD •TEST.BA• in this case, or select •TEST.BA•   directly   in
        MENU. LIST shows you the program, TEST.BA.

               =================

                : 00 files

               ----------------- "'XZZZZ
                    non-registered:
                      program

               ---------------
               I
                               "'XYYYY
                I

                : TEST.BA
                                         C"'XUUUU)
               : saved BA files:
               Figs.a

                                                                         I

               BASIC interpreter regardes   that the current TXTTAB
       indicates the current BA file.        So LIST command lists the
       program which was saved just now     because of specified by
       TXTTAB.

                The BA file can be created in BASIC mode and can be
       LOADed in BASIC mode and MENU mode. Refer to the PC-8201A
       user's guide and reference manual. And BA file is executed
       with BASIC interpreter at the menu level by selecting the BA
       file directly, as you know.  In other words, when you select
       the BA file name appeared on the MENU, PC-8201A invokes the
       BASIC interpreter, LOAD that BA file and RUN it automatically.

       S.2.3   CO File
               The CO file is made in BASIC with BSAVE command or can
       be loaded and saved from the cassette tape in MENU mode. The
       CO file is, sometimes, called ·machine language· file.  It can
       be executed directly like a command in menu level,when
       ·Execute· address was specified in BSAVE and the start address
       is higher than the second parameter in the latest ·cLEAR•
       command in BASIC. The default value is AXF380. So no CO file
       can be executed directly from the menu level without CLEAR
       command. The CO files are located above the DO files.

                                            .
       5.2.4   The Order Of The Files In RAM

                       ----------------- ~XFFFF

                       =================
                          CO file9

                          00 files

                       ------------~----I
                                        I

                         non-registered:
                         BASIC program :

                       : BA file9
                       ----------------<-BOTTOM
                       Fig 5.9 the order of the files in RAM

```
