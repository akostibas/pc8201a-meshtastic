# INTRODUCTION

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 6–9). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

The N82-BASIC Reference manual is a guide to the programming language used for the PC-8201 personal computer.  Microsoft TM 's N82-BASIC language, developed specifically for the PC-8201 offers a wide range of commands and functions, making it very useful and versatile.

This Reference Manual was designed for anyone, from beginning to professional programmers.  It is intended to be used in conjunction with the PC-8201 User's Guide.

This Manual is divided into ten chapters:

**Chapter 1** &nbsp;&nbsp;&nbsp; is an overview of the N82-BASIC language.  You will learn about the special features unique to N82-BASIC and its operating modes.  This chapter also gets you started using N82-BASIC.

**Chapter 2** &nbsp;&nbsp;&nbsp; includes all the general information about the BASIC language that you will need to know, such as definitions of statements and symbols used for programming.  A description of the PC-8201 LCD screen display is included.

**Chapter 3** &nbsp;&nbsp;&nbsp; explains how programming expressions are formed specifically for the N82-BASIC language.

**Chapter 4** &nbsp;&nbsp;&nbsp; includes complete explanations of the purpose and use of system commands, statements, and functions available with N82-BASIC.

**Chapter 5** &nbsp;&nbsp;&nbsp; outlines information needed for proper file handling.

**Chapter 6** &nbsp;&nbsp;&nbsp; describes Machine Language Programming.

**Chapter 7** &nbsp;&nbsp;&nbsp; is a guide to actual programming problems that may be encountered, especially with beginning programmers.  Programming hints and solutions to programming problems are included.

**Chapter 8** &nbsp;&nbsp;&nbsp; contains the causes and what action should be taken when error messages occur.

**Chapter 9** &nbsp;&nbsp;&nbsp; contains a variety of sample programs written in the N82-BASIC language.

**Chapter 10** &nbsp;&nbsp;&nbsp; includes the Appendices, offering quick reference tables and guides, memory maps, etc.

The PC-8201 is a very special personal computer.  It has its own specialized built-in BASIC language, along with more easy to read special Function Keys than any other portable computer available.  Another unique feature of the PC-8201 is its full screen editing capability which is extremely powerful for a compact portable computer.

In order to fully utilize the capabilities of the PC-8201, you should become familiar with the N82-BASIC language outlined in this Reference Manual.

It is best for beginning programmers to review this manual thoroughly and actually input sample programs with the PC-8201.  More advanced programmers can use this manual as a reference.

The system commands, statements, and functions in Chapter 4 are presented alphabetically for easy reference.  The explanations are all written in the following format:

**FUNCTION:** &nbsp;&nbsp;&nbsp; Gives a brief description of a command or function.

**FORMAT:** &nbsp;&nbsp;&nbsp; Describes how an instruction is written.  The following points apply to the format description for all of the commands and functions:

1. All capitalized words are BASIC Reserved Words.

2. All lower case words contained within angle bracket `< >` symbols are parameters, which must be supplied by you.

3. Parentheses ( ) are required to be typed in as shown in format.

   The three types of parameters:

   a. A line number — whole numbers are allowed.

   b. A string — enclosed by quotation marks.  Combinations of letters and numbers are allowed.

   c. A variable — constants, numerical values, or numerical formulas are allowed.

4. Braces { } indicate that the enclosed clause is optional, which you may choose to omit.

5. Brackets [ ] denote that any one of the enclosed words must be chosen for use.

6. Punctuation such as commas, periods, semicolons, etc., must be included in the format as written.

7. Items preceding the " . . . " symbol can be repeated any number of times as long as they do not go over the length of a line, which is 255 characters.

8. Placement of spaces between reserved words or parameters within the format of a command or function is not essential.

**SAMPLE STATEMENT:** &nbsp;&nbsp;&nbsp; This is a sample of the correct format of system commands, statements, and functions.

**DESCRIPTION:** &nbsp;&nbsp;&nbsp; Explains important points for the method of use for system commands, statements, and functions.

**NOTE:** &nbsp;&nbsp;&nbsp; Describes situations in which problems may arise if you do not fully understand the uses of a command or function.

**SEE ALSO:** &nbsp;&nbsp;&nbsp; Consists of other items shared by the command or function being described.

**SAMPLE PROGRAM:** &nbsp;&nbsp;&nbsp; When included, this is a sample program for system commands, statements, and functions described.

<!-- FIGURE: keycap icon labeled "SHIFT" (rounded-rectangle key), followed by "+ <Character> :" notation — source page 9 (target: image) -->

`[SHIFT]` + `<Character>` :

&nbsp;&nbsp;&nbsp; Indicates that you should press and hold the `[SHIFT]` Key, then type the specified character.  The + sign is not to be typed in.

<!-- FIGURE: small square keycap icon (CODE/FN key glyph), followed by "+ <Character> :" notation — source page 9 (target: image) -->

`[CODE/FN]` + `<Character>` :

&nbsp;&nbsp;&nbsp; Indicates that you should press and hold the `[CODE/FN]` Key, then type the specified character.  The + sign is not to be typed in.

Symbols used in this Reference Manual:

<!-- FIGURE: NOTE icon — small flag/tag graphic with the word "NOTE" lettered on it — source page 9 (target: image) -->

**NOTES** to be remembered.

<!-- FIGURE: REFERENCE icon — a pointing-hand (index finger pointing right) graphic — source page 9 (target: image) -->

**REFERENCE** is made to another chapter, to the PC-8201 User's Guide.

<!-- FIGURE: CAUTION icon — a hollow (outline) right-pointing arrow graphic — source page 9 (target: image) -->

**CAUTION** is required when utilizing certain features of the N82-BASIC language.
