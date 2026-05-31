# Chapter 4: N82-BASIC Instructions

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 59–211). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.
>
> This chapter is the alphabetical N82-BASIC instruction reference (ABS … XOR).
> It was OCR'd in six page-range segments and stitched in page order.
> Note: the original printing skips footer number 4-8 (page 4-7 / BLOAD is
> followed directly by 4-9 / BLOAD?); no content is missing — it is a
> pagination skip in the source. 153 physical pages span footers 4-1..4-154.

## ABS

**FUNCTION:** This function provides the absolute value of a number.

**FORMAT:**
```text
ABS( <numeric expression> )
```

**SAMPLE STATEMENT:** PRINT ABS(−8.+7.9)

**DESCRIPTION:** The ABS function is used to determine the absolute value of a `<numeric expression>`, e.g. without a "+" or "−" sign.

**SAMPLE PROGRAM:**
```text
10 FOR X=-3 TO 3
20 PRINT 'THE ABSOLUTE VALUE OF ';X;
   ' IS ';ABS(X)
30 NEXT X
40 END
```

## AND

**FUNCTION:** This logical operator is used to test multiple relational expressions.

**FORMAT:**
```text
<operand 1> and <operand 2>
```

**SAMPLE STATEMENT:** IF A=5 AND B=6 THEN 30

**DESCRIPTION:** And is a logical operator that performs tests on multiple relational expressions, bit manipulation, or Boolean operations. It returns either a non-zero (true) or zero (false) value.

For the conditional operation to be true, both `<operands>` must be true. If one or both is false, then the conditional operation is false. The table below indicates the evaluation process:

−1 AND −1→ −1 (TRUE AND TRUE → TRUE)

−1 AND 0 → 0 (TRUE AND FALSE → FALSE)

0 and −1 → 0 (FALSE AND TRUE → FALSE)

0 AND 0 → 0 (FALSE AND FALSE → FALSE)

> **For more details on logical operations and relational expressions see Chapter 3.**

**NOTE:** Logical operators work by converting their `<operands>` to sixteen bits binary integers. Therefore, the `<operands>` must range from −32768 to +32767. If operands are not within this range, an "?OV Error" (Overflow) message will appear on the screen.

**SEE ALSO:** Functions NOT, OR, XOR, EQV, IMP, and Chapter 3.

**EXAMPLE:**

| INTEGER | BINARY BITS        |
|---------|--------------------|
| 15      | 0000 0000 0000 1111 |
| 14      | 0000 0000 0000 1110 |

After you input the statement PRINT 15 AND 14, the integer 14 appears on the screen, whose binary representation is 0000 0000 0000 1110. By looking at the above table in the DESCRIPTION section, notice that the computation is correct.

**SAMPLE PROGRAM:**
```text
10 A=5: B=6:C=7
40 IF A=5 AND C=6 THEN 70
50 PRINT ' A IS NOT 5, OR B IS NOT 6'
70 IF A=5 AND C>6 THEN 90
80 PRINT 'A IS NOT 5, OR C IS NOT GREATER
   THAN 6'
90 PRINT 'A IS 5,  B IS 6,  AND C IS
   GREATER THAN 6'
100 END
```

## ASC

**FUNCTION:** This function provides the ASCII value of a character.

**FORMAT:**
```text
ASC( <string> )
```

**SAMPLE STATEMENT:** PRINT ASC("AB")

**DESCRIPTION:** The ASC function determines the ASCII code of a character, or the ASCII code of the first character in the specified `<string>`. If the `<string>` is null (an empty string) the "?FC Error" (Illegal function call) message will be displayed on the screen.

> **For more detail on ASCII codes see the Table of Character Codes.**

**SEE ALSO:** The CHR$ function and Table of Character Codes.

**SAMPLE PROGRAM:**
```text
10 PRINT 'THE ASCII VALUE OF D IS':
   ASC('D')
20 PRINT ' THE ASCII VALUE OF DAY IS
   ALSO';ASC('DAY')
30 PRINT 'PRESS ANY KEY TO CONTINUE...'
40 IF INKEY$='' THEN 40
60 FOR X=32 TO 122
70 PRINT 'THE ASCII VALUE OF ';CHR$(X);'
   IS';ASC(CHR$(X))
80 NEXT X
```

## ATN

**FUNCTION:** This function provides the inverse tangent.

**FORMAT:**
```text
ATN( <numeric expression> )
```

**SAMPLE STATEMENT:** PRINT ATN(.05)

**DESCRIPTION:** The ATN function, used in trigonometric applications, computes the inverse tangent (arc tangent) of an angle. The `<numeric expression>` is the angle expressed in radians, not in degrees.

The value obtained is within a range from −π/2 to π/2 (−90 to +90 degrees).

**NOTE:** To convert values from degrees to radians multiply the degrees by .0174533. To convert values from radians to degrees multiply the radians by 57.29578.

**SEE ALSO:** TAN, COS, and SIN functions.

**SAMPLE PROGRAM:**
```text
10 FOR I=1 TO 5
20 PRINT 'ENTER THE TANGENT OF AN ANGLE'
30 INPUT R
40 PRINT 'THE ANGLE IS ';ATN(R);'
   RADIANS, WHICH IS ';ATN(R)*57.2958;
   'DEGREES'
50 NEXT
```

## BEEP

**FUNCTION:** This command is used to generate a "BEEP" sound from the PC-8201.

**FORMAT:**
```text
BEEP
```

**SAMPLE STATEMENT:** BEEP

**DESCRIPTION:** The duration of the beep is approximately 0.12 second.

**NOTE:** The BEEP has no parameter.

The statement PRINT CHR$(7) has the same function as the BEEP command.

**SEE ALSO:** The SOUND command.

**SAMPLE PROGRAM:**
```text
10 FOR I=0 TO 6
20 READ W:BEEP
30 FOR J=0 TO W:NEXT J
40 NEXT I
50 DATA 10,100,10,10,100,300,100,100
```

## BLOAD

**FUNCTION:** This system command is used to load a Machine Language file into the memory.

**FORMAT:**
```text
BLOAD "{ <external device name> :} <file name>"
```

**SAMPLE STATEMENTS:**
```text
BLOAD "MACHLG"
BLOAD "CAS:HEXCAL"
```

**DESCRIPTION:** The BLOAD command loads a Machine Language program file specified by `<file name>` into the memory. The PC-8201 loads a Machine Language file from RAM if `<external device name>` is omitted.

Loading is not possible if a file in RAM is written via the BSAVE command without the file type. However, file type may be omitted when the actual loading process is executed.

If an execute start address is designated when a ".CO" file is created, this ".CO" file is executed as a subroutine immediately after it is loaded. Therefore, an additional EXEC statement is not required after a ".CO" file is loaded.

The PC-8201 returns to BASIC from the subroutine by using a RET Machine Language instruction. It loads from a data recorded if "CAS:" is designated for `<external device name>`. The PC-8201 loads the first file it locates if `<file name>` is omitted.

The SHIFT and STOP Keys can be pressed simultaneously to interrupt the execution of a BLOAD "CAS:" command.

<!-- NOTE: page 4-8 (SEE ALSO and any remaining BLOAD content) is absent from the scan — PDF pages p-065 (footer 4-7) and p-066 (footer 4-9) are consecutive files; page 4-8 appears to have been skipped during scanning. -->

## BLOAD?

**FUNCTION:** This system command is used to compare/verify a Machine Language program currently in the memory with another program saved on cassette tape.

**FORMAT:**
```text
BLOAD? "{ <external device name> :} <file name>"
```

**SAMPLE STATEMENT:** .BLOAD? "CAS:MACHLG"

**DESCRIPTION:** A Machine Language program in the memory and another Machine Language program on cassette tape can be compared and verified. This process is used to determine if a program file has been saved properly.

Execute a BLOAD? "( CAS:file name )" command only when a data recorder is connected to the PC-8201. If the content of both programs are identical, the PC-8201 displays an "Ok" message. Otherwise, if any error has occurred during the load process, the PC-8201 will output the message "BAD" and execution is terminated.

The BLOAD? command should be used immediately after the BSAVE command is executed.

The SHIFT and STOP Keys can be pressed at the same time to interrupt the execution of a BLOAD? "CAS:" command.

## BSAVE

**FUNCTION:** This command is used to save a Machine Language program from the memory in a designated file.

**FORMAT:**
```text
BSAVE "{ <external device name> :} <file name>", <start address>, <length>  {, <execute start location> }
```

**SAMPLE STATEMENTS:**
```text
BSAVE "MACHLG" ,61000,256
BSAVE "CAS:MACHLG" ,61000,256
```

**DESCRIPTION:** The BSAVE command saves a Machine Language program or the contents of memory to a file designated by `<file name>`. The number of bytes specified by `<length>` is saved as the Machine Language program beginning at `<start address>`. This program may use BSAVE and BLOAD only if it can be executed from `<start address>` (execution entry point).

The PC-8201 saves a Machine Language file from RAM if `<external device name>` is omitted. When device name is specified, "CAS:" is designated for data recorder.

If an `<execute start location>` option is designated, the contents can be stored as a ".CO" file. It is executed as a Machine Language subroutine when it is loaded via the BLOAD statement.

The `<file name>` cannot be omitted. In the sample statement, the contents are saved from memory location 61000 to 61255.

The SHIFT and STOP Keys can be pressed simultaneously to interrupt the execution of a BSAVE "CAS:" command.

**SEE ALSO:** The BLOAD commands and the chapters on Files and Machine Language programming.

## CDBL

**FUNCTION:** This function converts integers or Single Precision real numbers to Double Precision real numbers.

**FORMAT:**
```text
CDBL( <numeric expression> )
```

**SAMPLE STATEMENT:** PRINT CDBL(454.67)

**DESCRIPTION:** The CDBL function converts the `<numeric expression>` to a Double Precision real number without changing the effective number of digits.

**NOTE:** Refer to Type Conversion in Chapter 3.

**SEE ALSO:** The CINT and CSNG functions.

**SAMPLE PROGRAM:**
```text
10 DEFDBL D
20 A%=875
30 B1=45.3442
40 D1=CDBL(A%)
50 D2=CDBL(B1)
60 PRINT A%;TAB(20);D1
70 PRINT B1;TAB(20);D2
80 END
```

## CHR$

**FUNCTION:** This function allows the PC-8201 to change a single value ASCII code to its matching character.

**FORMAT:**
```text
CHR$( <numeric expression> )
```

**SAMPLE STATEMENT:** A$=CHR$(65)

**DESCRIPTION:** This function returns a character specified by `<numeric expression>`. The ASCII character code represented by `<numeric expression>` can correspond to a letter, number, or any special character. The value of the `<numeric expression>` must be within a range between 0 and 255, or an "?FC ERROR" (illegal function call) message will be displayed.

Real numbers may be included in the `<numeric expression>` but the value is rounded off to the decimal point.

**SEE ALSO:** The ASC function, and the Table of Character Codes.

**SAMPLE PROGRAM:**
```text
10 FOR I=0 TO 28
20 READ C:PRINT C;' = ';CHR$(C):NEXT
30 DATA 36,32,130,68,79,94,100,125
40 DATA 95,63,129,64,85,80,102,126
50 DATA 33,122,111,125,99,81,38,55,96
60 DATA 117,37,63,77
```

## CINT

**FUNCTION:** This function converts Single or Double Precision real numbers to integers.

**FORMAT:**
```text
CINT( <numeric expression> )
```

**SAMPLE STATEMENT:** CINT (4578)

**DESCRIPTION:** The CINT function rounds off (truncates) the value of the `<numeric expression>` and returns an integer.

An "?OV Error" (Overflow) message is displayed if the `<numeric expression>` is not between −32768 and +32767.

**SEE ALSO:** The CDBL, CSNG, FIX, and INT functions.

## CLEAR

**FUNCTION:** This statement is used to reset all variables to null or zero, and to establish the size of a string region and set the memory boundary.

**FORMAT:**
```text
CLEAR { <string area size> }  {, <maximum memory used in BASIC> }
```

**SAMPLE STATEMENT:** CLEAR 300,60000

**DESCRIPTION:** This statement initializes all numeric variables to zero and string variables to null string. If designated parameters are omitted, the previous value is preserved.

Designate only the first parameter if large character string arrays are used, or a large number of character string operations are performed. The second parameter sets the maximum memory used for BASIC and maintains memory chapacity used for Machine Language programs.

In the sample statement given above, the maximum memory specified is 59999, thus a Machine Language program can be placed between the area from 60000 to 62335. The locations beyond 62337 cannot be designated because they are reserved for the PC-8201.

**NOTE:** When both parameters are omitted, only the initialization of the variables is executed and the establishment of memory location remains unchanged. The string region is altered if the first parameter is specified. The establishment of a region in the memory is not altered until a new CLEAR statement is executed. Therefore, if a large string region is not secured in the program, an "?OS Error" (Out of String space) error message can occur during execution.

When a CLEAR statement is executed, any data in the PASTE buffer will be erased.

**SEE ALSO:** The BLOAD, EXEC, and DIM commands.

**SAMPLE PROGRAM:**
```text
10 A$='ATW':B=486:C=7111
20 PRINT 'A$=';A$;'   B=';B;'C=';C
30 PRINT 'CLEAR !' :BEEP
40 CLEAR
50 PRINT 'A$=';A$;'   B=';B;'C=';C
```

## CLOAD

**FUNCTION:** This system command is used to load a recorded program from cassette tape into the memory.

**FORMAT:**
```text
CLOAD "< file name >"
```

**SAMPLE STATEMENT:** CLOAD "DEMO"

**DESCRIPTION:** If a `<file name>` is specified, the PC-8201 will retrieve that program file from the cassette tape and load it into memory. However, when a `<file name>` is not specified, the PC-8201 loads the first program encountered from the cassette tape. A maximum of six characters can be used for the `<file name>`.

When a specific file is being searched, the system outputs a "SKIP: `<file name>`" message during the searching process. The PC-8201 will continue to scan the cassette tape until it finds the specific file, at which time it outputs a "FOUND" `<file name>` message. An "Ok" message is displayed when the loading process is completed.

If the remote lead of the cassette cable is properly connected to the Data Recorder, the PC-8201 can automatically turn the recorder ON and OFF during the LOAD process.

**NOTE:** If `<file name>` exceeds 6 characters (not including the file type extension), or if a `<file name>` does not exist on tape, the CLOAD command will search for the file name until the end of the tape is reached.

Even after an "Ok" message has appeared, it is possible that this loaded program may not operate properly, and may be due to improper set up of the Data Recorder.

The CLOAD process can be interrupted by pressing both the SHIFT and STOP Keys simultaneously.

**SEE ALSO:** The CSAVE, BLOAD, BLOAD?, BSAVE, NEW, LOAD, CLOAD?, and SAVE commands.

## CLOAD?

**FUNCTION:** This system command is used to compare/verify the program currently in memory with another program saved on cassette tape.

**FORMAT:**
```text
CLOAD? "< file name >"
```

**SAMPLE STATEMENT:** CLOAD? "DEMO"

**DESCRIPTION:** The CLOAD? command is used to verify whether a previously CSAVED program matches with the program currently residing in the memory. The `<file name>` refers to the program recorded on tape. If the content of both programs is the same the system displays "Ok", but if the programs are not identical, the system displays "BAD" and execution is terminated.

This verification is useful to check that the program in the memory has been recorded correctly to tape. The CLOAD? command is normally used immediately after the CSAVE command.

**SEE ALSO:** The CSAVE, CLOAD, BLOAD, BLOAD?, BSAVE, NEW, LOAD, and SAVE commands.

## CLOSE

**FUNCTION:** This statement is used to close files.

**FORMAT:**
```text
CLOSE { { # } <file number> } { ,{{#},file number} } ...
```

**SAMPLE STATEMENTS:**
```text
CLOSE
CLOSE #1,#2
```

**DESCRIPTION:** This statement is used to terminate input/output between a BASIC program and the data file(s). It closes the file corresponding to `<file number>`. These files are closed simultaneously if more than one `<file number>` is specified. All currently opened files are closed if `<file number>` is omitted.

Input/Output for a closed file is again possible if it is reopened by a specified file number.

The CLOSE command writes out all data remaining in the file buffer. These files must be closed in order to correctly terminate file output.

**SEE ALSO:** The OPEN, END, and NEW commands.

## CLS

**FUNCTION:** This statement erases the display screen.

**FORMAT:**
```text
CLS
```

**SAMPLE STATEMENT:** CLS

**DESCRIPTION:** The CLS statement clears all alphanumeric characters and graphics characters from the display screen. However, when the second parameter (Function key display switch) in the SCREEN statement is "1" (means it is ON), only the contents of the Function keys will remain on display.

**NOTE:** This statement has no parameter.

**SAMPLE PROGRAM:**
```text
10 FOR I=0 TO 40
20 X=RND(1)*35:Y=RND(1)*7
30 XP=RND(1)*240:YP=RND(1)*64
40 PSET(XP,YP)
50 LOCATE X,Y:PRINT 'GARBAGE';
60 NEXT
70 LOCATE 0,0:INPUT'HIT RETURN TO CLEAR
   THE DISPLAY'; C$
80 CLS
```

## COM ON/OFF/STOP

**FUNCTION:** This command establishes, prohibits, or informs of interruption by a data transmission circuit.

**FORMAT:**
```text
COM  ON
     OFF
     STOP
```

**SAMPLE STATEMENT:** COM ON

**DESCRIPTION:** The COM command informs BASIC that data that is being input from an external device through the communication port (the RS-232C circuit) may occur.

The COM ON command establishes the possibility of a BASIC program being interrupted by data, from a data transmission circuit. Interruption by the communications may then occur after this command is executed. The BASIC programming flow will then be diverted as a process routine designated by an ON COM GOSUB statement.

The COM OFF prohibits a BASIC program from being interrupted by communications input.

The COM STOP signals BASIC to inform of the occurrence of data, from a data transmission circuit. No divirsion to any proces routine will occur after this command is executed through the signal of the occurrence of the transmission is retained. After a subsequent COM ON command, diversion occurs to the ON COM GOSUB process routine.

**SEE ALSO:** The ON COM GOSUB command.

## CONT

**FUNCTION:** The CONT command restarts the execution of a program that was interrupted, either by the STOP statement, or the pressing of the STOP Key.

**FORMAT:**
```text
CONT
```

**SAMPLE STATEMENT:** CONT

**DESCRIPTION:** This command is normally used in conjunction with the STOP Key (or the CTRL + C Keys) to debug a program. The CONT command is used to re-start the program after variable values, statements, etc., have been investigated in the Direct Mode. A complete program can also be listed on the screen when execution is interrupted.

By input of the CONT command or pressing the f.7 Function Key ( SHIFT and f.2), the program will resume execution where the half occurred. If the program has been altered while execution is stopped, then execution cannot be continued using this command.

## COS

**FUNCTION:** This function provides the cosine of an angle.

**FORMAT:**
```text
COS( <numeric expression> )
```

**SAMPLE STATEMENT:** PRINT COS(3.14159)

**DESCRIPTION:** The COS function is used in trigonometric applications, it computes the cosine of an angle. The unit of the `<numeric expression>` is the angle expressed in radians.

**NOTE:** To convert an angle from degrees to radians multiply the degrees by .0174533.

**SEE ALSO:** SIN, TAN, and ATN functions.

**SAMPLE PROGRAM:**
```text
10 INPUT'ENTER AN ANGLE EXPRESSED IN
   DEGREES';D
20 PRINT 'THE ANGLE EXPRESSED INRADIANS
   IS ';D*.0174533;' AND ITS COSINE IS'
   ;COS(D*.0174533)
30 END
```

## CSAVE

**FUNCTION:** This system command is used to save a copy of the program on cassette tape.

**FORMAT:**
```text
CSAVE "< file name >"
```

**SAMPLE STATEMENT:** CSAVE "DEMO"

**DESCRIPTION:** This command saves a program currently in the memory onto cassette tape. The file name is specified using 6 characters or less. The PC-8201 will return to Direct Mode after the CSAVE command has been executed.

**NOTE:** Please refer to BSAVE and SAVE commands in regard to saving ".CO" and ".DO" files (ASCII code format) respectively.

A program file cannot be SAVEd to RAM once it has been shifted to the BASIC area by using a LOAD command. This is due to the fact that any modifications to the MENU-displayed program that is LOADed into BASIC automatically updates the program showed in the MENU. The LIST command should be used for final inspection before a CSAVE (to cassette tape) command is executed.

If interruption is necessary during the execution of a CSAVE command, press the SHIFT Key and the STOP Key at the same time.

**SEE ALSO:** The CLOAD, SAVE, LOAD, BSAVE, and BLOAD commands.

## CSRLIN

**FUNCTION:** The CSRLIN function determines the line of the current cursor position, and returns a line number.

**FORMAT:**
```text
CSRLIN
```

**SAMPLE STATEMENT:** PRINT CSRLIN

**DESCRIPTION:** The CSRLIN (cursor line) function returns the line of the current cursor position (vertical position).

The top line of the screen is always "0". Therefore, the value that is returned will be within the range from 0 to the number of lines of the screen minus 1. The number of the lines of the screen is either 7 or 8, depending on the mode. If the cursor is on the last line of the screen the CSRLIN function will return 6 or 7 as the result, depending on the mode.

**SEE ALSO:** The POS function.

**SAMPLE PROGRAM:**
```text
10 CLS
20 PRINT 'LINE 1 IS USED AS CURSOR
   LINE:';CSRLIN
30 LOCATE 1,1:PRINT 'LINE 2 IS USED AS
   CURSOR LINE:';CSRLIN
40 LOCATE 2,2:PRINT 'LINE 3 IS USED AS
   CURSOR LINE:';CSRLIN
50 LOCATE 3,3:PRINT 'LINE 4 IS USED AS
   CURSOR LINE:';CSRLIN
60 LOCATE 4,4:PRINT 'LINE 5 IS USED AS
   CURSOR LINE:';CSRLIN
70 LOCATE 5,5:PRINT 'LINE 6 IS USED AS
   CURSOR LINE:';CSRLIN
80 LOCATE 6,6:PRINT 'LINE 7 IS USED AS
   CURSOR LINE:';CSRLIN
90 LOCATE 7,7:PRINT 'LINE 8 IS USED AS
   CURSOR LINE:';CSRLIN
100 LOCATE 8,8
110 END
```

## DATA

**FUNCTION:** This statement holds the constants which are loaded into the variables with a READ statement.

**FORMAT:**
```text
DATA <constant> {, <constant> } ...
```

**SAMPLE STATEMENT:** DATA 1, CBA,1465

**DESCRIPTION:** The DATA statement is used to define information to the READ statement, and it can be inserted anywhere in the program. A program can have as many DATA statements as needed with no more than 255 characters on each data line.

READ statements input constants from DATA statements, starting from the DATA statement with the smallest line number. However, the order can be revised with the RESTORE statement.

Arithmetic expressions used for reading in numeric constants are not permitted in DATA statement. Constants are separated by commas on the data line. Their types should match the corresponding variable types in the READ statement. Numeric constant type is converted into numeric variable type if the numeric types do not match. String constants are not type converted, so they must be read into a string variable.

When a string data element includes significant spaces (leading or trailing) or embedded commas, it must be enclosed in double quotation marks.

**SEE ALSO:** See the READ and RESTORE commands.

**SAMPLE PROGRAM:**
```text
10 CLEAR 256:DIM A$(5),A(5):CLS
20 FOR I=0 TO 5
30 READ A$(I),A(I)
40 NEXT I
50 FOR I=0 TO 5
60 LOCATE A(I),I:PRINT A$(I)
70 BEEP:NEXT I
80 LOCATE 0,0
90 DATA THIS,5,IS,11,HOW,16,TO,21,USE,25,
               DATA,30
100 END
```
## DATE$

**FUNCTION:** This function provides the data from the internal real-time clock of the PC-8201.

**FORMAT:**
```text
DATE$="(year)/(month)/(day)"
```

**SAMPLE STATEMENTS:**
```text
DATE$="83/05/05"
PRINT DATE$
```

**DESCRIPTION:** The DATE$ function is used to set year, month, and day. The values for (year), (month), and (day) are designated for the current date, or any desired date.

Once the date has been set correctly, reset of the date again is not necessary, unless a Cold Start has been performed.

**NOTE:** The (year) value must be re-designated when the year advances because the timer repeats the same year again.

**SEE ALSO:** The TIME$ function.

---

## DEFINT/SNG/DBL/STR

**FUNCTION:** This command defines the format of a variable.

**FORMAT:**
```text
DEF  INT  <character range>
     SNG
     DBL
     STR
```

**SAMPLE STATEMENT:**
```text
DEFINT A,I-K
```

**DESCRIPTION:** By using the DEFINT statement, a variable name that begins with a character designated by a `<character range>` can be designated as integer type.

In Single Precision real number format a DEFSNG statement is used, in Double Precision real number format a DEFDBL statement is used, or in string format a DEFSTR statement is used.

Only one character may be used to specify each variable name, with its range designated in character range. The range is indicated by joining the characters with a hyphen if contiguous characters are to be specified. (i.e. DEFINT X, Y, Z can be entered as DEFINT X–Z).

Variable names followed by type declaration characters are given priority over variable names type-designated by the DEF statement. All variables starting with characters which have not been type designated by a DEF statement are assumed to be Single Precision type.

**SAMPLE PROGRAM:**
```text
10 DEFINT A-J,L:DEFSNG N-T
20 DEFDBL U-W:DEFSTR S,X-Z
30 A=53.9314558#:T=53.9314558#
40 W=53.9314558#:SE='  END'
50 PRINT A,T,W,SE
```

---

## DIM

**FUNCTION:** The DIM (Dimension) statement is used to allocate memory space for storing an array.

**FORMAT:**
```text
DIM <variable name> (<max subscript value>
    {,<max subscript value> ...})
```

**SAMPLE STATEMENT:**
```text
DIM A(12,2)
```

**DESCRIPTION:** This statement allocates memory space for the array area and sets the maximum subscript values for array variables. When an array variable is used and the DIM statement is not defined, the maximum subscript value is set at 10. Any reference to an array beyond the allocated size will display a "?BS Error" (subscript out of range) message.

If the same array is defined more than once, a "?DD Error" (duplicate definition) message will be displayed. By executing the CLEAR statement this problem can be eliminated.

The minimum subscript values is set at 0. For instance, if the array A is dimensioned A(3), four elements are in the array with subscripts of 0, 1, 2, and 3.

**SEE ALSO:** Array variables.

**SAMPLE PROGRAM:**
```text
10 PRINT 'RND (1) 20 TIMES AND SORT THESE
   NUMBERS'
20 DIM R(19)
30 FOR I=0 TO 19:R(I)=RND(1):NEXT I
40 FOR I=0 TO 18:L=R(I):N=I
50 FOR J=I+1 TO 19
60 IF R(J)<L THEN L=R(J):N=J
70 NEXT J:T=R(I):R(I)=L:R(N)=T
80 NEXT I
90 FOR I=0 TO 19
100 PRINT USING "#.######";R(I);
110 NEXT I
```

---

## EDIT

**FUNCTION:** This command shifts the PC-8201 from BASIC mode into TEXT mode.

**FORMAT:**
```text
EDIT {<line in which to start eidting>}
     {-<line in which to stop editing>}
```

**SAMPLE STATEMENT:**
```text
EDIT 20-80
```

**DESCRIPTION:** The command shifts into TEXT mode and allows program editing. If parameter is not designated for editing, the entire program text is open for editing. Other combinations are also allowed.

| Parameter Specified | Line(s) Edited |
|---|---|
| No parameter specified | All |
| First parameter only | Only that line |
| First parameter and hyphen | That line and all following |
| Hyphen and second parameter | First line to the second line specified by that parameter |
| First parameter, hyphen, and second parameter | The range of the two parameters |

**SEE ALSO:** Program Editing.

---

## END

**FUNCTION:** The END statement is used to terminate program execution.

**FORMAT:**
```text
END
```

**SAMPLE STATEMENT:**
```text
END
```

**DESCRIPTION:** This command terminates program execution, closes all files, and returns the PC-8201 to Direct Mode.

The END statement is inserted into the program at the location(s) at which it terminates program execution. The final END statement may be omitted in a program, but files are not closed.

**SEE ALSO:** The STOP and CLOSE commands.

**SAMPLE PROGRAM:**
```text
10 PRINT 'HIT ANY KEY'
20 IF INKEY$='' THEN 20
30 CLS:LOCATE 1,3
40 FOR I=0 TO 10:READ S,L,P$
50 PRINT P$;'  '::SOUND S,L:NEXT
60 END
70 PRINT 'THIS SECTION CANNOT BE
   EXECUTED.'
80 DATA 11172,16,THIS,11172,32,IS,
   11172,16,THE,11172
90 DATA 64,END,0,32,,,9394,32,MY,9952,
   32,ONLY,12538
100 DATA 32,FRIEND,11172,48,,,9394,16,,,
    11172,64,,
```

---

## EOF

**FUNCTION:** This function determines if the end of a sequential file is reached.

**FORMAT:**
```text
EOF(<file number>)
```

**SAMPLE STATEMENT:**
```text
IF EOF(3) THEN CLOSE #1 ELSE GOTO 100
```

**DESCRIPTION:** The EOF (End Of file) function determines if an end of a sequential file, designated by the `<file number>`, is reached.

The function returns a non-zero (true) value if the end is reached, and it returns a zero (false) value if the end has not been reached yet.

**SAMPLE PROGRAM:**
```text
20 OPEN 'TSTEOF' FOR OUTPUT AS #1
30 INPUT'HOW MANY TIMES DO YOU WANT TO
   WRITE IN DATA';N
40 FOR I=1 TO N
50 PRINT #1,I;
60 NEXT
70 CLOSE
80 OPEN 'TSTEOF' FOR INPUT AS #1
90 IF EOF(1) THEN PRINT 'END OF FILE HAS
   BEEN REACHED':END
100 INPUT#1,N
110 GOTO 90
```

---

## EQV

**FUNCTION:** This logical operator tests multiple relations.

**FORMAT:**
```text
<operand 1> EQV <operand 2>
```

**SAMPLE STATEMENT:**
```text
PRINT 5 EQV 6
```

**DESCRIPTION:** The EQV (Equivalence) logical operator performs tests on multiple relations, Boolean operations, and bit manipulation. It returns either a non-zero (true) value or zero (false) value.

For the operation to be true both `<operand 1>` and `<operand 2>` must be true, or both of them must be false. But if one of them is true and the other is false then a zero (false) value is returned.

The following table indicates the evaluation process:

```text
-1 EQV -1 -> -1 (TRUE EQV TRUE -> TRUE)

-1 EQV 0 -> 0 (TRUE EQV FALSE -> FALSE)

0 EQV -1 -> 0 (FALSE EQV TRUE -> FALSE)

0 EQV 0 -> -1 (FALSE EQV FALSE -> TRUE)
```

> **For more details on logical operators see Chapter 3.**

**NOTE:** EQV performs exactly opposite to XOR. Logical operators convert their `<operands>` to sixteen bit binary integers. Therefore, each `<operand>` must be in the range from −32768 to +32767. If they are not within this range, an "?OV Error" (Overflow) message will be displayed.

**SEE ALSO:** Functions AND, IMP, NOT, OR, XOR, and Chapter 3.

**EXAMPLE:**

| INTEGER | BINARY BITS |
|---|---|
| 234 | 0000 0000 1110 1010 |
| 3429 | 0000 1101 0110 0101 |

After you input the statement PRINT 234 EQV 3429 the integer −3472 is returned, whose binary is 1111 0010 0111 0000. By looking at the table under DESCRIPTION notice that the computation was done correctly.

---

## ERL

**FUNCTION:** The ERL function provides the line number where an error occurs.

**FORMAT:**
```text
ERL
```

**SAMPLE STATEMENT:**
```text
A=ERL
```

**DESCRIPTION:** The ERL function is a Reserved variable used in the error processing routine. It is used for displaying the line location of an error. It has the value of 65535 if an error occurs in the Direct Mode.

The content of ERL changes each time an error occurs during program execution. The value of ERL can be accessed, but the values cannot be assigned.

**NOTE:** The ERL function has no parameters.

**SEE ALSO:** See the ON ERROR GOTO and ERROR statements.

---

## ERR

**FUNCTION:** The ERR function provides the error code when an error occurs.

**FORMAT:**
```text
ERR
```

**SAMPLE STATEMENT:**
```text
B=ERR
```

**DESCRIPTION:** When errors occur in the Direct Mode or during program execution, a message is displayed to indicate the cause of an error. Each error message is associated with a different error code.

The ERR function is a Reserved variable which contains the error code when an error is detected. The content of ERR can be accessed but the values cannot be designated. The PC-8201 assigns ERR when an error occurs.

**NOTE:** The ERR function has no parameter.

**SEE ALSO:** See the ON ERROR GOTO and ERROR statements.

---

## ERROR

**FUNCTION:** The ERROR statement is used to simulate the occurrence of an existing error.

**FORMAT:**
```text
ERROR <integer>
```

**SAMPLE STATEMENT:**
```text
ERROR 200
```

**DESCRIPTION:** The value designated for `<integer>` must be between 0 and 255. When a specified value has been defined as a BASIC error code, the ERROR statement simulates the occurrence of that error and prints the corresponding message.

The ERROR statement may be used as a user-defined or undefined error code. When under particular conditions, the program branches to an error routine specified with the ON ERROR GOTO statement.

**SEE ALSO:** The ON ERROR GOTO and the ERL/ERR functions, and the Table of Error Codes.

**SAMPLE PROGRAMS:**
```text
20 ON ERROR GOTO 500
30 A=1/0
40 GOTO 0
50 NEXT
60 PRINT SQR(-2)
70 ERROR 255
80 END
500 PRINT'ERROR' ERR 'IN LINE NUMBER' ERL
510 IF ERR=11 THEN PRINT 'A DIVISION BY
    ZERO';
520 IF ERR=8 THEN PRINT'AN UNDEFINED
    LINE NUMBER';
530 IF ERR=1 THEN PRINT'NEXT WITHOUT FOR
    ';
540 IF ERR=5 THEN PRINT'AN ILLEGAL
    FUNCTION CALL';
550 IF ERR=255 THEN PRINT'AN UNDEFINED';
560 PRINT ' ERROR HAS OCCURED.':PRINT
570 RESUME NEXT
```

---

## EXEC

**FUNCTION:** This statement executes a Machine Language subroutine.

**FORMAT:**
```text
EXEC <initial location>
```

**SAMPLE STATEMENT:**
```text
EXEC 61000
```

**DESCRIPTION:** The EXEC statement transfers control to a Machine Language subroutine in the memory. The `<initial location>` is designated by integers from 33468 to 65535. A negative number, if used for `<initial location>` should be subtracted from 65536 (thus a negative 1 is 65536 − 1, or 65535).

If values are POKEd into the following locations, they can be transferred to the A, L, and H registers, respectively. After the system returns to BASIC from the subroutine, it is possible to obtain results by investigating the same locations using the PEEK function.

```text
A  Register Location 63911

L  Register Location 63912

H  Register Location 63913
```

The PC-8201 can return to BASIC from a Machine Language subroutine via the RET command.

**NOTE:** Select `<initial location>` carefully to avoid erratic operation.

**SEE ALSO:** The BLOAD, PEEK, and POKE commands.

---

## EXP

**FUNCTION:** This function calculates the value of "e" (base value of natural logarithm = 2.71828) raised to the power specified in the parameter.

**FORMAT:**
```text
EXP (  <arithmetic expression>  )
       <numeric constant>
       <numeric variable>
```

**SAMPLE STATEMENT:**
```text
A=EXP(1)
```

**DESCRIPTION:** This function returns the value of "e" raised to the specified power in Single Precision format. An "?OV Error" (Overflow) message will result if the power raised is greater than 87.33655.

---

## FILES

**FUNCTION:** This command displays all the files in the RAM.

**FORMAT:**
```text
FILES
```

**SAMPLE STATEMENT:**
```text
FILES
```

**DESCRIPTION:** This command displays all of the file names (including file type) stored in the RAM.

The file type ".BA" denotes a BASIC program file, ".DO" is a TEXT file, and ".CO" is a Machine Language program. When an asterisk (\*) is displayed directly after the file type extension ".BA", this means that it is presently accessible.

**SEE ALSO:** Chapter 5, Files.

**SAMPLE PROGRAM:**
```text
10    THIS PROGRAM MAY BE DESTROYED UPON
      EXECUTION, SO SAVE IT BEFORE RUNNING!
20 ON ERROR GOTO 160
30 PRINT 'TO USE IN ONE OF THE FOLLOWING
   PROCESSES--LOAD, OPEN, BLOAD--'
40 FILES
50 INPUT 'WHICH FILE NAME + FILE TYPE DO
   YOU SELECT';N$
60 K$=RIGHT$(N$,3)
70 IF K$='.BA' THEN 110
80 IF K$='.DO' THEN 120
90 IF K$='.CO' THEN 130
100 PRINT 'THE FILE NAME THAT YOU
    DESIGNATE MDOES NOT EXIST!':BEEP:
    GOTO 30
110 LOAD N$
120 OPEN N$ FOR INPUT AS #1: GOTO 140
130 BLOAD N$
140 INPUT#1,A$:PRINT A$:IF NOT (EOF(1))
    THEN 140
150 END
160 RESUME 100
```

---

## FIX

**FUNCTION:** This function returns the integer portion of a number.

**FORMAT:**
```text
FIX (<numeric expression>)
```

**SAMPLE STATEMENT:**
```text
PRINT FIX(9.9)
```

**DESCRIPTION:** The FIX function returns the integer portion of the `<numeric expression>`. It will omit the digits after the decimal point.

**NOTE:** This function does not round off the number.

**SEE ALSO:** INT and CINT functions

**SAMPLE PROGRAM:**
```text
10 PRINT '    I       FIX      INT'
20 FOR I=-2 TO 2 STEP .5
30 PRINT USING '###.##    #####    #####';
   I,FIX(I),INT(I)
40 NEXT
```

---

## FOR . . . TO . . . STEP ~ NEXT

**FUNCTION:** This statement repeats a series of instructions for a designated number of times.

**FORMAT:**
```text
FOR <variable name> = <initial value> TO
    <final value> {STEP <increment>}
    .
    .
    .
NEXT {<variable name> {,<variable name list>
     }}
```

where:

```text
<initial value> = <numeric expression>

<final value> = <numeric expression>

<increment> = <numeric expression>
```

**SAMPLE STATEMENT:**
```text
FOR J=0 TO 100 STEP 10
.
.
.
NEXT J
```

**DESCRIPTION:** The FOR . . . TO . . . STEP ~ NEXT statement executes a series of statements a given number of times (loop).

The `<variable name>` is used as a counter, which at the beginning is set to the `<initial value>`. Each time the sequence is completed and the NEXT statement is encountered, the `<variable name>` increases or decreases specified by the `<increment>` in the STEP parameter.

The value of the `<variable name>` is compared with the `<final value>`, and the loop will stop executing when the terminating condition is met or exceeded. Once the value of the `<variable name>` exceeds the `<final value>`, program control is passed to the statement following the NEXT statement.

The `<variable name>` in the NEXT statement may be omitted. NEXT always terminates the last unmatched FOR statement. If a `<variable name list>` is used and the variable list is not in proper sequence, the nested loops will not terminate correctly.

If the STEP parameter is omitted the default value off `<increment>` is +1. A negative value may also be specified as an `<increment>`.

The loop is executed only once in the following cases:

- When `<increment>` is positive, and `<initial value>` is greater than `<final value>`.

- When `<increment>` is negative, and `<initial value>` is less than `<final value>`.

- When `<initial value>` is equal to `<final value>`, no matter what the `<increment>` is.

- When there is not a matching NEXT statement.

If `<increment>` is zero then the loop is executed continuously (infinite loop). Press **SHIFT** and **STOP** Keys for interruption.

FOR ~ NEXT loops may be nested to any depth. In such case different `<variable names>` must be used, and the second loop must be completely located within the first loop. An "?NF Error" (Next without For) occurs if there is an illegal form of nesting.

The loop may be exited with a GOTO statement. The loop will remain open until another loop is executed using the same `<variable name>`, or when the loop is re-entered.

After a loop is terminated the `<variable name>` has the value of the `<final value>` + 1.

**NOTE:** A common practice to determine whether or not the nested loops are legal is to draw lines between the matching FOR and NEXT statements. If the lines cross each other, then the nesting is illegal. For example:

**FIGURE 4.1 — Legal FOR ~ NEXT nesting** (the bracketing lines do not cross):

```text
 ┌─10  FOR I=1 TO 10
 │ ┌─20  FOR J=10 TO 20 STEP 2
 │ │      .
 │ │      .
 │ │      .
 │ └─80  NEXT J
 │        .
 │        .
 │        .
 │ ┌─120 FOR K=30 TO 10 STEP -5
 │ │      .
 │ │      .
 │ │      .
 │ └─200 NEXT K
 │        .
 │        .
 │        .
 └───300 NEXT I
```

The above is an example of legal nesting.

**FIGURE 4.2 — Illegal FOR ~ NEXT nesting** (the bracketing lines cross — `NEXT X` closes the X loop before the inner Y loop is closed):

```text
 ┌───10  FOR X=10 TO 20
 │        .
 │        .
 │        .
 │ ┌─50  FOR Y=1 TO 20
 │ │      .
 │ │      .
 │ │      .
 └─│─100 NEXT X
   │      .
   │      .
   │      .
   └─200 NEXT Y
```

The above is an example of illegal nesting.

**SAMPLE PROGRAM:**
```text
10 FOR I= 1 TO 5
20 FOR J=16000 TO 1000 STEP -1000
30 SOUND J,I
40 NEXT J,I
```

---

## FRE

**FUNCTION:** This function reports the amount of unused memory area.

**FORMAT:**
```text
FRE(<expression>)
```

where:

```text
<expression> =  <character string>
                <character variable>
                <numeric expression>
                <numeric variable>
```

**SAMPLE STATEMENTS:**
```text
PRINT FRE(A)
PRINT FRE(A$)
```

**DESCRIPTION:** The FRE function calculates the amount of free string memory or the amount of free program memory. The value returned is the amount of unused bytes.

If the `<expression>` is a `<character string>` or a `<character variable>` the FRE function returns the amount of string space available.

If the `<expression>` is a `<numeric expression>` or `<numeric variable>` the FRE function returns the amount of program space available.

**SAMPLE PROGRAM:**
```text
10 PRINT 'INITIAL AMOUNT=';FRE(0)
20 PRINT 'STRING AREA=';FRE(A$)
30 CLEAR 500
40 PRINT 'AMOUNT OF PROGRAM NOW=';FRE(0)
50 PRINT 'STRING SPACE NOW=';FRE(A$)
```

---

## GOSUB ~ RETURN

**FUNCTION:** The GOSUB statement transfers control to a specified line number (beginning of the subroutine). The RETURN branches back to the GOSUB statement when the execution is completed.

**FORMAT:**
```text
GOSUB <line number>
```

**SAMPLE STATEMENT:**
```text
GOSUB 1000
```

**DESCRIPTION:** The GOSUB statement is used to eliminate repeating frequently used routines. The subroutine is a portion of the program that starts with a specific line number and terminates with a RETURN statement. However, a subroutine can have more than one RETURN statement, depending on the specific subroutine.

Subroutines are called by the GOSUB statement to perform the same sequence of instructions at different points of the program. Subroutines usually reside at the end of a BASIC program, and the statement GOSUB is used to call the subroutines. When a RETURN statement is reached in the subroutine, the program will resume execution at the statement following the GOSUB statement.

The procedure of one subroutine calling another subroutine is called "subroutine nesting". Such a procedure can take place as long as the memory stack is not overflow. (Seven stack bytes are used for each GOSUB. The RETURN will put the stack back to normal.)

**SEE ALSO:** The RETURN statement.

**SAMPLE PROGRAM:**
```text
10 GOSUB 30:GOSUB 50:GOSUB 70
20 END
30 FOR I=0 TO 9:PRINT 'FIRST ROUTINE':
   NEXT I
40 BEEP:RETURN
50 FOR I=0 TO 9:PRINT 'SECOND ROUTINE':
   NEXT I
60 BEEP:RETURN
70 FOR I=0 TO 9:PRINT 'THIRD ROUTINE':
   NEXT I
80 BEEP:RETURN
```

---

## GOTO

**FUNCTION:** This statement branches the program execution to a designated line number.

**FORMAT:**
```text
GOTO
GO TO   <line number>
```

**SAMPLE STATEMENTS:**
```text
GOTO 500
GO TO 500
```

**DESCRIPTION:** This command unconditionally branches to a specified `<line number>` in the program.

**NOTE:** This statement may be written either as "GOTO" or "GO TO". If two or more blanks are entered, N82-BASIC does not interpret it as the GOTO statement.

**SEE ALSO:** The IF and GOSUB statements.

**SAMPLE PROGRAM:**
```text
20 GOTO 60
30 PRINT' SPAGHETTI.':GOTO 70
40 PRINT' CALLED':GOTO 30
50 PRINT' NOT MAKE':;GOTO 90
60 PRINT' THIS IS':;GOTO 40
70 PRINT:PRINT' DO':;GOTO 50
80 PRINT' PROGRAM.':GOTO 100
90 PRINT' THIS KIND OF A':;GOTO 80
100 END
```

---

## IF . . . THEN . . . ELSE
## IF . . . GOTO . . . ELSE

**FUNCTION:** These statements are used to evaluate a logical expression and then perform a conditional process.

**FORMAT:**
```text
IF <expression>  THEN <then clause>
                 GOTO <goto clause>

    ELSE <else clause>
```

where:

```text
<expression> =  <arithmetic expression>
                <logical expression>
                <relational expression>

<then clause> =  <statement>
                 <multiple statement>
                 <line number>

<goto clause> = <line number>

<else clause> =  <statement>
                 <line number>
```

**SAMPLE STATEMENTS:**
```text
IF A$="Y" THEN BEEP ELSE 120
IF A+B=C AND A>E GOTO 200 ELSE PRINT A;B
```

**DESCRIPTION:** The IF . . . THEN . . . ELSE/IF . . . GOTO . . . ELSE functions control the program execution based on conditions established by the evaluation of the `<expression>`. If the evaluation of the `<expression>` is non-zero (true) the `<then clause>` or `<goto clause>` is processed. If the evaluation is zero (false) the `<else clause>` is processed.
When the ELSE option is omitted, and the evaluation of the `<expression>` is zero (false), the next line following the IF statement is processed.

Multiple (nested) IF statements are allowed. When nesting occurs the ELSE option will match the most previous unmatched IF statement.

The `<then clause>` can be made up from multiple statements, separated by a colon(:).

The complexity of a multiple arrangement is limited within the range of one line, which is 255 characters long, or before the Key is pressed.

> **For more details on the evaluation of a `<logical expression>`, `<relational expression>` or `<arithmetic expression>` see Chapter 3.**

**NOTE:** Tabs are not considered in matching IF, THEN, GOTO or ELSE clauses, they are only a programming aid in the structure of the code.

**SAMPLE PROGRAM:**
```text
10 M=10000:CLS
20 PRINT'YOU HAVE $';M;'.'
30 PRINT'$';M;'.';'HOW MACH DO YOU
   WANT TO BET ON THIS DIE':
   INPUT K
40 K=INT(K):PRINT
50 REM ** This is the nesting of the
   type of IF statement of line 70
60 REM *** when the input is not the
   right input...
70 IF K>M THEN PRINT'IMPOSSIBLE WITH
   ONLY '; M  :BEEP:GOTO 30 ELSE IF
   K<0 THEN PRINT'SNEAKY!':BEEP:GOTO
   30 ELSE IF K>M/2 THEN PRINT
   'GENEROUS!' ELSE IF K<M/100 THEN
   PRINT'CHEAPSKATE!'
80 INPUT'  NOW WHAT DO TOU THINK WILL
   COME UP ON THE DIE(1-6)';N
90 N=INT(N):PRINT
100 IF N<1 OR N>6 THEN PRINT'IMPOSSIBLE
    WITH AN ORDINARY DIE.':BEEP:GOTO 80
110 SOUND 3000,20:R=INT(RND(1)*6)+1
120 PRINT:PRINT'SO,';R;'SPOT(S) CAME UP
    ON THE DIE.':PRINT
130 IF N=R THEN SOUND 4000,10:M=M+K*6:
    PRINT'YOU   WERE  SUCCESSFUL!' ELSE
    PRINT'YOU LOST THIS TIME!':SOUND
    16000,10:M=M-K
140 IF M<1 THEN PRINT'YOU'RE BANKRUPT
    NOW!' ELSE IF M>1E+06 THEN PRINT
    'YOU ARE A MILLIONAIRE!' ELSE 30
```

---

## IMP

**FUNCTION:** This logical operator is used to test multiple relations.

**FORMAT:**
```text
<operand 1> IMP <operand 2>
```

**SAMPLE STATEMENT:** `PRINT 2 IMP 2`

**DESCRIPTION:** The logical operation IMP (Implication) performs tests on multiple relations, Boolean operations, and bit manipulation. It returns either a non-zero (false) value or a non-zero (true) value.

The operation returns zero (false) whenever `<operand 1>` is true and `<operand 2>` is false. Otherwise it returns a non-zero (true) value.

The following table indicates the evaluation process:

```text
-1 IMP -1 -> -1 (TRUE IMP TRUE -> TRUE)

-1 IMP 0 -> 0 (TRUE IMP FALSE -> FALSE)

0 IMP -1 -> -1 (FALSE IMP TRUE -> TRUE)

0 IMP 0 -> -1 (FALSE IMP FALSE -> TRUE)
```

> **For more details on logical operators see Chapter 3.**

**NOTE:** IMP performs the same way as NOT (`<operand 1>`) OR (`<operand 2>`). A IMP B is the same as NOT (A) OR B.

Logical operators convert their operands to sixteen bits binary integers. Therefore, `<operand 1>` and `<operand 2>` must range from −32768 to +32767. If not, an "?OV Error" (Overflow) message will be displayed.

**SEE ALSO:** Functions AND, EQV, NOT, OR, XOR, and Chapter 3.

**EXAMPLE:**

| INTEGER | BINARY BITS        |
|---------|--------------------|
| 23280   | 0101 1010 1111 0000 |
| 11853   | 0010 1110 0100 1101 |

After you input the statement PRINT 23280 IMP 11853, the integer −20657 appears, whose binary is 1010 1111 0100 1111. By looking at the table in the DESCRIPTION section, notice that the computation is correct.

---

## INKEY$

**FUNCTION:** The INKEY$ function is used to check if a character has been entered through the keyboard.

**FORMAT:**
```text
INKEY$
```

**SAMPLE STATEMENT:** `A$=INKEY$`

**DESCRIPTION:** The INKEY$ function returns a null string if the keyboard buffer is empty. When the keyboard buffer contains any character, the first character in the buffer is returned. Any key that is not included in the Character Codes Table will be ignored.

**SEE ALSO:** The Table of Character Codes.

**SAMPLE PROGRAM:**
```text
10 SCREEN 0,0:CLS:X=20:Y=3
20 PRINT' TRY TO MOVE THE CURSOR IN
   DIFFERENT DIRECTIONS'
30 PRINT' U=UP,D=DOWN,R=RIGHT,L=LEFT'
40 PRINT' HIT ANY OF THE ABOVE KEYS'
50 A$=INKEY$:IF A$='' THEN 50
60 LOCATE X,Y:PRINT'  ';
70 IF A$='U' AND Y>0 THEN Y=Y-1
80 IF A$='D' AND Y<7 THEN Y=Y+1
90 IF A$='R' AND X<39 THEN X=X+1
100 IF A$='L' AND X>0 THEN X=X-1
110 LOCATE X,Y:PRINT 'X';
120 GOTO 50
```

---

## INP

**FUNCTION:** This function obtains a value from an input port.

**FORMAT:**
```text
INP(<port number>)
```

**SAMPLE STATEMENT:** `A=INP(15)`

**DESCRIPTION:** The INP (Input from a Port) function reads a byte from the input port specified by the `<port number>`, and it returns that byte as the function value.

The `<port number>` must be an integer ranging from 0 to 255.

**SEE ALSO:** OUT statement.

---

## INPUT

**FUNCTION:** The INPUT statement allows data to be entered through the keyboard during program execution.

**FORMAT:**
```text
INPUT {"<prompt statement>"; } <variable 1>
{,<variable 2>} ...
```

**SAMPLE STATEMENT:** `INPUT "NAME, NO.";N$,A$`

**DESCRIPTION:** The INPUT statement is used to display a prompting message and then accepts one or more fields of data through keyboard input.

When the INPUT statement is executed, the `<prompt statement>` is displayed with a question mark following it, and the PC-8201 waits for data to be entered through the keyboard. If the prompt statement is omitted, the question mark alone will be displayed.

The input <variable(s)> are separated by commans, containing a mixture of variable types (integer, string, numeric, array), and may be as long as the line allows. Data elements entered are also separated by commas, and each data element corresponds to a variable in the INPUT statement.

If the number of data elements is less than the number of variables indicated, a double question mark (??) is displayed. This asks for additional input until there is sufficient data for the variables.

On the other hand, if data entered is more than needed, program execution continues with the next statement following the INPUT statement, disregarding the extra data. The message "?Extra ignored" is then displayed.

The type of data input should match the corresponding variable type. The screen displays "?Redo from start" if a character string is input to a numeric variable. Data must then be input again, starting from the first variable.

It is optional to enclose the character string in double quotation marks. However, if blank spaces (leading or trailing the string) or commas are entered into a string variable, they must be enclosed in double quotation marks ("). These double quotation marks in this case are not considered part of the character string.

Successive input of commas in the INPUT statement (with more than 2 variables such as 12,,3) indicate the omission of input data. The corresponding variable is assigned " " (null string) if it is a string type, and 0 if it is a numeric type.

**SEE ALSO:** The LINE INPUT and INPUT# commands.

**SAMPLE PROGRAM:**
```text
10 INPUT 'ENTER NAME          :';N$
20 PRINT '*** USE COMMA TO SEPERATE
   VARIABLES ***'
30 INPUT 'ENTER 2 NUMBERS     :';A%,B%
40 C%=A%+B%
50 PRINT N$;',THE SUM OF';A%;'AND';B%;
   'IS';C%
```

---

## INPUT$

**FUNCTION:** This function reads a character string of a specified length, either from a designated file in the function statement or from the keyboard.

**FORMAT:**
```text
INPUT$ ( [<integer constant> ] {,  {#}
          [<integer variable>]
                <file number> } )
```

**SAMPLE STATEMENTS:**
```text
A$=INPUT$(10)
B$=INPUT$(I%,#3)
```

**DESCRIPTION:** The integer in the first parameter is the character string to be input from the file. The maximum length of the string is 255 characters. The optional `<file number>` is assigned to the file by the OPEN statement.

The string is input from the keyboard if the `<file number>` is omitted in the statement. Keys entered are not displayed on the screen when input through the keyboard. The PC-8201 waits for more input if the number of characters entered is less than the specified string length.

The STOP Key or + C can be used to interrupt the INPUT$ function. All other keys are treated as part of the input string. The input buffer is cleared whenever the INPUT$ function is executed.

**SEE ALSO:** OPEN command.

**SAMPLE PROGRAM:**
```text
10 REM*INPUT$*
20 CLS:INPUT'DESIGNATE A PASSWORD';PW$
30 WL=LEN(PW$)
40 REM* THEN PROGRAM  STARTS FROM HERE *
50 CLS:PRINT 'ENTER PASSWORD:';
60 N$=INPUT$(WL)
70 IF N$=PW$ THEN PRINT'WELCOME USER!':
   SOUND 3000,20:GOTO 20
80 LOCATE 0,3:PRINT'INVALID PASSWORD!'
90 PRINT 'PLEASE TRY AGAIN'
100 SOUND 5000,4:SOUND 1000,4
110 CLS:GOTO 50
```

---

## INPUT #

**FUNCTION:** This statement is used to read data from an opened input file into variable(s) contained in the statement.

**FORMAT:**
```text
INPUT# <file number>,<variable 1> {,<variable
2>} ...
```

**SAMPLE STATEMENTS:**
```text
INPUT#1,A
INPUT#1,B,CS
```

**DESCRIPTION:** This statement inputs data from a designated file (in RAM, cassette tape, etc.) and functions similar to the INPUT statement except that a question mark (?) is not displayed.

The contents of the specified data file (file type ".DO") are read into the variables in the INPUT# statement. The `<file number>` is the number designated in the OPEN statement. The file should be opened for the input mode.

The <variable(s)> are assigned from left to right, starting from the beginning of the input file. The number of <variable(s)> in the INPUT# statement is the number of data elements used each time the statement is executed. Each time the INPUT# statement of the same file number is executed, it starts reading in data from where it terminated previously.

Data in the input file should be the appropriate type for the corresponding variable. The message "?EF Error" (End of file) will be displayed when an INPUT# statement is reached and insufficient data is available. The EOF function is used to test for end of file condition before an INPUT# statement is executed.

**SEE ALSO:** PRINT#, INPUT, LINE INPUT#, and the EOF function.

---

## INSTR

**FUNCTION:** This function searches for a character string within a string and returns its position.

**FORMAT:**
```text
INSTR {<numeric expression>,} <character string
1>,<character string 2>
```

**SAMPLE STATEMENT:** `PRINT INSTR(6,"THIS IS A TEST","TEST")`

**DESCRIPTION:** The INSTR function locates a substring in a string and returns its position. `<Character string 1>` is the original string which is searched for a match with `<character string 2>` substring.

The `<numeric expression>` is designated by an integer, that specifies the position in `<character string 1>`, where the search begins. If the `<numeric expression>` is omitted the searching begins at position 1.

The INSTR function returns the position where the match occurred. It returns zero if `<character string 1>` does not contain `<character string 2>` (no match).

If `<character string 2>` contains more than one character and a perfect match is made, the INSTR function returns only the position of the first character in `<character string 1>` where the match begins.

When the null string (empty string) is designated for `<character string 2>`:

1. If the `<numeric expression>` is omitted then "1" is returned.

2. If `<numeric expression>` is less than or equal to the length of `<character string 1>` then the `<numeric expression>` is returned.

or else 0 is returned if `<numeric expression>` is larger than the length of `<character string 1>`.

**NOTE:** The `<numeric expression>` must be an integer from 1 to 255. If not, an "?FC Error" (Illegal function call) message is displayed on the screen. When the number is read just its integer portion is taken as the beginning position.

The length of `<character string 2>` must be less than or equal to (<= ) `<character string 1>` or a zero will be returned.

---

## INT

**FUNCTION:** This function rounds numbers to their integer value.

**FORMAT:**
```text
INT(<numeric expression>)
```

**SAMPLE STATEMENT:**
```text
PRINT INT (9.9)
PRINT INT (-9.9)
```

**DESCRIPTION:** The INT function rounds the `<numeric expression>` to its integer (whole) value. If the `<numeric expression>` is positive, INT truncates it (drops decimal digits).

If the `<numeric expression>` is negative, INT returns the next smallest whole number. For example:

```text
INT(-3.1)=-4
INT(-3.9)=-4
```

**NOTE:** The value that is returned is always less than or equal to the `<numeric expression>`.

**SEE ALSO:** The FIX and CINT functions.

**SAMPLE PROGRAM:**
```text
10 PRINT '    I         INT     FIX'
20 FOR I=-1.5 TO 1.5 STEP .2
30 PRINT USING '###.##    #####    #####';
   I,INT(I),FIX(I)
40 NEXT
```

---

## KEY

**FUNCTION:** This function is used to define functions of the programmable function keys.

**FORMAT:**
```text
KEY <key number>, "<function>"
```

**SAMPLE STATEMENT:** `KEY1, "LOAD"`

**DESCRIPTION:** Up to ten programmable functions can be defined by using the five function keys (five on the keyboard, with five more in SHIFT mode). The function keys are numbered from 1 to 5, and 6 to 10 are used in the SHIFT mode. Each function key can be assigned with a character string or a control statement of 15 or less characters. Characters that cannot be input from the keyboard are entered by using the plus sign "+" and the CHR$ function.

**SEE ALSO:** See the Table of Character Codes for use with the CHR$ function.

**SAMPLE PROGRAM:**
```text
10 A$(0)=''
20 A$(1)='LOAD '+CHR$(34)
30 A$(2)='SAVE '+CHR$(34)
40 A$(3)='FILES '+CHR$(13)
50 A$(4)='LIST '
60 A$(5)='RUN '+CHR$(13)
70 FOR I=1 TO 59
80 KEY (I MOD 5)+1,A$(I MOD 6)
90 NEXT
```

---

## KILL

**FUNCTION:** This command is used to erase a designated file.

**FORMAT:**
```text
KILL "<file name.file type>"
```

**SAMPLE STATEMENT:** `KILL "SAMPLE.BA"`

**DESCRIPTION:** The KILL command deletes a specific file designated by a file name and/or device name. The file to be deleted must be closed. Any opened file is indicated by an asterisk (*) when the FILES command is executed. Only one file may be deleted with each KILL command.

The file name must always include its file type extension (".BA", ".DO", and ".CO") when the KILL command is executed. The PC-8201 returns to the Direct Mode after the execution.

**SEE ALSO:** The LOAD and SAVE commands and Chapter 5, Files.

---

## LEFT$

**FUNCTION:** This function is used to designate a specific number of characters from a string, starting from the left most position of a string.

**FORMAT:**
```text
LEFT$(<character string>,<numeric expression>)
```

**SAMPLE STATEMENT:** `B$=LEFT$(A$,4)`

**DESCRIPTION:** A `<character string>` can be a string constant or a string variable. The value of a `<numeric expression>` must be in a range from 0 to 255, which specifies the number of characters to be read, beginning from the left most character.

The full `<character string>` is returned when the `<numeric expression>` is greater than or equal to the total number of characters in the `<character string>`. LEFT$ returns a null string when the `<numeric expression>` is 0.

**SEE ALSO:** The RIGHT$ and MID$ functions.

**SAMPLE PROGRAM:**
```text
10 A$='++++++++++++++++++++++++++++++++++
   ++++++'
20 PRINT'INPUT DATA FOR EACH LINE.'
30 FOR I=0 TO 5:PRINT I;
40 INPUT'INPUT THE DESIRED BAR LENGTH
   (0 TO 39)';A(I)
50 IF A(I)<0 OR A(I)>39 THEN BEEP:PRINT
   'ILLEGAL NUMBER';;PRINT I:GOTO 40
60 NEXT I
70 FOR I=0 TO 5
80 PRINT LEFT$(A$,A(I))
90 NEXT I
```

---

## LEN

**FUNCTION:** This function returns the number of characters that are contained in a string.

**FORMAT:**
```text
LEN ( [<character string> ] )
     [<character variable>]
```

**SAMPLE STATEMENT:** `PRINT LEN ("123456789")`

**DESCRIPTION:** The LEN (Length) function returns the length of a `<character string>` or `<character variable>`. It counts all characters including the ones that can not be printed (control codes 1-31).

**NOTE:** To determine the length of a number, double quotation marks must be placed around it.

**SAMPLE PROGRAM:**
```text
20 INPUT 'INPUT ANY COMBINATION OF  LESS
   THAN 36 CHARACTERS.';N$
30 CLS: L=LEN(N$):GOSUB 60
40 PRINT '+ ';N$;' +'
50 GOSUB 60: END
60 FOR  I=1 TO L+4
70 PRINT '+';:NEXT
80 PRINT :RETURN
```

---

## LET

**FUNCTION:** This statement is used to assign values to variable names.

**FORMAT:**
```text
{LET} <variable name> = <value>
```

**SAMPLE STATEMENT:** `LET A=10+5`

**DESCRIPTION:** The BASIC Reserved Word (keyword) LET is optional, so the statement LET A=10+5 can be entered as A=10+5.

The `<variable name>` is assigned the evaluated `<value>` which may be a number, a string, an equation, or a function.

**SAMPLE PROGRAM:**
```text
10 BE=26:IT=810
20 LET IT=BE
30 PRINT IT,BE
```

---

## LINE INPUT

**FUNCTION:** The LINE INPUT statement is used to allow the input of an entire line of data.

**FORMAT:**
```text
LINE INPUT {"<prompt string>"; } <string variable>
```

**SAMPLE STATEMENT:** `LINE INPUT "WHAT?";A$`

**DESCRIPTION:** A `<prompt string>` is a sentence that displays a query for a specific input. A maximum of 255 characters, including delimiters (quotation marks, comma, etc.), can be entered and assigned to a `<string variable>`. All input from the keyboard (after the prompt string) up to the carriage return, is substituted for the `<string variable>`.

Any punctuation marks and symbols can be input in the `<string variable>`. The + C Keys and the STOP Key can be pressed to interrupt the LINE INPUT statement. This will stop program execution and return the PC-8201 to the Direct Mode. The LINE INPUT statement can be continued by executing the CONT command.

**SEE ALSO:** The INPUT statement.

**SAMPLE PROGRAM:**
```text
10 PRINT'INPUT (ANYTHING UP TO 255
   CHARACTERS IN ALL, INCLUDING A COMMA
   OR QUOTATION MARKS):'
20 LINE INPUT A$
30 FOR I=1 TO LEN(A$)
40 PRINT MID$(A$,I,1);
50 FOR T=0 TO 200:NEXT
60 NEXT I
```

---

## LIST/LLIST

**FUNCTION:** These commands are used to list either a portion or an entire program currently in the memory.

**FORMAT:** <!-- source prints "FORMT:" (missing A) — normalized to FORMAT to match the rest of the chapter -->
```text
[LIST ] {<line number 1>} {-<line number
[LLIST]  2>}
```

**SAMPLE STATEMENTS:**
```text
LIST 70-120
LLIST 70-120
```

**DESCRIPTION:** The LIST command is used to list a program on the screen; the LLIST command outputs the listing to the printer. The PC-8201 returns to the Direct Mode after the LIST or LLIST command is executed.

When both `<line number>`s are omitted, the entire program is listed. The STOP Key may be pressed at any time to interrupt listing on the screen. The SHIFT Key and the STOP Key are pressed simultaneously to interrupt listing to the printer.

If only `<line number 1>` is designated, only that specific line is listed (if it exists). If `<line number 1>` and a hyphen (-) are specified, all lines starting from `<line number 1>` are listed. When a hyphen is followed by a designated `<line number 2>`, the listing starts from the beginning and continues up to and including `<line number 2>`. When a hyphen is used between both `<line number 1>` and `<line number 2>`, all lines within the range of both `<line number>`s inclusive will be listed. The `<line number 2>` must be greater than or equal to `<line number 1>`.

The LLIST command is identical to the LIST command with the exception that it outputs to a printer.

---

## LOAD

**FUNCTION:** This command is used to load a program file into memory.

**FORMAT:**
```text
LOAD "{<external device name>:} <file name>"
{,R}
```

**SAMPLE STATEMENT:** `LOAD "CAS:SAMPLE.BA",R`

**DESCRIPTION:** This command loads the program specified by `<file name>` and optional `<external device name>` into the memory. When executed, the LOAD command closes all open files and deletes variables.

RAM is selected if the `<external device name>` is omitted, but `<file name>` must be specified. The PC-8201 loads from cassette tape if "CAS:" is designated for `<external device name>`. If file name is omitted, the first program file that it detects on the cassette tape is loaded. The SHIFT and STOP Keys can be pressed simultaneously to interrupt the execution of the LOAD "CAS:" command.

The intended device is the RS-232C interface when "COM:" is designated for `<external device name>`. Data transmission format can be indicated but `<file name>` cannot be used. (Please refer to the OPEN "COM:" command for details on this specific application).

The file must be a ".BA" or ".DO" file. File type extension can be omitted during loading. If the "R" (Run) option is specified, the program is executed immediately after loading.

The program currently in the memory is preserved until the specified file is found and the program loading has begun.

The PC-8201 returns to Direct Mode when the load process has been completed.

**NOTE:** A NEW command is executed before the actual execution of a LOAD command occurs, so that all existing variables and programs can be cleared.

**SEE ALSO:** The BLOAD, CLOAD, and SAVE commands. See Chapter 5, Files.

---

## LOCATE

**FUNCTION:** This command designates the location of the screen cursor.

**FORMAT:**
```text
LOCATE <horizontal coordinate>,<vertical coordinate>
```

**SAMPLE STATEMENT:** `LOCATE 20,5`

**DESCRIPTION:** This command moves the cursor to a designated location on the display screen. The range of the `<horizontal coordinate>` is 0 through 39, and for the `<vertical coordinate>` the range is 0 through 7. Home position is considered to be at coordinate (0,0).

Any number greater than 39 will be set as 39 for the `<horizontal coordinate>`, while any number larger than 7 will be set as 7 for the `<vertical coordinate>` (or 6 when the Function Keys are displayed on the bottom line of the screen).

**NOTE:** A LOCATE statement designates character coordinates and has absolutely no connection to the dot matrix structure of the screen itself.

**SAMPLE PROGRAM:**
```text
10 SCREEN 0,0:CLS
20 LOCATE 10,7:PRINT'X=';X;
30 LOCATE 20,7:PRINT'Y=';Y;
40 X=INT(RND(1)*39):Y=INT(RND(1)*7)
50 LOCATE X,Y:PRINT'HOP';
60 FOR I=0 TO 300:NEXT
70 LOCATE X,Y:PRINT'   ';
80 GOTO 20
```

---

## LOG

**FUNCTION:** This function returns the natural logarithm of a number.

**FORMAT:**
```text
LOG(<numeric expression>)
```

**SAMPLE STATEMENT:** `PRINT LOG(2.7182818)`

**DESCRIPTION:** The LOG function is useful in trigonometric applications, and it returns the natural logarithm of a number based on "e" (exponent).

The `<numeric expression>` must be greater than zero. If it is zero or less an "?FC Error" (Illegal function call) message is displayed on the screen.

**SAMPLE PROGRAM:**
```text
10 READ I
20 IF I=999 THEN END
30 X=LOG(I)
40 PRINT I,X
50 GOTO 10
60 DATA 34,1,06,44,8976,146,35.677,999
70 END
```

---

## LPOS

**FUNCTION:** This function determines the current printer head column.

**FORMAT:**
```text
LPOS(<numeric expression>)
```

**SAMPLE PROGRAM:** `LPRINT "ABCDE"; LPOS(0)`

**DESCRIPTION:** The LPOS function determines the current column position of the printer head within the buffer. It keeps track of the number of characters printed until a carriage return appears, which resets it to zero.

The value of the `<expression>` is only used as a dummy expression, used for the value that is returned by the LPOS function.

**SEE ALSO:** POS function.
## MAXFILES

**FUNCTION:** This command establishes the number of files that can be opened.

**FORMAT:**
```text
MAXFILES= <number of file(s)>
```

**SAMPLE STATEMENT:** MAXFILES=3

**DESCRIPTION:** The number of files that can be opened is set to 1 when a Cold Start is conducted. The maximum number of files that can be opened at one time is designated by a MAXFILES statement. The range of `<number of file(s)>` is from 0 through 15. Once this type of value has been designated, it will be protected until it is redesignated or when a Cold Start is again conducted.

**SEE ALSO:** The OPEN and CLOSE statements, and Chapter 5, Files.

---

## MENU

**FUNCTION:** This command returns to MENU display.

**FORMAT:**
```text
MENU
```

**SAMPLE STATEMENT:** MENU

**DESCRIPTION:** The MENU command clears all variables and returns to MENU mode. Files in access mode (indicated by an asterisk when the FILES command is executed), are closed when the MENU command is executed. The program is maintained in the BASIC area and execution is possible by entering the BASIC mode.

**NOTE:** MENU does not use any parameters.

---

## MERGE

**FUNCTION:** This command is used to merge two programs together.

**FORMAT:**
```text
MERGE {"external device name":} (<file name>)
```

**SAMPLE STATEMENT:** MERGE "CAS:DEMO.DO"

**DESCRIPTION:** A program file within the RAM or from an external device can be merged with a program currently in the memory. The PC-8201 returns to Direct Mode after the MERGE command is executed.

RAM is selected when the `<external device name>` is not specified, but `<file name>` cannot be omitted. When "CAS:" (cassette tape) is designated for external device and the `<file name>` is omitted, the first program detected is used in the merging process. When "COM:" (the RS-232C circuit) is designated, the file name cannot be used but the designation of data transmission format is possible. (Refer to the OPEN command for more detail in this specific situation.) The MERGE command will close all files after execution.

In all cases, the designated program must have been saved in ASCII code (must be a ".DO" file). If it is not, an error occurs.

**NOTE:** Use with caution, because if the two programs have identical line numbers, the line(s) in the memory are overwritten by the line from the designated file.

**SEE ALSO:** The SAVE and RENUM commands.

---

## MID$

**FUNCTION:** This function returns a specified number of characters from a desired position within a string.

**FORMAT:**
```text
MID$(<character string>, <numeric expression 1>
     {, <numeric expression 2>})
```

**SAMPLE STATEMENT:** PRINT MID$("ABCD",2,2)

**DESCRIPTION:** The MID$ (Middle) function returns a substring of a specified length from a desired position within the `<character string>`.

The `<numeric expression 1>` specifies the position within the `<character string>`, while `<numeric expression 2>` determines the length of the substring.

When `<numeric expression 2>` is omitted, or when the number of characters to the right of the `<numeric expression 1>` position within the `<character string>` is less than `<numeric expression 2>`, all characters to the right of the `<numeric expression 1>` position are returned.

If `<numeric expression 1>` is greater than the length of the `<character string>` a null string is returned.

**NOTE:** `<Numeric expression 2>` must be an integer from 0 to 255, while `<numeric expression 1>` must be an integer from 1 to 255. If not an "?FC Error" (Illegal function call) message is displayed.

**SAMPLE PROGRAM:**
```text
10 A$='JANUARY  XX, 19'
20 D$='1234567890'
30 P$=MID$(A$,1,8)+MID$(D$,1,1)+MID$(D$,10,1)
   +MID$(A$,11)+MID$(D$,9,2)
40 PRINT P$
50 END
```

---

## MOD

**FUNCTION:** This function provides the remainder of an arithmetic expression.

**FORMAT:**
```text
<numeric expression 1> MOD <numeric expression 2>
```

**SAMPLE STATEMENT:** PRINT A MOD 7

**DESCRIPTION:** Values for both numeric expressions can be positive integers that are less than 32767. When a negative value is used for `<numeric expression 2>`, it will be processed as an absolute value. If a negative value is specified for `<numeric expression 1>`, a negative value as the result is returned.

In addition, a zero cannot be used in `<numeric expression 2>`. Any decimal fraction included is rounded to the decimal point.

**SAMPLE PROGRAM:**
```text
10  SCREEN 0,0:CLS
20  LOCATE 5,0:BEEP:INPUT' A NUMBER';
    A:A=INT(A)
30  IF A<32768! THEN 50
40  PRINT'IT IS TOO LAARGE.':FOR I=0 TO
    1000:NEXT:GOTO 10
50  CLS:LOCATE 6,2:PRINT'THE DECIMAL
    NUMBER';A;' WILL BE '
60  LOCATE 6,4:PRINT'IN BINARY'
70  N=0
80  LOCATE 30-N*2,6
90  PRINT A MOD 2:A=INT(A/2):N=N+1
100 IF A<> 0 THEN 80
110 GOTO 20
```

---

## MOTOR

**FUNCTION:** This command controls the ON and OFF functions of the motor that drives the cassette recorder.

**FORMAT:**
```text
MOTOR <switch>
```

**SAMPLE STATEMENT:** MOTOR 0

**DESCRIPTION:** The cassette recorder motor is turned OFF when the `<switch>` value is set to 0. Any numeric value ranging from 1 to 255 turns the motor ON.

An error occurs if a value greater than 255 is designated to turn the motor ON.

**SAMPLE PROGRAM:**
```text
10  MOTOR 0
20  PRINT'SELECT CASSETTE TAPE WITH
    MUSIC THAT YOU LIKE'
30  PRINT'PLUG ONE END OF THE CABLE INTO
    THE PC-8201 AND INSERT THE BLACK PLUG
    INTO THE REMOTE CONNECTOR.'
40  PRINT'SET RECORDER TO ON'
50  PRINT'HIT 1 TO START'
60  IF INKEY$='' THEN 60
70  MOTOR 1
80  PRINT'HIT 0 TO STOP!'
90  IF INKEY$='' THEN 90
100 MOTOR 0:GOTO 50
```

---

## NAME

**FUNCTION:** This command is used to rename files in the RAM.

**FORMAT:**
```text
NAME "<old file name>" AS "<new file name>"
```

**SAMPLE STATEMENT:** NAME "OLD.BA" AS "NEW.BA"

**DESCRIPTION:** The NAME command renames the RAM file `<old file name>` as `<new file name>`. The designated file name must include the file type extension for both the old and the new file names. The file type for both file names must be identical.

An error message appears on the screen if one of the following is true:

1. A non-existing file name is designated as an `<old file name>`.

2. An existing file name is used as a `<new file name>`.

3. File types for both files are not identical.

**SEE ALSO:** Chapter 5, Files.

---

## NEW

**FUNCTION:** This command erases any program or data currently in the BASIC area and clears all variables.

**FORMAT:**
```text
NEW
```

**SAMPLE STATEMENT:** NEW

**DESCRIPTION:** The NEW command is used in Direct Mode prior to the input of a new program. When executed, it closes all opened files. Furthermore, a file in access (indicated by an asterisk when FILES command is executed) will be terminated.

This command does not use any parameter and it returns to Direct Mode after execution is completed.

**SAMPLE PROGRAM:**
```text
10  REM This program will self-destruct
    when you run it.
20  PRINT'YOU HAVE DESTROYED THE
    PROGRASM!'
30  BEEP:BEEP
40  NEW
```

---

## NOT

**FUNCTION:** This logical operator is used to test multiple relations, bit manipulation, and Boolean operations.

**FORMAT:**
```text
NOT <operand>
```

**SAMPLE STATEMENT:** `PRINT NOT 5`

**DESCRIPTION:** The logical operator NOT converts its `<operand>` to a sixteen bit binary integer, and then it inverts (negates) each bit of the `<operand>`. It returns −1 (true) if the bit is 0 (false) or it returns 0 if the bit is −1.

The following table shows the negated calculations:

NOT −1 → 0 (NOT TRUE → FALSE)

NOT 0 → −1 (NOT FALSE → TRUE)

> **For more details on logical operators see Chapter 3.**

**NOTE:** Because of the `<operand>` conversion to sixteen bit binary, the `<operand>` must range from −32768 to +34767. If not, an "?OV Error" (Overflow) message is displayed.

**SEE ALSO:** Functions AND, EQV, IMP, OR, XOR, and Chapter 3.

**EXAMPLE:**

| INTEGER | BINARY BITS        |
|---------|--------------------|
| 153     | 0000 0000 1001 1001 |
| −154    | 1111 1111 0110 0110 |

To negate it just replace 0 with 1 and vice versa. If you input the statement PRINT NOT 153, the PC-8201 responds −154, whose binary is 1111 1111 0110 0110, which is the correct result, according to the table above in the DESCRIPTION section.

---

## ON . . . GOTO/ON . . . GOSUB

**FUNCTION:** These statements transfer control (branch) to one of several specified lines/subroutines based on the evaluation of the statement.

**FORMAT:**
```text
ON <numeric variable> GOTO  <line number>
                       GOSUB
, <line number list>
```

**SAMPLE STATEMENT:** ON A GOTO 100, 140, 200, 400

**DESCRIPTION:** The ON . . . GOTO/ON . . . GOSUB statements branch to a specific `<line number>` based on the evaluation of the `<numeric variable>`.

After the `<numeric variable>` is evaluated its integer part is taken, and it is then used to select the first `<line number>` if the value is 1, the second `<line number>` if the value is 2, etc.

An "?FC Error in line" occurs if the value of the `<numeric variable>` is negative. But if it is zero or greater than the number of `<line number>` then control branches to the next logical line (following the ON . . . GOTO/GOSUB statement).

The `<line number>` following the GOTO or GOSUB must be separated by commas, or else an "?SN Error" (Syntax) message is displayed on the screen. There may be any number of `<line numbers>` in a list (up to 255 characters per line).

When ON . . . GOSUB is used and control is transferred to the subroutine, a RETURN statement is needed. After the RETURN statement is executed, control returns to the line following the ON . . . GOSUB statement.

> **For more information refer to GOSUB and RETURN statements.**

**NOTE:** These statements save time and program lines when they are used in place of the IF . . . THEN statement. For example:

```text
IF L=1 THEN GOSUB 150 ) ON L GOSUB 150, 80,
IF L=2 THEN GOSUB 80  } 200, ...
IF L=3 THEN GOSUB 200 )
```

**SEE ALSO:** ON ERROR, GOTO, GOSUB, and RETURN statements.

**SAMPLE PROGRAM:**
```text
10  INPUT 'ENTER A NUMBER FROM 0 TO 5';A
20  ON (A AND 1)+1 GOSUB 120,130
30  PRINT 'YOUR NUMBER IS ';
40  ON A+1 GOTO 60,70,80,90,100,110
50  PRINT 'OUT OF RANGE.':GOTO 10
60  PRINT 'ZERO':END
70  PRINT 'ONE':END
80  PRINT 'TWO':END
90  PRINT 'THREE':END
100 PRINT 'FOUR':END
110 PRINT 'FIVE':END
120 PRINT A ' IS AN EVEN NUMBER':RETURN
130 PRINT A ' IS AN ODD NUMBER':RETURN
```

---

## ON COM GOSUB

**FUNCTION:** This statement establishes initial line of a branch process when interruption occurs from a RS-232C communications port.

**FORMAT:**
```text
ON COM GOSUB <line number>
```

**SAMPLE STATEMENT:** ON COM GOSUB 2000

**DESCRIPTION:** This statement designates `<line number>`, which branches to the first line of a routine used to perform communication process when an RS-232C interrupt occurs.

A return from the process routine is conducted the same as normal subroutine.

A return from ON COM GOSUB routine is exactly the same as other normal routine, by using the RETURN statement. When specified, the program is restarted from where program execution was suspended. When `<line number>` is specified, the program is restarted from the specified line.

**SEE ALSO:** COM ON/OFF/STOP, OPEN and RETURN statements.

---

## ON ERROR GOTO ~ RESUME

**FUNCTION:** The ON ERROR GOTO statement is used to specify an error subroutine used for trappable errors.

**FORMAT:**
```text
ON ERROR GOTO <line number>
              <0>
```

**SAMPLE STATEMENTS:** ON ERROR GOTO 100
ON ERROR GOTO 0

**DESCRIPTION:** The ON ERROR GOTO ~ RESUME statement creates an error handling routine, which takes control from N82-BASIC if an error is detected during program execution.

The ON ERROR GOTO statement is used to instruct the PC-8201 that an error processing subroutine is in effect. In situations when an error occurs, `<line number>` indicated is to receive control, which should be the beginning of the error handling routine. If a line specified in `<line number>` does not exist, a "?UL Error" (Undefined line number) message will be displayed.

The ON ERROR GOTO 0 statement is used when an error trap function is not possible, which signals BASIC to handle all errors. BASIC proceeds with normal system error handling by displaying error messages and stopping program execution. It is advisable to execute an ON ERROR GOTO 0 statement for error processing routines so that any failure in the routines can be trapped.

**SEE ALSO:** The RESUME and ERROR statements.

---

## OPEN

**FUNCTION:** This statement is used to open a file for input or output.

**FORMAT:**
```text
OPEN "{<external device name>:} <file name>"
     INPUT
FOR  OUTPUT  AS {#} <file number>
     APPEND
```

**SAMPLE STATEMENT:** OPEN "SESAME" FOR OUTPUT AS #1
OPEN "CAS:SESAME" FOR OUTPUT AS #2

**DESCRIPTION:** The OPEN statement opens a file specified by `<file name>` for use with the buffer number `<file number>`. A range from 1 through 15 can be designated for `<file number>`. A `<file number>` previously used to open a file cannot be subsequently used to open another (a second) file. Input and output of an opened file are conducted by subsequently specifying a file number.

Three different `<modes>` are used to specify their access methods to a file. "INPUT" assigns sequential input from a device or an existing file, "OUTPUT" designates sequential output to a device or a file, and "APPEND" specifies addition to a RAM file.

The PC-8201 opens a file from RAM if `<external device name>` is omitted, but the file name must be supplied. When device name is specified, "CAS:" is designated for data recorder. If file name is omitted in this context, the PC-8201 opens the first tape file it detects if in input mode, and creates a new tape file if in the output mode but without a file name. The SHIFT and STOP Keys are pressed to interrupt the execution of an OPEN "CAS:" command.

OPEN reserves the buffer space required for input/output and uses it only for the specified file while it is open.

Any file name designated in output mode means that a new file is being created. If an existing file name is used for output, its content is erased when the file is open. Care should be exercised when selecting a file name for OPEN OUTPUT.

**NOTE:** Please refer to OPEN "COM" for details on its subject.

**SEE ALSO:** The CLOSE and OPEN "COM" statements, and Files in Chapter 5.

**SAMPLE PROGRAM:**
```text
20  OPEN 'SESAME' FOR OUTPUT AS #1
30  PRINT#1, 'OPEN SESAME!'
40  PRINT#1, 'CLOSE SESAME!'
50  CLOSE
60  OPEN 'SESAME' FOR INPUT AS #1
70  INPUT #1,A$:PRINT A$:SOUND 2000,20
80  INPUT #1,A$:PRINT A$:SOUND 5000,20
90  CLOSE
100 PRINT 'THE SESAME FILE IS NOW
    ARRANGED.'
110 PRINT 'FILES':FILES
```

---

## OPEN "COM"

**FUNCTION:** This statement opens up the RS-232C circuit.

**FORMAT:**
```text
              INPUT
OPEN "COM:{<CPBSXS>}" FOR OUTPUT  AS {#} <file number>
```

**SAMPLE STATEMENT:** OPEN "COM:9N82XN" FOR INPUT AS #1

**DESCRIPTION:** This command establishes the RS-232C circuit data transmission format and opens it as a file. `<Mode>` and `<file number>` perform the same way as in the OPEN statement. However, appended output mode cannot be designated.

> **Please refer to OPEN statement for more details.**

The designated parameter that follows the COM: requires six characters to establish a data transmission circuit format. Respective designation are as follows.

"COM: `<CPBSXS>`"

where CPBSXS stands for:

| Symbol | Meaning |
|--------|---------|
| C | Communications speed (BAUD RATE) |
| P | Parity |
| B | Word Length |
| S | Stop bit |
| X | Control according to "X" parameter |
| S | Control according to shift in/out sequence |

Each different character of the parameter is controlled by a different feature of the communication format.

The following are the values for each different feature of the communication format:

**VALUE** — Communication Speed (Baud Rate) (Bits per second)

| Value | Speed |
|-------|-------|
| 1 | 75 bps |
| 2 | 110 bps |
| 3 | 300 bps |
| 4 | 600 bps |
| 5 | 1200 bps |
| 6 | 2400 bps |
| 7 | 4800 bps |
| 8 | 9600 bps |
| 9 | 19200 bps |

**PARITY**

| Value | Meaning |
|-------|---------|
| N | No Parity |
| E | Even Parity |
| O | Odd Parity |
| I | Parity Bit Ignored |

**WORD LENGTH**

| Value | Meaning |
|-------|---------|
| 6 | 6 word length bits |
| 7 | 7 word length bits |
| 8 | 8 word length bits |

**STOP BIT**

| Value | Meaning |
|-------|---------|
| 1 | 1 Stop Bit |
| 2 | 2 Stop Bits |

**CONTROL ACCORDING TO "X" PARAMETER**

| Value | Meaning |
|-------|---------|
| X | Affects Control |
| N | Does not Affect Control |

The "X" parameter controls communication transmission by using CTRL + S to start and CTRL + Q to stop transmission.

**CONTROL ACCORDING TO SHIFT IN/OUT SEQUENCE**

| Value | Meaning |
|-------|---------|
| S | Affects Control |
| N | Does not Affect Control |

If the value of `<CPBSXS>` is omitted, then the previously established value is in effect.

When the RS-232C circuit is used in BASIC, two separate files must be opened to send transmitted data. The OPEN statement (at either end of the transmission) that was established last is used to set the data transmission format.

The CTRL + S and CTRL + Q functions can be transmitted although only the input/output of a file is opened.

**NOTE:** The RS-232C circuit cannot be used while the data recorder is in use.

> **Please refer to the TELCOM command in the PC-8201 User's Guide for specific precautions.**

**SEE ALSO:** The OPEN and COM ON/OFF/STOP statements, and TELCOM section of the PC-8201 User's Guide.

---

## OR

**FUNCTION:** This logical operator is used to test multiple relations.

**FORMAT:**
```text
<operand 1> OR <operand 2>
```

**SAMPLE STATEMENT:** IF A=5 OR B=5 THEN 200

**DESCRIPTION:** The logical operator OR performs tests on multiple relations, bit manipulation, and Boolean operation. It returns either a non-zero (true) or zero (false) value.

For the operation to return a non-zero (true) value, the condition of at least one `<operand>` has to be true, or else the operation returns zero (false).

The following table indicates the evaluation process:

−1 OR −1 → −1 (TRUE OR TRUE → TRUE)

−1 OR 0 → −1 (TRUE OR FALSE → TRUE)

0 OR −1 → −1 (FALSE OR TRUE → TRUE)

0 OR 0 → 0 (FALSE OR FALSE → FALSE)

> **For more details on logical operators see Chapter 3.**

**NOTE:** Logical `<operators>` work by converting their `<operands>` to sixteen bit binary integers. Therefore, `<operand 1>` and `<operand 2>` must range from −32768 to +32767. If not, an "?OV Error" (Overflow) message will be displayed.

**SEE ALSO:** Functions AND, EQV, IMP, NOT, XOR, and Chapter 3.

**EXAMPLE:**

| INTEGER | BINARY BITS        |
|---------|--------------------|
| 23280   | 0101 1010 1111 0000 |
| 11853   | 0010 1110 0100 1101 |

After you input the statement PRINT 23280 OR 11853, the integer 32509 appears, whose binary is 0111 1110 1111 1101. By looking at the above table in DESCRIPTION, notice that the computation is correct.

---

## OUT

**FUNCTION:** This statement sends data to a specific port.

**FORMAT:**
```text
OUT <port number>, <data>
```

**SAMPLE STATEMENT:** OUT 1,32

**DESCRIPTION:** The OUT statement sends data to a designated output port. The `<port number>` must be an integer ranging from 0 to 255, while `<data>` is the data that is output through the port.

**NOTE:** If the OUT statement is not used correctly BASIC might not operate normally.

---

## PEEK

**FUNCTION:** This function loads the content of a designated location in the memory.

**FORMAT:**
```text
PEEK (<address>)
```

**SAMPLE STATEMENT:** A=PEEK (61400)

**DESCRIPTION:** The PEEK function returns the memory content of a designated `<address>`. Any value from 0 through 65535 may be designated for `<address>`.

Any numbers (specified for `<address>`) that contain decimal fractions are rounded off.

**SEE ALSO:** The POKE command.

---

## POKE

**FUNCTION:** This command writes data to a designated memory address.

**FORMAT:**
```text
POKE <address>, <data>
```

**SAMPLE STATEMENT:** POKE 61400,201

**DESCRIPTION:** This command is used to write one byte (8 bits) of data into a designated location in the memory. The `<address>` is designated with 2 byte integers between 0 and 65535. The `<data>` is designated by one byte integers between 0 and 255. The POKE statement is used in conjunction with the PEEK statement to perform the inverse operation. It is used when the numeric values of a Machine Language subroutine are to be accessed.

**NOTE:** The POKE command rewrites the current memory content. Therefore, it should only be used after checking the memory to ensure that data in the BASIC work area is not destroyed. It is quite easy to destroy programs and files if you do not adequately understand Machine Language. If the PC-8201 operates abnormally after the POKE statement is used, the Reset Switch may be pressed to restore normal operation.

**SEE ALSO:** The PEEK statement and Machine Language Programming.

---

## POS

**FUNCTION:** This function determines the current cursor column.

**FORMAT:**
```text
POS(<expression>)
```

**SAMPLE STATEMENT:** PRINT"123456" ;POS(0)

**DESCRIPTION:** The POS (position) function determines the current column position (horizontal position) of the cursor on the screen.

The `<expression>` is only used for the value that is returned by the POS function. Therefore, it does not make any difference what value is used for the `<expression>`.

**NOTE:** Since there are 40 columns on the screen, the returned value is always between 0 through 39.

**SEE ALSO:** The CSRLIN function.

**SAMPLE PROGRAM:**
```text
10  CLS
20  PRINT:PRINT'PC-8201';
30  PRINT POS(X)
40  LOCATE 2,2
50  PRINT POS(X)
60  LOCATE 4,4
70  PRINT POS(X)
```
## POWER

**FUNCTION:** This statement automatically turns OFF the electrical power of the PC-8201.

**FORMAT:**
```text
POWER [ <timer> ]
      [ OFF    ] ,RESUME
      [ CONT   ]
```

**SAMPLE STATEMENTS:**
```text
POWER 200
POWER OFF
POWER CONT
```

**DESCRIPTION:** The designated value for `<timer>` can be ranging from 10 through 255, at increments of approximately 6 seconds per unit. Keyboard input is not accepted once the designated `<timer>` is reached and the electrical power is automatically turned OFF. Once the value for the `<timer>` has been established, it remains at that value until it is reset or modified.

The electrical power of the PC-8201 is promptly turned OFF when a POWER OFF command is executed. It returns to the MENU mode when the power switch is turned ON again. If optional parameter ",RESUME" is also appended, the PC-8201 is reinstated in the configuration when it was automatically turned OFF. The contents of the variables is also reinstated.

After a POWER CONT (Continuous Power) command is executed, the automatic power shut off function is deactivated until the POWER `<timer>` command is input again.

It is not recommended to execute the POWER CONT command unless an AC Adapter is used, otherwise the batteries may be severely drained.

In the sample statement, the POWER 200 statement will cause the PC-8201 to shut off in 20 minutes, if nothing is input or output during that time. The calculation of time for the sample statement is as follows:

200 units * 6 seconds (per unit) = 1,200 seconds or 20 minutes


## PRESET

**FUNCTION:** This statement resets the desired dot pattern on the LCD screen.

**FORMAT:**
```text
PRESET (<horizontal coordinate>, <vertical coordinate> {,<function code>})
```

**SAMPLE STATEMENT:**
```text
PRESET (80,32)
```

**DESCRIPTION:** The PRESET statement resets dots on the screen at the designated coordinates. The `<vertical>` and `<horizontal>` coordinates or the function code must be within the range from 0 to 255 or else an error occurs.

The system for the dot coordinates for the LCD display is 239 X 63. If the `<horizontal coordinate>` is greater than 239, it is generally treated as 239, and if the `<vertical coordinate>` is greater than 63 it is generally treated as 63.

When the `<function code>` is an even number, the PRESET command reverses, and operates exactly the same way as the PSET command.

If the `<function code>` is an odd number the command operates the same way as when it is omitted.

**SEE ALSO:** PSET statements.

**SAMPLE PROGRAM:**
```text
10  PRINT' THESE SENTENCES WILL'
20  PRINT
30  PRINT'  DISAPPEAR SLOWLY'
40  PRINT
50  PRINT'  BY THE EFFECTS OF'
60  PRINT
70  PRINT'  PRESET!';
80  FOR Y=0 TO 55:FOR X=30 TO 160
90  PRESET(X,Y):NEXT X,Y
```


## PRINT/LPRINT

**FUNCTION:** These statements output information to the display screen or to a printer.

**FORMAT:**
```text
[PRINT ] {"} {<expression> ...} {"}
[LPRINT]
```

**SAMPLE STATEMENTS:**
```text
PRINT "ABC"
LPRINT "PC-8201"
```

**DESCRIPTION:** The PRINT statement outputs the values of a designated expression or a string to the display screen, while the LPRINT statement outputs to a printer.

A PRINT statement by itself (without expression), will cause a line feed carriage return to be executed. If a comma is used to separate each individual item, it causes these items to be printed every 14 spaces, which are called print zones.

A question mark (?) can be used as the abbreviated form of the PRINT statement.

**NOTE:** A comma (,), semicolon (;), or blank space can be omitted, except for punctuation within a string (where a variable is enclosed by quotation marks). In this case, the operation is identical to using a semicolon for punctuation.

Single Precision numbers can be displayed without loss of precision in six columns (excluding exponential format). Double Precision numeric values can be displayed without loss of precision (excluding exponential format) in sixteen columns.

**SAMPLE PROGRAM:**
```text
10  PRINT'IF YOU DO NOT WANT AN
    INDENTATION,';
20  PRINT'THEN',
30  PRINT'USE A SEMICOLON.'
```


## PRINT USING/LPRINT USING

**FUNCTION:** This statement outputs formatted data to the display screen or to a printer.

**FORMAT:**
```text
[PRINT ] USING <formatting string>;
[LPRINT]       <numeric expression>
               {[,] <numeric expression list>
                [;] }
```

**SAMPLE STATEMENT:**
```text
PRINT USING "##  ####";2.3;4567
```

**DESCRIPTION:** The PRINT USING statement outputs numeric data in a designated format. It formats numbers in several ways, making it easier to read and interpret the output on the screen. LPRINT USING outputs data to a printer in the same manner.

PRINT USING/LPRINT USING allows you to specify:

- Number of significant digits.
- Location of decimal point.
- Exponential format.
- Inclusion of symbols (asterisk, dollar sign, comma, leading zeros).
- Indicate negative values.

The output of a `<numeric expression>` field will always be the same length as the length of the `<formatting string>`, unless there is insufficient space and an error occurs.

If the field specified by the `<formatting string>` is not large enough for the `<numeric expression>`, the number that is printed includes a "%" symbol at the beginning.

The `<formatting string>` may include the following:

1. The "#"(symbol) pound sign , which reserves space for one digit and indicates that leading zeros are to be suppressed. For example:

```text
PRINT USING "###";3
PRINT USING "###";3333
```

results:

```text
__3
%333
```

> **NOTE** **The underscore (_) denotes a blank space.**

2. The ".", (decimal point), which specifies the number of digits to the left and right of the decimal point. The digits to the left of "." will always be printed, even if zeros are required.

Rounding will occur when the number of specified spaces to the right of "." is less than the `<numeric expression>`. Only one "." may be specified. A second "." indicates the end of the old format field and the beginning of a new one. For example:

```text
PRINT USING "###.##";2.5
PRINT USING "###.##"2.555
PRINT USING "###.#.#";2.34,45
```

will result:

```text
__2.50
__2.56
__2.3%45.0
```

3. The "," symbol (comma), which is used anywhere within the `<formatting string>`, after the first character and before the decimal point. It punctuates the printed number with "," appearing every third digit, starting from the decimal point and heading left. For example:

```text
PRINT USING "##,##.###";2222.2
PRINT USING "#,#####.##";123456
PRINT USING "#####,#";1234.5
```

will result:

```text
2,222.200
%123,456.00
_1235.,
```

4. The "+" symbol (plus sign), which is used at the beginning or at the end of the `<formatting string>`, and specifies the sign (+ or -) of the `<numeric expression>`. For example:

```text
PRINT USING "+##.##";2
PRINT USING "##.#+";34.5
PRINT USING "+##.##";-3
PRINT USING "###.#+";-34.5
PRINT USING "#,####.#+";12345.6
```

will result:

```text
_+2.00
34.5+
_-3.00
_34.5-
12,245.6+
```

5. The "-" symbol (minus sign), which is used only at the end of the `<formatting string>`, and specifies the sign (+ or -) of the `<numeric expression>`. For example:

```text
PRINT USING "###.#-";-123
PRINT USING "##.#-";12.3
PRINT USING "#,####.#-"-12345.6
```

will result:

```text
123.0-
12.3
12,345.6-
```

6. The "^" symbol (exponent), which is used at the end of the `<formatting string>`, and outputs the exponential format of a `<numeric expression>`. For example:

```text
PRINT USING "###.###^^^^";123456
PRINT USING "#.###^^^^";1234567
PRINT USING "#.###^^^^";-1234567
```

will result:

```text
_12.346E+04
0.123E+07
-.123E+07
```

7. The "**" (asterisks), which are used at the beginning of the `<formatting string>`, and provide the number with leading asterisks instead of with leading zeros. For example:

```text
PRINT USING "**###.##-";-2.2
PRINT USING "**######+";-123
PRINT USING "** ##.####.#-";-12345.6
```

will result:

```text
****2.20-
****123-
***12,345.6-
```

**NOTE:** When characters that are not described above are used, they will be printed before or after any numeric values.

**SEE ALSO:** The PRINT/LPRINT, PRINT#, and PRINT# USING statements.

**SAMPLE PROGRAM:**
```text
10  PRINT'LET'S CREATE TWO HUNDRED
    RANDOM NUMBERS OF FOUR COLUMNS
    EACH.'
20  FOR I=0 TO 24
30  FOR J=0 TO 7
40  R=RND(1)*10000
50  PRINT USING'####';R;
60  NEXTJ,I
```


## PSET

**FUNCTION:** This statement sets a desired dot pattern on the LCD screen of the PC-8201.

**FORMAT:**
```text
PSET (<horizontal coordinate>, <vertical coordinate> {,<function code>})
```

**SAMPLE STATEMENT:**
```text
PSET (80,32)
```

**DESCRIPTION:** The PSET statement sets dots on the screen at the designated coordinates. The `<vertical>` and `<horizontal>` coordinates of the `<function code>` must be within the range from 0 to 255, or else an error occurs.

The LCD display has 240 dots horizontally and 64 dots vertically. If the `<horizontal coordinate>` is greater than 239 it is generally treated as 239, and if the `<vertical coordinate>` is greater than 63 it is generally treated as 63.

When the `<function code>` is an even number, the PSET command reverses, and operates exactly the same way as the PRESET command. If the `<function code>` is an odd number, the command operates the same as if it was omitted.

**SEE ALSO:** PRESET statements.

**SAMPLE PROGRAM:**
```text
10  SCREEN 0,0:CLS
20  A=150:B=.05:C=11
30  FOR T=-15 TO 72 STEP .13
40  X=EXP(-T*B)*COS(160*3.14*T/180-A)
50  Y=EXP(-T*B)*COS(160*3.14*T/180-C)
60  X=X*120+120:Y=Y*32+32
70  IF X>=0 AND X<256 AND Y>=0 THEN
    PSET(X,Y)
80  NEXT
90  BEEP
```


## READ

**FUNCTION:** This statement is used to read a value from a DATA statement and assign data to a variable.

**FORMAT:**
```text
READ <variable list>
```

**SAMPLE STATEMENT:**
```text
READ A,Z,H$
```

**DESCRIPTION:** The READ statement is always used in conjuction with the DATA statement. The READ statement is used to accept data from the DATA statements and assigns corresponding data to a variable. Numeric or string variables may be contained in the READ statement.

A single READ statement may access one or more DATA statements (accessed in order). In addition, multiple READ statements may access a single DATA statement. If the number of data items in the DATA statement is less than the variables specified in the `<variable list>`, an "?OD Error" (out of data) message is displayed.

When designated variables in the `<variable list>` are less than the amount of data in a DATA statement, the next READ statement accesses data not read previously. If no more READ statements are coded in the program, any extra data is ignored.

If repeat utilization of the same data in a program is necessary, the RESTORE statement can make this possible by recycling through the complete or partial set of DATA statements.

**SEE ALSO:** The RESTORE and DATA statements.

**SAMPLE PROGRAM:**
```text
10  CLS:LOCATE 8,3
20  FOR I=0 TO 8
30  READ R$
40  PRINT R$;'  ';
50  NEXT
60  END
70  DATA Please, read, this, manual.
80  DATA I, (PC-8201), am, reading,
    data.
```


## REM

**FUNCTION:** The REMARK statement is used to put non-executable remarks or comments in a program.

**FORMAT:**
```text
[REM] <remark>
```

**SAMPLE STATEMENTS:**
```text
REM THIS IS A TEST PROGRAM
' THIS IS A TEST PROGRAM
```

**DESCRIPTION:** The REM statement is used to input explanatory remarks or comments in a program. It is not an executable statement.

There is a single quotation mark on the keyboard, used as an apostrophe. An apostrophe (') can be used as a substitute for the keyword "REM" in a REMARK statement.

When the program is listed, all the REM statements are output unchanged. REM statements may be used in multi-statement lines only as the last statement. This is because all statements that follow the REM statement in the multi-statement line are treated as the `<remark>`, and they will not be executed.

**SAMPLE PROGRAM:**
```text
10  REM ** REM **
20  REM A REMARK statement is included as
    an explanation in a program.
30  'An apostrophe can be subsrituted for
    the keyword 'REM' in a REM statement.
40  REM The PC-8201 disregards  anything
    in a REM statement that follows the
    keyword 'REM'.
50  REM Any commands that follow a REM
    statement in the same line will also
    be disregarded.
60  PRINT'HOWEVER, THE REVERSE WITH A
    REM STATEMENT AFTER ANOTHER
    STATEMENT IN A LINE IS POSSIBLE.:
    REM This is useless.'
```


## RENUM

**FUNCTION:** This command is used to reorganize the line numbers of a program.

**FORMAT:**
```text
RENUM {<new line number>} {,<old line number>} {,<increment>}
```

**SAMPLE STATEMENTS:**
```text
RENUM
RENUM 101,50
RENUM ,,6
```

**DESCRIPTION:** The `<new line number>` is the line number replacing the `<old line number>` when renumbering, with a default value of 10. The `<old line number>` is the first line to be renumbered as `<new line number>`, with its default value being the first line number of the current program. Optional `<increment>` is the amount that each subsequent line number is to be incremented, with the default value being 10.

The RENUM command can renumber lines used in conjunction with the GOTO, GOSUB, ON. .GOTO, ON. .GOSUB, THEN RESTORE statements, and ERL function. If a non-existent line is designated by one of these statements, an "Undefined line *llll* in yyyy" error message appears on the screen. In such a case, an erroneous line number (*llll*) cannot be modified via the RENUM command, but line number (yyyy) can be altered.

The PC-8201 returns to Direct Mode after the RENUM command is executed.

**NOTE:** The RENUM command cannot be used to change the sequence of program lines, for example, using RENUM 15,30 with three lines numbered 10, 20, and 30 in a program.

Line numbers cannot be written in excess of 65529, or else an "?FC Error" (Illegal Function Call) message will occur.


## RESTORE

**FUNCTION:** The RESTORE statement is used to manipulate the data list pointer, and thus re-use data elements from the DATA statement.

**FORMAT:**
```text
RESTORE {<line number>}
```

**SAMPLE STATEMENT:**
```text
RESTORE 80
```

**DESCRIPTION:** The RESTORE statement is used when the same data elements (from the DATA statement) are needed to be utilized more than once.

If `<line number>` is omitted, the first DATA statement in the program is accessed by the next READ statement.

IF `<line number>` is specified, the first item of the DATA statement (designated by `<line number>`) is the next item to be accessed.

**SAMPLE PROGRAM:**
```text
10  FOR I=0 TO 19
20  READ A$:PRINT A$;'  ';
30  RESTORE 70
40  NEXT I
50  RESTORE 80
60  READ A$:PRINT A$
70  DATA Anything
80  DATA 'can be read as data.'
```


## RESUME

**FUNCTION:** This statement is used to continue program execution after performing an error processing routine.

**FORMAT:**
```text
RESUME [ <0>         ]
       [ <NEXT>      ]
       [ <line number> ]
```

**SAMPLE STATEMENTS:**
```text
RESUME
RESUME NEXT
RESUME 100
```

**DESCRIPTION:** The RESUME statement terminates an error handling routine and the parameter specifies NEXT action when program execution continues. This statement functions in a manner similar to the RETURN statement, but may only be used in an error routine, and then returns control to BASIC after an error processing routine has been performed.

Depending on the location where program execution is to continue after an error processing routine, one of the following three formats is selected:

1. RESUME or RESUME0 — continues execution at the statement that caused the error.

2. RESUME NEXT — continues execution at the statement immediately after the statement where the error occurred.

3. RESUME `<line number>` — continues execution but control is to be transferred to the line specified.

**SEE ALSO:** The ON ERROR GOTO statement.


## RETURN

**FUNCTION:** The RETURN statement terminates execution in a subroutine and returns control to the statement following the GOSUB (call) statement.

**FORMAT:**
```text
RETURN {<line number>}
```

**SAMPLE STATEMENTS:**
```text
RETURN
RETURN 200
```

**DESCRIPTION:** The RETURN statement from the subroutine transfers control to the first statement which follows the GOSUB statement.

If an optional `<line number>` is included with the RETURN statement, program execution transfers to the line number specified, and the statement following the GOSUB call is discarded.

A GOSUB statement is used when performing (calling) subroutines. If a GOSUB is not executed first, and a RETURN is encountered an "?RG Error" (Return without gosub) message will be displayed.

A subroutine can have more than one RETURN statement. Only one RETURN statement is executed each time a subroutine is called.

**NOTE:** If a CLEAR command is executed in a subroutine, the line number to which the subroutine is to return is removed from the memory. An "?RG Error" (Return without Gosub) message results when the RETURN statement is reached.

**SEE ALSO:** See the CLEAR, GOSUB...RETURN, and ON...GOSUB statements.

**SAMPLE PROGRAM:**
```text
10  GOSUB 200
20  A%=A%+1: PRINT A%;
30  IF A% < 6 THEN GOSUB 200
40  END
200 IF A% < 5 THEN RETURN 20
210 RETURN
```


## RIGHTS

**FUNCTION:** This function is used to access a specific number of characters from a string, starting from the right most position of the string.

**FORMAT:**
```text
RIGHT$(<character string>,<numeric expression>)
```

**SAMPLE STATEMENT:**
```text
B$=RIGHT$(A$,4)
```

**DESCRIPTION:** The `<character string>` can be a string constant or a string variable. The `<numeric expression>` is a value ranging from 0 to 255, which specifies the number of characters to be read, beginning from the right most character.

The full `<character string>` is returned when the `<numeric expression>` is greater than or equal to the total number of characters in the `<character string>`. The RIGHT$ statement returns a null string when the `<numeric expression>` is 0.

**SEE ALSO:** The LEFT$ and MID$ functions.

**SAMPLE PROGRAM:**
```text
10  A$='CONTEST'
20  B$=RIGHT$(A$,4)
30  PRINT'THE ';RIGHT$('ALRIGHT',5);
    '$ FUNCTION PASSED THIS ';B$;'.'
40  END
```


## RND

**FUNCTION:** The RND function generates a uniformly distributed random number between 0 and 1.

**FORMAT:**
```text
RND (<numeric expression>)
```

**SAMPLE STATEMENT:**
```text
PRINT RND (9.9)
```

**DESCRIPTION:** The RND (Random) function is used whenever you want the PC-8201 to pick a number, flip a coin, draw a card, etc.

The random number that is furnished by the RND function is a floating point (real number) between 0 and 1, and it depends upon the `<numeric expression>`. The following cases apply to the RND function:

- If the `<numeric expression>` is positive, an ordinary random number is generated.

- If the `<numeric expression>` is zero, the same number as the most recent one designated is generated repeatedly.

- If the `<numeric expression>` is less than zero (negative number), a new random series is established by changing the random seed.

**SAMPLE PROGRAM:**
```text
10  X=120:Y=32
20  SCREEN 0,0:CLS
30  X=X+INT(RND(1)*3)-1
40  IF X<0 OR X>255 THEN X=120
50  Y=Y+INT(RND(1)*3)-1
60  IF Y<0 OR Y>63 THEN Y=32
70  PSET(X,Y)
80  GOTO 30
```


## RUN

**FUNCTION:** This statement is used to execute a program already in memory or to load a program and execute it.

**FORMAT:**
```text
RUN {<line number>}
RUN "{<device name>:}<program name>" {,R}
```

**SAMPLE STATEMENTS:**
```text
RUN 100
RUN "GAME"
```

**DESCRIPTION:** The format of RUN {`<line number>`} is used to execute a program from a designated `<line number>`. Program execution starts from the first line if the `<line number>` is not specified.

When a parameter is not specified with the RUN statement, the program currently in the memory is executed starting from the first statement of that program. If a program does not exist in the memory, the PC-8201 will display an "Ok" message and execution is not performed.

The format RUN "{`<device name>`:}`<program name>`" {,R} loads a program file from the RAM if `<device name>` is omitted. When "CAS:" is designated, a program file from the data recorder is loaded and executed. If option "R" is included, it will open all data files.

When a RUN statement is executed all open files are closed, and the contents of the BASIC area is cleared when the program is loaded.

The PC-8201 reverts back to Direct Mode after program execution is completed.

**NOTE:** The loading for RUN "CAS:" can be interrupted by pressing both the [SHIFT] Key and [STOP] Key at the same time.

**SAMPLE PROGRAMS:**
```text
5   'SAVE  THIS PROGRAM UNDER  THE  NAME
    RUN 1
10  REM ** RUN 1 **
20  REM It's not easy to use a 'RUN'
    command within an actual program.
30  PRINT'IF IT RUNS, THE PROGRAM WILL
    NOT STOP.'
40  PRINT
50  PRINT'PRESS THE STOP KEY!'
60  PRINT
70  RUN 'RUN 2'
```

```text
5   'SAVE  THIS PROGRAM UNDER  THE  NAME
    'RUN 2'
10  REM ** RUN 2**
20  PRINT'NOW, RUN 2 IS BEING EXECUTED.'
30  PRINT
40  PRINT'NEXT, LET'S RETURN TO RUN 1.'
50  PRINT
60  RUN 'RUN 1'
```


## SAVE

**FUNCTION:** This command is used to save a program on a designated device.

**FORMAT:**
```text
SAVE "{<external device name>:}<file name>" {,A}
```

**SAMPLE STATEMENTS:**
```text
SAVE "ENERGY",A
SAVE "CAS:ENERGY",A
```

**DESCRIPTION:** This command saves a program currently in the memory into RAM or onto external devices. The designated `<file name>` can be six characters or less. When an identical `<file name>` is specified, (compared to an existing file name) the original file content will be overwritten. After the command is executed, the PC-8201 returns to Direct Mode.

The PC-8201 saves a program file from the RAM if `<external device name>` is omitted. When `<external device name>` is specified, "CAS:" is designated for data recorder, "COM:" is designated for an RS-232C circuit, and "LPT:" is used to designate a printer.

For more details, please refer to the CSAVE command for "CAS:", the OPEN command for "COM:", and the LLIST command for "LPT:".

File type ".BA" is automatically selected if none is specified. If file type ".DO" is designated for a ".BA" file, or if option "A" is assigned, then a ".DO" file in ASCII format is created.

Once a program file is saved, it is maintained as a file unless another program is saved with an identical file name, until a KILL command is executed, or when a Cold Start is performed.
An "?FC Error" (Illegal function call) message will
be displayed if a program is saved twice with the
same file name.

**NOTE:** A program file in the RAM cannot be saved if it is
retrieved into the BASIC area by a LOAD command.

The LIST command can be executed before the
SAVE command.  This is to display the program
content before saving, and any required changes can
then be made.

If screen editing is performed while a program is in
access mode (indicated by an asterisk when the
FILES command is executed), the original statement(s) is rewritten by the newly input statement(s).

A program should be saved as a ".DO" file if
adequate memory capacity is available.  If this is
not possible, try saving the program on cassette tape
as a ".BA" file.  Use the option "A" when
creating a ".DO" (ASCII format) file on cassette.  The SHIFT and STOP Keys can be pressed
simultaneously to interrupt the SAVE "CAS:"
command.

**SEE ALSO:** The CSAVE, LOAD, LLIST, BSAVE, and OPEN
"COM:" commands, and Chapter 5, Files.

---

## SCREEN

**FUNCTION:** This statement establishes the display mode.

**FORMAT:**
```text
SCREEN 0, <function key display switch>
```

**SAMPLE
STATEMENT:** `SCREEN 0,0`

**DESCRIPTION:** The SCREEN statement establishes the display
mode.

When the `<function key display switch>` is 0, the
function key is not indicated and display is 8 lines
long.

The first parameter is dammy and can be omitted,
and the comma is always needed.  For
example:

```text
SCREEN 0, 1 (function key display enable)

SCREEN 0, 0 (function key display disenable)
```

The `<function key device switch>` must be in the
range from 0 to 255, or else an error occurs.

**SEE ALSO:** The CLS statement.

**SAMPLE
PROGRAM:**
```text
10  FOR I=0 TO 21
20  SCREEN 0,I MOD 2
30  NEXT
```

---

## SGN

**FUNCTION:** This function determines whether a number has a
negative or positive sign.

**FORMAT:**
```text
SGN (<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT SGN (-245)`

**DESCRIPTION:** The SGN function returns 1 if the <numeric
expression> is positive, 0 if the `<numeric expression>` is 0, and −1 is returned if the <numeric
expression> is negative.

**SAMPLE
PROGRAM:**
```text
10  READ X
20  IF X=999 THEN END
30  PRINT X,SGN(X)
40  GOTO 10
50  DATA 55,2,0,-3,4,18,5,999
60  END
```

---

## SIN

**FUNCTION:** This function provides the sine of a numeric
expression.

**FORMAT:**
```text
SIN (<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT SIN (3.14159/2)`

**DESCRIPTION:** The SIN function has many practical uses such as
trigonometric applications.  The `<numeric expression>` determines the angle expressed in radians.

**NOTE:** To convert an angle from degrees to radians,
multiply it by .0174533.

**SEE ALSO:** The ATN, COS, and TAN functions.

**SAMPLE
PROGRAM:**
```text
10  SCREEN 0,0:CLS
20  X=0:N=0:F=1
30  Y=SIN(N/25)*32+33
40  PSET(X,Y)
50  IF X<1 THEN F=1
60  IF X>239 THEN F=-1
70  X=X+F:N=N+1
80  GOTO 30
```

---

## SOUND

**FUNCTION:** This command produces a designated sound.

**FORMAT:**
```text
SOUND <tone>, <length>
```

**SAMPLE
STATEMENT:** `SOUND 5586,50`

**DESCRIPTION:** This command is designated by tone and
length, which produce a sound.  The integers
for the tones range from 0 through 16383, where
higher numbers produce a higher pitch
tone.  Length is comprised of integers within a
range of 0 through 250, where the length of a single
unit is 0.02 seconds.

The designation of 5586 in the example produces a
sound of 440 Hz.

MUSICAL SCALE TABLE: <!-- source prints "MUSCIAL"; corrected to MUSICAL. Left margin of the source table carries a vertical "CODE" label spanning all note rows. -->

| CODE | OCTAVE 1 | OCTAVE 2 | OCTAVE 3 | OCTAVE 4 | OCTAVE 5 | OCTAVE 6 |
|------|----------|----------|----------|----------|----------|----------|
| C  | —     | 9394 | 4697 | 2348 | 1171 | 587 |
| C# | —     | 8866 | 4433 | 2216 | 1103 | 554 |
| D  | —     | 8368 | 4184 | 2092 | 1045 | 523 |
| D# | 15800 | 7900 | 3950 | 1975 | 987  | 493 |
| E  | 14912 | 7456 | 3728 | 1864 | 932  | 466 |
| F  | 14064 | 7032 | 3516 | 1758 | 879  | 439 |
| F# | 13284 | 6642 | 3321 | 1660 | 830  | 415 |
| G  | 12538 | 6269 | 3134 | 1567 | 783  | —   |
| G# | 11836 | 5918 | 2954 | 1479 | 733  | —   |
| A  | 11172 | 5586 | 2793 | 1396 | 693  | —   |
| A# | 10544 | 5272 | 2636 | 1316 | 653  | —   |
| B  | 9952  | 4968 | 2486 | 1244 | 622  | —   |

**SEE ALSO:** The BEEP statement.

**SAMPLE
PROGRAM:**
```text
10  DIM S(17):Z#=4697
20  FOR I=1 TO 17
30  S(I)=Z#
40  Z#=Z#/1.0594639#
50  NEXT
60  FOR I=1 TO 16
70  SOUND S(15),32/I:SOUND S(17),32/I
80  SOUND S(13),32/I:SOUND S(1),32/I
90  SOUND S(8),48/I:SOUND S(0),16/I
100 NEXT I
```

---

## SPACES

**FUNCTION:** This function provides spaces (blanks) of a desired
length.

**FORMAT:**
```text
SPACE$ (<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT "A"+"B"+SPACE$(5)+"C"`

**DESCRIPTION:** The SPACE$ function is used in spacing output for
reports and forms.  It will provide a string of
spaces determined by the designated <numeric
expression>.  The value of the `<numeric expression>` must range from 0 to 250.

**SEE ALSO:** The TAB function.

**SAMPLE
PROGRAM:**
```text
10  FOR Z=1 TO 12
20  PRINT '*'+SPACE$(Z)+'*'
30  NEXT Z
40  END
```

---

## SQR

**FUNCTION:** This function provides the square root of a number.

**FORMAT:**
```text
SQR (<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT SQR (16)`

**DESCRIPTION:** The SQR function is used to compute the square
root of a positive `<numeric expression>`.  If the
`<numeric expression>` is negative, the message
"?FC Error" (illegal function call) will be displayed.

**SAMPLE
PROGRAM:**
```text
10  INPUT 'WHAT'S YOUR NUMBER';X
20  IF X=0 THEN END
30  PRINT 'THE SQUARE ROOT IS';SQR(X)
40  GOTO 10
```

---

## STOP

**FUNCTION:** The STOP statement is used to halt program
execution and return to Direct Mode.

**FORMAT:**
```text
STOP
```

**SAMPLE
STATEMENT:** `STOP`

**DESCRIPTION:** When a STOP statement is executed, the PC-8201
halts the execution of a program.  The following
message is displayed on the screen.  "Break in
*llll*" is displayed, with "*llll*" representing the
line number that the STOP statement has executed.

A STOP statement differs from an END statement
because STOP does not close the file.  This statement is useful for debugging programs.  The execution of the program can be resumed by using the
CONT command, unless the program has been
altered while stopped.

**SEE ALSO:** The CONT command.

**SAMPLE
PROGRAM:**
```text
10  PRINT'Use a STOP command for
    debugging.'
20  PRINT'Use a CONT command to continue
    the execution of the program.'
30  STOP 'USE CONT TO CONTINUE
40  I=1:PRINT I;'Resume execution.'
50  GOTO 20
```

---

## STR$

**FUNCTION:** This function converts a numeric value to a numeric
string.

**FORMAT:**
```text
STR$(<numeric expression>)
```

**SAMPLE
STATEMENT:** `A$=STR$(123)`

**DESCRIPTION:** The STR$ function converts the value of the
`<numeric expression>` to a string.  This function
is useful for programming a sort routine that
includes both numbers and characters.  If the
`<numeric expression>` contains a non-numeric
character, then a 0 will be returned.

**SEE ALSO:** The VAL and STRING$ functions.

**SAMPLE
PROGRAM:**
```text
10  PRINT'ENTER A 1 OR 2 DIGIT NUMBER'
20  INPUT'NOW, WHAT HOUR IS IT';H:H$=
    MID$(STR$(H),2)
30  IF LEN(H$)=1 THEN H$='0'+H$
40  INPUT'HOW MANY MINUTES';M:M$=MID$
    (STR$(M),2)
50  IF LEN(M$)=1 THEN M$='0'+M$
60  INPUT'HOW MANY SECONDS';S:S$=MID$
    (STR$(S),2)
70  IF LEN(S$)=1 THEN S$='0'+S$
80  TIME$=H$+':'+M$+':'+S$
90  PRINT'THE TIME HAS NOW BEEN SET AT'
    ;TIME$;'.'
```

---

## STRING$

**FUNCTION:** This function provides a string which contains the
specified character, repeated a designated number of
times.

**FORMAT:**
```text
STRING$(<numeric expression>),
         <character string>
         <ASCII code>         )
```

**SAMPLE
STATEMENTS:** `PRINT STRING$(10,"*")`
`PRINT STRING$(10,45)`

**DESCRIPTION:** The STRING$ function returns a string which
contains the desired `<character string>` or <ASCII
code>, repeated by the `<numeric expression>`.

The `<numeric expression>` must be in the range of
0 to 250.  If it is not within this range, a "?TM
Error" (Type Mismatch) message is displayed.  The
`<ASCII code>` is converted to its equivalent character code and then it is returned by the function.

If the `<character string>` is more than one character, only the first character is returned.

**SEE ALSO:** The STR$ function.

**SAMPLE
PROGRAM:**
```text
10  PRINT STRING$(20,'*');'HEADING';STRING$
    (10,'*')
20  PRINT
30  PRINT STRING$(20,'-');'LINE ONE'
40  PRINT STRING$(20,'*');'LINE TWO'
50  PRINT STRING$(20,45);'LINE THREE'
```

---

## TAB

**FUNCTION:** The TAB function is used to space out or separate
data to be printed or displayed on a line.

**FORMAT:**
```text
TAB (<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT "A";TAB(10);"B"`

**DESCRIPTION:** This function is useful for printing reports, tables,
and forms, and to organize the screen display for
maximum readability.

It spaces out or separates data to be printed or
displayed on the current line.  Before the printing
begins, the cursor or the print-head skips to the
position specified by the `<numeric expression>`.  The `<numeric expression>` must be in the
range of 0 to 255, or else and "?FC Error" (Illegal
function call) message will be displayed on the
screen.

The cursor position does not move backward, so if
the position specified by the `<numeric expression>`
is left of the cursor, the TAB function will start
displaying from the right side of the cursor.

The TAB function is only used with the PRINT and
LPRINT statements.

**NOTE:** You can use more than one TAB function on the
same line.

**SEE ALSO:** The SPACE$ function.

**SAMPLE
PROGRAM:**
```text
10  FOR I=1 TO 21 STEP 4
20  PRINT STRING$(I,'#');TAB(22-I);'*'
30  NEXT
```

---

## TAN

**FUNCTION:** This function provides the tangent of an angle.

**FORMAT:**
```text
TAN(<numeric expression>)
```

**SAMPLE
STATEMENT:** `PRINT TAN(3.14159/4)`

**DESCRIPTION:** The TAN function is used in trigonometric applications.  It computes the tangent of an angle.  The
unit of the `<numeric expression>` is the angle
expressed in radians.

**NOTE:** To convert an angle from degrees to radians,
multiply the degrees by .0174533.

**SEE ALSO:** The ATN, COS, and SIN functions.

**SAMPLE
PROGRAM:**
```text
10  INPUT'ENTER AN ANGLE IN DEGREES';D
20  PRINT'THE ';D;' DEGREES ANGLE IS';
    D*.0174533;'RADIAND AND ITS TANGENT
    IS';TAN(D*.0174533)
30  END
```

---

## TIME$

**FUNCTION:** This function provides the time from the internal
real-time clock of the PC-8201.

**FORMAT:**
```text
TIME$="<hour>:<minute>:<second>"
```

**SAMPLE
STATEMENTS:** `TIME$="15:30:20"`
`PRINT TIME$`

**DESCRIPTION:** The TIME$ function is used to set the current
time.  The `<hour>` is a number between 00 and
23.  Both the `<minute>` and `<second>` values are
numbers ranging from 00 through 59, used when
the time is set.  Reset is not necessary once the
time has been set, unless a Cold Start is performed.

**SEE ALSO:** The DATE$ function.

---

## VAL

**FUNCTION:** This function returns the numeric value of a
numeric string.

**FORMAT:**
```text
VAL(<numeric string>)
```

**SAMPLE
STATEMENT:** `PRINT VAL("123")`

**DESCRIPTION:** The VAL function returns the numeric value of a
numeric string.  The "+" or "−" sign can be
used as the first character of the <numeric
string>.  For example:

```text
VAL("−1234.567") = −1234.567
```

Any spaces in the `<numeric string>` are disregarded.  For example:

```text
VAL("12 12") = 1212
```

If any other character not mentioned above is used
within the `<numeric string>`, anything after that
character is ignored.  For example:

```text
VAL("123a4") = 123
VAL("ab") = 0
```

**SEE ALSO:** The STR$ and CHR$ functions.

**SAMPLE
PROGRAM:**
```text
10  A$='123':B$='456.7':C$='-8.9'
20  X=VAL(A$):Y=VAL(B$):Z=VAL(C$)
30  D$=A$+B$+C$
40  N=X+Y+Z
50  PRINT A$,B$,C$,D$
60  PRINT X,Y,Z,N
70  END
```

---

## XOR

**FUNCTION:** This logical operator is used to test multiple
relations.

**FORMAT:**
```text
<operand 1> XOR <operand 2>
```

**SAMPLE
STATEMENTS:** `IF A=5 XOR B=5 THEN 200`
`PRINT 5+3 XOR 4+4`

**DESCRIPTION:** The logical operator XOR (exclusive OR) performs
tests on multiple relations, bit manipulation, and
Boolean operations.  It returns either a non-zero
(true) or zero (false) value.

For the operation to return a non-zero (true) value,
one of them has to be true and the other must be
false.  Otherwise, if both of them are true, or both
are false, the operation returns a zero (false) value.

The following table indicates the evaluation process:

```text
−1 XOR −1 → 0  (TRUE XOR TRUE → FALSE)

−1 XOR 0 → −1  (TRUE XOR FALSE → TRUE)

0 XOR −1 → −1  (FALSE XOR TRUE → TRUE)

0 XOR 0 → 0    (FALSE XOR FALSE → FALSE)
```

> **For more details on logical operators see Chapter 3.**

**NOTE:** The XOR function performes exactly opposite from
the EQV function.

Logical operators work by converting their
`<operands>` to sixteen bits binary integers.  Therefore, the `<operands>` must be in the
range from −32768 to +32767.  If the
`<operands>` are not within this range, an "?OV
Error" (Overflow) message will be displayed on the
screen.

**EXAMPLE:**

| INTEGER | BINARY BITS |
|---------|-------------|
| 25 | 0000 0000 0001 1001 |
| 13 | 0000 0000 0000 1101 |

After inputting the statement PRINT 25 XOR 13
the integer 20 appears on the screen, whose binary
is 0000 0000 0001 0100.  By looking at the table
in the DESCRIPTION section above, notice that the
computation is correct.

**SEE ALSO:** The AND, EQV, IMP, NOT, and OR functions.
