# Chapter 6: BASIC

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 100-121 / printed 6-1..6-22), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## Overview

The PC-8201 is provided with N82-BASIC as its programming language. This chapter describes simply the concept and the use of BASIC, with examples of various simple operations.

## BASIC Language

A computer will remind you of a complicated and difficult machine. However, a regularly used small calculator is a type of computer, and its principle is essentially the same as a large computer. A major difference between a calculator and computers like the PC-8201 is that the calculator is usually limited in the kind of tasks it can perform.

A typical computer, as well as the PC-8201, can perform various operations and more sophisticated tasks. For example, it can execute a complicated calculation, create graphics, animate graphics, produce sound, etc.

To execute such varied functions and tasks, words (special language) are needed to direct commands and precise instructions to the computer. However, the computer cannot understand our human language.

Languages have been developed for the purpose of transmitting commands or instructions to the computer. One of the most common of the languages is called "BASIC", meaning "Beginner's All-purpose Symbolic Instruction Code".

The BASIC language that the PC-8201 uses is N82-BASIC. This programming language is easy to use and has the following advantages:

1. The user can experiment with BASIC by trial and error while the language is being learned. Even a novice can easily operate the PC-8201 using BASIC.

2. The user can easily create and modify a program, which is a collection of commands written in BASIC.

3. It has a wide range of possible applications.

## Special Keys Used in BASIC Mode

It is important for you to become familiar with the keyboard. Since most of the keys are the same as an ordinary typewriter, only the Special Keys used in the BASIC mode will be outlined:

**[STOP]** — Forcibly stops the execution of a program, in direct mode.

**[RETURN]** — The RETURN Key is used to execute a command or statement in direct or program mode.

**f.1 — f.5** — These keys are called the Function Keys, which represent frequently used command words. These Keys can also be used as f.6, f.10 by simultaneously pressing the [SHIFT] Key.

**[CTRL]** — Used to input with particular control characters.

**[DEL/INS]** **[PASS/INS]** — These are Screen Editing keys, used when a program on display has to be revised, added to, or modified.

## Operation Modes

First of all, BASIC has to be started. Turn ON the power switch of the PC-8201. When the word "BASIC" appears in reverse image on the screen, press the [RETURN] Key and the following display will be on the screen:

```text
NEC PC-8201 BASIC Ver 1.0 (C) Microsoft
12374 Bytes free
Ok
█
```

```text
Load "  Save "  Files  List  Run
```

After the message "Ok" appears on the screen, the PC-8201 is in the BASIC mode and in the Direct Mode (command level). In this situation, N82-BASIC commands can be input through the keyboard.

### Direct Mode

If a BASIC statement is input without a line number, it is executed immediately when the [RETURN] key is input. This operation is referred to as "execution in the direct mode".

### Program Mode

If a BASIC statement with a line number is input, it is stored in the RAM as a program. Once a program is stored it can then be executed by using the RUN command. The operation is referred to as "execution in the program mode".

> **REFERENCE:** Consult the BASIC Reference Manual for details.

### Bytes Free

The number on the second line of the screen, and before the words "Bytes free", represents the amount of memory that is available in BASIC. The number is reduced each time a file is created in BASIC or TEXT mode.

When this number decreases to hundreds instead of thousands, be very careful that sufficient memory is available for use. You should delete any unneeded files, or save important files on an external device (a cassette tape). The operations outlined in this chapter will require approximately 3000 bytes of free memory.

> **NOTE:** Be aware that certain BASIC commands, such as DIM, require extra memory in order to run the program.

### Function Keys

There are five commands displayed on the bottom line of the screen which correspond to the five Function Keys (f.1 through f.5). Press the [SHIFT] Key and another set of five commands are displayed on the screen. These are the functions referred to as f.6 through f.10.

All of the ten Function Keys in the BASIC mode are different from the ten in the MENU mode, so do not confuse the two modes. Each command and its corresponding function will be described later in this chapter.

### To Clear Screen

First clear the display screen by pressing the [CTRL] Key and the "L" Key simultaneously. The display will appear as follows:

```text
█

Load "  Save "  Files  List  Run
```

### Syntax Error

Now type in the word "TALK":

```text
TALK█

Load "  Save "  Files  List  Run
```

Nothing happens at all. Nothing will be accepted by the PC-8201 until the [RETURN] Key is input.

> **NOTE:** It is always necessary to press the [RETURN] Key as the last step in order to execute BASIC command in Direct Mode.

Now press the [RETURN] Key.

"?SN Error" should be displayed on your screen. The phrase "Syntax Error" means that what has been input is incompatible with the grammar of the BASIC language and it cannot be executed.

You should realize that we have performed two steps up to this point:

1. Some letter keys have been input and the PC-8201 has simply displayed what was input. The letters appear on the screen at the location of the cursor.

2. When the [RETURN] Key was input, the PC-8201 did not recognize all the characters on the display as a command and responded with a message.

### Beep

Since nothing but an error message has been displayed so far, you can now try to input a BASIC command. Type "BEEP" [RETURN]:

```text
TALK
?SN Error
Ok
BEEP
Ok
█
Load "  Save "  Files  List  Run
```

The PC-8201 should generate the "BEEP" sound.

Now try to input the word "SOUND 10000,100" [RETURN]:

```text
?SN Error
Ok
BEEP
Ok
SOUND 10000,100
Ok
█
Load "  Save "  Files  List  Run
```

A lower and longer sound should be produced.

> **NOTE:** The cursor was output on the screen the same as in the first example, but since the screen became full the entire display moved up one line and the first line of the screen disappeared.

### Repeating the Command

Any information and commands that remain on the screen can be used again. To input a line or command again, simply move the cursor to that particular line and press the [RETURN] Key.

Use the ↑ Cursor Movement Key and move the cursor upward four times (four lines):

```text
?SN Error
Ok
█EEP
Ok
SOUND 10000,100
Ok
Load "  Save "  Files  List  Run
```

Now press the [RETURN] Key and once again the "BEEP" will be executed. The cursor will position at "S" in the word "SOUND". That is because that line is the next logical line after the "Ok" message:

```text
?SN Error
Ok
BEEP
Ok
█OUND 10000,100
Ok
Load "  Save "  Files  List  Run
```

Now press the ← Cursor Movement Key 7 times and press the "6" Key to change the "0" to "6". Then press the 5 Key and a lower sound than the one previously generated will be heard and the cursor will move down another line on the display:

```text
?SN Error
Ok
BEEP
Ok
SOUND 16000,100
Ok
█
Load "  Save "  Files  List  Run
```

> **REFERENCE:** To understand why the sound generated at this time was lower than that of the previous time, consult the BASIC Reference Manual.

### Space Bar

In the BASIC mode, characters are erased when the Space Bar spaces over them. The Space Bar can also be used to interconnect commands as a sentence of one line.

### Statement & Line

Here is a simple explanation about the difference between a statement and a line:

**STATEMENT** — The smallest unit consisting of a BASIC command, plus different parameters associated with the command. For example, (SOUND 10000,100, etc.).

**LINE** — A joining of statements as a group of commands. A maximum of 250 characters per line is permitted on the PC-8201. This is also called a "multi-statement".

### Colon

Up to now you have written lines with only one statement. Next you can work with an example where several statements are connected on the same line.

The colon is used to "delimit" (separate) multi-statements entered on the same line.

Your screen has various items on it, so clear it first by pressing the [CTRL] Key + "L". Input the following characters and press the [RETURN] Key:

```text
BEEP:SOUND2000,10:SOUND4000,20:SOUND8000
,40█

Load "  Save "  Files  List  Run
```

Several sounds will be generated and the "Ok" message will appear. The colon is used to link one statement with another. Also in this example there is no space between successive numerical values, so there is no need to be concerned about whether or not spaces are present between statements in a given line.

> **NOTE:** The comma shown is part of the "SOUND" command.

## Function Keys

### f.1/LOAD

SYNTAX:

```text
LOAD "<File Name> (,R)
```

FUNCTION:

Used to load a program file stored in the RAM into the memory of the PC-8201.

DESCRIPTION:

Programs are loaded into the memory from RAM by pressing the f.1 Function Key and entering (file name) in response to the prompt "Load from". If the "R" option is specified, the program will be executed immediately after loading.

After a LOAD command is executed, the word "WAIT" will blink until the word "Ok" is displayed. Using the LOAD command will overlay whatever was loaded previously into the memory.

Once a program has been loaded into the memory, it is available for modification or for execution.

### f.2/SAVE

SYNTAX:

```text
SAVE "<File Name> (,A)
```

FUNCTION:

Used to save BASIC programs in the RAM of the PC-8201.

DESCRIPTION:

This statement saves BASIC programs in the memory into a file designated with (file name). Press the f.2 Function Key and type (file name) and press the [RETURN] Key in response to the prompt "Save". When a file by that name already exists, the original file content is overwritten.

When the option "A" is specified, the program is saved in the ASCII format, and is then saved as a ".DO" TEXT file, instead of as a ".BA" BASIC file. When this option is not specified, the program is saved in Binary format. An ASCII SAVE requires more storage space than a Binary SAVE.

### f.3/FILES

SYNTAX:

```text
FILES
```

FUNCTION:

Used to list the name and type of all files for a particular memory bank in use.

DESCRIPTION:

This command displays the name and File Type registered in the current bank. File information will output to the screen when the f.3 Key is input (or type in the word "FILES" and press the [RETURN] Key).

The FILES command is usually used after the SAVE command has executed, to verify that the saved program is indeed in the RAM.

### f.4/LIST

SYNTAX:

```text
LIST <Line Number> <-Line Number>
```

FUNCTION:

Used to display all or part of a program currently in the memory, on the screen.

DESCRIPTION:

Before creating a new program, press the f.4 Function Key (or type the word "LIST" and then press the [RETURN] Key) to determine if another program is currently in the memory. If there is a program or data displayed on the screen, type the word "NEW" and then press the [RETURN] Key. The memory will be cleared and you can go ahead and type your program lines.

The LIST command is also used to list lines on the screen, allowing you to check them for accuracy.

The following table shows the lines that are listed on the screen, according to the (line number) entered:

<!-- FIGURE 6.1: LIST command line-number selection table — source page 112 (target: table) -->

| \<Line Number\> specified | Line Listed |
|---|---|
| None (default) | All |
| First \<Line Number\> only | Only that line |
| First \<Line Number\> and Hyphen | That line and all following |
| Hyphen and 2nd \<Line Number\> | First line to that line |
| First \<Line Number\> Hyphen 2nd \<Line Number\> | That range |

<!-- TODO(tier-b): verify LIST line-number table layout against source page 112 -->

### f.5/RUN

SYNTAX:

```text
RUN <Line Number>
RUN <"File Name">
```

FUNCTION:

Executes the program currently in the memory.

DESCRIPTION:

In the Program Mode, successive BASIC commands can be entered as units on a single line. These commands may be executed as a group (BASIC program) at any time by a RUN command.

The f.5 Key can be input to execute the RUN command if a program is currently in the memory. Input the word "RUN" to execute the command in all other described cases.

When (file name) is specified, after the RUN command is input, the program will first be loaded into the memory from the RAM. A blinking word "WAIT" is displayed during loading. The program is then executed after being loaded into the memory.

When (line number) is specified, the program is executed from that specified line (all other statements before that line are ignored). If (line number) is omitted, the program is executed from the first line of the program.

### f.6/EDIT

SYNTAX:

```text
EDIT <Line Number> <-Line Number>
```

FUNCTION:

Used to display a specified line for editing.

DESCRIPTION:

This function is used in the same manner as in the TEXT mode. The PC-8201 can switch directly from the BASIC mode into the TEXT Mode by pressing the f.6 Key ([SHIFT] and f.1), or by typing in "EDIT" and then pressing the [RETURN] Key.

> **NOTE:** When in the BASIC mode, you cannot switch to the EDIT function unless a file is in the memory.

The EDIT function is used to modify a program, either when program execution is stopped by using the [STOP] Key, or when an error occurs. The editing may begin at the line that caused the error.

> **REFERENCE:** The method for using the (line number) in EDIT is the same as the (line number) for the LIST command. Please refer to that section.

When (line number) is omitted, the EDIT function copies the complete file to a working area for editing. If (line number) is specified, it displays the specified line(s) for editing. EDIT also moves the cursor to the top left corner of the screen (home position) and switches the PC-8201 into the INSERT mode.

Press the f.6 Key and then the functions for the TEXT mode will appear. Press the f.6 Key again, and the line will not display any more. This additional blank line can be used for editing.

> **REFERENCE:** Refer to Chapter 7 for the use of the TEXT Function Keys and editing rules.

To leave EDIT and return to the BASIC mode:

1. Press the [ESC] Key twice, or

2. Press the f.10 Function Key ([SHIFT] and f.5).

The editing will be automatically saved. The blinking word "WAIT" is displayed upon returning to BASIC.

If the message "TEXT ILL-FORMED" is displayed, check the file syntax and format carefully.

### f.7/CONT

SYNTAX:

CONT

FUNCTION:

Restarts the execution of a program that was previously stopped.

DESCRIPTION:

The [STOP] Key, [SHIFT] + C Key, or the STOP statement in BASIC are used to halt program execution. Once stopped, investigation of a possible error can be achieved in the direct mode. The CONT command is then used to re-start (continue) the program. The program will resume execution where the halt occurred. To continue program execution simply press the f.7 Key ([SHIFT] and f.2) or input "CONT" and then press the [RETURN] Key.

The CONT command cannot be executed if the contents of the program have been altered after the STOP occurred.

### f.8/PRINT

SYNTAX:

PRINT ( Parameter )

FUNCTION:

Used to display output

DESCRIPTION:

The PRINT command is used to output data to the screen. It can also be operated in both the direct and program modes.

Before input of the ( parameter ) for PRINT command, you may do one of the following:

1. Press the f.8 Function Key ([SHIFT] and f.3).

2. Input the word "PRINT" and then [RETURN].

3. Input "?" as an abbreviated form.

The displayed position for the parameter value or character strings is determined by the type of punctuation (colon, semicolon, comma, etc.) that is used. If ( parameter ) is omitted, a line feed is issued (print all blanks and skip a line).

A colon ":" is used to delimit multi-statements on the same line:

SAMPLE:    Z=A+B:PRINT Z

In any PRINT statement, the ( parameter ) that is enclosed in the quotation marks (known as a character string) will be automatically output to a new line. A semicolon ";" inserted before a colon ":" will prevent the new line change:

SAMPLE:    PRINT "ABC";;PRINT "DEF"

The result will be "ABCDEF".

A comma "," is used in a PRINT statement to separate printed items into 14 unit widths:

SAMPLE:    PRINT "ABC",:PRINT "DEF"

The result will be "ABC(skips 11 blanks)DEF".

The comma is convenient to use when a table is to be created on the screen.

When using puctuation within the PRINT statement with a character string, you should take into consideration numeric constants, numeric variables, mathematical expressions, and letter variables.

> **REFERENCE:** Refer to the **BASIC Reference Manual** for details on the PRINT command.

### f.9/LIST.

SYNTAX:

LIST.

FUNCTION:

List last statement of a file.

DESCRIPTION:

This command is used to list the last statement of the file currently in the memory. Press the f.9 Function Key ([SHIFT] and f.4) to execute this command.

### f.10/MENU

SYNTAX:

MENU

FUNCTION:

Returns the PC-8201 to the MENU mode.

DESCRIPTION:

When in the BASIC mode, press the f.10 Function Key ([SHIFT] and f.5) or input the word "MENU" and then press the [RETURN] Key. This process will return the PC-8201 to the MENU mode.

### BASIC Sample Program:

This is a sample program that uses letters in the operation of the screen display. Letter variables and string functions could also be employed.

> **REFERENCE:** See the **BASIC Reference Manual** for an explanation of variables and string functions.

```basic
10 REM DISPLAY 1
20 CLS
30 A$="Ohhhh":N=1
40 FOR X=0 TO 32 STEP 8
50 LOCATE X,0
60 PRINT LEFT$(A$,N);
70 N=N+1
80 BEEP
90 NEXT X
100 END
```

<!-- FIGURE 6.2: Screen output of BASIC Sample Program showing progressive display "0  Oh  Ohh  Ohhh  Ohhhh" with function-key menu bar "Load "  Save "  Files  List  Run" — source page 121 (target: image) -->
