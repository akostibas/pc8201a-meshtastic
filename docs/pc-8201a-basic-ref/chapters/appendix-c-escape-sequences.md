# Appendix C: Escape Sequences

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 281–283). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

An Escape Sequence involves the performance of a designated function according to any array of letters which follow the Escape code (ESC:27). It is input by pressing the ESC Key and pressing a letter key. The methods of using the ESC and SHIFT Keys are entirely different, so do not confuse these special methods with normal functions of the ESC and SHIFT Keys.

An Escape Sequence is also effective in BASIC.

The following Escape Sequences can be used with the PC-8201:

<!-- Tier B verified against source pages 281–282: every ESC glyph and
     character code confirmed cell-by-cell. The case-sensitive distinctions
     (ESC j=106 vs ESC J=74, ESC l=108, ESC p=112, ESC q=113) are noted inline
     below; the scan prints them as the OCR markers describe. -->

| ESC + | CHARACTER CODE | FUNCTION |
|-------|---------------|----------|
| E | 27, 69 | Clears Screen and moves the cursor to the top left corner of the screen (the home position) |
| J <!-- OCR: printed glyph "J" but character code 27, 106 = decimal 106 = ASCII 'j' (lowercase) — likely ESC j --> | 27, 106 | Clear Screen |
| K | 27, 75 | Erases characters from cursor position to the end of line |
| J <!-- OCR: printed glyph "J" but character code 27, 74 = decimal 74 = ASCII 'J' (uppercase) — likely ESC J; two distinct "J" rows on this page indicate one is uppercase, one lowercase --> | 27, 74 | Erases characters from cursor position up to the end of the display |
| I <!-- OCR: printed glyph "I" but character code 27, 108 = decimal 108 = ASCII 'l' (lowercase L) — likely ESC l; I/l ambiguity in source typeface --> | 27, 108 | Erases characters on the line where the cursor is located |
| L | 27, 76 | Inserts a Line |
| M | 27, 77 | Deletes the line where the cursor is located |
| Y ⟨y⟩ ⟨x⟩ | | Moves the cursor to a designated location, the y x offset by the space character ASCII (decimal 32). |
| A | 27, 65 | Moves the cursor one line up |
| B | 27, 66 | Moves the cursor one line down |
| C | 27, 67 | Moves the cursor one character (one column) to the right |
| D | 27, 68 | Moves the cursor one character (one column) to the left |
| P <!-- OCR: printed glyph "P" but character code 27, 112 = decimal 112 = ASCII 'p' (lowercase) — likely ESC p --> | 27, 112 | Changes the screen into reverse display |
| q | 27, 113 | Restores characters to normal (switches from reverse display) |
| T | 27, 84 | Displays Function Keys |
| U | 27, 85 | Erases the display of Function Keys |
| V | 27, 86 | Inhibits scrolling (freezes the display) |
| W | 27, 87 | Permits Scrolling |

## ESC + Y ⟨y⟩ ⟨x⟩

The cursor position is designated vertically and horizontally by two characters which are subsequent to ESC + Y.

Capital letters from character code 32 are used in the designation. A blank (space) corresponds to the location 0, and (!) corresponds to 1, while (") corresponds to 2. for instance, to move the cursor to home position, input the following string:

ESC, "Y", " ", " "

This means 27, 89, 32, 32 in character code.

> **Note:** In TERM mode, when the RETURN Key is input, only the carriage code (13) is transmitted while the change line code (10) is not transmitted. In the case where the carriage return code is received, the line is not changed. Though this does not cause a problem in communication with a host computer, when communicating with other computers the user must input CTRL + J in order to actively perform the change of lines.

No change line code will be transmitted when the UPLOAD command is executed. This is something to be fully aware of when a program is being created at the receiving end of the data transmission.
