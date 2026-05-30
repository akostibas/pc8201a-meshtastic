# Chapter 4: How To Use 2nd/3rd RAM

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 49–59). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> Do not treat numeric/tabular values here as **authoritative**.

When you want to change the bank of RAM, the most simple method is to do an OUT instruction and to jump to `0X0000` for a warm start, because managing the bookkeeping area yourself is too difficult. But if you would not like to do a warm start, you must manage the bookkeeping and system parameters yourself and use the special RAM bank handling routine.

You can easily guess that when the bank of RAM is changed, PC (the program counter) must stay lower than `0X7FFF`, because a bank switch completely changes the code in RAM from address `0X8000` to `0XFFFF`. The area from `0X0` to `0X7FFF` is used for ROM. The only way is to make a special RAM bank switch routine in all RAM banks at the same address. The following illustration will help you to understand this curious method.

```asm
   POP      HL           POP    HL       ; Pick up return address
   MOV      A,NEXT       MOV    A,NEXT   ; Set next bank status
   OUT      0XA1         OUT    0XA1     ; Change bank
   PUSH     H            PUSH   H        ; Set return address
   RET                                   ; Return to specified address
         RAM #0          RAM #1
            Fig 4.1
```

Same routine is stored in the same position of 2 RAM banks. Refer to the next section to write a program at another bank.

In addition, you must take care of the STACK POINTER, too.

## 4.1 Read and Write to Another RAM Bank

There are two methods to read/write another bank of RAM. The first is simpler than the second. But the first method has some limitation in performance, because this method uses ROM #1. The second method is more complex, but more powerful. The size of the second method is longer than the first.

These are very useful routines in the 1st ROM: GETBNK and PUTBNK.

### 4.1.1.1 GETBNK (`0X7EEC`)

This routine reads one byte from other banks of RAM. The GETBNK routine temporarily changes the specified RAM bank, reads a byte pointed by [HL], and returns to the original bank. Interrupts should be disabled before calling the GETBNK routine.

```
Entry   [B]  = Bank number
                  0X00: Main bank
                  0X08: Bank #2
                  0X0C: Bank #3
        [HL] = Address of byte to read
Exit    [D]  = Byte data which was read
Altered registers
        [A], [C], [D], [F]
```

### 4.1.1.2 PUTBNK (`0X7EE8`)

The PUTBNK routine writes one byte at the specified address pointed by [HL] in the specified RAM bank. Similar to the GETBNK routine, the original bank will be selected after writing the data. Before using the PUTBNK routine, interrupts should be disabled.

```
Entry   [B]  = Bank number
                  0X00: Main bank
                  0X08: Bank #2
                  0X0C: Bank #3
        [HL] = Location where the byte is stored
        [D]  = Byte data to be stored
Exit    None
Altered registers
        [A], [C], [F]
```

### 4.1.2 Method 2 (Using Your Original Code)

When your code is located in the upper address range (`0X8000`–`0XFFFF`), and you want to read/write a large amount of data in another bank of RAM, you had better change the target RAM bank at the lower position of memory.

(1) Your code is in RAM #1. And data you want to access is in RAM #2.

<!-- FIGURE 4.2: Memory map — code in RAM #1, data in RAM #2 (upper address scenario, step 1) — needs vision re-OCR from source page 52 (target: mermaid or table) -->

```text
                     AXFFFF   -------- --------
                                        Your       RAM
                                        code       #2

                     AX8000   -------- --------
                     AX7FFF   --------
                                        ROM

                     AX0000   --------
                       Fig 4.2
```

(2) Change the Bank.

<!-- FIGURE 4.3: Memory map — after bank switch, code in RAM #1 accesses RAM #2 (upper address scenario, step 2) — needs vision re-OCR from source page 53 (target: mermaid or table) -->

```text
                     AXFFFF   ---------
                                   Your
                                              I
                                    code      I
                              I
                              I
                              I
                                              :<--
                              I
                     AX8000   --------               Handle
                     AX7FFF   ---------               some
                                              '
                                              I        data
                                  RAM #2:
                                              I
                                              I

                                              :<--

                       Fig 4.3
```

(3) Then change back to the previous bank configuration.

In this case, you have to disable all interrupts before changing the BANK.

When your code is located at a lower address (`0X0000`–`0X7FFF`), for instance running a program in 2nd ROM, please use the next method to handle the data in other RAM banks.

(1) The program in 2nd ROM is running with RAM #1.

<!-- FIGURE 4.4: Memory map — code in 2nd ROM running with RAM #1 (lower address scenario, step 1) — needs vision re-OCR from source page 54 (target: mermaid or table) -->

```text
                         AXFFFF   ---------- ---------        \
                                  :standard:
                                  I
                                  I              RAM
                                  : RAM           #2
                         AX8000   ---------- ---------        .
                                                              ,

                         AX7FFF   ----------
                                        2nd
                                         ROM

                         AX0000   ----------
                             Fig 4.4
```

(2) Read or write RAM #2 by bank switching with all interrupts prohibited.

<!-- FIGURE 4.5: Memory map — RAM #2 switched in during bank switch (lower address scenario, step 2) — needs vision re-OCR from source page 55 (target: mermaid or table) -->

```text
                         0XFFFF   ---------- -----------
                                        RAM    : RAM
                                         #2    :standard
                                  I
                                  I

                         AX8000   ---------- -----------
                         AX7FFF   ----------
                                        2nd
                                         ROM

                         AX0000   ----------
                            Fig 4.5
```

(3) Switch again, and resume the previous processing.

---

**TITLE:** Read/Write routine for another BANK of RAM

This sample will access another bank of RAM. There are two routines in this source program. One is for byte-by-byte access using special bank switching. The other is for block-of-data access.

In the architecture of the bank, bank 1 (Standard RAM) is not able to switch the low address range (`0X0000`–`0X7FFF`).

```
Entry   HL: Address to be accessed
        C:  Bank number
Exit    B:  Data which was read

Entry   HL: Address to be accessed
        C:  Bank number
Exit    B:  Data to be written

Entry   HL: Start address to be changed
        A:  Bank number
        DE: Start address in current bank
        BC: Byte length to be read
Exit    None

Entry   HL: Start address to be written
        A:  Bank number
        DE: Start address in current bank
        BC: Byte length to be written
Exit    None
```

Bank number:

```
Bank #1 (Standard RAM)  : 0X00
Bank #2 (RAM #2)        : 0X08
Bank #3 (RAM #3)        : 0X0C
```

```asm
; <<< System label defines >>>
BNKCRL  EQU     0X0A1           ; Bank control port
STATUS  EQU     0X0A0           ; Bank status port
        ORG     0X0000          ; This program can be located
                                ; any place
                                ; This switch should be changed
                                ; according to the situation
HIGH    EQU     -1              ; High address (0X8000-0XFFFF)
SLOW    EQU     0               ; Low address  (0X0000-0X7FFF)

; <<< Byte access routine >>>
BYTER:  DI                      ; Disable interrupt
        IN      STATUS          ; Read current bank status
        PUSH    PSW             ; Save current bank status
        ANI     0B11110011      ; Clear high address of bank switch
        ORA     C               ; Set new data of bank
        PUSH    PSW             ; Save current bank
        MOV     A,C             ; Pick up new bank data
        RAR                     ;
        RAR                     ; Shift 2 bits
        MOV     C,A             ; Restore bank data
        POP     PSW             ; Pick up current bank
        ANI     0B11111100      ; Clear low address of bank switch
        ORA     C               ; Set new data of bank
        ENDIF
        OUT     BNKCRL          ; Select new bank!
        MOV     B,M             ; Read data from other bank
        POP     PSW             ; Pick up before bank
        OUT     BNKCRL          ; Select before bank
        EI                      ; Enable interrupt
        RET                     ;

BYTEW:  DI                      ; Disable interrupt
        IN      STATUS          ; Read current bank status
        PUSH    PSW             ; Save current bank status
        ANI     0B11110011      ; Clear high address of bank switch
        ORA     C               ; Set new data of bank
        PUSH    PSW             ; Save current bank
        MOV     A,C             ; Pick up new bank data
        RAR                     ;
        RAR                     ; Shift 2 bits
        MOV     C,A             ; Pick up current bank
        ANI     0B11111100      ; Clear low address of bank switch
        ORA     C               ; Set new data of bank
        ENDIF
        OUT     BNKCRL          ; Bank switch!
        MOV     M,B             ; Write data
        POP     PSW             ; Pick up before bank
        OUT     BNKCRL          ; Select before bank
        EI                      ; Enable interrupt
        RET                     ;

; <<< Block access routine >>>
BLOCKR: DI                      ; Disable interrupt
        PUSH    B               ; Save length
        MOV     C,A             ; Set up bank number
        IN      STATUS          ; Read current bank status
        STA     CURBNK          ; Save current bank
        ANI     0B11110011      ; Clear high address of bank switch
        ORA     C               ; Set new data of bank
        PUSH    PSW             ; Save current bank
        MOV     A,C             ; Pick up new bank data
        RAR                     ;
        RAR                     ; Shift 2 bits
        MOV     C,A             ; Restore bank data
        POP     PSW             ; Pick up current bank
        ANI     0B11111100      ; Clear low address of bank switch
        ORA     C               ; Set new bank data
        ENDIF
        POP     B               ; Pick up length
NEXTR:
        LDAX    D               ; Read data
        MOV     M,A             ; Write data
        INX     D
        INX     H               ; Next position of data
        DCX     B               ; Decrement counter
        JNZ     NEXTR           ; Loop until done
        LDA     CURBNK          ; Set previous bank
        OUT     BNKCRL          ; Select previous bank
        EI                      ; Enable interrupt
        RET                     ;

BLOCKW: DI                      ; Disable interrupt
        PUSH    B               ; Save length
        MOV     C,A             ; Set up bank number
        IN      STATUS          ; Read current bank status
        STA     CURBNK          ; Save current bank
        ANI     0B11110011      ; Clear high address of bank switch
        ORA     C               ; Set new data of bank
        ELSE                    ; <!-- ? original label/condition unclear -->
        PUSH    PSW             ; Save current bank
        MOV     A,C             ; Pick up new bank data
        RAR                     ;
        RAR                     ; Shift 2 bits
        MOV     C,A             ; Restore bank data
        POP     PSW             ; Pick up current bank
        ANI     0B11111100      ; Clear low address of bank switch
        ORA     C               ; Set new bank data
        ENDIF
        POP     B               ; Pick up length
NEXTW:
        MOV     A,M             ; Pick up data
        STAX    D               ; Write data
        INX     H               ;
        INX     D               ; Next position of data
        DCX     B               ; Decrement counter
        JNZ     NEXTW           ; Loop until done
        LDA     CURBNK          ; Restore previous bank
        OUT     BNKCRL          ; Select previous bank
        RET                     ;

; <<< System work area >>>
CURBNK: DB      0X00            ; Current bank data
        END
```
