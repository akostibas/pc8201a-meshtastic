# Chapter 8: Error Messages

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 230–245). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

This chapter outlines causes and what action you should take when error messages are displayed on your screen.  There are 43 messages programmed into the PC-8201.  Many more error messages could be defined by you, using a BASIC program.

If an incorrect system command, statement, or function is encountered while a BASIC program is running, the program will terminate abnormally and an error message will be displayed.

N82-BASIC has a built-in error trap function.  To simplify the process of determining the source of errors within a program, the explanations of error messages listed are in alphabetical order.

## Error Messages

**MESSAGE:**    **?AO ERROR**  File is Already Open.

**POSSIBLE
CAUSES:**
1. The execution of an OPEN statement for a file already opened.

2. The execution of a KILL statement for an open file.

**USER
ACTION:**   Close the file using the CLOSE command before trying to OPEN it or to KILL it.

---

**MESSAGE:**    **?BN ERROR**  Bad file Number is used.

**POSSIBLE
CAUSES:**
1. When a PRINT statement is used with a file number nor previously designated by an OPEN statement.

2. When an OPEN statement is used to assign a file number larger than the maximum number designated by a MAXFILES command.

**USER
ACTION:**
1. OPEN the file.

2. Use the MAXFILES command to assign the desired number of files.

---

**MESSAGE:**    **?BO ERROR**  Buffer is Overflowed.

**POSSIBLE
CAUSE:**    An attempt is made to input more characters than the buffer can hold.

**USER
ACTION:**   Adjust the program that creates the file to shorten the length of the records.

---

**MESSAGE:**    **?BS ERROR**  Bad Subscript

**POSSIBLE
CAUSES:**
1. When the subscript of an element of an array is incorrect.

2. When the subscript of an element of an array is outside the dimensions of the array.

**USER
ACTION:**
1. Correct the number of elements specified for arrays within the program.

2. Increase the size of array dimensions if necessary.

---

**MESSAGE:**    **?CE ERROR**  Closed File

**POSSIBLE
CAUSE:**    An attempt is made to access an unopened file.

**USER
ACTION:**   Open the file properly before trying to access it.

---

**MESSAGE:**    **?CN ERROR**  Continue Not Possible

**POSSIBLE
CAUSES:**
1. When a CONT statement is used after a break occurs in program execution and the program is then edited.

2. When a CONT command is written as a statement within a program.

3. When a CONT statement is used after a break occurs in program execution, following a CLEAR statement.

**USER
ACTION:**
1. Return the program by using a RUN command.

2. Eliminate the CONT statement from the program content.

3. Rerun the program from the beginning.

---

**MESSAGE:**    **?DD ERROR**  Duplicate Definition

**POSSIBLE
CAUSE:**    An attempt is made to redefine an array previously designated by use of the DIM command.

**USER
ACTION:**   Use the CLEAR command within the program to clear all arrays so that they can be redefined.  When using the NEW or RUN command all arrays will be cleared.

---

**MESSAGE:**    **?DS ERROR**  Direct Statement in File

**POSSIBLE
CAUSE:**    When loading a file using the LOAD command with a file type extension of ".DO", and the file contains a statement without a line number.

**USER
ACTION:**   Enter the ".DO" file while in the TEXT mode and add line numbers to all lines within the file.

---

**MESSAGE:**    **?DU ERROR**  Device Unavailable

**POSSIBLE
CAUSE:**    When there is something unusual or incorrect for a device designation.

**NOTE:**   An "?FC Error" (Illegal Function Call) occurs if no external devices are connected to the PC-8201.

---

**MESSAGE:**    **?EF ERROR**  End of File

**POSSIBLE
CAUSE:**    When using the INPUT statement or LINEINPUT statement beyond the end of the file.

**USER
ACTION:**   Use the EOF command in conjuction with INPUT or LINEINPUT commands to detect the end of the file and avoid going past it.

---

**MESSAGE:**    **?FC ERROR**  Illegal Function Call

**POSSIBLE
CAUSES:**   A parameter that is out of range is passed to a math or string function.  May also occur as the result of:

1. A negative or unreasonably large subscript.

2. A negative or zero argument with LOG

3. A negative argument to SQR or CLEAR

4. When ".BA" files are combined with a MERGE command.

5. When a RENUM statement is used improperly and line sequence is changed.

6. When a device is used that is not connected or is incorrectly connected to the PC-8201.

7. When parameter values are not within the proper range for CLOSE, ERROR, LOCATE, MOTOR, GOTO, GOSUB, OUT, POKE, POWER, PRESET, SCREEN, CHR, EOF, INP, INPUT, INST, LEFT, MID, RIGHT, SPACE, STRING, TAB, KEY, MAXFILES, and SOUND statements.

**USER
ACTION:**
1. Be sure all peripheral devices used with the PC-8201 are attached correctly.

2. Correct all parameter designations entered into the program incorrectly.

> See Chapter 4 for legal parameter designations of system commands, statements, and functions.

---

**MESSAGE:**    **?FF ERROR**  File Not Found

**POSSIBLE
CAUSES:**
1. When a file used with a LOAD, KILL, or OPEN command is not on a designated device.  If the device designated is a Data Recorder, the PC-8201 will continue searching for the file until the end of the tape is reached.

2. When a file with a type extension other than ".CO" is loaded using the BLOAD command.

**USER
ACTION:**
1. Be sure all files loaded with the BLOAD command are ".CO" files.
2. Use the SHIFT Key and the STOP Key simultaneously to interrupt the searching and try the command with the correct name.

---

**MESSAGE:**    **?FL ERROR**  Filing Limit

**POSSIBLE
CAUSE:**    When the MENU director is filled with file names, and no space is avilable for display of a new file name.  Memory bytes may still be free.

**USER
ACTION:**   Move some files to external devices and KILL unwanted files, to create space for more directory entries.

---

**MESSAGE:**    **?IE ERROR**  Internal Error

**POSSIBLE
CAUSE:**    An error occurs within BASIC itself.

**USER
ACTION:**   Consult your Authorized NEC Dealer.

---

**MESSAGE:**    **?IO ERROR**  Input-Output Error

**POSSIBLE
CAUSES:**
1. When the SHIFT Key and STOP Key are pressed to forcibly stop input or output to an external device.

2. When peripheral equipment is in need of maintenance.

**USER
ACTION:**   Check equipment if error occurred spontaneously.  May need maintenance such as cleaning of Data Recorder heads.

---

**MESSAGE:**    **?LS ERROR**  Long String

**POSSIBLE
CAUSE:**    An attempt is made to designate a string longer than 255 characters.

**USER
ACTION:**   Use multiple variables to break down string length to avoid exceeding limit of 255 characters.  If the string was made too long in error, simply change the length designated in the program.

---

**MESSAGE:**    **?MO ERROR**  Missing Operand

**POSSIBLE
CAUSE:**    A necessary operand is missing.

**USER
ACTION:**   Check the program and insert the omitted parameter.

> See Chapter 4 for full explanations of statement format.

---

**MESSAGE:**    **?NE ERROR**  NEXT without FOR

**POSSIBLE
CAUSES:**
1. A program attempts to execute a NEXT statement without the previous execution of a corresponding FOR.

2. When a GOTO or GOSUB subroutine causes a program to jump into a FOR NEXT loop.

3. When a FOR NEXT loop is improperly nested.

**USER
ACTION:**
1. Check that the program has the same number of NEXT and FOR statements.

2. Check the GOTO and GOSUB subroutine operations included in the program, and correct if necessary.

3. Correct improper nesting of FOR NEXT loops.

> See Chapter 4 for rules for the use of nested loops.

---

**MESSAGE:**    **?NM ERROR**  File Name Mismatch

**POSSIBLE
CAUSES:**
1. File name conventions described in Chapter 5 were not followed.

2. An attempt is made to access ".CO" files using commands other than BLOAD or BSAVE.

**USER
ACTION:**
1. Correct file name to follow conventions exactly.

2. Be sure that correct commands for loading and saving of files are used for different file types.

---

**MESSAGE:**    **?NR ERROR**  No Resume

**POSSIBLE
CAUSE:**    When an error processing subroutine has no RESUME statement.

**USER
ACTION:**   Add RESUME, END, or ON ERROR GOTO to error processing subroutines.

---

**MESSAGE:**    **?OD ERROR**  Out of Data

**POSSIBLE
CAUSES:**
1. The elements read by using the READ statement do not correspond to the number of elements within the DATA statements.

2. When a RESTORE statement is not used at all, or is improperly used.

**USER
ACTION:**
1. Check the program to be sure the number of elements designated for READ and DATA statements correspond.

2. Be sure the program includes a RESTORE statement in the appropriate place, before trying to read DATA elements that have been previously read.

> See Chapter 4 for correct use of the RESTORE statement.

---

**MESSAGE:**    **?OM ERROR**  Out of Memory

**POSSIBLE
CAUSES:**
1. When a program is too long to be stored in the memory.

2. When sufficient memory is available for storage of a program but there is not enough available to run it.

3. When an array is too large for the available memory.

4. When a string is too large for the available memory space.

5. When nesting becomes excessively deep with FOR or GOSUB statements.

6. When you are creating or expanding a file and there is no memory available.

7. When memory area required for a Machine Language application becomes too small.

**USER
ACTION:**   Move files to external devices, such as a Data Recorder, or KILL unwanted files to create memory space.

---

**MESSAGE:**    **?OS ERROR**  Out of String Space

**POSSIBLE
CAUSE:**    A sufficient working memory area for string handling has not been maintained.

**USER
ACTION:**   Utilize the CLEAR command to reserve enough RAM space for string operations.  The default value for the working area is 255 characters.  You can use combined (concatenated) strings totaling 255 characters in length.  If more area is needed, you will have to use the CLEAR command to reserve more space.

---

**MESSAGE:**    **?OV ERROR**  Overflow

**POSSIBLE
CAUSES:**
1. When results of an integer operation or substitution are not within the range of −32768 through +32767.

2. When the results of a real number operation are not between −1.70141E+38 and 1.70141E+38.

3. When parameters used with POKE, OUT, and DIM statements are not within the proper range.

**USER
ACTION:**   Rearrange operations within the program so that they flow within the legal ranges.

> See Chapter 4 for descriptions of legal ranges for statements and Chapter 3 for ranges of integer and real number operations.

---

**MESSAGE:**    **?PC ERROR**  PC-8001

**POSSIBLE
CAUSE:**    When an N-BASIC program, which cannot be executed in N82-BASIC, is loaded into the PC-8201.

**USER
ACTION:**   The program will need to be written and modified into an N82-BASIC program.  This error will usually not occur because an "?SN ERROR" or "?FC ERROR" will occur first.

---

**MESSAGE:**    **?RG ERROR**  Return without Gosub.

**POSSIBLE
CAUSE:**    An attempt is made to execute a RETURN statement without a corresponding GOSUB statement.

**USER
ACTION:**
1. Make sure you are ont using a GOTO to execute a subroutine.

2. Make sure to use an END statement, so the program does not fall through any possible subsequent subroutines.

---

**MESSAGE:**    **?RW ERROR**  Resume Without error

**POSSIBLE
CAUSE:**    A RESUME statement is encountered before an error trapping routine is entered.

**USER
ACTION:**
1. Check for any other GOTO's or GOSUB's to error trapping routines, except by using the ON ERROR command.

2. Check for END statement, so at the end the program does not fall through any possible subsequent error trapping routines.

> See Chapter 4 for more information about the ON ERROR command.

---

**MESSAGE:**    **?SN ERROR**  Syntax Error

**POSSIBLE
CAUSES:**
1. When a statement or a command does not agree with the grammar of BASIC.

2. When there is only a function or mathematical expression on the left side of a substitution formula (although it can normally be used alone in a statement).

3. When the name of a variable does not begin with a letter, when a reserved word is included, etc.

4. When a colon is missing as a punctuation mark between multiple statements.

5. When line numbers are not within the range from 0 to 65529.

6. When a variable is used to designate a line number.

7. When an ELSE is used without a THEN in terms of an IF statement.

8. When the number of dummy variables in a function or the parameters of a command are insufficient or in excess.

9. When two lines become joined together during the screen editing process.

**USER
ACTION:**
1. Use the LIST command.  In most cases, the number of the line in which the error has occurred will be displayed, after the f.9 Function Key is pressed.

2. If two lines are joined together, edit this excessively long line in the TEXT mode.

3. Check for an accidental substitution, (1 and l, a period and a comma, a colon and a semicolon, etc.).

4. Check names of variables that might contain a Reserved Word (a keyword), for instance, **COST**, **SHIFT**, etc.

5. Check for compound numeric formulas that are not properly enclosed by punctuation marks.

---

**MESSAGE:**    **?ST ERROR**  String Formula is too complex

**POSSIBLE
CAUSE:**    When an expression is too long or too complex.

**USER
ACTION:**   Expression should be broken into smaller expressions.

---

**MESSAGE:**    **?TM ERROR**  Type Mismatch

**POSSIBLE
CAUSES:**
1. When a string variable name is assigned a numeric value or vice versa.

2. When a function that expects a numerical argument is given a string argument or vice versa.

3. When a Double Precision real number is used as the control variable in a FOR statement.

**USER
ACTION:**   Correct the incorrectly assigned value.

---

**MESSAGE:**    **?UF ERROR**  Undefined User Function

**POSSIBLE
CAUSE:**    When an undefined user function has been called up.

**USER
ACTION:**   This error cannot occur in N82-BASIC.

---

**MESSAGE:**    **?UL ERROR**  Undefined Line number

**POSSIBLE
CAUSES:**
1. When a reference is made to a nonexistent line number.

2. When no line number exists but one has been designated by a RESTORE or RUN statement.

3. When a program has nonexistent line for GOTO or GOSUB.

**USER
ACTION:**   Correct program references for line numbers.

---

**MESSAGE:**    **?/0 ERROR**  Division by zero

**POSSIBLE
CAUSES:**
1. When division is performed with an undefined variable, (and its initial value has been set at zero).

2. When the variable that comprises the resultant divisor of an operation is zero.

3. When the dummy variable of a TAN function is π/2.

4. When multiplication is performed on zero by a negative exponent.

**USER
ACTION:**   Have the value of the variable displayed by the PRINT statement.  Attempt to investigate the portion where the operation has been run that has used that variable within the program in terms of zero.
