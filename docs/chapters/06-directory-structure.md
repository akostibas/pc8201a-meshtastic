# Chapter 6: Directory Structure

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 76–78). Prose is approximate and **tables/figures
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.
> Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.

## 6.1 Directory Configuration Per Entry

The directory area is allocated in the middle of the bookkeeping area. The top of the address is F84F in hexadecimal. The directory configuration is shown below.

```
DIRTBL: BASIC
          FILER
                   <--------- &HF84F
          TELCOM
NULDIR:   (Directory for non-registered program)
SCRDIR:   (Directory for SCRAP)
EDTDIR:   (Directory for EDIT command)
USRDIR:   (Directory for user-defined files)

          ((End-of-directory)) &HFF
```

> Note: The "non-registered program" means a non-saved BASIC program. Refer to "BA file" in the previous section. "Directory for SCRAP" and "Directory for EDIT command" are explained in "DO file".

Each slot in the directory consists of 11 bytes: 1 byte flag, 2 bytes address, and 8 bytes file name. The first 6 slots in the directory area are initialized by the INIT routine at the COLD START.

**Dir slot's configuration per entry**

| Field     | Size    |
|-----------|---------|
| Dir flag  | 1 byte  |
| Addrfield | 2 bytes |
| File name | 8 bytes |
| **Total** | **11 bytes** |

<!-- TODO(tier-b): bit-flag table garbled — re-OCR from source page 76 -->

**Bit assignment of Directory flag**

```text
Bit 7  Master bit      (1 when directory valid)
Bit 6  ASCII bit       (1 when ASCII-text file)
Bit 5  Binary bit      (1 when Machine-language file)
Bit 4  File-in-ROM     (1 when file is in ROM)
Bit 3  Hidden file     (1 when file is hidden)
Bit 2  <!-- ? -->
Bit 1  RAM file open flag
Bit 0  For internal use (always set to 0 normally)
```

**Vptr address-field**

<!-- TODO(tier-b): address-field labels garbled — re-OCR from source page 77 -->

```text
B,e  - Address which TXTTAB must be set to
oe   - Beginning address of file
c,e  -        ditto
```

TXTTAB in BASIC shows the lowest byte of the file, the first link pointer in the BASIC program file. Please refer to her manual to understand what "link pointer" is if you wco handle the BASIC programs. <!-- OCR: unclear ("her", "wco") -->

Initialized values for the first 6 slots in the Directory are shown below. The first 3 files are stored in ROM and displayed on the menu screen. (These 3 files are called the "standard programs".) The next 3 files are used for hidden files created in RAM area. These hidden files will not appear on the Menu screen. Refer to the previous section, "DO file" and "BA file". The characteristics of these hidden files are described there.

> Note: First 6 slots in Directory (Initialized data stored at &H6C8E)

<!-- TODO(tier-b): directory-init data garbled — re-OCR from source page 78 -->

```asm
        ;BASIC
        DB      &B1011000    ; flag <!-- OCR: 7 bits in source -->
        DW      Start address of BASIC
        DB      'BASIC
        DB      0
        ;FILER (TEXT)
        DB      &B1011000    ; flag <!-- OCR: 7 bits in source -->
        DW      Start address of TEXT
        DB      'TEXT
        DB      0
        ;TELCOM
        DB      &B1011000    ; flag <!-- OCR: 7 bits in source -->
        DW      Start address of TELCOM
        DB      'TELCOM'
        DB      0
        ;for non-registered program
        DB      &B10001000    ; flag
        DW      0
        DB      0
        DB      'XXXXXXX'
        ;for SCRAP file
        DB      &B11001000    ; flag
        DW      0
        DB      0
        DB      'YYYYYYY'
        ;for EDIT command of BASIC
        DB      &B01001000    ; flag
        DW      0
        DB      0
        DB      'ZZZZZZZ'
```
