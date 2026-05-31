# Chapter 7: N82-BASIC Programming Aids

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 221–228). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

This chapter is designed to provide enough information to make programming easier for beginning programmers.  It will aid in the creation of your own programs, as well as helping to resolve problems within those programs.


## Recovery from Different Critical Situations


### Wrap Around and Screen Scrolling

SITUATION:

Scrolling occurs whenever characters are input on the bottom line of the screen, or the space between characters is not what is expected.

EXPLANATION:

The cursor in the BASIC Mode is described as a flashing box ■; its position is very important when you input or print on the screen display.

Wrap around is a process when characters continue on to the next line of the screen.  When characters are input past the 39th position of the current line, they are moved onto the first position of the next line.

- Wrap around occurs when a field longer than 40 characters is printed, or the semicolon ";" is used when printing more than one field on the same line with the total length over 40.

- When you print a field with less than 40 characters in length and the semicolon ";" is not used, the cursor skips to the beginning of the next line when the operation is completed.

Scrolling is the process when all of the lines of the screen display move up one line, with the top line moving off the screen and a new line appearing at the bottom.  Scrolling occurs if the cursor is at the last line and a wrap around is encountered.


### Spontaneous Program Execution Errors

SITUATION:

A program started to operate incorrectly but executed previously without any difficulty.

EXPLANATION:

In this situation, the program was somehow modified.  This primarily happens when a ".BA" file has been loaded and modified.  When programs are loaded into the temporary working area of the PC-8201, they can be modified and stored in the RAM or on external devices, such as a Data Recorder.

When a program is loaded from the RAM and needs modification, this program should be saved again in the RAM and not on external devices.  If a program is loaded from a cassette tape, do not save it in the RAM unless it is free of errors and operates the way it should.

When loaded files from tape are modified and then SAVEd in the RAM, the display of the file name includes an asterisk (*) after the file type extension, when the FILES command is used.  It is important to recognize that these modified programs may contain potential errors when attempting to LOAD the original file from tape, and the bad file can mistakenly be loaded.


### Logical Errors

SITUATION:

When the program result is different than expected.

EXPLANATION:

This type of situation is hard to resolve, because it is difficult to determine all the underlying causes.  You will have to go through your program statement by statement, and determine the operation of each statement.  By doing so, the logical flow of your program may be established.

You have to be persistent, because even if the program initially appears to be in order, it may actually have a problem at some point.  Keep in mind that the PC-8201 is executing your commands to the letter, exactly as they were input, and it will do exactly what you ask of it.

EXAMPLE:

Assume that you have the following program:

```text
20 DATA 10,13,2,5,6,33
30 FOR I=0 TO 5
40 READ A(I)
50 NEXT
60 FOR I=1 TO 6
70 B=B+A(I)
80 NEXY
90 PRINT B
```

In this program we want to add the numbers 10, 13, 2, 5, 6, and 33, and print the result of this calculation.  If you RUN the program, the result printed is 59, which is incorrect.  The logical error must be found, which is actually in statement 60.  Statement 20 defines values for 6 different numbers, with statement 30 reading the values of the numbers into statements 40 and 50.  The array is A, so A(0) will have the value of 10, A(1) a value of 13, A(2) a value of 2, etc.  Statements 60, 70 and 80 will add the values of A(1) through A(6) into B, and then statement 90 will print the value of B.

The logical error occurs in statement 60 because we add elements 1 to 6 instead of 0 to 5.  We do not add element 0 which has the value of 10, instead we add element 6 which has not been initialized, and therefore it has the value of zero.  In order to demonstrate this change statement 60 to read:

```text
60 FOR I = 0 TO 5
```

Type RUN and press the `RETURN` Key <!-- source shows a small unlabeled keycap graphic; identified as RETURN/ENTER from context --> and you will see that the result of 69 is now correct.


### Loss of Program Control

SITUATION:

The `STOP` Key is ineffective and you have no control over a program.

EXPLANATION:

In this situation you may have temporarily overlayed vital routines through the use of a POKE command or through your own Machine Language programs.  These vital routines include the information that the PC-8201 utilizes for its operation.

Files stored in the RAM are erased when this situation is encountered.  The only option you have at this point is to turn the power switch OFF.  When the power is turn ON again, no files are displayed on the MENU screen except the primary files of BASIC, TEXT, and TELCOM.

If the PC-8201 still does not operate correctly in some way, conducting a Cold Start is necessary.  To do this, press the `RETURN` Key <!-- source shows a small unlabeled keycap graphic; identified as RETURN/ENTER from context --> and the `SHIFT` Key simultaneously, while the Reset Switch on the back of the PC-8201 is pressed.  If necessary, refer to the User's Guide.


### Return to BASIC from TEXT is Impossible

SITUATION:

When editing a BASIC program within the TEXT Mode, it may be impossible to exit from this mode.

EXPLANATION:

In this situation, the message "Text ill-formed" is displayed on the screen whenever you try to exit and return to the BASIC or MENU Mode.  This happens because a statement within the program is longer than 255 characters, or the statement format is illegal.

The PC-8201 locks you out and pressing the `STOP` Key or the f.10 Function Key have no effect except to display the error message.  To resolve this problem, it is necessary to find the long statement and make it shorter, or re-format the statement.  Exit from the TEXT Mode should then be possible.


## Programming Hints


### Hints for Detecting Errors:

1. A flowchart (a chart depicting the course of program operations) should be carefully constructed.  This is especially useful when beginning programmers are suddenly confronted with a major error in the middle of a program.

2. The PC-8201 User's Guide and this N82-BASIC Reference Manual should be carefully read and you should understand and try out the commands and functions utilized by the PC-8201.

3. A chart of the variables you have assigned should be kept to avoid any duplication in the names of variables.

4. Make it a point to use extensive REM statements and avoid multiple statements as much as possible, which makes the program easy to understand when searching for errors.

5. If a particular line does not work at all, isolate it by means of a REM statement rather than eliminating it.  You can then easily modify it later.

6. Use a STOP statement to confirm any changes in the value of a variable.  A CONT command can be used during this process.


### Hints for Speeding Up Program Execution:

1. Spaces and REM statements should be eliminated.

2. Integer variables should be used whenever possible.

3. Omit a control variable designation within NEXT statements when possible.

4. Multiple statements should be used as much as possible.

5. Use the format A=0 at the beginning of a program for any frequently used variables.

6. Frequently used subroutines should be placed at the beginning of a program.

7. Make sure that the region for string use is adequate.

8. Try to simplify the process of frequently used loops.


### Hints for Saving Memory Space:

1. Use multiple statements whenever possible.

2. Remove spaces and REM statements from the program.

3. Constants should be held with a variable, no matter how many times a constant appears within a program.

4. Utilize old variables no longer being used within a program, instead of defining new variables.

5. When there are numerous situations where the same process is being conducted, consider ordering these by directing them through a single subroutine.

6. Any array variable used should be declared.  If it has not been declared it is automatically declared to 10.

7. Integer variables should be used whenever possible.

8. Keep the memory area reserved for strings to a minimum.
