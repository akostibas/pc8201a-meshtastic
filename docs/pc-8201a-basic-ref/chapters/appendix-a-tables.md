# Appendix A: Tables

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 265–278). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.

## A1. Reserved Words

| | | | |
|---|---|---|---|
| ABS | FILES | NOT | SCREEN |
| AND | FIX | ON COM GOSUB | SGN |
| ASC | FOR . . . TO . . . STEP ~ NEXT | ON ERROR GOTO ~ RESUME | SIN |
| ATN | FRE | ON . . . GOTO/GOSUB | SOUND |
| BEEP | GOSUB ~ RETURN | OPEN | SPACE$ |
| BLOAD | GOTO | OPEN "COM" | SQR |
| BLOAD? | IF . . . THEN . . . ELSE | OR | STOP |
| BSAVE | IMP | OUT | STR$ |
| CDBL | INKEY$ | PEEK | STRING$ |
| CHR$ | INP | POKE | TAB |
| CINT | INPUT | POS | TAN |
| CLEAR | INPUT$ | POWER | TIME$ |
| CLOAD | INPUT# | PRESET | VAL |
| CLOAD? | INSTR | PRINT/LPRINT | XOR |
| CLOSE | INT | PRINT USING/LPRINT USING | |
| CLS | KEY | PSET | |
| COM ON/OFF/STOP | KILL | READ | |
| CONT | LEFT$ | REM | |
| COS | LEN | RENUM | |
| CSAVE | LET | RESTORE | |
| CSNG | LINE INPUT | RESUME | |
| CSRLIN | LINE INPUT# | RETURN | |
| DATA | LIST/LLIST | RIGHT$ | |
| DATE$ | LOAD | RND | |
| DEFINT/SNG/DBL/STR | LOCATE | RUN | |
| DIM | LOG | SAVE | |
| EDIT | LPOS | | |
| END | MAXFILES | | |
| EOF | MENU | | |
| EQV | MERGE | | |
| ERL | MID$ | | |
| ERR | MOD | | |
| ERROR | MOTOR | | |
| EXEC | NAME | | |
| EXP | NEW | | |

## A2. Error Codes

| Error Message | Code | N82-BASIC Message | Meaning |
|---|---|---|---|
| ?AO Error | 53 | File Already Open | The same file has been opened before. |
| ?BN Error | 51 | Bad file Number | The number of file is inappropriate. |
| ?BO Error | 23 | Buffer Overflow | The input buffer has overflowed. |
| ?BS Error | 9 | Bad Subscript (out of range) | The subscript of the array is inappropriate. |
| ?OF Error | 58 | File not open | The file has not yet been opened. <!-- OCR: "opende" in source --> |
| ?ON Error | 17 | Continuation is Not possible | The execution of the program cannot be resumed by means of a CONT command. |
| ?DD Error | 10 | Duplicate Definition | The same array is declared twice. |
| ?DS Error | 56 | Direct Statement in file | An ASCII format file does not load. |
| ?DU Error | 25 | Device Unavailable | A designated device is not being used. |
| ?EF Error | 54 | End of File | No more data in the file. |
| ?FC Error | 5 | Illegal Function Call | Commands or Functions are used incorrectly. |
| ?FF Error | 52 | File not Found | The designated name of file can not be located. |
| ?FL Error | 57 | Filing Limit | There are too many files. |
| ?ID Error | 12 | Illegal Direct | The specified command cannot be used in the direct mode. <!-- OCR: "dircet" in source --> |
| ?IE Error | 50 | Internal Error | An error has occurred within BASIC itself. <!-- OCR: "occured" in source --> |
| ?IO Error | 24 | I/O Error | An error occurs during input or output. |
| ?LS Error | 15 | Long String | The contents of a string variable are in excess of 255 characters. |
| ?MO Error | 22 | Missing Operand | A required parameter is missing. |
| ?NF Error | 1 | NEXT without FOR | There is no FOR statement to match the NEXT statement. |
| ?NM Error | 55 | File Name Mismatch | The name of the file is inappropriate. |
| ?NR Error | 19 | No RESUME | There is no RESUME command present in an error routine. |
| ?OD Error | 4 | Out of Data | The data required to be read is insufficient. |
| ?OM Error | 7 | Out of Memory | There is insufficient memory. |
| ?OS Error | 14 | Out of String space | The memory region available for string storage is inadequate. |
| ?OV Error | 6 | Overflow | A numerical value is excessive. |
| ?PC Error | 59 | PC-8001 Command | This command is used on the PC-8001. |
| ?RG Error | 3 | RETURN without GOSUB | A RETURN statement is present without GOSUB statement. |
| ?RW Error | 20 | RESUME Without existence of an Error | A RESUME is encountered before an error routine is entered. |
| ?SN Error | 2 | Syntax error | The grammar of a statement is erroneous. <!-- OCR: "Syntac" in source --> |
| ?ST Error | 16 | String formula Too complex | The string formula is complicated. |
| ?TM Error | 13 | Type Mismatch | The types of variables and integers are inconsistent with one another. |
| ?UE Error | 21 | Unprintable Error | An error that has not been designated in a message. |
| ?UF Error | 18 | Undefined Function | An undefined user function has been read. |
| ?UL Error | 8 | Undefined Line number | A designated line has not been defined. |
| ?/0 Error | 11 | Division by Zero | A division by 0 is performed. |

## A3. Control Codes

The PC-8201 uses ASCII character codes from 1 through 31 as control codes, and has a function for display operations such as cursor movement control.

The following control codes are effective in the TELCOM mode:

| Operation | Character Code | Function |
|---|---|---|
| CTRL + C | 3 | Interrupts command input (effective during keyboard input) the same as the key <!-- OCR: key glyph unclear, appears to be STOP/BREAK key icon --> |
| CTRL + G | 7 | Bell to sound the beeper |
| CTRL + H | 8 | Back Space (the same as BS key) |
| CTRL + I | 6 | TAB <!-- source prints 6 (verified against scan at 400dpi — clean glyph, not a rotated 9). Likely a source misprint for ASCII HT=9: every other code on this page matches standard ASCII (C=3,G=7,H=8,J=10,K=11,L=12,M=13,...) and CTRL+I=TAB=HT=9 universally. Kept 6 as printed per byte-faithful rule. --> |
| CTRL + J | 10 | Line Feed |
| CTRL + K | 11 | Home Position |
| CTRL + L | 12 | Clear the Screen |
| CTRL + M | 13 | Carriage Return (same as RETURN key) |
| CTRL + N | 14 | Shift OUT (effective only with a control designation, applies to RS-232C) |
| CTRL + O | 15 | Shift IN (effective only with a control designation) <!-- OCR: "deisgation" in source --> |
| CTRL + Q | 17 | Request Interrupt during transmission (effective only with a control designation) <!-- OCR: "deisgation" in source --> |
| CTRL + S | 19 | Authorizes Reopening of transmission (effective only with a control designation) <!-- OCR: "Atuhorizes" in source --> |
| ESC | 27 | Begins the Escape Sequence |
| ◁ (left arrow key) | 28 | Moves the cursor one character to the right <!-- OCR: source shows left-pointing triangle icon; function text says "to the right" — faithfully transcribed as printed --> |
| ▷ (right arrow key) | 29 | Moves the cursor one character to the left <!-- OCR: source shows right-pointing triangle icon; function text says "to the left" — faithfully transcribed as printed --> |
| ▽ (down arrow key) | 30 | Moves the cursor up one line <!-- OCR: source shows down-pointing triangle icon; function text says "up" — faithfully transcribed as printed --> |
| △ (up arrow key) | 31 | Moves the cursor down one line <!-- OCR: source shows up-pointing triangle icon; function text says "down" — faithfully transcribed as printed --> |

## A4. Character Codes

> **Note on source pages 276–278:** Source page 276 contains a duplicate row labeled 154 (row for decimal 153 appears to be omitted in the original). Rows 156–159 on page 276 contain handwritten annotations in the scan reading CLUBS, DIAMONDS, HEARTS, SPADES — these are not printed characters but reader's notes identifying the card suit symbols at those positions. Codes 131–214 (except 128–130 which have distinct symbols) are labeled "User-defined characters (Potential to be Input from the Keyboard)". Codes 224–255 are labeled "User-defined characters (Output by using the CHR$$ function)". <!-- OCR: "CHSS" in source likely = CHR$ -->

| Decimal | Character | Decimal | Character |
|---|---|---|---|
| 0 | *(control — cannot be output as character)* | 20 | *(control — cannot be output as character)* |
| 1 | *(control — cannot be output as character)* | 21 | *(control — cannot be output as character)* |
| 2 | *(control — cannot be output as character)* | 22 | *(control — cannot be output as character)* |
| 3 | *(control — cannot be output as character)* | 23 | *(control — cannot be output as character)* |
| 4 | *(control — cannot be output as character)* | 24 | *(control — cannot be output as character)* |
| 5 | *(control — cannot be output as character)* | 25 | *(control — cannot be output as character)* |
| 6 | *(control — cannot be output as character)* | 26 | *(control — cannot be output as character)* |
| 7 | *(control — cannot be output as character)* | 27 | *(control — cannot be output as character)* |
| 8 | *(control — cannot be output as character)* | 28 | *(control — cannot be output as character)* |
| 9 | *(control — cannot be output as character)* | 29 | *(control — cannot be output as character)* |
| 10 | *(control — cannot be output as character)* | 30 | *(control — cannot be output as character)* |
| 11 | *(control — cannot be output as character)* | 31 | *(control — cannot be output as character)* |
| 12 | *(control — cannot be output as character)* | 32 | (space) |
| 13 | *(control — cannot be output as character)* | 33 | ! |
| 14 | *(control — cannot be output as character)* | 34 | " |
| 15 | *(control — cannot be output as character)* | 35 | # |
| 16 | *(control — cannot be output as character)* | 36 | $ |
| 17 | *(control — cannot be output as character)* | 37 | % |
| 18 | *(control — cannot be output as character)* | 38 | & |
| 19 | *(control — cannot be output as character)* | 39 | ' |
| 40 | ( | 65 | A |
| 41 | ) | 66 | B |
| 42 | * | 67 | C |
| 43 | + | 68 | D |
| 44 | , | 69 | E |
| 45 | — <!-- OCR: printed as em-dash; likely hyphen-minus --> | 70 | F |
| 46 | . | 71 | G |
| 47 | / | 72 | H |
| 48 | 0 | 73 | I |
| 49 | 1 | 74 | J |
| 50 | 2 | 75 | K |
| 51 | 3 | 76 | L |
| 52 | 4 | 77 | M |
| 53 | 5 | 78 | N |
| 54 | 6 | 79 | O |
| 55 | 7 | 80 | P |
| 56 | 8 | 81 | Q |
| 57 | 9 | 82 | R |
| 58 | : | 83 | S |
| 59 | ; | 84 | T |
| 60 | < | 85 | U |
| 61 | = | 86 | V |
| 62 | > | 87 | W |
| 63 | ? | 88 | X |
| 64 | @ | 89 | Y |
| 90 | Z | 115 | s |
| 91 | [ | 116 | t |
| 92 | \ | 117 | u |
| 93 | ] | 118 | v |
| 94 | ^ <!-- OCR: printed as circumflex/caret --> | 119 | w |
| 95 | _ <!-- OCR: printed as long dash; likely underscore --> | 120 | x |
| 96 | ` <!-- OCR: cell appears blank; likely backtick/grave accent --> | 121 | y |
| 97 | a | 122 | z |
| 98 | b | 123 | { |
| 99 | c | 124 | \| <!-- OCR: printed as broken vertical bar --> |
| 100 | d | 125 | } |
| 101 | e | 126 | ~ |
| 102 | f | 127 | *(blank/DEL — no character shown)* |
| 103 | g | 128 | ◀ (solid left-pointing triangle) |
| 104 | h | 129 | ↵ (carriage-return arrow) |
| 105 | i | 130 | 🖵 <!-- OCR: small keyboard/screen icon; exact glyph unclear --> |
| 106 | j | 131 | *(User-defined — keyboard input)* |
| 107 | k | 132 | *(User-defined — keyboard input)* |
| 108 | l | 133 | *(User-defined — keyboard input)* |
| 109 | m | 134 | *(User-defined — keyboard input)* |
| 110 | n | 135 | *(User-defined — keyboard input)* |
| 111 | o | 136 | *(User-defined — keyboard input)* |
| 112 | p | 137 | *(User-defined — keyboard input)* |
| 113 | q | 138 | *(User-defined — keyboard input)* |
| 114 | r | 139 | *(User-defined — keyboard input)* |
| 140 | *(User-defined — keyboard input)* | 165 | *(User-defined — keyboard input)* |
| 141 | *(User-defined — keyboard input)* | 166 | *(User-defined — keyboard input)* |
| 142 | *(User-defined — keyboard input)* | 167 | *(User-defined — keyboard input)* |
| 143 | *(User-defined — keyboard input)* | 168 | *(User-defined — keyboard input)* |
| 144 | *(User-defined — keyboard input)* | 169 | *(User-defined — keyboard input)* |
| 145 | *(User-defined — keyboard input)* | 170 | *(User-defined — keyboard input)* |
| 146 | *(User-defined — keyboard input)* | 171 | *(User-defined — keyboard input)* |
| 147 | *(User-defined — keyboard input)* | 172 | *(User-defined — keyboard input)* |
| 148 | *(User-defined — keyboard input)* | 173 | *(User-defined — keyboard input)* |
| 149 | *(User-defined — keyboard input)* | 174 | *(User-defined — keyboard input)* |
| 150 | *(User-defined — keyboard input)* | 175 | *(User-defined — keyboard input)* |
| 151 | *(User-defined — keyboard input)* | 176 | *(User-defined — keyboard input)* |
| 152 | *(User-defined — keyboard input)* | 177 | *(User-defined — keyboard input)* |
| 153 | *(User-defined — keyboard input)* <!-- OCR: source skips decimal 153; duplicate row "154" appears twice in original --> | 178 | *(User-defined — keyboard input)* |
| 154 | *(User-defined — keyboard input)* | 179 | *(User-defined — keyboard input)* |
| 155 | *(User-defined — keyboard input)* | 180 | *(User-defined — keyboard input)* |
| 156 | *(User-defined — keyboard input; handwritten annotation in scan: "CLUBS")* | 181 | *(User-defined — keyboard input)* |
| 157 | *(User-defined — keyboard input; handwritten annotation in scan: "DIAMONDS")* | 182 | *(User-defined — keyboard input)* |
| 158 | *(User-defined — keyboard input; handwritten annotation in scan: "HEARTS")* | 183 | *(User-defined — keyboard input)* |
| 159 | *(User-defined — keyboard input; handwritten annotation in scan: "SPADES")* | 184 | *(User-defined — keyboard input)* |
| 160 | *(User-defined — keyboard input)* | 185 | *(User-defined — keyboard input)* |
| 161 | *(User-defined — keyboard input)* | 186 | *(User-defined — keyboard input)* |
| 162 | *(User-defined — keyboard input)* | 187 | *(User-defined — keyboard input)* |
| 163 | *(User-defined — keyboard input)* | 188 | *(User-defined — keyboard input)* |
| 164 | *(User-defined — keyboard input)* | 189 | *(User-defined — keyboard input)* |
| 190 | *(User-defined — keyboard input)* | 215 | *(User-defined — keyboard input)* |
| 191 | *(User-defined — keyboard input)* | 216 | *(User-defined — keyboard input)* |
| 192 | *(User-defined — keyboard input)* | 217 | *(User-defined — keyboard input)* |
| 193 | *(User-defined — keyboard input)* | 218 | *(User-defined — keyboard input)* |
| 194 | *(User-defined — keyboard input)* | 219 | *(User-defined — keyboard input)* |
| 195 | *(User-defined — keyboard input)* | 220 | *(User-defined — keyboard input)* |
| 196 | *(User-defined — keyboard input)* | 221 | *(User-defined — keyboard input)* |
| 197 | *(User-defined — keyboard input)* | 222 | *(User-defined — keyboard input)* |
| 198 | *(User-defined — keyboard input)* | 223 | *(User-defined — keyboard input)* |
| 199 | *(User-defined — keyboard input)* | 224 | *(User-defined — CHR$ output only)* |
| 200 | *(User-defined — keyboard input)* | 225 | *(User-defined — CHR$ output only)* |
| 201 | *(User-defined — keyboard input)* | 226 | *(User-defined — CHR$ output only)* |
| 202 | *(User-defined — keyboard input)* | 227 | *(User-defined — CHR$ output only)* |
| 203 | *(User-defined — keyboard input)* | 228 | *(User-defined — CHR$ output only)* |
| 204 | *(User-defined — keyboard input)* | 229 | *(User-defined — CHR$ output only)* |
| 205 | *(User-defined — keyboard input)* | 230 | *(User-defined — CHR$ output only)* |
| 206 | *(User-defined — keyboard input)* | 231 | *(User-defined — CHR$ output only)* |
| 207 | *(User-defined — keyboard input)* | 232 | *(User-defined — CHR$ output only)* |
| 208 | *(User-defined — keyboard input)* | 233 | *(User-defined — CHR$ output only)* |
| 209 | *(User-defined — keyboard input)* | 234 | *(User-defined — CHR$ output only)* |
| 210 | *(User-defined — keyboard input)* | 235 | *(User-defined — CHR$ output only)* |
| 211 | *(User-defined — keyboard input)* | 236 | *(User-defined — CHR$ output only)* |
| 212 | *(User-defined — keyboard input)* | 237 | *(User-defined — CHR$ output only)* |
| 213 | *(User-defined — keyboard input)* | 238 | *(User-defined — CHR$ output only)* |
| 214 | *(User-defined — keyboard input)* | 239 | *(User-defined — CHR$ output only)* |
| 240 | *(User-defined — CHR$ output only)* | | |
| 241 | *(User-defined — CHR$ output only)* | | |
| 242 | *(User-defined — CHR$ output only)* | | |
| 243 | *(User-defined — CHR$ output only)* | | |
| 244 | *(User-defined — CHR$ output only)* | | |
| 245 | *(User-defined — CHR$ output only)* | | |
| 246 | *(User-defined — CHR$ output only)* | | |
| 247 | *(User-defined — CHR$ output only)* | | |
| 248 | *(User-defined — CHR$ output only)* | | |
| 249 | *(User-defined — CHR$ output only)* | | |
| 250 | *(User-defined — CHR$ output only)* | | |
| 251 | *(User-defined — CHR$ output only)* | | |
| 252 | *(User-defined — CHR$ output only)* | | |
| 253 | *(User-defined — CHR$ output only)* | | |
| 254 | *(User-defined — CHR$ output only)* | | |
| 255 | *(User-defined — CHR$ output only)* | | |
