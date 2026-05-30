# Chapter 8: RAM File Handling

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 102–153). Prose LLM-cleaned 2026-05-29; figures/tables pending Tier B vision re-OCR.
> **Do not treat numeric/tabular values here as authoritative.**

In this chapter, the technique to manage the RAM file is described. The main purpose is to create or delete a RAM file for the applications stored in the RAM area or 2nd ROM. As described before, if there is some violation in the standard rules of RAM file handling, the file you made (or sometimes all files in the RAM) will be lost by the standard manipulation. (The "standard manipulation" means the file handling or operation with Menu, BASIC, TEXT or TELCOM in ROM #0.)

There are many useful routines to make up for these violations of standard rules in ROM #0. But using ROM #0 from ROM #1 will reduce the speed of the application. If you want to handle the RAM file without ROM #0, please make sure what you should do in this chapter. And refer to "Bookkeeping" and "Directory structure".

> **NOTE:** Another technical manual for PC-8201A has already been made available. There is much information about the RAM file handling routines in ROM #0 in it. For example, "OPEN RAM FILES", "KILL ASCII FILE", "READ A CHARACTER FROM A RAM FILE" and "CLOSE ALL FILES". If you will use your application or subroutine with ROM #0, you had better refer to that manual.


## 8.1 What Should We Do in RAM File Handling

In the "Directory structure" and "Bookkeeping area", many rules about the RAM file handling are described. The important rules are explained again here.

**1. Make sure that there is enough free area.**

When a new file is opened, or new data is appended and inserted, please investigate whether there is enough free bytes in the current RAM bank. Especially, the free area requested in OPEN is sometimes ignored. At least, one byte is necessary to OPEN a DO file; 3 bytes for CO file. Refer to "What is RAM file" and following sections.

You can find where the free space is in the figure in "Bookkeeping area". The difference between the pointer STREND and the value in the stack pointer indicates the free size. But don't forget that some area will be used for stack operation in that free area. For instance, the make-room routine used in BASIC and TEXT recognizes that the current free space is less than 120 bytes from that difference. In other words, 120 bytes is always maintained for the stack area when new data is stored. Refer to "MAKHOL" in "Useful Routines For RAM File Handling In ROM #0".

**2. Register the file name correctly.**

The contents of the directory are described in "Directory construction". No one forgets to register the file name in it. But someone forgets to set up the directory flag byte and the starting address of the file. If you don't set the directory flag, the file might be deleted by Menu or another operation. If you write a bad starting address in the address field, the link of the directory and the files will be lost. As a result, you cannot select a file properly in Menu mode, or PC-8201A is hung up. In any case, the directory flag and address field have very important meaning. Please refer to "Directory construction" and following sections.

**3. Maintain the order of the files.**

In order to maintain the order of the files, we have to do a special trick in setting the starting address of the new file. For a new DO file, we have to set ASCTAB−1 as the starting address of that new file in the directory area. And for a new BA file, you have to register ASCTAB−1 in the "non-registered" file's directory area and insert double NULL codes there. That new BA file will be created at ASCTAB−1 and will have the starting address ASCTAB−2. In making both a new DO file and a new BA file, LNKFIL should be executed before the end of its process. Refer to "Useful Routines for RAM file handling in ROM #0" to understand what LNKFIL is.

**4. Make and shrink a hole safely.**

The calculation of the free space is very important. And you have to maintain the stack area when you make a room. One more important thing is the management of the pointers. The reason why many programs — Menu, BASIC, TEXT and so on — can use the same RAM area safely is that they adjust the pointers for RAM every time they change the RAM configuration. For example, when BASIC deletes a BASIC program file, it changes many pointers: STREND, ARYTAB, VARTAB, BINTAB and ASCTAB. And it turns off the directory flag in order to indicate that the slot in the directory is not used now. Refer to MAKHOL and MASDEL in "Useful Routines for RAM file handling in ROM #0".

**5. Insert the promissory byte in the file.**

When you open a DO file, you have to enter at least one byte of data. The data is Control-Z (0x1A); it shows the end of file in RAM. Sometimes this promissory byte is forgotten, so the routine which makes up the starting address in the directory area becomes confused. Simultaneously, BASIC needs 2 NULL bytes at the end of the file. A CO file requires a 6-byte file header at the top of the file. Refer to "What is RAM file".

**6. Make up the starting address in the directory.**

When you change the RAM configuration, you have to care not only about the pointers but also about the starting address in the directory area. It is easy to imagine that the starting address in the address field of all the DO files should be changed when you make a new BASIC file. (BASIC file is created under the lowest DO file. Refer to "Memory Map about RAM files".) And when some data are inserted in "A.DO", a DO file, the starting address of the DO file and CO file located above "A.DO" should be changed. Refer to "LNKFIL" in "Useful Routines For RAM file Handling in ROM #0". You can get the know-how to make up the starting address in the directory area.

**7. Bad data in DO file.**

You cannot store data which includes the character whose code is 0x00, 0x08 or 0x1A. The 0x00 is used as "NULL" to indicate a hole which is not used, or double NULL means the end of the BA file. The 0x08 is used as "Back space". The 0x1A is regarded as the end of the DO file, as you know. Refer to "DO file".


## 8.2 How To Make a New File

### 8.2.1 How To Register The New File Name

At the first, the new file name should be registered in the user's directory area when you create a new file. The user's directory area starts from USRDIR. And the next byte of the user's directory area — the end of the directory area — has 0xFF (255 in decimal). This byte is called the "Directory Stopper". The used slot starts with a number larger than 0x80 as the directory flag. Therefore it is easy to find the free slot. Refer to the sample program shown later.

You had better compare the new file name with the file names which already exist. Two files which have the same file name sometimes cause a serious problem. So during searching for the free slot, the existing file names should be checked. And if there is a same file name, you had better delete it before making the new file or abandon making a new file.

If you succeed in finding a free slot in the user's directory area, you have to register the directory flag, the address of the file, and the file name. At this time, you already know the file name. And you can set the directory flag now. (You can get detailed information about the directory flag in the section "DIRECTORY STRUCTURE".) The address of the file will be fixed later, because the way to get the address for the new file depends on the file type: DO file, BA file and CO file. In any case, don't forget to set up the directory flag when you register the new file name. Otherwise, Menu, BASIC or TEXT and so on will destroy your new file without any caution.

Refer to "Directory construction".

### 8.2.2 How To Make a DO File

If you have already registered the file name and directory flag at the slot in the directory area, now the only one piece of information lacking in the new directory area is the address of the new DO file. If you didn't read "How to Register The New File Name" and have not yet set the file name and directory flag, please read that section and make them up first.

Usually the new DO file is created just above ASCTAB, the lowest address of the existing DO files. Refer to the figure in "What is RAM file" to make sure your image. If you follow the standard rule used by Menu, BASIC and others in ROM #0, you can copy the contents of ASCTAB−1 as the starting address of the new file. Then the registration of the new DO file is done completely. The reason why we have to use ASCTAB−1 instead of ASCTAB is to maintain the order of the files. LNKFIL, which makes up the starting address in the directory area, searches the file name from top to end and links the starting address of each file. Since LNKFIL searches the directory from younger address to older address and older files have younger addresses, the order of the DO files will be swapped if you use ASCTAB instead of ASCTAB−1. Refer to "LNKFIL" in "Useful Routines for RAM file Handling in ROM #0".

But you have to do two more steps for that new DO file. One is to insert the end-of-file flag at the bottom of that new DO file. Another one is, as you know, to make up the starting address of other files in the directory area.

There is no DO file whose size is zero, because the final character of the DO file should be ^Z (0x1A, 26 in decimal). In other words, the ^Z indicates the End of File of the DO file. So the DO file will spend at least one byte. If you only want to open the new DO file without any data, you have to insert a ^Z at the starting address. If you want to save some data now, you have to append a ^Z at the end of the data. Never forget to insert a ^Z at the end of the file. Otherwise, the next RAM file operation might destroy all RAM files.

In order to make a room for the new file, a convenient routine is in ROM #0. Its name is MAKHOL (MAKe HOLe). This routine makes a hole from the specified point whose size can be decided by the contents in the [BC] register. Refer to "MAKHOL" in "Useful Routines For RAM file handling in ROM #0". The concept of MAKHOL is shown briefly in that section.

If there is no free area in RAM and you cannot insert a ^Z, you cannot continue to enter data to the file. And, of course, you have to clear the directory flag for the next user.

To make up the starting address in the directory area, the routine named LNKFIL is ready in ROM #0. The flow diagram of that routine is shown in "Useful Routines For RAM file handling in ROM #0". You can get information to make your own LNKFIL routine in it, too.

If you succeed in inserting a ^Z and making up the starting address field in the directory, the opening of a new DO file has been done successfully. You can save data to the new file using MAKHOL and LNKFIL. Refer to another section to know how to Append, Insert, and Delete data. The sample program in the following section will show you how to make a new file and save data.

**Cf. How to make a new DO file:**

1. Find a free slot in the user's directory. If you cannot find a free slot in the directory area, you have to give up making a new DO file. Or if you find the same name in the directory, delete that file or abandon continuing.
2. Register the file name and directory flag at the free slot.
3. Get ASCTAB−1 and save it in the address field of the slot.
4. Try to make a one-byte hole at the address where ASCTAB pointed.
5. If you fail to make a hole, clear the directory flag which you registered at (2).
6. If you succeed in making a hole, insert a ^Z at that point.
7. Make up the pointers and starting address in the directory area.
8. That's all. The new DO file has been created without fail.

> **NOTE:** If you make a hole by your own routine, please make sure that your own routine refines the pointers. Refer to the explanation about MAKHOL. And refer to "LNKFIL" to know how to make up the address in the directory.

### 8.2.3 How To Make a BA File

There are few differences between how to make a DO file and how to make a BASIC file. There is no difference in the registration of the file name and the directory flag. The first difference is that you have to end the BASIC file with double NULLs (0x00) instead of ^Z in DO files. In order to understand what double NULLs means, you have to be familiar with the function of the LINK POINTER in Microsoft BASIC. The inner specification of the Microsoft BASIC file is too difficult to describe here briefly. You can get some good texts to learn the information about BASIC programs and their data constructions at the book store or computer shop. But the basic concept about RAM file handling is exactly the same as DO file. (Register the file name and other information in the directory and make a room for the program.)

The second difference is that the new BA file is created just above the BA files which have already been stored. In other words, the new BA file is inserted just below the lowest DO file. Refer to the section "WHAT IS RAM FILE?".

I believe that the person who wants to handle the BA files is an expert about the BASIC program and BASIC interpreter. If you are a novice class programmer about the BASIC interpreter, you had better not try to handle the BA file yourself. Please use BASIC mode in ROM #0.

**ex. How to create a new BA file in PC-8201A:**

1. Search a free slot in the user's directory area. If you find a same name in the directory area, delete the file or abandon continuing.
2. Set up the directory flag and copy the file name into the directory.
3. Copy ASCTAB−1 into NULDIR, the non-registered program's directory area. And make a 2-byte hole and store the double NULL for the non-registered program.
4. Make a hole as large as possible at ASCTAB−1.
5. If the size of that hole is too small for the new BA file, clear the directory flag written in (2).
6. If you succeed in making a big hole for your BA file, copy the BASIC program into the hole. Don't forget to insert the double NULLs at the end of the program.
7. Register the starting address at the starting address area in the directory area. Usually, the address that is one byte less than the starting address of the non-registered program is used.
8. Squeeze the hole, when you made a too large hole.
9. Adjust the pointers: ASCTAB, BINTAB, VARTAB, ARYTAB and STREND. Make up the starting address of other files in the directory area. All DO files' and CO files' starting addresses in the directory field should be changed. Refer to LNKFIL.
10. End.

### 8.2.4 How To Make a CO File

The CO file is the other type of file which you want to make yourself beside the DO file. The difference between the DO file and CO file is the heading instruction of the file. The CO file needs the heading data instead of the End of File character, ^Z. So you have to make sure that there are more than 6 bytes besides the size of your machine language program in the free area. And if there is not enough free area, you cannot continue to make a new CO file. If you have already set up the directory flag and file name, clear them soon. Don't leave an illegal flag and file name in the directory.

**Heading of CO file:**

| Field             | Size   |
|-------------------|--------|
| START ADDRESS     | 2 bytes |
| LENGTH            | 2 bytes |
| EXECUTION ADDRESS | 2 bytes |

So the file length of a CO file can be calculated by LENGTH + 6. In making a CO file, don't forget to renew the pointers VARTAB, ARYTAB and STREND.

The CO file is usually made just under the address pointed by VARTAB. So the starting address of the other files need not be changed after saving the new CO file. But I recommend doing LNKFIL after saving a new CO file for safety.

**ex. BSAVE "MAC.",50000,10,50000 in BASIC mode.**

Dump the data in the CO file is:

```
0xC350        (50000)  Starting address
0x000A        (10)     Length
0xC350        (50000)  Execution address
```

**Cf. The flow of making a new CO file:**

1. Search the free slot in the directory area. If there is the same file name in the directory, delete that file or abandon continuing.
2. Check the free area. Estimate that the free size is greater than your CO file's length + 6 bytes.
3. If there is no room, stop making a new CO file.
4. Make a hole just under the address pointed by VARTAB and store the data (or machine language program). Make sure that all pointers are proper. At this time, if you use MAKHOL to make a room, you have to adjust the pointer BINTAB, because MAKHOL changes BINTAB always.
5. Register the file name, directory flag and start address in the directory.
6. Adjust VARTAB, ARYTAB and STREND. Make up the starting address of all other files in the directory for safety. If you use LNKFIL for adjustment of all start addresses in the directory, you have to care about BINTAB as you do in MAKHOL.
7. That's all.


## 8.3 How To Delete a File

You can guess how to delete a file from the RAM file system in PC-8201A easily. The things that you have to do are to clear the directory flag and to remove the data of the file.

To delete a directory entry, you only turn off the directory flag. If the directory flag is less than 0x80, other programs regard that slot as not used now.

And when you squeeze the body of the file, you have to check the pointers and the start address of other files in the directory. When you are using the subroutines in ROM #0, these pointers are adjusted automatically. But if you do it by your own routine, you have to care about the pointers. You can find good clues in "How to make new file", and "MAKHOL" in "Useful Routines for RAM file handling in ROM #0".

Whether you treat the pointers by your own routine or utilize MASDEL in ROM #0, you have to make up the starting addresses of the other files. LNKFIL will do it well. Refer to the following section to know the ENTRY information about LNKFIL. That section will give you a clue about what LNKFIL should do when you will make a LNKFIL yourself.

### 8.3.1 How To Delete a DO File

First, search the file name which you want to delete. If you don't remember the directory construction, please refer to the chapter "DIRECTORY CONSTRUCTION" and make sure of it. When you find the file name in the directory, check the directory flag of the file. The file which is opened in BASIC cannot be deleted. If you do it by force, the RAM file system might be crushed or the system might be hung up.

**Cf. The flow of deleting a DO file (calling a machine language program by USR function in BASIC):**

1. Search the file name in the directory.
2. Check the directory flag; if the file is opened by BASIC, you cannot delete it.
3. Get the starting address of the file.
4. Search ^Z (End of File).
5. Count the size of the file.
6. Remove the data of the file and shrink. The ROM routine MASDEL will do it automatically. MASDEL changes the pointers BINTAB, VARTAB, ARYTAB and STREND automatically.
7. Refine the starting address of other files. LNKFIL will help you.
8. Clear the directory flag of the file which you deleted.
9. That's all.

### 8.3.2 How To Delete a BA File

When you are not in a BASIC program, there are few differences between killing a DO file and killing a BA file. The differences are in searching the end of file. In DO file, ^Z (26 in decimal) indicates the End of File. But in BA file, there is no such a good terminator. The only way to get the end of the BA file is to trace the "link pointer" from the beginning of the BA file to the end. If you can utilize ROM #0, you may use the useful routine CHEAD. CHEAD searches the end of the BA file. And MASDEL removes the data and refines the pointers. You have to care about the TXTTAB position. If you delete a BA file which is located under the file pointed by TXTTAB, you have to adjust TXTTAB. This case occurs when TXTTAB points the second BA file and you delete the first BA file. Finally, you have to make up all the starting addresses (link pointers) in the directory area. LNKFIL will do it.

> **NOTE:** MASDEL does not change ASCTAB. When a BA file is killed, ASCTAB should be changed. So after calling MASDEL, you have to adjust ASCTAB. Refer to the sample program in the following section. Also "How to make a BA file" will give you a clue.

Another difference is that there is a limitation in deleting a BA file when you are executing that BASIC program. The following caution is available when you make a machine language subroutine for a program written in BASIC. If you won't make a machine language subroutine which handles the BASIC file, you may skip reading this caution.

> **NOTE:** You cannot kill the BA file when you are in it. In other words, when you are running a machine language subroutine with a BASIC program, you may not delete that BASIC program in the subroutine. The following short sample illustrates this.
>
> In BASIC mode, you can know where you are in by the `FILES` command. The file name with `*` is the current file which you are treating. You don't kill it.
>
> 1. Select BASIC mode in the menu.
> 2. Type a BASIC program:
>    ```
>    10 PRINT "HELLO"
>    ```
> 3. Save it: `SAVE "TEST"`
> 4. Load it again: `LOAD "TEST"`
> 5. Try to kill it: `KILL "TEST.BA"` → `?FC Error` / `Ok`
> 6. This result shows what I want to say. BASIC's KILL command checks the current TXTTAB and avoids killing itself. Your machine language routine should do the same check before killing a BASIC file.
>
> **NOTE:** The comparison between TXTTAB and the starting address of the BA file is available only when you are executing the BASIC program or executing the machine language subroutine in BASIC mode. It is meaningless to care about TXTTAB and the starting address when you are not in BASIC mode.

Refer to "What is RAM file" and "Bookkeeping area" to understand the position of the BA files and TXTTAB.

**Cf. The flow of deleting a BA file:**

1. Search the file name in the directory.
2. Check the directory flag; if the file is not a BA file, you cannot delete it.
3. Get the starting address of the file in the directory.
4. Compare that starting address to TXTTAB. If they are identical, you cannot delete it. If not, you have to remember which is larger: the starting address or TXTTAB.
5. Search the End of File. CHEAD will help you to find the end of file. Refer to "Useful Routines for RAM file Handling in ROM #0".
6. Count the size of the file.
7. Remove the data of the file and shrink. The ROM routine MASDEL will do it automatically. MASDEL changes the pointers BINTAB, VARTAB, ARYTAB and STREND. Refer to "What is RAM file" and "Bookkeeping area". And MASDEL returns the negative length in the BC register. You can use it to adjust ASCTAB.
8. Adjust ASCTAB.
9. Refine the starting address of other files. LNKFIL will help you. Refer to "Useful Routines For RAM file handling in ROM #0".
10. Restore the result of the comparison between the starting address of the file and TXTTAB. If TXTTAB is greater than the starting address, adjust it.
11. Clear the directory flag of the file which you deleted.
12. That's all.

### 8.3.3 How To Delete a CO File

<!-- FIGURE 8.1: Memory map showing loaded CO file layout (AXFFFF at top, CO files, DO files, BA files, AX8000 at bottom) — needs vision re-OCR from source page 119 (target: mermaid) -->

```text
                ex.    Delete a CO file itself

                1.    Load a CO file in BASIC or MENU.

                                 ----------------- AXFFFF
                                 -----------------
                                  I
                                  I

                                  : machine prog           I
                                                           I

                                                           :<--   BLOAD
                                                                   or

                                                                  Select
                                 =================
                                 : CO2 file
                                                                   in
                                 -----·------------               MENU
                                      CO file         :-:
                         BINTAB->:                     I
                                                       I

                                                       I
                                                       I
                                      DO files         I
                                                       I

                                 --------------
                                      BA files        .,
                                                       I

                         AX8000 ---------~-----
                                 Fig 8.1
```

<!-- FIGURE 8.2: Memory map showing state after machine program loaded/running (PC and STREND pointers shown) — needs vision re-OCR from source page 119 (target: mermaid) -->

```text
     2.    Run the machine program.

     ---------------- AXFFFF
     =================

       machine prog
                              <-- PC

                              <- STREND

     =================
        CO2 file       <- XAAAA

       CO file
                              <- BINTAB

        DO files

        BA files
AX8000 -----------------
     Fig 8.2
```

<!-- FIGURE 8.3: Memory map showing state after CO file deleted and data between STREND and XAAAA moved — needs vision re-OCR from source page 120 (target: mermaid) -->

```text
     3.   Delete the CO file and move the data between STREND and XAAAA.

                              ----------------- AXFFFF
                              =================
                              I                I
                              I                I
                              : machine prog   :<- PC

                                                    <- STREND

                              -----------------
                              I
                              I

                              : CO2 file
                                                    <- BINTAB
                                               I.
                                               I

                                  DO files

                                  BA files
                      AX8000 ----------~~--
                              Fig 8.3
```

> **NOTE:** PC means Program Counter.

You don't have to care about where you are in now, unlike killing a BA file or killing a DO file. You may delete any CO file you want to delete, even if you are executing that CO file. A CO file is loaded at the specified area when it is invoked in menu mode or in BASIC mode. So the CO file can delete the CO file itself and can save the free area.

Unfortunately, you cannot use MASDEL simply for shrinking the hole made by killing the CO file, as you can in deleting a BA file and a DO file. Because MASDEL changes the pointer BINTAB. (You can understand why BINTAB should not be changed by reviewing the section "What is RAM files" and "Bookkeeping area".) So if you want to use MASDEL, I do recommend that you save BINTAB before calling MASDEL and restore it after calling MASDEL.

**Cf. The flow of deleting a CO file:**

1. Search the file name which you want to delete.
2. Save the starting address in the directory.
3. Calculate the size of that file. The 2nd and 3rd bytes in that file show the data length. So the total size of the file is made by adding 6 bytes to the data length. (The 6 bytes include the starting address, data length and the execution address. Refer to "What is the RAM file".)
4. Set the starting address and the length for MASDEL.
5. Save BINTAB.
6. Call MASDEL.
7. Recover BINTAB.
8. Clear the directory flag of the file.
9. That's all.


## 8.4 How To Append Data To a DO File

The way to append data to the DO file is very easy. First, get the starting address of the DO file in the directory and search the end of file, ^Z. Then, make a room for data you want to store at that point. The routine MAKHOL is the best routine to make a room. Refer to "Useful Routines For RAM file handling in ROM #0". And don't forget to refine the starting address of other files in the directory area. LNKFIL will help you. Refer to the previous section "How to make a DO file" also.

**Cf. APPEND data to the DO file:**

1. Search the file name in the directory.
2. Make sure the file type and status by checking the directory flag.
3. Get the starting address in the directory.
4. Search the end of file, ^Z (26 in decimal).
5. Make a hole just before the ^Z. I recommend using MAKHOL.
6. Store data in the hole.
7. Shrink the hole, when the hole you made is too large for the data. MASDEL in ROM #0 is useful.
8. Refine the starting address in the directory area. LNKFIL will help you.
9. End.

There is a sample program of how to APPEND data to DO file in the following section.


## 8.5 How To Insert Data To a DO File

When you want to insert some data to the DO file, you can use the know-how which you use to APPEND data to the DO file. The difference is that you have to search the address where you want to insert the data instead of searching the end of file.

**Cf. Insert data to DO file:**

1. Search the file name in the directory.
2. Make sure the file type and status by checking the directory flag.
3. Get the starting address in the directory.
4. Get the address where you want to insert the data.
5. Make a hole for the data at that point. Usually MAKHOL in ROM #0 is used. MAKHOL changes the pointers BINTAB, VARTAB, ARYTAB and STREND.
6. Copy data in the hole.
7. Shrink the hole, when the hole is too large for the data. MASDEL in ROM #0 is useful. MASDEL adjusts the pointers BINTAB, VARTAB, ARYTAB and STREND.
8. Adjust the starting address in the RAM. LNKFIL in ROM #0 is useful. Refer to "Useful Routines for RAM file Handling in ROM #0".
9. End.


## 8.6 How To Delete Data From a DO File

To DELETE data from the DO file is easier than to INSERT data to the DO file. If you will use ROM #0, the routine named MASDEL deletes the data. MASDEL refines the pointers and LNKFIL adjusts the starting addresses of other files. You can find the detailed information about MASDEL and LNKFIL in "Useful Routines for RAM file in ROM #0". If you cannot use ROM #0, you have to renew the pointers BINTAB, VARTAB, ARYTAB and STREND yourself. And you must modify the starting addresses in the directory yourself. Refer to the chapter "Directory construction" and "Bookkeeping" to understand the directory structure and pointers. "MAKHOL" and "LNKFIL" in "Useful Routines for RAM file handling in ROM #0" show you how to do it.


## 8.7 Useful Routines For RAM File Handling In ROM #0

There are several useful routines in ROM #0 for RAM file handling. Indeed, you have to do "bank-switching" to use these RAM file handling routines from ROM #1. (Refer to Chapter 3.3.) But you don't have to worry about the pointers if you use them. And also, you can save the time to make your own subroutines. I do recommend you use these RAM file handling routines in ROM #0 for saving time and making applications smoothly.

The useful routines presented in ROM #0:

| Routine | Description |
|---------|-------------|
| MAKHOL  | Make a room for data entry with changing the pointers |
| LNKFIL  | Make sure the start address in the directory area |
| MASDEL  | Shrink the room made by MAKHOL. This helps you when you made a too large hole. |
| CHEAD   | Search the end of file in a BA file. |

### 8.7.1 MAKHOL

**Make a hole**

```
ADDRESS:  0x6C0A  (octal 066012, decimal 27658)
ENTRY:    [HL]  points where you want to make a hole
          [BC]  size of the hole
EXIT:     [HL] and [BC] are preserved
          Carry is set if out of memory
```

In order to know the free area's size, STREND is the best pointer. The amount of STREND and your file's size, in this case, should be less than [SP] − 120. (The "SP" means Stack Pointer, as you know.) The 120 bytes are reserved for stack operation. If there is enough room, MAKHOL shifts all data between the specified address and STREND. If not, MAKHOL returns with carry set.

<!-- FIGURE 8.4: MAKHOL flow diagram — needs vision re-OCR from source page 130 (target: mermaid) -->

```text
                ex.     The flow of MAKHOL.   (How to make a room safely.)

                /------------¥
                   MAKHOL
                ¥------------/
                ; STREND + Required bytes
                         < SP - Stack area ( 120 bytes) :
                           I
                           I   No
                           : -----.----> Out of Memory

                : Move the data between STREND and
                     specified address

               -------------------------------------
                 Change the pointers
                                                     **
                      ASCTAB, BINTAB, VARTAB, ARYTAB
                        and STREND
               -----------------~-------------------
                 -/-----------¥
                     RETURN
                  ¥-----------/
                    Fig 8.4
```

It is unnecessary to care about the pointers unless you make your own MAKHOL routine. The MAKHOL in ROM #0 manages the pointers automatically. But it does not change the starting address in the directory field. Refer to LNKFIL.

> **\*\*** When you make a hole just above ASCTAB to create a new DO file, you have to change the pointers BINTAB, VARTAB and ARYTAB. ASCTAB is modified only when you make a hole under ASCTAB to register a new BA file.

It is easy to guess that calling MAKHOL too many times will reduce the processing speed. So you had better call MAKHOL with a good large number in the BC register. It makes a good hole which is large enough to save the data you want to keep. The only one thing you have to care about is that you have to shrink the hole when you made a too big hole. The DO file cannot include NUL (0x00) or ^Z (0x1A) in the file. (The ^Z means the End of File, as you know.) There is a convenient routine to shrink the hole and it refines the pointers, also. Its name is MASDEL and you can get the information about it in the following section.

### 8.7.2 LNKFIL

**Fix up directory structure**

```
ADDRESS:  0x233A  (octal 021472, decimal 9018)
ENTRY:    NONE
EXIT:     NONE
          All registers might be altered
```

This routine fixes up all possible incomplete "links" between files and their directories. There are many chances in which the link pointers (same as starting address) in the directory fields are not maintained properly. For instance, making a new DO file will change the starting address of other DO files and CO files. I agree that these link pointers should be modified every time when the RAM organization is modified. But it is also true that such an operation will make a big overhead in RAM file handling. So you had better make sure when LNKFIL should be called. For instance, when a file is deleted during further file I/O, all link pointers should be fixed up.

<!-- FIGURE 8.5: LNKFIL internal flow diagram — needs vision re-OCR from source pages 130–131 (target: mermaid) -->

```text
                Internal flow of LNKFIL

                /---------------¥
                   LNKFIL
                ¥---------------/
                  Mark the all valid directory:
                : flag (turn 0 bit of all

                : Get the lowest file address:
               ~-----------------------------
                    Get the lowest link pointer
                     in the valid file's
                      directory

                : Save this link pointer r

                          :<------------------------------·
                  Search the lowest link pointer:
                : directory area

               ---------------------------
                 Save the saved link pointer
                    at this marked files link
                    pointer field    ·
               ---------------~-----------------
                          I
                          I
                               :

                 Demark the directory flag of
               : that file. (turn off the bit 0:
               : of that file)

                         (A)                             (B)

                l Get next lowest file address l
                l from the bottom of RAM       l·
                --------------------------------
                -----------------------------
                l All marked directory flag
                l has demarked?
               --------------------------------
                               Not End of directory

                        l End of directory

               /---------------¥
                     END
               ¥---------~----/
                       Fig 8.5
```

When the top address of the next file is searched, the pointers ASCTAB and BINTAB are useful to know what kind of file is searched now.

### 8.7.3 MASDEL

**Delete [BC] bytes from [HL]**

```
ADDRESS:  0x6C3C  (octal 066074, decimal 27708)
ENTRY:    [HL]  pointer of the hole should be squeezed
          [BC]  size of the hole
EXIT:     [HL]  preserved
          [BC]  negated
```

This routine does exactly the reverse operation of MAKHOL. The data above [HL]+[BC] is moved up. And the pointers BINTAB, VARTAB, ARYTAB are modified. If you use this routine for shrinking a hole of a BA file, you can adjust ASCTAB with the negated [BC] after exiting this routine. And also you can adjust TXTTAB by using this negated BC register if necessary. You have to adjust TXTTAB when you remove a BA file which is located under the address pointed by TXTTAB.

If you want to utilize this routine for a CO file, you need to save BINTAB and recover it after exit. BINTAB is not modified by killing a CO file.

### 8.7.4 CHEAD

**Search for the end of this BASIC program**

```
ADDRESS:  0x0718  (octal 03430, decimal 1816)
ENTRY:    [HL]  Top address of that BASIC file
EXIT:     [HL]  The last address of that BASIC file
          All registers and flags are possibly modified
```

The main purpose of CHEAD is to fix links of the BASIC program. In other words, CHEAD goes through the program storage and fixes up all the links. The end of each line is found by searching for the zero at the end. The double zero link is used to detect the end of the program. So EXIT [HL] plus one will show you the top address of the next file.


## 8.8 Sample Program

The sample programs listed here are exactly "SAMPLE". So some processes are omitted to make the explanation clear. For instance, searching the directory to find the good slot for file handling is not described except "How to make a DO file". You know that you have to survey the all directory for checking the same file name and free slot when you make a new file.

And also, these programs stored in this section are written in plain program technique. You will find another good algorithm to handle the RAM files safely and quickly.

### 8.8.1 Make A New DO File (ASCII File)

```asm
; Register new DO file in the Directory area
;    OPEN DO file
;
USRDIR  EQU     0xF891  ; Top address of user's directory
EOTDIR  EQU     USRDIR - Directory_length
DIRLEN  EQU     11      ; Length of the directory per file
NAMLEN  EQU     6       ; Length of the file name
ASCTAB  EQU     0xFAE1  ; Points the lowest address of DO files
LNKFIL  EQU     0x233A  ; Make up the address in Directory
MAKHOL  EQU     0x6C0A  ; Make a room for file
EOFFIL  EQU     0x1A    ; End of DO file

OPENDO:
        XRA     A           ; Clear HL
        MOV     H,A
        MOV     L,A
        SHLD    SLTADR      ; Clear slot address
;
        LXI     H,EOTDIR    ; Set [top of user directory]
                            ;   - Directory length
SEANAM:
        LXI     B,DIRLEN    ; Set Directory length
        DAD     B           ; Get next slot
        MOV     A,M         ; Get directory flag
        CPI     0x80        ; Valid?
        JC      NONVAL      ; Jump if not valid slot
        INR     A           ; End of directory area?
        JZ      ENOSEA      ; Jump if end of test
;
; Is the file a DO file?
        DCR     A           ; Adjust directory flag
        MOV     D,A         ; copy flag for later use
        ANI     0b01000000  ; Pick up ASCII flag
        ORA     A           ; DO file?
        JZ      SEANAM      ; Jump if not DO file
;
; Compare the name
;
        PUSH    H           ; Save the slot address
        INX     H
        INX     H           ; Advance to name field in directory
        XCHG                ; [DE] name address
        LXI     H,NAME      ; name of the file which we want to make
        MVI     B,NAMLEN    ; Set name length
CMPNAM:
        LDAX    D           ; Get directory's name
        CPI     M           ; Compare with our file
        JNZ     NOTSAM      ; Jump if not same
        INX     H           ; Advance the pointers
        INX     D
        DCR     B
        JNZ     CMPNAM      ; compare next
;
        POP     H           ; Top of the slot address
        MOV     A,M         ; Get directory flag
        ANI     0b00000010  ; Pick up OPEN BIT
        ORA     A           ; File already opened?
        JNZ     FILAOP      ; Jump if file already opened
;
; Find same name and not opened file
;
        SHLD    SLTADR      ; Save it
        CALL    DELFIL      ; Delete this file
        JMP     FINONM      ; go to Registration
;
; Find free slot
;
NOTSAM:
        XCHG                ; [DE] free slot address
        LHLD    SLTADR      ; Get free slot address that has been found
        MOV     A,H
        ORA     L           ; Never found?
        JNZ     EVERFN      ; jump if already found
        XCHG                ; This is the first time
        SHLD    SLTADR
        JMP     SEANAM      ; Check next slot
;
EVERFN:
        XCHG                ; Don't renew the address
        JMP     SEANAM
;
; Search of directory is done
;
FINONM:
        LHLD    SLTADR      ; Is there good free slot?
        MOV     A,H
        ORA     L
        JZ      DIRFULL     ; Jump if directory full
;
        PUSH    H           ; Save the top of the slot
        MVI     M,0b11000000 ; Set directory flag as DO file
        INX     H           ; Advance to name field
        LXI     D,NAME      ; Top of our file name
        MVI     B,NAMLEN    ; Name length
CPYNAM:
        LDAX    D           ; get source char
        MOV     M,A         ; copy it in directory
        INX     H
        INX     D
        DCR     B           ; Continue to end of name
        JNZ     CPYNAM
;
        LHLD    ASCTAB      ; Get lowest address for DO files
        LXI     B,1         ; Make one byte hole
        CALL    MAKHOL      ; Dig
        JC      MEMFUL      ; Jump if out of memory
        MVI     M,EOFFIL    ; Set end of file marker
        DCX     H           ; Lowest address - 1
                            ; for maintaining the file order
        POP     D           ; Recover Top of that slot
        INX     D           ; Advance to address field
        MOV     A,L         ; set start address
        STAX    D
        INX     D
        MOV     A,H
        STAX    D
;
; Make up starting address of other files in directory area
; (call LNKFIL here)
;
        RET
;
; External routines
;
DELFIL:
        ; Delete the specified file
FILAOP:
        ; Error handling --- File already opened
MEMFUL:
        ; Error handling --- Memory full
DIRFULL:
        ; Error handling --- Directory full
;
; DATA AREA
;
NAME:   DB      'TEST   DO'
        END
```

### 8.8.2 Save Data Into DO File

```asm
; Save data into DO file
;
; ENTRY: [HL] points directory of the file
;        [DE] address of source data
;        [BC] length of data
;
MAKHOL  EQU     0x6C0A  ; Make a room for data
LNKFIL  EQU     0x233A  ; Make up starting address
ENDFIL  EQU     0x1A    ; End of DO file
;
SAVDAT:
;
; Check the directory flag of the file
;
        MOV     A,M         ; Get directory flag
        PUSH    B           ; Save data length
        MOV     B,A         ; Save directory flag
        ANI     0b11000000  ; Pick up mode bits
        CPI     0b11000000  ; DO file?
        JNZ     BADFIL      ; Jump if not DO file
        MOV     A,B         ; Get flag again
        ANI     0b00000010  ; Pick up OPEN bit
        ORA     A           ; File already opened?
        JNZ     FILAOP      ; Jump if file already opened
        MOV     A,B         ; Get directory flag
        ORI     0b00000010  ; Say this file is opened
        MOV     M,A
;
; Search end of file
;
        POP     B           ; Recover DATA length
        PUSH    H           ; Save Top of directory address
        PUSH    B           ; Save DATA length
        INX     H           ; Advance to Address field
        MOV     A,M         ; get address in [HL]
        INX     H
        MOV     H,M
        MOV     L,A         ; Set top of the file
;
SEALOP:
        MOV     A,M         ; Get Data
        CPI     ENDFIL      ; End of file?
        JZ      FNDEOF      ; Jump if end of file
        INX     H
        JMP     SEALOP      ; Search next
;
FNDEOF:
; MAKE A ROOM FOR DATA
;
        POP     B           ; Recover data length
        PUSH    D           ; Save source address
        CALL    MAKHOL      ; Dig a hole for data
        JC      MEMFUL      ; jump if error detected
        POP     D           ; Recover source address
;
; Copy data into the hole
;
COPYLP:
        LDAX    D           ; Get source data
        MOV     M,A         ; save it into file
        INX     D
        DCX     B           ; Decrement DATA length
        MOV     A,B
        ORA     C           ; End of data?
        JNZ     COPYLP      ; Continue till end of data
;
; Make up starting address of other files in directory area
; (call LNKFIL here)
;
; Turn off the opened bit in directory flag
;
        POP     H           ; Recover directory address
        MOV     A,M         ; Get directory flag
        ANI     0b11111101  ; Turn off the flag
        MOV     M,A         ; Renew the flag
        RET
;
; External routines
;
BADFIL:
        ; Bad file mode
FILAOP:
        ; File already opened
MEMFUL:
        ; Memory full error
        END
```

### 8.8.3 Delete Some Data From DO File

```asm
; Delete some data from DO file
; ENTRY: [HL] Top of the directory address
;        [DE] Offset address of top data to be deleted
;        [BC] Length of data to be deleted
;
MASDEL  EQU     0x6C3C  ; Remove some data
LNKFIL  EQU     0x233A  ; Make up starting address
;
DELDAT:
;
; Check directory flag
;
        MOV     A,M         ; Get directory flag of the file
        ANI     0b11000000  ; Pick up VALID bit and ASCII bit
        CPI     0b11000000  ; Valid DO file?
        JNZ     BADFIL      ; Jump if bad file
        MOV     A,M         ; Get directory flag again
        ANI     0b00000010  ; Pick up OPEN bit
        ORA     A           ; Already opened?
        JNZ     FILAOP      ; jump if the file already opened
        MOV     A,M         ; Set opened bit
        ORI     0b00000010
        MOV     M,A         ; Say, the file is opened
;
        PUSH    H           ; Save directory address
        INX     H           ; Get start address of the file
        MOV     A,M
        INX     H
        MOV     H,M
        MOV     L,A         ; [HL] start address of the file
;
        DAD     D           ; Absolute address of the data
                            ; which should be removed
;
; Delete data
; [HL] TOP of the data, [BC] data length
;
        CALL    MASDEL      ; Remove the data from file
;
; Turn off the OPENED bit
;
        POP     H           ; Restore the directory address
        MOV     A,M         ; Get directory flag
        ANI     0b11111101  ; Turn off
        MOV     M,A
;
; Adjust the directory
        CALL    LNKFIL      ; Make up all start address in the
                            ; directory
;
        RET
;
; External routines
;
BADFIL:
        ; Bad file mode -- Error
FILAOP:
        ; File already opened -- Error
```

### 8.8.4 Delete DO File

```asm
; Delete DO file
;
; ENTRY: [HL] points the directory of the file
;
MASDEL  EQU     0x6C3C  ; remove data
LNKFIL  EQU     0x233A  ; adjust address field in directory area

DELOO:
        MOV     A,M         ; Get directory flag
        ANI     0b11000000  ; Pick up VALID and ASCII bit
        CPI     0b11000000  ; Valid DO file?
        JNZ     BADFIL      ; jump if bad file mode
        MOV     A,M         ; get directory flag
        ANI     0b00000010  ; pick up opened bit
        ORA     A           ; Already opened?
        JNZ     FILAOP      ; jump if already opened
;
; Calculate the size of the file
;
        PUSH    H           ; save directory address
        INX     H           ; get start address
        MOV     A,M
        INX     H
        MOV     H,M         ; [HL] start address
        MOV     L,A

        PUSH    H           ; Save start address
SEALOP:
        MOV     A,M         ; end of file?
        CPI     EOFFIL
        INX     H           ; next field
        JNZ     SEALOP      ; continue till EOF
;
        POP     D           ; Restore start address
        MOV     A,L         ; [HL]-[DE] = length
        SUB     E
        MOV     C,A
        MOV     A,H
        SBB     D
        MOV     B,A         ; Set length in [BC]

        XCHG                ; [HL] start address
;
        CALL    MASDEL      ; Remove the data
;
        POP     H           ; recover directory address
        XRA     A
        MOV     M,A         ; clear directory flag
;
; Make up all start address in directory
; (call LNKFIL here)
;
        RET
;
; External routines
;
FILAOP:
        ; File already opened error
BADFIL:
        ; Bad file mode error
        END
```

### 8.8.5 Delete BA File

```asm
; Delete BASIC file
;
; Assume that this subroutine is used with a BASIC main program
;
; ENTRY: [HL] directory address of the file
;
MASDEL  EQU     0x6C3C  ; remove data from file
LNKFIL  EQU     0x233A  ; make up starting address
CHEAD   EQU     0x0718  ; search end of BASIC file
TXTTAB  EQU     0xF450  ; lowest address of current BASIC program
ASCTAB  EQU     0xFAE1  ; Lowest address of DO files
;
DELBAS:
        MOV     A,M         ; Get directory flag
        CPI     0b10000000  ; BASIC file?
        JNZ     BADFIL      ; Jump if not BASIC file
        XCHG                ; [DE] directory address
        LHLD    TXTTAB      ; get lowest address of the
                            ; current BASIC program
                            ; (We are executing the
                            ; BASIC program with this
                            ; machine subroutine.)
        XCHG                ; [DE] TXTTAB  [HL] Directory address
        PUSH    H           ; save directory address
        INX     H           ; advance to address field
        MOV     A,M         ; get start address of BA file
                            ; which we want to delete
        INX     H
        MOV     H,M
        MOV     L,A         ; [HL] start address
        MOV     A,H         ; compare to TXTTAB
        SUB     D
        JNZ     NOSAM       ; jump if not same
        MOV     A,L         ; compare lower address
        SUB     E
        JNZ     NOSAM       ; jump if not same
        JMP     FCERR       ; you cannot kill your mother BASIC

NOSAM:
        XCHG                ; save start address in [DE]
        POP     H           ; recover directory address
        PUSH    PSW         ; save result of comparison
        XRA     A           ; [A]=0
        MOV     M,A         ; clear directory flag
        PUSH    D           ; save start address
;
; [DE] start address of the BA file
;
        XCHG                ; [HL] = start address
        CALL    CHEAD       ; search the end of BA file
        INX     H           ; adjust for length calculation
        POP     D           ; recover start address
        PUSH    D           ; Save start address again
        MOV     A,L         ; Calculate the length
        SUB     E
        MOV     C,A         ; Set length in [BC]
        MOV     A,H
        SBB     D
        MOV     B,A
        POP     H           ; recover start address
;
; Remove body of the file
;
        CALL    MASDEL      ; return negative length in [BC]
;
        LHLD    ASCTAB      ; adjust ASCTAB because MASDEL
                            ; doesn't change it
        DAD     B
        SHLD    ASCTAB
;
        PUSH    B           ; save this value for later use
;
; Adjust starting address in directory
;
        CALL    LNKFIL
;
        POP     B           ; Restore adjustment value
        POP     PSW         ; recall result of comparison
                            ; between TXTTAB and start address
        RNC                 ; Return if TXTTAB is smaller
                            ; than start address
        LHLD    TXTTAB      ; Adjust TXTTAB because we
                            ; delete BA file under TXTTAB
        DAD     B
        SHLD    TXTTAB
        RET
;
; EXTERNAL ROUTINES
;
FCERR:
        ; Illegal function call error

BADFIL:
        ; Bad file mode error
        END
```

### 8.8.6 Make New CO File

```asm
; MAKE NEW CO FILE
;
; ENTRY: [STARAD]  start address of CO file data
;        [LENGTH]  length of data
;        [EXECAD]  execution address
;        [HL]      directory address for this CO file
;
MAKHOL  EQU     0x6C0A  ; make a room
LNKFIL  EQU     0x233A  ; make up directory address field
HEADLN  EQU     6       ; Header length of CO file
BINTAB  EQU     0xFAE3  ; lowest address of existing CO files
VARTAB  EQU     0xFAE5  ; lowest address of Variable table

MAKECO:
;
; Refer HOW TO MAKE NEW DO FILE to know how to find
; the directory address for new files.
;
        MVI     A,0b10100000 ; Set directory flag as CO file
        MOV     M,A         ; register it
        PUSH    H           ; save directory address
        LHLD    LENGTH      ; get file length of new CO
        LXI     B,HEADLN    ; Set header length
        DAD     B           ; Get total length of new CO file
        MOV     B,H         ; Set length in [BC]
        MOV     C,L
        LHLD    BINTAB      ; [HL] lowest address of existing CO files
        PUSH    H           ; Save current BINTAB
        LHLD    VARTAB      ; [HL] just above highest CO file
        CALL    MAKHOL      ; Try to make a hole
        JC      MEMFUL      ; jump if there is no enough room
        XCHG                ; Save the top address of hole in [DE]
        POP     H           ; recover BINTAB
        SHLD    BINTAB      ; Adjust BINTAB
        XCHG                ; restore TOP of hole in [HL]
;
        POP     D           ; [DE] directory address
        INX     D           ; advance to address field
        MOV     A,L         ; Set start address
        STAX    D
        INX     D
        MOV     A,H
        STAX    D
;
; To register the file name in directory is omitted.
;
        XCHG                ; [DE] top of the vacant room
        MVI     B,HEADLN    ; Set header length
        LXI     H,STARAD    ; address of header data
COPYHD:
        MOV     A,M         ; Get header data
        STAX    D           ; store it in file
        INX     D
        DCR     B           ; end of header data?
        JNZ     COPYHD      ; copy 3 addresses as header
;
        LHLD    LENGTH      ; Get data length
        MOV     B,H         ; set length in [BC]
        MOV     C,L
        LHLD    STARAD      ; [DE] destination address
                            ; [HL] source address
COPYLP:
        MOV     A,M         ; copy contents of file
        STAX    D
        INX     D
        DCX     B           ; count down
        MOV     A,B         ; end of data?
        ORA     C
        JNZ     COPYLP      ; continue till end of data
;
        CALL    LNKFIL      ; make up all start address of
                            ; other files in directory area
        RET
;
; ERROR HANDLING ROUTINE
;
MEMFUL:
        ; memory full error
;
; DATA AREA
;
STARAD: DS      2
LENGTH: DS      2
EXECAD: DS      2
        END
```

### 8.8.7 Delete a CO File

```asm
; DELETE A CO FILE
;
; ENTRY: [HL] address of its directory
;
MASDEL  EQU     0x6C3C  ; remove data
LNKFIL  EQU     0x233A  ; make up starting address in the directory
BINTAB  EQU     0xFAE3  ; lowest address of CO files
HEADLN  EQU     6       ; length of the header in CO file

DELCO:
        MOV     A,M         ; Get DIRECTORY flag
        CPI     0b10100000  ; CO file?
        JNZ     BADFIL      ; Jump if BAD file mode
        XRA     A
        MOV     M,A         ; Clear directory flag
        INX     H           ; Advance to address field
        MOV     A,M         ; Get start address of the CO file
        INX     H
        MOV     H,M         ; [HL] start address
        MOV     L,A
        PUSH    H           ; save start address
        INX     H           ; Get file length in the header
        INX     H           ; (skip start address field in header)
        MOV     C,M         ; get length in [BC]
        INX     H
        MOV     B,M
        LXI     H,HEADLN    ; add header length
        DAD     B
        MOV     B,H         ; Set total length in [BC]
        MOV     C,L
        POP     H           ; recover start address
        XCHG                ; save it in [DE]
        LHLD    BINTAB      ; get lowest address of existing CO files
        PUSH    H           ; save it for later adjustment
        XCHG                ; [HL] start address, [BC] file length
        CALL    MASDEL      ; remove the body of the file
        POP     H           ; recover BINTAB
        SHLD    BINTAB      ; adjust BINTAB
;
        CALL    LNKFIL      ; make up starting address in
                            ; the directory area
        RET
;
; EXTERNAL ERROR ROUTINE
;
BADFIL:
        ; Bad file mode
        END
```
