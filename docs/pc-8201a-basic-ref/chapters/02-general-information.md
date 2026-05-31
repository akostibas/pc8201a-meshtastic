# Chapter 2: General Information

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 21–29). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

## Screen Display

The Liquid Crystal Display screen can display 8 lines of 40 characters per line.  The first 7 lines are usually available for your use, depending on the mode of the PC-8201.  The last line usually displays the names of the functions corresponding to the Function Keys on the keyboard.

The character positions on the screen are numbered 0 through 39 columns from left to right, and 0 through 7 lines from top to bottom:

```text
        col 0                          col 39
        +------------------------------------+
line 0  | 0.0  -------------------->   39.0  |
        |  |                             |   |
        |  v                             v   |
line 7  | 0.7  -------------------->   39.7  |
        +------------------------------------+
```

*Figure 2.1 — Screen character-position coordinates (column.line).*

| Corner       | Coordinate |
|--------------|------------|
| top-left     | 0.0        |
| top-right    | 39.0       |
| bottom-left  | 0.7        |
| bottom-right | 39.7       |

<!-- Note: source labels corners with a dot separator (e.g. "0.0", "39.7"), read as column.line, not column,line. -->


Each position is addressable by using the LOCATE statement.

Dot graphics may be displayed on the screen of the PC-8201.  The screen consists of 240 pixels (dots) across from left to right, with the columns numbered 0 through 239.  There are 64 pixels from top to bottom on the screen, with the lines numbered 0 through 63:

```text
        col 0                          col 239
        +-------------------------------------+
line 0  | 0.0   ------------------>   239.0   |
        |  |                            |     |
        |  v                            v     |
line 63 | 0.63  ------------------>   239.63  |
        +-------------------------------------+
```

*Figure 2.2 — Dot-graphics pixel coordinates (column.line).*

| Corner       | Coordinate |
|--------------|------------|
| top-left     | 0.0        |
| top-right    | 239.0      |
| bottom-left  | 0.63       |
| bottom-right | 239.63     |

<!-- Note: source labels corners with a dot separator (e.g. "0.63", "239.63"), read as column.line. -->


Each dot is addressed using the PSET statement.

## Statements and Line Numbers

BASIC programs consist of statements, which give the PC-8201 instructions.  These statements can perform arithmetic operations, assign values, input data, output data, transfer the sequence of execution of certain program functions, test certain conditions within a program, etc.

A program line consists of one or more statements.  If there is more than one statement in a line, the group of statements are called compound statements.  Compound statements must be separated by a colon (:).

Each program line begins with a line number, which indicates the sequence in which they are to be executed and stored in the memory.  Program execution starts with the lowest numbered line and then continues in programmed sequence.  Acceptable line numbers can range from 0 to 65529.  Each program line cannot exceed 255 characters.

EXAMPLE OF A PROGRAM LINE FORMAT:

```text
20 Let A = 1:Let B = 2:Let C = 3
```

The above program line is a compound statement with the individual statements separated by a colon, and a line number of 20.

## Special Symbols

In addition to regular arithmetic symbols, such as +, −, *, and /,
N82-BASIC reserves several symbols for special purposes:

- Period (.) is used to reference the last program line input.  It is also used to point to the line in which an error occurs during program execution.

- Hyphen (-) indicates a range, in place of the word "to", such as 1-19.  The hyphen is the same character as the minus sign.

- Comma (,) separates variables or data within a PRINT command into <!-- a small shaded/cross-hatched block graphics glyph appears here in place of a numeral; the intended Space-Zone width is not legible --> unit widths called Space Zones.

- Colon (:) is used to separate compound statements within one program line, which saves memory space.

- Semicolon (;) is usually used in the PRINT or INPUT statement.  It directs the cursor to the position immediately following the last printed character on the same line.

- A Single quotation mark ' is used to precede remarks or comments in a statement.  These remarks are not executed when the program is run.

- Double quotation marks (" ") are used to enclose character strings.  The strings cannot be longer than 255 characters.

- Question mark (?) is the abbreviation for the PRINT command.

- Blank spaces are generally ignored by the PC-8201.

### Special Symbols following Variable Names:

| Symbol          | Format       | Variable                        |
|-----------------|--------------|---------------------------------|
| Percent (%)     | (variable)%  | Integer                         |
| Exclamation (!) | (variable)!  | Real Number Single Precision    |
| Pound (#)       | (variable)#  | Real Number Double Precision    |
| Dollar ($)      | (variable)$  | Character String                |

## Control Characters

The characters recognized by N82-BASIC include:

| Category            | Characters                                                          |
|---------------------|---------------------------------------------------------------------|
| Upper case alphabet | A - Z                                                               |
| Lower case alphabet | a - z                                                               |
| Numbers             | 0 - 9                                                               |
| Special symbols     | . − , : ; ' " ? % ! # $ & = ( ) [ ] \ / @ + ^ _ etc.              |
| Graphics characters | (three sample graphics glyphs are shown: a solid left-pointing triangle, a return/enter arrow, and a shaded/cross-hatched block)<!-- glyphs not in Unicode-faithful form; described in prose --> , and up to a total of 125 programmable graphics characters |

## Error Messages

If an error occus <!-- [sic] printed "occus" in the source; should read "occurs" --> during program execution, the PC-8201 will terminate the program and return to the Direct Mode.

The error message is displayed on the screen if the PC-8201 is in the Direct Mode of BASIC.  While in the Program Mode, the line number where the error occurred is displayed along with the error message.

> **See Chapter 7 for the list and explanations of error messages.**

## Program Editing

The two editing modes featured by the PC-8201 are the Direct Mode in BASIC and the TEXT mode.  You can edit your programs in either mode, depending upon your preference.

## Screen Editing of Programs

Editing programs in the BASIC mode is done by modifying program lines.  When you edit in this manner, the [RETURN] Key must be pressed after your changes have been made in order to be entered into the memory.  Remember that a program line cannot be over 254 characters long, which is more than 6 full lines on the screen.  It is recommended that lines have less than 200 characters, so they may be LISTed and edited.

The following operations are used to edit (modify) program lines.  First list the line by typing LIST and then the line number following by the [RETURN] Key.

INSERT:

1. Move the cursor to the place where the character is to be inserted using the Cursor Movement Keys.

2. Press the [INS] Key.

3. Type the character(s) to be inserted.

4. If other insertions are needed on the same program line, move the cursor to the desired positions again using the Cursor Movement Keys, then press [INS] Key and insert the character(s).

5. Press the [RETURN] Key to enter your insertions into the memory.

6. Keep in mind that when INSERTion editing in the Direct Mode of BASIC is used, the INSERT is active until a [RETURN] Key is pressed, or a cursor movement key is entered.

DELETE:

To delete characters that precede the cursor in a program line, LIST the line, then:

1. Move the cursor to the right of the character to be deleted.

2. Press the [BS/DEL] Key.

3. Press the same key as many times as needed to delete characters to the left of the cursor.

4. Press the [RETURN] Key to store the changes.

To delete characters that follow the cursor in a program line, LIST the line, then:

1. Move the cursor onto the first character to be deleted.

2. Press and hold the SHIFT Key and then input the [BS/DEL] key.

3. Repeat the same process as many times as needed.

4. Press the [RETURN] Key to store the changes.

To delete an entire line:

1. Type the line number to be deleted, with no characters following it.

2. Press the [RETURN] Key.

Another way to delete an entire line is to LIST the line then:

1. Move the cursor to the space between the line number and the body of the statement.

2. Press and hold the [CTRL] Key and input the E Key, then press the [RETURN] Key.

> **NOTE**  This procedure of holding the [CTRL] Key down while inputting a character will appear in this manual as [CTRL] + 〈character〉.  Do not input the + sign, because it just signifies that the two keys are being entered simultaneously.

ADD:

A new line can be added at any point in the program.

The program is executed following the sequential order of line numbers.  The PC-8201 will put the line numbers in increasing order, regardless of what order the lines were typed in.

To rewrite a line just type the old line number followed by the contents of the new line, even if you are at the end of the program.  As stated above, the PC-8201 will put the lines in order when the program is LISTed.

## Other Keys Used for Screen Editing

- TAB — Moves the cursor directly to columns 8, 16, 24, and 32 of the line in which the cursor is positioned.

- STOP — Terminates the EDIT mode.

- CTRL + C — Same as the STOP Key.

- CTRL + E — Erases characters from the position directly to the right of the cursor, all the way to the end of the program line.

- CTRL + H — Same as the [BS] Key.

- CTRL + I — Same as the TAB Key.

- CTRL + K — Moves the cursor to the cursor "home" position, in the upper left corner of the screen.

- CTRL + L — Clears the screen and moves the cursor to the home position.

- CTRL + M — Same as the [RETURN] Key.

- CTRL + Q — Continues the scrolling of a program listing on the screen after the LIST instruction has been given and the listing was interrupted.  See CTRL + S.

- CTRL + S — Interrupts the scrolling of a program listing on the screen after the LIST instruction has been used.

- CTRL + R — Same as the [INS] Key.

- CTRL + U — Erases a line displayed on the screen.  The internal memory is not altered.

## Editing Programs Using the TEXT Mode

Programs can be edited in the TEXT mode by entering EDIT and then pressing the [RETURN] Key.  To exit the TEXT editing mode, press the [RETURN] Key twice or the f.10 Function Key (SHIFT Key and f.5).

In this mode, any character typed is inserted one at a time, at the location of the cursor.  Unlike editing in the Direct Mode, every modification that you make in a program line is entered into the memory of the PC-8201 immediately, before you press the [RETURN] Key.

Use of the TAB Key while in the TEXT editing mode will indent the line being typed.  The [RETURN] Key must be used to end a program line being typed or modified in this mode, or else the line will appear in the program out of sequence.

The PC-8201 will check a newly input program line in the TEXT editing mode.  If a line with only a line number and no characters following it or if a line which does not contain a line number is input by you, the PC-8201 will not store it in the memory.  When this type of line is input the message "Text ill-formed" will be displayed on the screen and a "BEEP" sound will be generated.  You will have to type in a correct program line or delete the line number from the screen to avoid this error message.

The TEXT editing mode is most useful if you want to copy a section of a program into another program by using the PASTE buffer.  The pattern searching function of the FIND command is also very helpful in locating certain words, strings, etc., when you are editing programs.  PASTE and FIND are described fully in the User's Guide.
