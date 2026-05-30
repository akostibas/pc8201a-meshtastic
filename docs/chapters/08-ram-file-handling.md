# Chapter 8: Ram File Handling

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 102-153). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                      CHAPTER 8

         In this chapter, the technic to manage the RAM file is
described. The main purpose is to create or delete a RAM file
for the applications stored RAM area or 2nd ROM. As described
before, if there is some violation in standard rules of RAM
file handling, the file you made (or sometimes all files in
the RAM) will be lost by the standard manipulation. (The
·standard manipulation· means the file handling or operation
with Menu, BASIC, TEXT or TELCOM in the ROM #0.)
        There are many useful     routines to make up these
violation in standard rules in ROM #0. But using ROM #0 from
ROM #1 will reduce the speed of the application. If you want
to handle the RAM file without ROM #0, please make sure 'What
                                                 1            1
you should do• in this chapter. And refer to       Bookkeeping
and ·oirectory structure·.

       NOTE: The another technical manual for PC-8201A has
       been available already.     There are many information
       about the RAM file handling routines in ROM #0 in it.
       For example,   •oPEN RAM FILES",    'KILL ASCII FILE",
                                           1
       'READ A CHARACTER FROM A RAM FILE     and 'CLOSE ALL
       FILES•.    If   you   will use your application or
       subroutine with ROM #0, you had better refer to that
       manual.

        8.1    WHAT SHOULD WE DO IN RAM FILE HANDLING
                In the ·Directory structure· and ·Bookkeeping area",
        many rules about the RAM file handling are described.   I do
        explain again about the important r~les.

        1.    Make sure that there is enough free area
                  When a new file is opened, or new data is appended
           and inserted, please investigate whether there is enough
           free bytes in the current RAM bank.    Especially, the free
           area requested in OPEN is sometimes ignored. At least, one
           byte is necessary for OPEN a DO file. 3 bytes for CO file.
           Refer to 'What is RAM file· and following sections.
                  You can find where the free space is in the figure in
           ·Bookkeeping are·.     The difference between the pointer
           •sTREND• and the value in the stack pointer indicates the
           free size. But don't forget that some area will be used for
           the stack operation in that free area.    For instance, the
           make-room routine used in BASIC and TEXT recognizes that the
          current free space is less 120 bytes than that difference.
           In other words, 120 bytes is always maintained for the 60
          stack area when new data is stored. Refer to ·MAKHOL• 1n
         . ·useful Routine For RAM File Handling In ROM #0·.

   2. ·Register file name correctly
                 The contents of the directory is       described  in
          ·oirectory construction·.    No one forgets to register the
          file name in it.      But someone forgets to set up the
          directory flag byte and the starting address of the file.
          If you don't set the directory flag, the file might be
          deleted by Menu or another operation. If you write a bad
          starting address in the address field, the link of the
          directory and the files will be lost. By the result, you
          cannot select a file properly in the Menu mode or PC-8201A
          is hung up. Any way, the directory flag and address field
          have very important meaning. Please refer to the •Directory
          construction· and following sections.

   3.   Maintain the order of the files

                   In order to maintain the order of the file, we have to
         do    a    special trick in setting the starting address of the

          new file. For a new DO file~ we-have to set ASCTAB -1 as
          the starting address of that new file at the directory area.
          And for a new BA file, you have to register the ASCTAB -1 in
          the ·non-registered· file's directory area and insert double
          NULL code there. That new BA file will be created at ASCTAB
          -1 and will have the starting address, ASCTAB - 2.        In
          making both of a new DO file and a new BA file, LNKFIL
          should be executed before end of its process •. Refer to
          ·useful Routines for RAM file handling in ROM 10• to
          understand what is LNKFIL.

   4.   Make and shrink a hole safely

                The calculation of the free space is very important.
          And you have to maintain the stack area when you make a your
          room. And one more important thing is the management of the
          pointers.   Tne reason why many programs, Menu, BASIC, TEXT
          and so on, can use the same RAM area safely is that they
          adjust the pointers for RAM every time when they change the
          RAM configuration.   For example~ BASIC deletes ~ BASIC
          program file,   he changes many pointers, STRENO, ARYTAB,
          VARTAB, BINTAB and ASCTAB. And he turns off the directory
          flag in order to indicate that the slot in the directory is
          not used now.    Refer to MAKNOL and MASOEL in ·useful·
          Routines for RAM file handling in ROM 10.·

   S.   Insert the promissory byte in the file
                When you open a DO file, you have to enter one byte
          data at least. The data is Control-Z C~X1A), it shows the
          end of file in RAM.    Some~imes this promissory byte is
          forgotten.   So the routine which makes up the starting
          address in the directory area is confused.    Simultaneously
          BASIC needs 2 NULL bytes at the end of the file.   Otherwise
          CO file requires the 6 bytes file header at the top of the
          file. Refer to ·what is RAM file·.

   6.   Make up the starting address in the directory
               When you changes the RAM configuration, you have to
         care not only the pointers but also the starting address ~n
         the directory area.  It is easy to image that the starting
         address in the address field of all the 00 files should be

                                               .
          changed when you make a new BASIC file.    (BASIC file 1s
          created under the lowest DO file.      Refer to "Memory Map
          about RAM files" ) And when some data are inserted in
          "A.DO", a DO file, the starting address of the DO file and
          CO file located above "A.DO" should be changed.   Refer to
          "LNKFIL" in the "Useful Routines For RAM file Handfing in
          ROM #0". You can get the know-how to make up- the starting
          address in the directory area.                     ·

   7.   Bad data in 00 file
               You cannot store the data which include the character
         whose code is 0, Axe and AX1A. The ·0· is used "NULL" to
         indicate the hole which is not used. Or double NULL means
         the end of the BA file. The ·Axe· is used "Back space".
         The "A1A" is regarded as the end of the 00 file,    as you
         know. Refer to "DO file".

        8.2    HOU TO MAKE NEU FILE
       8.2.1    How To Register The New File Name

               At the first, the new file name should be registered
       in the user's directory area when you create a new file. The
       user's·directory area is started from USRDIR.   And the next
       byte of the user's directory area, the end of the directory
       area, has AXFF ( 255 in decimal).       This byte is called
       •Directory Stopper·.    The used slot starts with the number
       larger than AX80 as the directory flag. Therefore it is easy
       to find the free slot.       Refer to the sample program shown
       later.
               You had better compare the new file name with the file
       name which is existed already. Two files which have same file
       name sometimes occur a serious problem. So during searching
       the free slot, the existed file name should.be checked. And
       if there is a same file name, you had better delete it before
       making new file or abandon to make a new file. ·
               If you succeed to find a free slot in the user's
       directory area, you have to register the directory flag, the
       address of the file and the file name.  In this time, you have
       already known the file name. And you can set the directory
       flag now.   (You can get the detail    information about the
       Directory flag in the section, DIRECTORY STRUCTURE.> The
       address of the file will be fixed later. Because the way to
       get the address for the new file is depend on the file type,
       00 file, BA file and CO file. Any way, don't forget to set up
       the directory flag when you register the new file.name.
       Otherwise someone, Menu, BASIC or TEXT and so on~ will destroy
       your new file without any caution.

       Refer to •Directory construction·.

       8.2.2    How To Make DO File

               If you have already registered the file name and
       directory flag at the slot in the directory area, now the only
       one information lacking in the new directory area 1s the
       address of the new DO file.        If you didn't read "Hou to
       Register The New File Name" and you have not set the file name

F'
                                             ........
             and directory   flag yet, please read that section and make up
             them first.
                      Usually the new DO file is created just above the
            ASCTAB, the lowest address of the-:existed DO files. Refer to
            the figure in the ·what is RAM file· to make sure your image.
            If you go with the standard rule which Menu, BASIC and others
            in ROM #0 is used, you can copy the contents of the ASCTAB-1
            as    the  starting address of the new files.        Then the
            registration of the new DO file is done completely.        The
            reason why we have to use ASCTAB-1 instead of ASCTAB is to
            maintain the order of the files.     The LNKFIL, to make up
            starting address in directory area, searches the file name
            from top to end and links the starting address of each file.
            For LNKFIL searches the directory from younger address to
            older address and older file has younger address, the order of
            the DO file will be swapped if you use ASCTAB instead of
            ASCTAB-1. Refer to •LNKFIL• in •useful Routine for RAM file
                    But you have to do two more steps for that new DO
            file.   One is to insert the end of file flag at the bottom of
            that new DO file. Another one is, as you know, to make up the
            starting address of other files in the directory area.
                    There is no DO file whose size is zero, because the
            final character of the DO fiie should be AZ (AX1A, 26 in
            Decimal). In other words, the AZ indicates the End of File of
            the DO file. So the DO file will spend one byte at least.  If
            you only want to open the new DO file without any data, you
            have to insert a AZ at the starting address. If you want to
            save some data now, you have to append a AZ at the end of the
            data.   Never forget to insert a AZ at the end of the file.
            Otherwise, next RAM file operation might destroy the all RAM
            files.
                     In order to make a room for the new file, a convenient
            routine is in the ROM #0. Its name is MAKHOL, MAKe HOLe.
            This routine makes a hole from the specified point and whose
            size can be decided by the contents in CBCJ register. Refer
            to ·MAKHOL• in ·useful Routine For RAM file handling in ROM
            #0·.   The concept of the MAKHOL is shown briefly in that
            section.

                    If there is no free area in RAM, and you cannot insert
            a AZ, you cannot continue to enter data to the file. And, of
            course, you have to clear the directory flag for next user.
                    To make up the starting address in the directory area,
            the routine named LNKFIL is ready in ROM #0. The flow diagram

                                        ........
        of that routine is shown in the ·useful Routine For RAM file
        handling in ROM #0·. You can get information to make your own
        LNKFIL routine in it, too.
               If you succeed to insert 6 AZ and to make up the
       etarting address field in the directory, the opening a new 00
       file ha~ been done successfully. You can save the data to the
       new file with using MAKHOL and LNKFIL. Refer to another
       section to know how to Append, Insert, and Delete data.   The
       sample program in the following section will show you how to
       make a new file and save data.
               Cf.    How to make a new DO file
                1.   Find a free slot in the user's directory.  If you
                     cannot find a free slot in the directory area, you
                     have to give up to make a new DO file. Or if you
                     find the same name in the directory, delete that
                     file or abandon to continue.
               2.    Register the file name and directory· flag        at     the
                     free slot.
               3.    Get the ASCTAB-1 and·save it in the address            field
                     of the elot.
               4.    Try to make a one byte hole at the      address        where
                     ASCTAB pointed.
               5.    If you fail to make a hole, clear       the    directory
                     flag which you registered at (2).
               6.    If you succeed to make a hole, insert a       AZ at that
                     point.
               7.    Make up the pointers and starting address         in    the
                     directory area.
               8.    Tha~'s all. The new   00   file   has   been    created
                     without fail.

               NOTE: If you make a hole by your own routine, please
               make sure that the your own routine refines the
               pointers. Refer to the explanation about the MAKHOL.
               And refer to ·LNKFIL• to know how to make up the
               address in Directory.

              8.2.3   How To Make A BA File

                      There is few difference between how to make DO file
              and How to make BASIC file. There is no difference in the
              registration of the file name and the directory flag.      The
              first· difference is that you have to end the BASIC file with
              double NULLs (0) instead of AZ in DO files.      In order to
              understand what double NULLs means, you·have to familiar with
              the function of the LINK POINTER in the Microsoft BASIC.   The
              inner specification of the Microsoft BASIC file 1s too
              difficult to described here briefly. You can get some good
              texts to learn the information about the BASIC programs and
              their data constructions at the book store or the computer
              shop.   But the ba$ic concept about RAM file handling is
              exactly same as DO file.  ( Register the file name and another
              information at the directory and make a room for the program.)
                      The second difference is the new BA file is created
              just above the BA files which has already stored. In other
              words, the new BA file is inserted just below the lowest 00
              file. Refer to the section, •wHAT IS RAM FILE?•,
                      I believe that the person who wants to handle the BA
              files,  is an expert about the BASIC program and BASIC
              interpreter. If you are a novice class programmer about the
              BASIC interpreter, you had better not try to handle the BA
              file yourself. Please use BASIC mode in ROM #0.

                      ex.    How to create a new BA file in PC-8201A
                      1.    Search a free slot in the user's directory area.
                            If you find a same name in the directory area,
                            delete the file or abandon to continue.
                      2.    Set.up the directory flag and copy the     file   name··
                            into the directory,
                      3.    Copy ASCTAB -1 into NULDIR, non-register program's
                            directory area.    And make 2 bytes hole and store
                            the double NULL for non-register program.
                      4.    Make a hole as large as possible at the ASCTAB-1.

         ..           5.    The size of that hole is too small for the new BA
                            file, clear that directory flag written in (2).

                6.   If you succeed to make a big hole for your BA
                     file, copy the BASIC program into the hole. Don't
                     forget to insert the double NULLs at the end of
                     the program •
              . 7.   Register the starting address at the starting
                     addres~ area in the directory area. Usually-, the
                     address that is one byte less than the starting
                     address of the non-registered program is used.
                8.   Squeeze the hole, when you made a too large hole.
                9.   Adjust the pointers, ASCTAB, SINTAB,    VARTAB,
                     ARYTAB and STREND. Make up the starting address
                     of other files in the directory area.   All DO
                     files' and CO files' starting address in the
                     directory field should be changed.    Refer to
                     LNKFIL.
              10.    End

       8.2.4   How To Make A CO File

                The CO file is the another type of the file which you
       want to make _yourself beside the DO file. ·The difference
       between DO file and CO file is the heading instruction of the
       file. · The CO file needs the heading data instead of the End
       of File character, AZ. So you have to make sure that there
       are more than 6 bytes besides the size of your machine
       language program in the free area. And if there is no enough
       free area, you cannot continue to make a new CO file.    If you
       have already set up the directory flag and file name, clear
       them soon. Don't leave the illegal flag and file name in the
       directory.

               Heading of CO file
                         START ADDRESS                 2 bytes

                         LENGTH                        2 bytes

                         EXECUTION ADDRESS             2 bytes

               So the file length of CO file can be calculated by
       LENGTH + 6.     In making CO file, don't forget to renew the
       pointers, VARTAB ,ARYTAB and STREND.
               The CO file is usually made just under the address
       pointed by VARTAB. So the starting address of the other files
       need not be changed after saving new CO file.  But I recommend
       to do LNKFIL after ~aving new CO file for safety.

               ex.    BSAVE •MAC.,50000,10,50000 in BASIC mode
               Dump the data in CO file is;

                     AXC350        (50000) Starting address
                     AX000A        (10)       Length
                     AXC350        (50000) Execution address

                Cf.    The flow of making a new CO file

                1.    Search the free slot in the directory area. If
                      there is the same Tile name in the directory,
                      delete that file or abandon to continue.
               2.     Check the free area. Estimate the free size       is
                      greater than your CO file's length+ 6 bytes.
               3.     If there is no room, stop.making a new CO file.
               4.     Make a hole just under address pointed by VARTAB
                      and store the data (or machine language program).
                      Make sure that all pointers are proper.   In this
                      time,  if you use MAKHOL to make a room, you have
                      to adjust the pointer, BINTAB.     Because MAKHOL
                      changes BINTAB always.
               S.     Register the file name; directory flag   and   start
                      address at the directory.
               6.     Adjust VARTAB, ARYTAB and STRENO.   Make up the
                      starting   address of a 11 other files in the
                      directory for safety.     If you use LNKFIL for-
                      adjustment   of   the   a 11  start addresses in
                      directory, you have to care about the BINTAB as
                      you do in MAKHOL.
               7 • . That ' s a 1 1 •

       8.3     HOW TO DELETE A FILE
                You can guess how to delete a file from the RAM file
       •system in PC-8021 easily. The things that you have to do are
        to clear the directory flag and to remove the data of the
        file.
               To delete a directory entry, you only turn off the
       directory flag.    If the. directory flag is less than AX80,
       other programs regardes that slot is not used now.
               And when you squeeze the body of the file, you have to
       check the pointers and the start address of other files in the
       directory. When you are using the subroutines in ROM #0,
       these pointers are adjusted automatically. But if you do it
       by your own routine, you have to care about the pointers. You
       can find the good .clues in 'How to make new file", and
       'MAKHOL' in 'Useful Routines for RAM file handling in ROM #0".
               Whether you treat the pointers by your own routine or
       utilize the MASOEL in ROM #0, you have to make up the starting
       addresses of the another files. The LNKFIL will do it well.·
       Refer to the following section to know the ENTRY information
       about the LNKFIL. That section will give you a clue what
       LNKFIL should do when you will make a LNKFIL by yourself.

       8.3.1    How To Delete A 00 File

               At the first, search the file name which you want to
       delete in the file.      If you don't remember the directory
       construction, please refer     to   the   chapter   'DIRECTORY
       CONSTRUCTION", and make sure it. When you find the file name
       in the directory, check the directory flag of the file.     The
       file which is opened in BASIC, cannot be deleted.     If you do
       it by force, the RAM file system might be crushed or the
       system might be hung up.
                 Cf. The flow of d~leting a DO file (Calling   Machine
                 language program by USR function in BASIC.)
                 1.   Search the file name in the directory

                2.   Check the directory flag and if the file is opened
                     by BASIC, you cannot delete it.
                3.   Get the starting address of the file
                4.   Search   AZ <End of File)
                5.   Count the size of the file
                6.   Remove the data of the file and shrink.  The ROM
                     routine MASOEL will do it automatically. MASOEL
                     changes the pointers, BINTAB, VARTAB, ARYTAB and
                     STRENO automatically.
                7.   Refine the starting         address     of     other    files.
                     LNKFIL will help you.
                8.   Clear the directory flag of       the        file   which   you
                     deleted.
                9.   That~s all

       8.3.2   How To Delete A BA File

               When you are not in BASIC program, there is few
       differences between killing 00 file and killing BA file.   The
       differences are in searching the end of file.  In 00 file,  AZ
       (26 in decimal) indicates the End of file. But in BA file,
       there is no such a good terminater. The only one way to get
       the end of the BA file is tracing the ·1ink pointer· from the
       beginning of the BA file to end.  If you can utilize the ROM
       #0, you may use the useful routines, CHEAO.          The CHEAO
       searches the end of the BA file.  And MASDEL removes the data
       and refines the pointers. You have to care about the TXTTAB
       position.  If you delete a BA file which is located under the
       file pointed by TXTTAB, you have to adjust the TXTTAB. This
       case is occurred when TXTTAB points the second BA file and you
       delete the first BA fil&. Finally, you have to do make up the
       all starting address Clink pointers) in directory area.
       LNKFIL will do it.
               NOTE: MASOEL does not change the ASCTAB. When a BA
               file is ·killed, ASCTAB should be changed. So after

                calling MASOEL, you have to adjust the ASCTAB.  Refer
                to the sample program in the following section. Also
                ·How to make a BA file· will give you a clue.
                Another difference is that there is a limitation in
       deleting a BA file when you are executing that BASIC program.
       The following caution is ~vailable when you make a machine
       language subroutine for a program written in BASIC.     If you
       won't make a machine language subroutine which handles the
       BASIC file, you may skip to read this caution.

               NOTE:   You cannot kill the BA file when you are in
               it.   In other words, when you are running a machine
               language subroutine with a BASIC program, you may not
               delete that BASIC program in the subroutine.      I'm
               afraid that this explanation will not make sense for
               you. So I will show you the short sample.

                       In the BASIC mode, you can know ~here you are
               in by •FILES• command. The file name with •*• is the
               current file which you are treating. You don't kill
               it.

               1.   Select BASIC mode in the menu
               2.   Type a BASIC program.
                        10 PRINT •HELLO• .
               3.   Save it.
                        SAVE .TEsr·

               4.   Load it again.
                        LOAD .TEsr·

               5.   Try to kill it
                        KILL •TEST.BA• (Return>
                        ?FC Error
                        Ok
               6.   This result show you what I want to say.   SASIC's
                    KILL command checks the current TXTTAB and avoid
                    to kill himself. Your machine language routine
                    should do same check before killing a BASIC file.

                        NOTE: The comparison between TXTTAB and the
                starting address of the BA file is available only when
                you are executing the BASIC program or executing the
                machine language subroutjne in BASIC mode.       It is
                meaningless to care about- the TXTTAB and starting
                address when you are not in BASIC mode,

               Refer to ·what is RAM file· and ·aookkeeping area·              to
       understand the position of the BA files and TXTTAB.

               Cf.    The flow of the deleting the BA file

               1.    Search the file name in the directory
               2.    Check the directory flag and if the file is not SA
                     file, of course, you cannot delete it.
               3.    Get the starting        address   of   the   file   in   the
                     directory
               4.    Compare that starting address to TXTTAB. If they
                     are identical, you cannot delete it. If not, you
                     have to remember which is larger, the starting
                     address or TXTTAB.
               5.    Search End of the File
                     CHEAO will help you to find the end of file.
                     Refer to ·useful Routines for RAM file Handling in
                     ROM #0•.

               6.    Count the size of the file
               7.    Remove the data of the file and shrink.
                     The ROM routine MASDEL will do it automatically.
                     MASDEL   changes the pointers, BINTAB, VARTAB,
                     ARYTAB and STRENO. Refer to •what is RAM file•
                     and ·eookkeeping area·.     And MASDEL returns the
                     negative length in BC register~ You can use it to
                     adjust the ASCTAB.
               8.    Adjust ASCTAB
               9.    Refine the starting address of other files.
                     LNKFIL will help you. Refer to "Useful Routine
                     For RAM file handling in ROM #0".

   :Restore the result of the comparison between the
  :starting address of the file and TXTTAB.        If
· ;TXTTAB is greater than the starting addres, adjust
  .: it.
                                 .   ..
  Clear the directory flag of             the   file   which   you
 !deleted.
 : That' e a 11

 To DELETE A CO File

· don't have to care about where you are in now like
   file or killing DO file. You may delete any CO
nt to delete, even if you are executing that co
, CO f i 1e· is 1oaded at the specified area when the
6ked in menu mode or in BASIC mode.     So the ·co·
delete the ·co· file itself, and can save the free

                            '!

                                             ..
                ex.    Delete a CO file it9elf

                1.    Load a CO file in BASIC or MENU.

                                 ----------------- AXFFFF
                                 -----------------
                                  I
                                  I

                                  : machine prog           I
                                                           I

                                                           :<--   BLOAO
                                                                   or

                                                                  Select
                                 =================
                                 : CO2 file
                                                                   in
                                 -----·------------               MENU
                                      CO fi 1e         :-:
                         BINTAB->:                     I
                                                       I

                                                       I
                                                       I
                                      00 file9         I
                                                       I

                                 --------------
                                      BA file9        .,
                                                       I

                         AX8000 ---------~-----
                                 Fig 8.1

                                                 ,-
                           /
:hine prog

     ---------------- AXFFFF
     =================

       machine prog
                              <-- PC

                              <- STRENO

     =================
        CO2 file       <- "XAAAA

       CO file
                              <- BINTAB

        00 files

                          I
                         ~I

        BA files
:000 -----------------

     Fig 8.2

               119
r
~··

         3.   Delete the CO·file and move the data between      the   STRENO   and
              "XAAAA.

                              ----------------- AXFFFF
                              =================
                              I                I
                              I                I
                              : machine prog   :<- PC

                                                    <- STRENO

                              -----------------
                              I
                              I

                              : CO2 file
                                                    <- BINTAB
                                               I.
                                               I

                                  00 files

                                  BA files
                      AX8000 ----------~~--
                              Fig 8.3
              NOTE: PC means Program Counter

               Unfortunately, you cannot use MASOEL simply       for
       shrinking the hole which is made by killing the CO file, like
       in deleting a BA file and a 00 file. Because MASOEL changes
       the pointer, BINTAB. ( You can understand why BINTAB should
       not be changed by reviewing the sec~ion, 'What is RAM files'
             1
       and   Bookkeeping area'.) So if you want to use MASDEL, I do
       recommend that, you have to save the BINTAB before calling
       MASOEL and restore it after calling MASOEL.

                 Cf.    The flow of deleting CO file.

                 1.    Search a file name which you want to delete
                 2.    Save the starting address in the airectory
                 3.    Calculate the size of that file. The 2nd and 3rd
                       byte in that file show the data length. So the
                       total size of the file is made by adding 6 bytes
                       to the data length.      (The 6 bytes includes the
                       starting address, data length and the execution
                                              1
                       address. Refer to What is the RAM file.·)
                 4.    Set the starting address and the length for MASOEL
                 s.    Save BINTAB
                 6.    Call MASDEL
                 7.    Recover BINTAB
                 8.    Clear the directory flag of the file
                 9.    That's all

       8.4   HOW TO APPEND DATA TO 00 FILE"

               The way to append data to the 00 file is very easy.
       At the first, get the starting aadress of the 00 file in the
       directory and search the end of file, AZ. Then, make a room
       for data you want to store at that point. The routine,
       MAKHOL, is a best routine to-make a room.   Refer to ·useful
       Routine For RAM file handling in ROM #0•. And don't forget to
       refine the starting address of other files in the directory
       area.   LNKFIL will help you. Refer to previous chapter, ·How
       to make a DO file· also.

               Cf.    APPEND data to the 00 file
               1.    Search the file name in the directory
               2.    Make sure the file type and status by checking the
                     directory flag.
               3~    Get the starting address in the directory
               4.    Search the end of file,   AZ ( 26 in Decimal)
               5.    Make a hole_just before the AZ.
                         I recommend to use MAKHOL.
               6.    Store data in the hole
               7.    Shrink the hole, when the hole      you   made   1s   too
                     large for the data   ·

                           MASOEL in ROM #0 is useful.
               8.    Refine the starting address in the Directory area.
                         LNKFIL will help you.
               9.    End

               There is a sample program of how to APPEND data to          00
       file in the foll~wing section.

        8.5   HOW TO INSERT DATA TO DO FIL~

                When you want to insert some data to the DO file, you
       can use the know-how which you Wse to APPEND data to the DO
       file. The difference is that you have to search the address
       where you want to insert the data instead of searching the end
       of file.

                Cf.    Insert data to DO file
                1.    Search the file name in the directory
                2.    Make sure the file type and status by checking the
                      directory flag
                3.    Get the starting address in the directory
                4.    Get the address where you want to insert the data
                5.    Make a hole for the data at the point
                      Usually, MAKHOL in ROM #0 is used. MAKHOL changes
                      the pointers, BINTAB, VARTAB, ARYTAB and STREND.
                6.    Copy data in the hole
                7.    Shrink the hole, when the hole is   too   large   for
                      the data
                          MASOEL in ROM #0 is useful.    MASOEL adjusts
                      the pointers, BINTAB, VARTAB, ARYTAB and STRENO.
                8.    Adjust the starting address in the RAM.
                         LNKFIL in ROM #0 is useful. Refer to "Useful
                      Routines for RAM file Handling in ROM #0".
                9.    End

                                   ...

       8.6   HOU TO DELETE DATA FROM DO FILE
               To DELETE data from the 00 file is easier than to
       INSERT data to the 00 file.    If you will use the ROM #0, the
       routine named MASDEL delete the da~a. The MASOEL refines the
       pointers and LNKFIL adjusts the starting addresses of other
       file's. You can find the detail information about MASDEL and
       LNKFIL in ·useful Routine for RAM file in ROM #0. If you
       cannot use the ROM #0, you have to renew the pointers, BINTAB,
       VARTAB, ARYTAB and STRENO by YOURSELF. And you must modify
       the starting addresses in the directory YOURSELF.    Refer to
       the chapter ·oirectory construction· and "Bookkeeping• to
       under stand the directory structure and pointers.     "MAKHOL"
       and "LNKFIL• in ·useful Routine for RAM file handling in ROM
       #&" show you how to do it •

                           •

           8.7   USEFUL ROUTINES FOR RAM FILE HANDLING IN ROM #0

                   There are several useful routines in ROM #0 for RAM
           file handling. ·Indeed that you have to do 'bank-switching' to
           use these RAM file handling routines from ROM #1.   (Refer to
           Chapter 3.3) But you don't have to worry about the pointers,
           if you use them. And also, you can save the time to make your
           own subroutines.    I do recommend you to use these RAM file
           handling routines in ROM #0 for saving time and making
           applications smoothly.

           The presented useful routine in ROM #0.
           MAKHOL:    Make a room for data entry with changing the pointers
           LNKFIL:    Make sure the start addre~s in the directory area
           MASDEL:    Shrink the room made by MAKHOL. This file help you
                      when you made a too large hole.
           CHEAO:    Search the end of file in BA file.

l

        8.7.1   MAKHOL

                 Make a hole
          ADDRESS        AX6C0A C AO66012, 27658 >
         ENTRY CHLJ points where you want to make a hole
                CBCJ size of the hole
         EXIT   CHLJ and CBCJ are preserved
                Carry is set if out of memory
                        In order to know the free area's size, STRENO
                is the best pointer.      The amount of the STRENO and
                your file's size, in this case, should be less than
                CSPJ     120.    (The ·sp• means Stack Pointer, as you
                know.  ) The 120 bytes are reserved for Stack's
                operation.    If there is a enough room, MAKHOL shifts
                the all data between the specified address and STRENO.
                If not,· MAKHOL returns with carry set. The flow of
                MAKHOL is listed at next page.

                ex.     The flow of MAKHOL.   tHow to make a room safely.)

                /------------¥
                   MAKHOL
                ¥------------/
                ; STRENO + Required bytes
                         < SP - Stack area ( 120 bytes) :
                           I
                           I   No
                           : -----.----> Out of Memory

                : Move the data between STRENO and
                     specified address

               -------------------------------------
                 Change the pointers
                                                     **
                      ASCTAB, BINTAB, VARTAB, ARYTAB
                        and STREND
               -----------------~-------------------
                 -/-----------¥
                     RETURN
                  ¥-----------/
                    Fig 8.4

                       It is unnecessary to care about the pointers
               unless you make your own MAKHOL routine. The MAKHOL
               in ROM #0 manages the pointers automatically. But it
               does not change the starting address in the directory
               field. Refer to LNKFIL.

                    ·**When you make a hole just above the ASCTAB to
                     create a new DO file, you have to change the
                     pointers, BINTAB, VARTAB and ARYTAB.   The ASCTAB
                     is modified only when you make a hole under ASCTAB
                     to register a new BA file.

               It is ~asy to guess that calling MAKHOL too many times
        will reduce the processing speed. So you had better call the
       MAKHOL with a good large number in BC register.   It makes a
       good hole which is large enough to save the data you want to
       keep. The only one thing you have to care of is that you have
       to shrink the hole when you made a too big hole. The 00 file
       cannot include NUL (0) and AZ (26) in the file.  (The AZ means
       the End of File, as you know.) There is a convenient routine
       to shrink the hole and it refines the pointers, also.      Its
       name is MASOEL and you can get the information about it in the
       following section.

       8.7.2    LNKFIL

                Fix up directory structure
         ADDRESS             AX233A   < A021472, 9018 >
         ENTRY:       NONE
         EXIT    :    NONE
                     All registers might be altered

               This routine fixes up all possible incomplete "links"
       between files and their directories. There are many chances
       in that the link pointers ( same as starting address>. in the
       directory fields are not maintained properly. For instance,
       Making a new DO file will change the starting address of other
       00 files and CO file.  I agree that these link pointers should
       be modified every time when the RAM organization is modified.
       But it is also true that such a operation will make a big
       overhead in RAM file handling. Since you had better make sure
       when LNKFIL should be called. For instance, when a file is
       deleted during further file I/O, all link pointers should be
       fixed up.

                Internal flow of LNKFIL

                /---------------¥
                   LNKFIL
                ¥---------------/
                  Mark the all valid directory:
                : flag (turn 0 bit of all

                : Get the lowest file address:
               ~-----------------------------
                    Get the lowest link pointer
                     in the valid file's
                      directory

                : Save this link pointer r

                          :<------------------------------·
                  Search the lowest link pointer:
                : directory area

               ---------------------------
                 Save the saved link pointer
                    at this marked files link
                    pointer field    ·
               ---------------~-----------------
                          I
                          I
                               :

                 Demark the directory flag of
               : that file. (turn off the bit 0:
               : of that file)

                         (A)                             (8)

                                   - 130

                       CA)                            (8)

                l Get next lowest file address l
                l from the bottom of RAM       l·
                --------------------------------
                -----------------------------
                l All marked directory flag
                l has demaked?
               --------------------------------
                               Not End of directory

                        l End of directory

               /---------------¥
                     ENO
               ¥---------~----/
                       Fig 8.5

               When the top address of ~he next file is searched, the
       pointers, ASCTAB and BINTAB are useful to know what kind of
       file is searched now.

        8.7.3   MASOEL

                  Delete CBCJ bytes from CHLJ
                                           .
          ADDRESS:       AX6C3C C A066074, 27708)

         ENTRY:           CHLJ pointer of the hole should be squeezed
                  CBCJ size of the hole
         EXIT: CHLJ preserved
               CBCJ negated

                          This routine do exactly reverse operation of
                  MAKHOL.   The data above the CHLJ+CBCJ is moved up.
                  And the pointers, BINTAB, VARTAB~ ARYTAS are modified.
                  If you use this routine for shrinking a hole of BA
                  file, you can adjust the ASCTAB with the negated CBCJ _
                  after exit this routine. And also you can adjust the
                  TXTTAB by using this negated BC register if necessary.
                  You have to adjust the TXTTAB when you remove a BA
                  file which is located under the address where 1s
                  pointed by TXTTAB.
                          If you want utilize this routine for CO file,
                  you need save BINTAB and recover it after exit. The
                  BINTAB is not modified by killing CO file.

        8.7.4   CHEAD
                                          ...
                 Search for the end of this BASIC program
         ADDRESS         AX718 C 34300, 1816)

         ENTRY·:    CHLJ Top address of that BASIC file
         EXIT:     CHLJ The last address of that BASIC file
                 All registers and flags are modified possibly

                         The main purpose of CHEAD is fix links of the
                 BASIC program.    In other words, CHEAD goes through
                 program storage and fixes up all the links.   The end
                 of each line is found by searching for the zero at the
                 end. The double zero link is used to detect the end
                 of the program.     So EXIT CHLJ and one will show you
                 the top address of the next file.

                                         --~
        8.8   SAMPLE PROGRAM

               The sample ,programs listed here are the exactly
       ·sAMPLE·.   So some processes are omitted to make explanation
       clearly. For instance, searching directory to find the good
       slot for file handling is not described except ·How to make a
       DO file·. You know that you have to survey the all directory
       for checking the same file name and free slot, when you make a
       new file.
               And also, these programs, stored this section are
       written in plane program technic. You will find another good
       algorism to handle the RAM files safely and quickly.

       8.8.1   Make A New 00 File (ASCii File)

          ; Register new DO file in the Directory area
          ;    OPEN DO file
          ;
         USRDIR         EQU       AXF891 ;Top address of user's
                                  ;directory
         EOTDIR         EQU       USROIR - Directory length
         OIRLEN         EQU       11      ;Length of the directory per
         file
         NAMLEN         EQU       6       ;Length of the file name
         ASCTAB         EQU       AXFAE1 ;Points the lowest address of
                                  ;DO files
         LNKFIL         EQU       AX233A ;Make up the address 1n
                                  ;Directory
         MAKHOL         EQU       AX6C0A ;Make a room for file
         EOFFIL         EQU       A1AH    ;End of 00 file
         OPENDO:
               XRA      A        ;Clear HL
               MOV      H,A     ,•
               MOV      L,A   . ,•
               SHLO     SLTAOR ;Clear slot address
         ,•
                  LXI   H,EOTOIR ;Set Ctop of user directory]
                                ;   - Directory length
         SEANAM:
               LXI      B,OIRLEN;Set Directory length
               DAO      8      ;Get next slot
               MOV      A,M    ;Get directory flag
               CPI      AX80   ; Va 1 id?
               JC       NONVAL ;Jump if not valid slot
               INR      A      ;End of directory area?
               JZ       ENOSEA ;Jump if end of test
         ,•
         ; Is the file DO file?
               OCR      A       ;Adjust directory flag
               MOV      D,A     ;copy flag for later use
               AN!      AB01000000
                                ;Pick up ASCII flag
               ORA      A       ;DO file?
               JZ       SEANAM ;Jump if not DO file
         ,•
         ,• Compare the name
         ,•
               PUSH     H         ;Save the slot address
               INX      H
               INX      H         ;Advance to name field in

                               ; directory
                XCHG           ;COEJ name address
                LXI     H,NAME ;name of the file which
                               ; we want to make
                MVI     B,NAMLEN;Set name ~ength
          CMPNAM:
                LOAX    0          ;Get directory's name
                CPI     M          ;Compare with our file
                JNZ     NOTSAM     ;Jump if not same
                INX     H          ;Advance the pointers
                INX     0
                OCR     B
                JNZ     CMPNAM     ;compare next
          ,•
          ,•
                POP     H       ;Top of the slot address
                MOV     A,M     ;Get directory flag
                ANI     AB00000010
                                ;Pick up OPEN BIT
                ORA     A       ;File already opened?
                JNZ     FILAOP ;Jump if file already opened
          ,•
         ; Find same name and not opened file
         ,•
                 SHLO   SLTAOR    ;Save it
                -CALL   OELFIL    ;Delete this file
               · JMP    FINONM    ;go to Registration
         ,•
         ; Find free slot
         ,•
                XCHG               ;COEJ free slot address
                LHLO    SLTAOR     ;Get free slo.t address
                                   ; that has been found
                MOV     A,H       ,•
                ORA     L          ;Never found?
                JNZ     EVERFN    ;jump if already found
                XCHG              ;This is the fir-st time
                SHLO    SLTAOR
                JMP     SEANAM    ;Check next slot
         ,•
         EVERFN:
               XCHG               ;Don't renew the address
                JMP     SEANAM    ,•
         ; To search the directory is done
         ,•
               LHLO     SLTAOR    ;Is there good free slot?
               MOV      A,H
               ORA      L         ,•

                                              4

                JZ      OIRFULL ;Jump if directory full
           ;
                PUSH    H        ;Save the top of the slot
                MVI     M,"'811000000
                                 ;Set directory flag as 00
                                 ; fi l·e
                 INX    H        ;Advance to name field
                LXI     O,NAME ;Top of our file name
                MVI     B,NAMLEN;Name length
          CPYNAM:
                MOV     M,A       ;copy it in directory
                INX     H         ,•
                INX     D
                OCR     B         ;Continue to end of name
                JNZ     CPYNAM
          •,
                LHLD    ASCTAB  ;Get lowest address for 00
                               ; files
                LXI     8,1    ;Make one byte hole
                CALL    MAKHOL ;Dig
                JC      MEMFUL ;Jump if out of memory
                MVI     M,EOFFIL;Set end of file marker
                DCX     H      ;Lowest address - 1
                               ; for maintain the file order
                POP     D      ;Recover Top of that slot
                INX     D      ;Advance to address field
                MOV     A,L    ;set start address
                STAX    D
                INX     0
                MOV     A,H
                STAX    0
          ,•
          ; Make up starting address of other files in
          ,•   directory area
          ;
                RET
          ;
          ; External routines
          •
         '
         DELFIL:
                ; Delete the specified file
               ; Error handling --- File already opened

                ; Error handling          Memory ful 1
          DIRFUL:
                ; Error handling --- Directory full
          ,•
                                              ..
          ; DATA AREA
          •
         '
         NAME: DB       'TEST   DO'
                ENO

       8.8.2     Save Data Into DO Fi 1e . --

        •
         '; Save data into DO file
         •
        ;' ENTRY: CHLJ points directory of the file
        ,•          CDEJ address of source data
        •           CBCJ length of data
       '•
       '
       MAKHOL EQU          AX6C0A    ;Make a room for data
       LNKFIL     EQU      AX233A    ;Make up starting address
       ENDFIL    EQU       AX1A      ;End of DO file
       •t
        •
       '
       SAVDAT:

           .
       '•; Check the directory flag of the file
       •
       t
                 MOV      A,M      ;Get directory flag
                 PUSH     B        ;Save data length
                 MOV      B,A      ;Save directory flag
                 ANI      Ae11000000·
                                   ;Pick up mode bits
                 CPI      AB11000000
                                   ;DO file?
                 JNZ      BADFIL ;Jump if not DO file
                 MOV      A,B      ;Get flag again
                 ANI      AB00000010
                                 ·;Pickup OPEN bit
                 ORA      A       ;File already opened?
                 JNZ      FILAOP ;Jump if file already opened
                 MOV      A,B     ;Get directory flag
                 ORI      000000108
                                  ;Say this file is opened
                 MOV      M,A
       •
       ';Search end of file
       •
       '        POP     B            ;Recover DATA length
                 PUSH     H          ;Save Top of directory address
                 PUSH     B          ;Save DATA length
                 INX      H          ;Advance to Address field
                 MOV      A,M        ;get address in CHLJ
                 INX      H

                                                                  I

                  MOV     H,M
                  MOV     L,A        ;Set top of the file
        ,•
        SEALOP:
                  MOV     A,M        ;Get Data
                  CPI     ENDFIL     ;End of file?
                  JZ      FNDEOF     ;Jump if end of file
                  JMP     SEALOP     ;Search next
        ,•
        ;MAKE A ROOM FOR DATA
        ,•
                  POP     B          ;Recover data lengtH
                  PUSH    D          ;Save source address
                  CALL    MAKHOL     ;Dig a hole for data
                  JC      MEMFUL     ;jump if error detected
                  POP     D          ;Recover source address
        ,•
        ;copy data in to the hole
        ,•
       COPYLP:
                  LDAX    D          ;Get source data
                  MOV     M,A        ;save it in~o file
                  INX     D
                  DCX     B          ;Decrement DATA length
                  MOV     A,B        ,•
                  ORA     C          ;End of data?
                  JNZ     COPYLP     ;Continue till end of data
        ,•
        ;Make up starting address of other files in
        ; directory area
        ,•
        •,
        ;Turn off the opened bit in directory flag
        •,
                  POP    H       ;Recover directory address
                  MOV    A,M     ;Get directory flag
                  ANI    ~B11111101
                                 ;Turn off the flag
                  MOV    M,A     ;Renew the flag
                  RET
       ,•
       ;External routines
       ,•
                  ; Bad file mode

                                          .
                  ; File already o~ened
                  ; Memory full error..
                  ENO

,
..

            8.8.3      DELETE SOME DATA FRoM·oo FILt

                                                  ..
                  Delete some data from DO file
               ENTRY: CHLJ Top of the direetory address
                      CDEJ Offset address of Top data
                             should be deleted
            ;         CBCJ Length of data should be deleted
            ,•
            MASOEL EQU      AX6C3C ;Remove some data
            LNKFIL EQU      AX233A ;Make up starting address
             ,•
            OELDAT:
            ,•
             ;Check directory flag
            '•         MOV     A,M     ;Get direetory flag of
                                       ; the file
                       ANI     AB11000000
                                       ;Pick up VALID bit and ASCII
                                       ; bit
                       CPI     AB11000000
                                       ;Valid 00 file?
                       JNZ     BADFIL ;Jump if bad file
                       MOV     A,M     ;Get direetory flag again
                       ANI     A800000010
                                       ;Pick up OPEN bit
                       ORA     A       ;Already opened?
                       JNZ     FILAOP ;jump if the file already opened
                       MOV     A,M     ;Set opened bit
                       ORI     AB00000010
                       MOV     M,A     ;Say, the file is opened
            ,•
                       PUSH    H        ;Save directory address
                       INX     H       ;Get start address of the file
                       MOV     A,M      •
                                        '
                       MOV     H,M     ,•
                       MOV     L,A      ;CHLJ start address of the file
            ;
                       DAD     D       ;Absolute address of the data
                                       ; ~hich should be removed
            ; Delete data
            ,• CHLJ TOP of the data, CBCJ data length
            ,•

                 CALL    MASOEL     ;Remove the data from file
        ,•
        ; Turn off the OPENED bit
        ,•
                 POP    H       ;Restore .the directory address
                 MOV    A,M     ;Get d1rectory flag
                 ANI    AB11111101
                                ;Turn off
                 MOV    M,A
        ,•
        ;Adjust the directory
                 CALL   LNKFIL     ;Make up all 9tart address in the
                                   ; directory flag
        ,•
                 RET
        ,•
        ; External routine
       ,•
                 ;Bad file mode -- Error
                 ;File already opened -- Error

        8.8.4    DELETE 00 FILE

        •
        •
        ; Delete 00 file
        •,
        ; ENTRY.: CHLJ points the directory of the file
        ,•
       MASOEL    EQU       AX6C3C     ;remove data
       LNKFIL    EQU       AX233A     ;adjust address field in
                                      ; directory area
       DELOO:
                 MOV     A,M     ;Get directory flag
                 ANI     AB11000000
                                 ;Pick up VALID and ASCII bit
                 CPI     "811000000
                                 ;Valid do file
                 JNZ     BADFIL ;jump if bad file mode
                 MOV     A,M     ;get directory flag
                 ANI     AB00000010
                                 ;pick up opened bit
                 ORA     A       ;Already opened?
                 JNZ     FILAOP ;jump if already opened
       ,•
        ; Calculate the size of the file
       •
       •         PUSH    H           ;save directory address
                 INX     H           ;get start address
                 MOV     A,M         ,•
                 MOV     H,M         ;CHLJ start address
                 MOV     L,A
       ;
                 PUSH    H           ;Save start address
       SEALOP:
                 MOV     A,M         ;end of file?
                 CPI     EOFFIL      ,•
                 INX     H           ;next field
                 JNZ     SEALOP      ;continue till EOF
       ,•
                 POP     0           ;Restore start address
                 MOV     A,L         ;CHLJ-CDEJ= length
                 SUB     E:
                 MOV     C,A
                 MOV     A,H         ,•
                 S88     0
                 MOV     8,A         ;Set length in CBCJ

      tlAN~LING

             XCHG               ;CHLJ star·t" address
 ,•
             CALL    MASOEL     ;Remove the data
 •,
             POP     H          ;recove_r directory address
             XRA     A
             MOV     M,A       ;clear it
,•
;Make up all start address in directory
,•
,•
             RET
•
'
;External routine
•
'
             ;File already opened error
BAOFIL:
             ;Bad file mode error
,•
             ENO

                                               --·-s   -•
       8.8.S        DELETE SA FILE

        •
         '
        ;Delete  BASIC file           -  . . -l
         •
        '; Asswme that this subroutine i!s used with BASIC
                I
        •    main program
        ',•
        ; ENTRY: CHLJ directory address of the file
        ,•
       MASOEL       EQU     "'X6C3C    ; remove data from file
       LNKFIL       EQU     "'X233A    ; make up starting address
       CHEAO        EQU     "X0718; search end of BASIC file
       TXTTAB       EQU     "'XF45O ; lowest address of current
                                    ; BASIC program
       A$CTAB       EQU     "XFAE1 ·; Lowest address of 00 files
       ,•
       ,•
       OELBAS:
                    MOV     A,M     ;Get directory flag
                    c·p1    "B10000000
                                    ;BASIC file?
                    JNZ     BAOFIL ;Jump if not BASIC
                                    ; file
                    XCHG            ;COEJ directory address
                    LHLO    TXTTAB ;get lowest address of the
                                    ;current BASIC program
                                    ; (Ue are executing the
                                    ; BASIC program with this
                                    ; machine subroutine.)
                    XCHG            ;COEJ TXTTAB CHLJ Directory
                                    ;                   address
                    PUSH    H       ;save directory address
                    INX     H       ;advance to address field
                    MOV     A,M     ;get start address of BA file
                                    ; which we want to delete
                    MOV     H,M
                    MOV     L,A       ;CHLJ start address
                    MOV     A,H       ;compare to TXTTAB
                    SUB     D
                    JNZ     NOSAM     ;jump if not same
                    MOV     A,L       ;compare lower address
                    SUB     E         ,•
                    JNZ     NOSAM     ;jump if not same

                                           146 -

                 JMP    FCERR      ;you cannot kill Y.Our mother
                                   ;BASIC
        NOSAM:
                 XCHG              ;save start address
                 POP    H          ;recover directory address
                 PUSH   PSIJ       ;save result of comparison
                 XRA    A          ;CAJ=0
                 MOV    M,A        ;clear directory flag
                 PUSH   D          ;save start address
        ,•
        ;COEJ start address of the BA file
        •
        '       CALL    CHEAO      ;search the end of BA file
                INX     H          ;adjust for calculation the length
                POP     0          ;recover start address
                PUSH    0          ;Save start address· again
                MOV     A,L        ;Calculate the length
                SUB     E          •
                MOV     C,A        ';Set length in CBCJ
             ·· MOV     A,H
                SBB     D
                POP     H          ; recov·er start address
        •
       ';Remove body of the file
       •
       '         CALL   MASOEL     ;return negative length in CBCJ
       •
       '         LHLD   ASCTAB     ;adjust ASCTAB because MASOEL
                                   ;doesn't change it
                 DAD    B
                 SHLO   ASCTAB
       •
       '       PUSH    B       ;save this value for later use
       •
       '
       ;Adjust starting address in directory
       •
       '         CALL   LNKFIL     •
       •                           '
       '
                 POP    B          ;Restore adjustment value
                 POP    PSIJ       ;recall result of comparison
                                   ; TXTTAB and start address
                 RNC               ;Return if TXTTAB is smaller
                                   ; than start address
                 LHLO   TXTTAB     ;Adjust TXTTAB because we
                                   ; delete BA file under TXTTAB
                 DAO    B
                 SHLD   TXTTAB
                 RET
       •
       '

          ; EXTERNAL ROUTINE
          •
         'FCERR:
                    ; Illegal function call error

          BAOFIL:
                    ; Bad file mode error
                    ENO

        8.8.6    MAKE NEW CO FILE

                             -.
         ; MAKE NEW CO FILE
         ,•
          ; ENTRY: CSTRADRJ start address of CO file data
          •        CLENGTHJ length of data
        ' CEXECADJ execution address
        •
          CHLJ directory address for this CO file
        '•
        '
        MAKHOL   EQU     "'X6C0A    ;make a room·
        LNKFIL   EQU     "'X233A    ;make up directory address field
        HEADLN   EQU     6          ;Header length of CO file
        BINTAB   EQU     "'XFAE3    ; 1owest address of existed co
                                     • files
        VARTAS   EQU     "'XFAES    '; 1owest address of Variable
                                    • table
                                    '
       MAKECO:
        ,•
        ; Refer HOU TO MAKE NEU DO FILE to know how to find
        ; the directory address for new files •
        •
       -'
                 MVI     A,""B10100000
                                  ;Set direc~ory flag as CO file
                 MOV     M,A      ;register it
                 PUSH    H        ;save directory address
                 LHLD    LENGTH ;get file l~ngth of new CO
                 LXI     B,HEAOLN;Set header length
                 DAO     B        ;Get total length of new CO file
                 MOV     B,H      ;Set length in CBCJ
                 MOV     C,L      ;
                 LHLD    BINTAB· ;CHLJ lowest address of existed
                                  ;CO files
                 PUSH    H        ;Save current BINTAB
                 LHLD    VARTAB ;CHLJ just above highest CO file
                 CALL    MAKHOL ;Try to make a hole
                 JC      MEMFUL ;jump if there is no enough room
                 XCHG             ;Save the top address of hole
                 POP     H        ;recover BINTAB
                 SHLD    BINTAB ;Adjust BINTAB
                 XCHG             ;restore TOP of hole

                 POP       D
                                               ..   -·
                                      ;CDEJ directory address
                 INX       0          ;advance to address field
                 MOV       A,L        ;Set start address
                 STAX
                 INX
                           0
                           D
                                                    ..
                                                    -
                 MOV       A,H        •,
                 STAX      D
        ,•
        ; To register the file name in directory is omitted •
        ,•
                 XCHG             ;COEJ top of the vacant room
                 MVI       B,HEAOLN;Set header length
                 LXI       H,STARAO;offset of header data
       COPYHD:
                 MOV       A,M        ;Get header data
                 STAX      0          ;store'it in file
                 INX       0
                 OCR       B          ;end of header data?
                 JNZ       COPYHD     :copy 3 address as header
       ,•
                 LHLD      LENGTH     ;Get data length
                 MOV       B,H ,      ;set length in• CBCJ
                 MOV       C,!:ir-
                 LHLD      STARAD     ;CDEJ destination address
                                      ;CHLJ source address
       COPYLP:
                 MOV       A,M        ;copy contents of file
                 STAX      0
                 INX       0
                 DCX       B          ;count down
                 MOV       A,B        ;end of data?
                 ORA       C
                 JNZ       COPYLP     ;continue till end of data
       ,•
                 CALL      LNKFIL     ;make up all start address of
                                      ;other files in directory area
                 RET
       •
       '• ERROR HANDLING ROUTINE
        '•
       '
       •         memory ful 1 er-r-or-
       '
       ,•
       ,• DATA AREA
       ,•
       STARAO: OS         2
       LENGTH: OS         2

                                   -~
       EXECAO: OS    2

               ENO

                .~

        8.8.7   DELETE A CO FILE

        •
        ;' DELETE A CO FILE
        ;
        ; ENTRY: CHLJ addres of its directory
        •
       '
       MASDEL EQU          AX6C3C     ;remove data
       LNKFIL        EQU   AX233A     ;make up starting address
                                      ;in the directory
       BINTAB    EQU       "XFAE3     ; 1owest address of CO files
       HEADLN    EQU       6          ; 1ength of the header in CO
                                      • file
                                      '
       DELCO:
                 MOV       A,M      ;Get DIRECTORY flag
                 CPI       "'810100000
                                    ;CO file?
                 JNZ       BAOFIL ;Jump if BAO file mode
                 XRA       A          •
                 MOV       M,A        ';Clear directory flag
                 INX       H          ;Advance to address field
                 MOV       A,M        ;Get start address of the CO
                                      ;file
                 MOV       H,M        ;CHLJ start address
                 MOV       L,A
                 PUSH      H          ;s~ve start address
                 INX       H          ;Get file length in the
                                      ; header
                 MOV       C,M        ;get length in CBCJ
                 INX       H          •
                 MOV       B,M        '
                 LXI       H,HEADLN;add header length
                 DAO       B          ;
                 MOV       B,H        ;Set total length in CBCJ
                 MOV       C,L
                 POP       H          ;recover start address
                 XCHG                 ;save it at once
                 LHLO      BINTAB     ;get lowest address of existed
                                      ;CO files
                 PUSH      H          ;save it for after adjustment
                 XCHG                 ;CHLJ start address
                                      ;CBCJ file length
                 CALL      MAS.DEL    ;remove the body of the file
                 POP       H          ;recover BINTAB
                 SHLD      BINTAB     ;adjust BINTAB

                                       ;,   -   .. ·1
        •
        '        CALL    LNKFIL    ;make up starting address in
                                   ;the directory area
                 RET
        ; EXTERNAL ERROR ROUTINE
        ,•
                 ;Bad file mode
                 END

```
