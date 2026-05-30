# Chapter 3: Features & Functions of the PC-8201

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 38-44 / printed 3-1..3-7), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## Overview

The layout of the screen and keyboard are described in this chapter, along with explanations for all of the Special Keys on the keyboard of the PC-8201. You will need to review this information, since there are variations of the layout and functions of keys from that on an ordinary typewriter.

## Screen Description

When the electrical power of the PC-8201 is turned ON, the LCD screen will look like this:

<!-- FIGURE 3.1: MENU mode screen layout at power-on — source page 38 (target: ascii) -->

```
1983/01/01 00:00:00       (C) Microsoft #1
BASIC          TEXT       TELCOM     -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
Load     Save     Name     List     12374
```

<!-- TODO(tier-b): verify free-bytes value "12374" and the highlighted/reversed first cell (read as "BASIC") against source page 38 -->

The screen display shown is referred to as the MENU mode. The first line at the top displays the date and time. The number in the upper right corner of the screen is the number of the memory bank in use. The RAM is divided into units referred to as "banks".

> **REFERENCE:** See Chapter 5 for a detailed explanation of Banks.

The second line displays the names of the three software features, BASIC, TEXT, and TELCOM. The bottom line of the screen displays the functions that can be executed in the MENU mode, corresponding to the five Function Keys.

The number of bytes free in the memory bank in use is displayed in the lower right corner of the screen. Notice that the screen display will change when the SHIFT Key is pressed as shown:

<!-- FIGURE 3.2: MENU mode screen layout with SHIFT pressed — source page 39 (target: ascii) -->

```
1983/01/01 00:00:37       (C) Microsoft #1
BASIC          TEXT       TELCOM     -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
  -.-            -.-        -.-       -.-
SetIPL   ClrIPL          Kill     Bank
```

The display of the last line changes to correspond with the Function Keys 6 through 10. These Function Keys are only accessed by pressing the SHIFT Key and the Function Keys simultaneously.

The rest of the lines will be filled in with programs and file names that you have created and saved.

> **REFERENCE:** It is possible that when you turn ON your PC-8201 a different display will appear on your screen, if you have used the SETIPL command. See Chapter 5 for details on the IPL feature.

## Keyboard

The keyboard of the PC-8201 has upper and lower case characters. It has Ordinary Keys like any typewriter, along with several special keys. The keyboard is arranged as illustrated:

<!-- FIGURE 3.3: PC-8201 keyboard layout illustration — illustration, source page 40. TODO(tier-b): crop image from source. -->

<!-- Keyboard legend transcribed best-effort from source page 40. Top row: STOP, f·1, f·2, f·3, f·4, f·5, PAST/INS, DEL/BS, cursor diamond (up/down/left/right arrows). -->

| Row | Keys (left to right) |
|---|---|
| Top | STOP, f·1, f·2, f·3, f·4, f·5, PAST/INS, DEL/BS, cursor arrows (↑ ↓ ← →) |
| Number | ESC, `!`/1, `"`/2, `#`/3, `$`/4, `%`/5, `&`/6, `'`/7, `(`/8, `)`/9, `^`/0, `=`/-, `~`/`^` |
| QWERTY | TAB, Q, W, E, R, T, Y, U, I, O, P, `` ` ``/@, `\` |
| Home | CTRL, A, S, D, F, G, H, J, K, L, `+`/`;`, `*`/`:`, [RETURN] |
| Bottom | CAPS, SHIFT, Z, X, C, V, B, N, M, `<`/`,`, `>`/`.`, `?`/`/`, SHIFT |
| Space | GRPH, SPACE BAR, `{`/`[`, `}`/`]` |

<!-- TODO(tier-b): dense key grid — re-OCR at 500dpi crop, candidate for opus, source page 40 -->

The keyboard has Special Keys and Ordinary Keys. When Ordinary Keys are input a character is displayed on the screen. When Special Keys are input a function or command is executed.

The PC-8201 has a special repeat feature. Any character of an Ordinary Key can be repeated automatically when the key is pressed for more than 1 second. This function is very convenient at times. The following Special Keys can also be repeated:

DEL/BS &nbsp;&nbsp;&nbsp; SPACE BAR &nbsp;&nbsp;&nbsp; (cursor movement keys)

### Special Keys

**SHIFT** — This key is the same as the SHIFT key on any typewriter. If an ordinary character key is pressed at the same time as the SHIFT Key, then capital letters and symbols are input. The SHIFT Key is also used to access Function Keys 6 through 10.

**CTRL** — This key is referred to as the "CONTROL" Key. Special functions can be performed by using the CTRL Key in combination with Ordinary Keys. The functions performed vary according to the mode that the PC-8201 is in, such as BASIC mode, or TEXT mode.

> **REFERENCE:** Refer to individual Chapters to determine the functions assigned to the CTRL Key for different modes.

The CTRL + A Key is an example of how the instruction would be written in this manual. It is simply telling you to press both the CTRL Key and the A Key at the same time.

**GRPH** — GRAPHICS symbols can be input by using the GRPH Key in combination with Ordinary Keys. Only the Ordinary Keys Z, X, and C have been pre-set with graphics symbols:

```
Z ◄        X ↵        C ■
```

There are 125 other graphics symbols that may be defined through the use of a BASIC program.

> **REFERENCE:** See the BASIC Reference Manual or Appendix C for a detailed explanation of how to define these graphics symbols.

**CAPS** — This key will lock when pressed to allow input of all capital letters, as with any ordinary keyboard. The locked the CAPS Key is bypassed when numbers or symbols such as the period, parentheses, exclamation point, etc., are input. This means that when you want to input the symbols shared by the those keys you must manually press the SHIFT Key. The CAPS Key is unlocked by pressing the key again.

**BS** — The Back Space Key is used to erase characters directly to the left of the cursor. If there are characters or lines of text continuing past the point of the cursor position, then those characters or lines of text will be pulled backwards, and the characters before the cursor will be deleted.

**DEL** — The DELETE Key is input by pressing the DEL/BS Key simultaneously with the SHIFT Key. This key is used to erase characters at the point of the cursor position. The characters are pulled backwards towards the cursor and characters at the cursor position will be deleted each time the key is input.

**INS** — The INSERT Key is used with the BASIC mode. You can access the INSERT mode by pressing this key. While in the insert mode you can insert characters into a line immediately before the cursor position. The insert mode is deactivated by pressing a Cursor Movement Key or pressing the PAST/INS Key again. Notice the cursor change to a bar instead of a block when in the INSERT mode.

**PASTE** — The PASTE Key is input by pressing the PAST/INS Key and the SHIFT Key simultaneously. This key allows the contents of the PASTE buffer to be input.

> **REFERENCE:** Refer to Chapter 7 for explanations of the use of this function in the TEXT mode.

**STOP** — The STOP Key is used to interrupt the execution of different commands, depending upon the mode, such as BASIC, TEXT, and TELCOM. To stop the operation of peripheral devices, press the SHIFT Key and the STOP Key simultaneously.

> **REFERENCE:** Refer to individual chapters on software features for a full explanation of the different uses of the STOP Key.

**ESC** — When an Ordinary Key is input while pressing the ESCAPE Key, an escape sequence is run. This key is utilized differently in various modes.

> **REFERENCE:** Refer to individual chapters for a full explanation of the different uses of the ESC Key.

**TAB** — This key is primarily used in the TEXT and BASIC modes. Desired tab positions are set and the TAB Key is input to advance the cursor to those positions.

> **REFERENCE:** Refer to Chapter 7 for an explanation of the use of this key in the TEXT mode.

### CURSOR MOVEMENT KEYS

These keys are the four triangular keys with arrows on them. They are used to move the cursor on the screen in the direction of the arrow. The cursor movement Keys function differently in the BASIC and TEXT modes.

> **REFERENCE:** See Chapter 7 for details on the use of the Cursor Movement Keys while in the TEXT Mode.

### SPACE BAR

The Space Bar is the long narrow key centered on the bottom row of the keyboard. The Space Bar creates spaces as on any ordinary typewriter. The function of the Space Bar is different with each software feature, such as BASIC, TEXT, and TELCOM.

> **REFERENCE:** See individual chapters for details on the use of the Space Bar while utilizing various modes.

**RETURN** — This key is usually called the [RETURN] key and is used to execute commands from the keyboard. It is also used to mark the end of lines used in BASIC or TEXT files. The function of the key differs with various software features.

> **REFERENCE:** See individual chapters for an explanation of the use of the key with different software features.

## Function Keys

The Function Keys have different functions according to the software feature in use, such as BASIC, TEXT, or TELCOM.

> **REFERENCE:** Refer to individual chapters for explanations of the use of the Function Keys in different modes.

Function Keys 1 through 5 are activated by pressing the respective keys. Function Keys 6 through 10 are activated by pressing the SHIFT Key and the same Function Keys simultaneously.
