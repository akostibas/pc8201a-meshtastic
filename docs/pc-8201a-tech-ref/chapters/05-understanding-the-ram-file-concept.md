# Chapter 5: Understanding The RAM File Concept

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 60–75). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as **authoritative**.

## 5.1 Summary

Usually, the RAM files are controlled by the ROM #0, settled in ROM socket #0 at the shipment. There are many rules to use the RAM file. Unless you replace this ROM #0 with your own ROM, ROM #0 checks the RAM file organization and pointers in the bookkeeping area sometimes, even if you don't use BASIC, TEXT or TELCOM. (For instance, at Power on and "Bank" command in menu.) If you ignore the standard rules for RAM file handling, ROM #0 will flush not only the files which were made by your own application program, but also the files which were made by BASIC and TEXT in ROM #0. In order to save your files from such kinds of accidents, please read the following chapters about the RAM file handling and understand the standard rules in PC-8201A.

The two situations were considered for this section. Someone wants to handle RAM files with the machine language subroutine in the BASIC mode. In this case, opening the file will be done by a BASIC command, OPEN. And the file will be closed and deleted by CLOSE and KILL command in BASIC. So the machine language subroutine will make up the lacking facilities in BASIC commands. For instance, Insert a data at the middle of the opened file. In this case, you had better care about a few pointers only. You needn't know the directory structure.

But another person might try to make his (or her) original application program without using BASIC. He (or She) might open a file, save data, append data, insert data, delete data and erase a file with his (or her) own application. In this case, the name of the data file should be registered by that application program. So that programmer needs to know the Directory configuration and many parts of the pointers playing.

This section is written for supporting both of them. The programmer who wants to make an original application without BASIC needs much more information than a user who uses BASIC. But too much data sometimes confuses a novice programmer who wants to make a subroutine for a BASIC main program. After long consideration, I decided to obey the famous common saying, "The greater serves for the lesser." Therefore I serve everything what I know. Please find what you want to know in the following section.

In these chapters, I tried to describe each section independently. You, however, might meet unknown words sometimes. Please refer to another section or another chapter at that time. I hope you will make many good application programs with this document.

## 5.2 What Is a RAM File?

In PC-8201A, you can have many files in RAM area at a time, like files on the floppy disk. The files are classified into three suffixes: .DO (document), .BA (basic) and .CO (command). Hereafter .DO (document) file is abbreviated DO file, BA (basic) file is BA file, and .CO (command) file is CO file. And sometimes the word "ASCII file" is used in place of "DO file."

### 5.2.1 DO File (ASCII File)

The DO file is created by BASIC, TEXT and TELCOM. Of course, you can load a DO file from I/O in menu mode. In BASIC, the `OPEN` command handles the DO file. The OPEN command with `FOR OUTPUT` option makes a new DO file. OPEN with `FOR APPEND` opens the DO file in order to add the data after the last data that has already been entered. When there is no file whose name is same as the specified in the `OPEN` with `FOR APPEND`, that OPEN command works as the OPEN with `FOR OUTPUT`. The OPEN with `FOR INPUT` opens the specified file.

The `SAVE` command with `,A` option or `SAVE` command with the file descriptor followed by the suffix `.DO` stores a BASIC program as a DO file. This DO file is sometimes called an ASCII (saved program) file. (Note: A SAVE command without `,A` option creates a BA file.) In this case, the BASIC program in the BASIC files area is saved into the DO files area in the ASCII format. So you can read it in TEXT mode. `SAVE` command without `,A` or without the suffix `.DO` only registers the file name with the suffix `.BA` and changes some pointers. It does not make a new file. Please refer to the next section about BA files. And I think almost every BASIC interpreter has this "ASCII save function" for the disk files. Refer to the BASIC reference manual if you have another disk top personal computer's manual.)

<!-- FIGURE 5.1: SAVE with ".DO" or ",A" option — needs vision re-OCR from source page 62 (target: mermaid or table) -->

```text
                                              I        A
                                              I
                                                                 Upper
                                              I
                        ''                    I
                                              I   •
                         I DO files           I   •

                                                                 Lower
                         non-registered                V
                         BASIC program
                              or
                         saved BASIC
                          program
                           •A.BA•

                       ----------------- <-- TXTTAB

               Type BASIC program in BASIC mode.
               Do SAVE command.
                       SAVE "TEST" ,A
                          or
                       SAVE "TEST.DO"

                                                      ....
                                                             :Upper
                         DO files

                       ------------       I
                                          I

                         TEST.DO          : <-- New DO file
                                                                  is inserted
                                                             :Lower
                         non-registered                      V
                          BASIC program
                            or
                         saved BASIC
                          program
                          'A.BA'
                       ----------------- <-- TXTTAB

                       Fig 5.1 SAVE with ".DO" or ",A" option
```

There are two special DO files kept in RAM. One is the "SCRAP" file used in TEXT, and another is the "EDIT" file used in BASIC. The screen oriented text editor in PC-8201A, named TEXT, has wonderful functions called "CCP." The CCP functions mean SELECT, CUT, COPY and PASTE. (The detail information about these functions are explained in the PC-8201A user's guide.) The CUT command or COPY command after SELECT command makes a temporary DO file. This DO file can be invoked by PASTE key many times. Though this file cannot be found in menu level, this file will be kept until next SELECT-COPY or SELECT-CUT will be executed and is not broken by the PASTE key.

And more good feature is in this DO file. Since the contents of this DO file is treated as the data from keyboard, this file can be used in BASIC. After saving a part of a file in SCRAP with SELECT-COPY function, return to Menu, and invoke BASIC. The contents of this "SCRAP" file will appear by PASTE key. (In the PC-8201A user's guide, this temporary DO file is called "PASTE buffer.")

Another one, "EDIT" file, is created by EDIT command in BASIC. The EDIT command in BASIC falls into the TEXT editor with the BASIC file. At that time, the BASIC program is translated into ASCII format file, "EDIT", and original BASIC file is killed. This file is erased when the EDIT mode is finished by double ESC or F8, converted into BASIC file and saved. So no one can find this file at the menu level.

The DO file usually consists of "ASCII" characters. And you cannot use the 3 Control Characters, NULL (0), sometimes abbreviated as `^Z`. The Control-Z is used as the End of DO file. So if you store it as one of the data in the middle of the DO file, the standard programs, BASIC, TEXT and TELCOM, will regard that Control-Z as the End of that DO file. The data after that Control-Z will be lost. Otherwise the NULL is used to fill the hole dug by MAKHOL. After copying or inserting the data into the hole, some routines try to find the end of the data by finding the NULL. Then a routine squeezes the NULLs. Therefore the NULL in the middle of the DO file might cause serious problems. Similarly, the Back Space has special meaning in DO file. Please don't use these three Control characters in the DO file. BASIC's `PRINT#` command cannot save these control characters into the DO file.

> NOTE: MAKHOL and MASOEL are names of routines stored in ROM #0. Refer to "Useful Routines for RAM file handling in ROM #0."

Examples of when a DO file is made in PC-8201A:

1. TEXT always creates and modifies DO files.
2. `SAVE` command with `,A` creates a DO file in BASIC.
3. UPLOAD and DOWNLOAD sends or receives a DO file through RS-232C in TELCOM.
4. DO file can be saved or loaded from CASSETTE and RS-232C in MENU.
5. OPEN with `FOR OUTPUT` registers the file name and inserts only End of file character as the DO file in BASIC.

### 5.2.2 BA File

The BA file is made in BASIC mode or made by LOAD function in Menu mode. There are two types of BA file in PC-8201A. One is a "saved" BASIC program, and another is a "non-registered" BASIC program. Sometimes the "non-registered" is called the "un-saved" BASIC program, because "un-saved" will make sense more than "non-registered" for a person who knows BASIC very well. The BASIC program typed just after selecting BASIC mode in menu level is called "non-registered" BASIC file, since the name of the program has not been registered in the directory area yet. But after executing `SAVE` command in BASIC mode, that "non-registered" BASIC program becomes a "saved" BASIC program. (In the point of view, `SAVE` command in BASIC, the words "un-saved" and "saved" are suitable, I think.) The `SAVE` command in BASIC "registers" the file name and the starting address in the directory area. Then the file name can be seen on the display screen of the MENU or by `Files` command in the BASIC mode.

Meanwhile the `LOAD` function in MENU can create a "saved" BA file directly. The `LOAD` function can read a BASIC program from the cassette, and can "register" its name in the directory area. So after LOADing in Menu, the file name can be seen at the menu level.

Example — the flow diagram of making a BASIC program:

1. Select BASIC in menu level.
2. Type BASIC program:

```basic
10 PRINT "HELLO"
20 END
```

3. In this point, this BASIC program is called a "non-registered" program.

4. If you return to menu level now, this program is reserved. You cannot find this program in Menu mode at this time. Next time you select BASIC in menu mode, LIST command shows you this program again. This program will be kept unless you do NEW command, LOAD ASCII saved file in RAM or LOAD.

5. Do `SAVE` command:

```basic
SAVE "TEST"
```

or

```basic
SAVE "TEST.BA"
```

(Note: `SAVE "TEST.DO"` or `SAVE "TEST",A` has another meaning.)

This registers the program. This program is now called a "saved" BA program and is moved out of the non-registered program area.

Just after doing SAVE, you can list the program with LIST command. So you might be confused. But don't worry about it. The following illustration will help you to understand not only why LIST command just after SAVE command can list the "saved" program, but also why PC-8201A can have many BASIC programs at a time, I hope.

<!-- FIGURE 5.2: RAM layout — in MENU mode — needs vision re-OCR from source page 67 (target: mermaid or table) -->

```text
1.   You are in MENU mode

        -----------------
         I
         I

         I DO   files
        ----------------- 'XUUUU
         I                     I
         I                     I

        : saved BA file :
                                   <- BOTTOM
                                      ('XF980)

        Fig 5.2
```

<!-- FIGURE 5.3: RAM layout — after typing non-registered BASIC program — needs vision re-OCR from source page 67 (target: mermaid or table) -->

```text
2.    Select BASIC in MENU and TYPE a BASIC program.
      LIST shows you the non-registered BASIC program.

        -----------------
         : DO files

        --------------- AXYYYY
                               I

          non-registered:
          BASIC program I
        ----------------- <-- ('XUUUU)
                                TXTTAB
             saved BA
               file

        Fig 5.3
```

<!-- FIGURE 5.4: RAM layout — after return to menu — needs vision re-OCR from source page 68 (target: mermaid or table) -->

```text
3.   Return to menu by MENU command

        -----------------
             DO files
        ----------------- 'XYYYY
            non-registered:
            BASIC program:
        ----------------- 'XUUUU
        I                   I
        I                   I

        : Saved BA file:
        Fig 5.4
```

<!-- FIGURE 5.5: RAM layout — after selecting BASIC again — needs vision re-OCR from source page 68 (target: mermaid or table) -->

```text
4.   Select BASIC    again.     LIST  command   lists   the
     non-registered BASIC program which you typed in (2).

           -----------------
                     -------
            I
            I

            : DO files
           -----------------
           I               I
                             AXYYYY
           I                   I

                non-registered:
                 program
                                       ('XUUUU)
            : Saved BA files:
           Fig 5.5
```

<!-- FIGURE 5.6: RAM layout — after SAVE "TEST" — needs vision re-OCR from source page 69 (target: mermaid or table) -->

```text
5.   SAVE "TEST". TXTTAB still points the program typed in (2).
     So the same list appears on the screen by LIST.

                                           'XFFFF
           -----------------
             DO files
           ----------------- 'XYYYY
              TEST.BA

                                ('XUUUU)
             Saved BA
              files

           ----------------- 'X8000
           Fig 5.6
```

<!-- FIGURE 5.7: RAM layout — after MENU and NEW or select BASIC again — needs vision re-OCR from source page 70 (target: mermaid or table) -->

```text
6.   MENU and select BASIC again or execute NEW command in BASIC.
     Now, LIST command lists nothing.  Type new BASIC program,
     again. LIST lists the program that you typed just now.

              I
            • I                           'XFFFF

            -----------------
             : DO files

            ----------------- 'XZZZZ
                  non-registered:
                   program area:

                                 ('XYYYY)
             I TEST.BA

            ----------------- 'XUUUU
                                     I
                                     I

             : Saved BA files:
            Fig 5.7
```

<!-- FIGURE 5.8: RAM layout — after LOAD "TEST.BA" — needs vision re-OCR from source page 71 (target: mermaid or table) -->

```text
7.        LOAD "TEST.BA" in this case, or select "TEST.BA" directly in
     MENU. LIST shows you the program, TEST.BA.

           =================

            : DO files

           ----------------- 'XZZZZ
                non-registered:
                  program

           ---------------
           I
                           'XYYYY
            I

            : TEST.BA
                                     ('XUUUU)
           : saved BA files:
           Fig 5.8
```

BASIC interpreter regards that the current TXTTAB indicates the current BA file. So LIST command lists the program which was saved just now because of being specified by TXTTAB.

The BA file can be created in BASIC mode and can be LOADed in BASIC mode and MENU mode. Refer to the PC-8201A user's guide and reference manual. And BA file is executed with BASIC interpreter at the menu level by selecting the BA file directly, as you know. In other words, when you select the BA file name appeared on the MENU, PC-8201A invokes the BASIC interpreter, LOADs that BA file and RUNs it automatically.

### 5.2.3 CO File

The CO file is made in BASIC with `BSAVE` command or can be loaded and saved from the cassette tape in MENU mode. The CO file is, sometimes, called a "machine language" file. It can be executed directly like a command in menu level, when "Execute" address was specified in BSAVE and the start address is higher than the second parameter in the latest `CLEAR` command in BASIC. The default value is `$F380`. <!-- TODO(tier-b): verify hex prefix — source shows "AXF380"; 'X and AX appear throughout as sigil variants; digits F380 preserved exactly --> So no CO file can be executed directly from the menu level without CLEAR command. The CO files are located above the DO files.

### 5.2.4 The Order of the Files in RAM

<!-- FIGURE 5.9: Order of files in RAM — needs vision re-OCR from source page 72 (target: mermaid or table) -->

```text
                       ----------------- ~XFFFF

                       =================
                          CO files

                          DO files

                       -----------------
                                        I

                         non-registered:
                         BASIC program :

                       : BA files
                       ----------------<-BOTTOM
                       Fig 5.9 the order of the files in RAM
```
