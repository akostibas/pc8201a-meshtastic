# Chapter 1: N82-BASIC Overview

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 11–19). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.

N82-BASIC has been designed to fully utilize the many features of the PC-8201 personal computer.  The language that is used is similar to many other forms of BASIC language.  In certain ways, it differs since the hardware features of the PC-8201 are different than those on other computers.

All of the hardware and software features of the PC-8201 are related to the N82-BASIC language:


## Internal and External Features

- Programmable Function Keys
- Real-time Clock
- Sound Generator
- Automatic Power Shut off
- Cassette recorder connector
- RS-232C interface connector
- Dot Matrix Printer connector
- Letter Quality Printer connector (same as above)
- Bar Code Reader connector
- SIO connectors
- Modem capability
- RAM Cartridges

For a computer of its size, the LCD screen of the PC-8201 can handle extremely high resolution graphics of 240 x 64 pixels (dots).  Graphics capability is utilized through programs written in N82-BASIC.

You can easily create and modify (edit) BASIC programs using the PC-8201's powerful screen editor.  You also have the option to write and edit programs while in the TEXT mode, and then load them into the BASIC mode of the PC-8201.  This TEXT feature is quite powerful and versatile.

Use of the PC-8201 for computer-to-computer communication through a telephone modem is accomplished effectively.  This is done by using the TELCOM software feature, along with BASIC operation instructions, such as ON COM GO SUB.

Large BASIC programs may be written with the PC-8201, since the memory is expandable to 96K bytes.  The PC-8201 comes equipped with 16K bytes of RAM installed, with one memory bank available for use.  Two other memory banks of 32K bytes each may be utilized if additional RAM chips or cartridges are installed in the unit.

The PC-8201 can store up to 21 different files in each memory bank.  This allows for 18 of your own customized files, along with the three primary files of BASIC, TEXT, and TELCOM.  These files can be accessed faster and easier than with a Disk Drive on other computers.

Battery power of the PC-8201 is conserved as efficiently as possible due to the Automatic Shut off feature.  This feature is operated by the POWER instruction, which is proprammed into the PC-8201.

Data stored within the RAM of the PC-8201 is protected from loss by a back up Power system.  This means that a minimal amount of battery power is used even when the power switch is turned OFF, allowing the files and programs stored in the RAM to remain intact.


## OPERATING MODES

The BASIC software feature of the PC-8201 has two operating modes, the Direct Mode and the Program Mode.  These operating modes are used when you are in the BASIC mode of the PC-8201.

As described in the PC-8201 User's Guide, the BASIC mode is entered by moving the cursor onto the word BASIC on the LCD screen:

<!-- FIGURE 1.1: LCD menu screen with cursor on "BASIC", showing date 1983/01/01 00:00:00, (C) Microsoft #1, and function-key labels Load/Save/Name/List/12374 — deferred to image/table pass, source page 13 (target: image) -->

After pressing the [ENTER] Key, the message "Ok" will be displayed:

<!-- FIGURE 1.2: BASIC startup screen showing "NEC PC-8201 BASIC Ver 1.0 (C) Microsoft / 12374 Bytes free / Ok" with cursor, and function-key labels Load "/Save "/Files/List/Run — deferred to image/table pass, source page 13 (target: image) -->

You can now utilize either the Direct Mode or the Program Mode of the BASIC feature.


## DIRECT MODE

The Direct Mode of BASIC allows an individual program statement, written in the N82-BASIC language, to be executed.  This is done by typing in the statement and then pressing the [ENTER] Key.  The statements used in the Direct Mode do not have a line number, and they must conform to syntax requirements of the N82-BASIC language.  The Direct Mode is useful for testing a particular statement.  You can then see if the statement acts as you expect it to, or if it performs a function correctly, without running an entire program or set of statements.

The variable of a statement used in the Direct Mode is "held" in the memory temporarily, while you are working with them.  They may be erased from the memory by typing NEW and then pressing the [ENTER] Key.  These statements cannot by "SAVED" in the RAM or external devices for future use.


## PROGRAM MODE

Statements used in the Program Mode must conform to command format requirements of N82-BASIC.  The Program Mode is entered simply by placing a line number, such as 10, 20, or 30, directly to the left of a program statement.

The line number and the statement can then be stored in the RAM.  This means that the numbered statement is "held" in the working memory.  This way, multiple statements can be written to create a program.  This differs from statements in the Direct Mode because those unnumbered statements cannot be "SAVED" in the RAM or on external devices, such as a Data Recorder.  Line numbers used in the Program Mode can range from 0 to 65529.

Once a program has been created, it can be executed by using a RUN command.  The PC-8201 returns to the Direct Mode after a program has ended.  This means that it switches back to the Direct Mode if a program finishes running normally, if a program terminates abnormally due to an error, or if the [STOP] Key is pressed while a program is running.

The PC-8201 is device independent, allowing all of your programming on the PC-8201 to be done without any peripheral devices attached.  All programs can be written, edited, run, and saved within the unit itself.  You have the option of attaching a Data Recorder for the purpose of saving your programs, but it is certainly not necessary.  You are not even required to attach a printer since the LCD screen displays your program for editing and modification.


## Getting Started with N82-BASIC

To begin using the N82-BASIC language, get the PC-8201 into the BASIC Mode.  Your screen should appear as illustrated:

<!-- FIGURE 1.3: BASIC startup screen showing "NEC PC-8201 BASIC Ver 1.0 (C) Microsoft / 12374 Bytes free / Ok" with cursor, and function-key labels Load "/Save "/Files/List/Run — deferred to image/table pass, source page 16 (target: image) -->

The "Ok" message with the flashing cursor appearing on the next line indicates that the PC-8201 is ready for use and is waiting for instructions from you.  The PC-8201 is now in the Direct Mode, meaning that you can enter system commands or statements.

When in the Direct Mode, commands and statements are always executed as soon as they are typed and the [ENTER] Key is pressed.

> **See Chapter 4 for a complete list of system commands.**

Statements can be entered using either the Direct or Program Mode.


## Using the Direct Mode

The Direct Mode of N82-BASIC allows an individual statement to be executed.  Statements used in the Direct Mode are typed without line numbers, and the [ENTER] Key is then pressed to execute the statement.

An example of using the Direct Mode:

Type in: INPUT "Radius of circle"; R [ENTER]

This statement causes the question: "Radius of circle?" to be printed on the screen, waiting for your answer to be input.  Input your choice and press the [ENTER] Key.  (For example press 5 then [ENTER] Key).

Type in: PRINT "Diameter = ";2\*R [ENTER]

This statement calculates the diameter of the circle and prints:

```text
Diameter = (result)
```

on the screen.  (For our example the result will be 10)

Type in: PRINT "Area = "; 3.14159\*R^2 [ENTER]

> **NOTE: 3.14159 is the value of π.**

This statement calculates the area of the circle and prints:

```text
Area = (result)
```

on the screen.  (For our example 78.5397 will be the result.)

Type in: PRINT "Circumference = ";2\*3.14159\*R [ENTER]

This statement calculates the circumference of the circle and prints:

```text
Circumference = (result)
```

on the screen.  (The direct mode will give 31.4159 as the result of our example.)

While in the Direct Mode, the PC-8201 prints an "Ok" message on the screen each time the [ENTER] Key is input at the end of the statement.

The Direct Mode is useful for testing particular statements, or for performing simple calculations.  Most program statements can be entered in the Direct Mode, but not all can be executed.  This is because some statements need to be executed in conjunction with other statements.

The PC-8201 retains the value of Radius (R) by holding it in a temporary working area of the memory.  Values will remain until a CLEAR or NEW command is used, the power switch is turned OFF, another program is executed or the value is redefined.

> **NOTE: Notice whenever you type NEW or CLEAR, the radius loses its value.**


## Using the Program Mode

Assume that you wanted to know the diameter, area and circumference of a circle with a different radius, then you would have to repeat the whole process described for the Direct Mode.  This is where the Program Mode comes in handy.

Type in the following:

```text
10 INPUT "Radius of circle";R
20 PRINT "Diameter = ";2*R
30 PRINT "Area = ";3.14159*R^2
40 PRINT "Circumference = ";2*3.14159*R
50 END
```

Now type RUN and press the [ENTER] Key.

If you type the program correctly the question "Radius of circle?" will appear on your screen.  Type in a radius value and press the [ENTER] Key.

Now you see the answers:

```text
Diameter = (result)
Area = (result)
Circumference = (result)
```

Congratulations, you have written your first program.  Now SAVE it in the RAM.  Press the f.2 Function Key and then type:

"RADIUS.BA" and press the [ENTER] Key.

Press the f.10 Function Key (hold [SHIFT] down and press f.5) to go to the MENU and you will see your program name among the other files.

> **NOTE: By pressing the [SHIFT] key, you change function keys f.1, f.2, f.3, f.4, f.5, to f.6, f.7, f.8, f.9, and f.10 respectively.  So, by holding down [SHIFT] and pressing f.5 you have entered the f.10 Function Key (MENU).**
