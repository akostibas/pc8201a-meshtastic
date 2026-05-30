# Chapter 2: Precautions

> Vision-OCR'd from NEC8201A-UsersGuide.pdf (image-only scan, source pages 29-36 / printed 2-1..2-8), 2026-05-30.
> Figures/tables are transcribed per the project's per-figure-type policy; values flagged with TODO(tier-b) still need a human check against the scan.
> **Do not treat numeric/tabular values here as authoritative** — Tier B review pending.

## Overview

It is important that you become familiar with the information contained in this chapter. You will get the best performance from your PC-8201 and avoid unnecessary errors if you follow the precautions outlined here.

## Cold & Warm Start

When the PC-8201 is normally turned ON, the contents of the RAM is not erased. When the previously saved files remain intact and available for use after the power is turned ON, the process is known as a "Warm Start".

A "Cold Start" clears all of the contents of the RAM, including any of your previously saved files. The time and date are even erased when a Cold Start is performed.

### Warm Start:

The Warm Start is performed by simply turning the power switch ON. This is the method normally used, since it will usually be desirable to retain files saved in the RAM. The MENU is displayed on the screen after the Warm Start is performed.

### Cold Start:

The following steps are performed for a Cold Start:

1. Turn the Back Up Power Switch to the ON position if it is not already. Then turn ON the main power switch.

2. Press the [SHIFT] + [CTRL] Key simultaneously.

3. Press the Reset Switch located on the back of the PC-8201.

The display will be erased for an instant after the Cold Start, and then a normal MENU display will appear on the screen. Since the RAM has been completely erased, the MENU display will not show file names other than those of BASIC, TEXT, and TELCOM. Those three primary files are not erased because they are located in the ROM:

<!-- FIGURE 2.1: post-Cold-Start MENU screen showing BASIC/TEXT/TELCOM with date/time and free-byte count — screen mock-up, source page 30 (target: ascii) -->

```text
1983/01/01 00:00:00      (C) Microsoft #1
BASIC      TEXT      TELCOM      -.-
-.-        -.-       -.-         -.-
-.-        -.-       -.-         -.-
-.-        -.-       -.-         -.-
-.-        -.-       -.-         -.-
-.-        -.-       -.-         -.-
Load     Save     Name     List     12374
```

<!-- TODO(tier-b): verify free-byte count "12374" and the BASIC label (highlighted/inverse block) against source page 30 -->

> **[RETURN]** Be certain that you want to erase all files before performing a Cold Start and pressig the Reset Switch. It should not be necessary to perform this procedure often.

> **NOTE:** It is advisable to save important programs and files on cassette tape before performing a Cold Start.

### Cold Start for Banks #2 and #3

If the memory has been expanded to make Banks #2 and #3 available, a Cold Start must be performed for each of these banks after installation of the additional RAM.

This type of Cold Start is performed in the MENU mode. The steps for the Cold Start of Bank #2 are performed while displaying Bank #1, and the steps for the Cold Start of Bank #3 are performed while displaying Bank #2. The two steps of the Cold Start must be performed one right after the other, with no time lapse between the two. The [SHIFT] Key is kept depressed during both steps:

1. Press the f.5 Function Key while keeping the [SHIFT] Key depressed. The screen will clear for an instant at this time.

2. Press the [CTRL] Key immediately after pressing the f.5 Function Key, while the [SHIFT] Key remains depressed and the screen is clear.

This process will not work if the [SHIFT] Key is released before step 2 is completed. The screen clears instantly after step 1, and step 2 must be performed during the instant that the screen is cleared, before a new screen is displayed.

If the Cold Start for Banks #2 and #3 does not work, try it again. It is possible that too much time lapsed between steps 1 and 2, even if you thought that they were performed quickly enough.

Bank #2 should be cleared of all files after the above Cold Start is performed successfully. To clear Bank #3, the process in steps 1 and 2 above are repeated exactly as in the Cold Start performed for Bank #2, with the exception that the procedure would be started from Bank #2.

## IPL

The PC-8201 has a special feature called "IPL" (Initial Program Load). This feature allows you to have predetermined functions performed every time the PC-8201 is turned ON. For example, the PC-8201 could automatically go into a particular mode, such as BASIC, or it could automatically run a particular program each time it is turned ON. This is all done by the use of a special file generated in the TEXT Mode.

This feature is initiated by the "IPL Command File", containing the program that instructs the PC-8201 to perform the specified function when turned ON.

> **REFERENCE:** See the Commands section of Chapter 5 for more details on constructing an IPL Command File or for setting up an IPL operation.

## Reset Switch

The Reset Switch is located on the back of the PC-8201. As mentioned previously, the Reset Switch should not be used often, since it will cause the programs and files stored in the RAM to be erased:

<!-- FIGURE 2.2: rear-panel connector/switch layout of the PC-8201 (AC-adapter, Protect switch, Reset switch, SIO1, SIO2, Bar-code reader/BCR, RS-232C, Printer, Cassette/CMT connectors) — illustration, source page 33. TODO(tier-b): crop image from source. -->

The Reset Switch is used during the Cold Start process and as part of a sequence for freeing the PC-8201 when "hung up".

When the PC-8201 appears to be "hung up", it does not respond when keys are input on the keyboard. This should not happen when using the built-in software features, but may occur while using customized programs.

To resolve a "hung up" situation:

1. Press the [STOP] Key.

If the problem is not resolved:

2. Press the [SHIFT] + [STOP] Key simultaneously.

If the PC-8201 is still "hung up":

3. Press [CTRL] + Q Key simultaneously.

If there seems to be no other solution to the problem:

4. Press the Reset Switch.

5. Press the Reset Switch, the [SHIFT] Key, and the [CTRL] Key simultaneously.

Most times, steps 1 - 4 will be the only actions needed to resolve a problem.

> **[RETURN]** In any situation requiring you to perform steps 5 and 6, remember that the files contained in the RAM will be erased.

## Protect Switch

When the RAM of the PC-8201 has been expanded by the addition of CMOS 8K byte chips (PC-8201-06), or with a RAM Cartridge (PC-8206), extra memory banks become available for use.

The Protect Switch, set to the ON position, prevents data from being entered into Bank #2, so there is no way that the data in the bank could be "written over".

Bank #3 is protected by a similar protect switch located on the side of the RAM Cartridge (PC-8206). This protect switch is the only switch located on the cartridge.

The main Protect Switch on the back of the PC-8201 should be left ON whenever you want to protect vital data. If you want to access the data in Bank #2 then the Protect Switch must be turned OFF.

The protect switch on the RAM Cartridge operates in the same manner as the main Protect Switch.

> **NOTE:** When you are turning the protect switch of the RAM Cartridge ON be sure that the power of the PC-8201 is turned OFF.

Bank #1 is unprotected. Since data could be "written over" in Bank #1, it is recommended that all important programs and files be stored in Banks #2 and #3.

## Care of the PC-8201

1. Never expose the PC-8201 to extreme temperatures. Extreme cold could freeze the LCD display, causing permanent damage.

2. Do not leave the PC-8201 or peripheral devices in direct sunlight.

3. Never leave your PC-8201 in the car unattended for long periods, since temperatures are not controlled in a parked automobile.

4. Never leave the PC-8201 in the luggage compartment of a train, bus, or airplane, since temperatures are not controlled in those areas.

5. Never allow the PC-8201 to pass through airport X-Ray scanning equipment.

6. Avoid putting pressure on the LCD screen. Excessive pressure could cause permanent damage to the display.

7. Do not use harsh detergents or cleaning solutions on the PC-8201. Clean only with a slightly damp cloth.

8. Keep connection ports on the back of the PC-8201 covered with the plastic covers provided when not in use. Pins and connectors could easily be damaged if left uncovered.

9. Read the User's Guide thoroughly. Notice the precautions, special references, and special notes listed in the manual for best performance of the PC-8201.
