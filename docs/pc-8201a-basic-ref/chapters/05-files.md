# Chapter 5: Files

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 213–216). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.

A file is a collection of records in the RAM of the PC-8201 or external devices, such as a data recorder.  Each record consists of a group of logically related characters.  For example, an N82-BASIC program line is one record.  The PC-8201 uses the record unit to read or write into a file, and each file is designated a distinct file name when the file is created.


## File Names

A file name consists of three parts:

- The main name, which must be no more than 6 characters in length.

- A period, used as a connector in the middle of the file name.

- The file type extension, added to the end of the file name, which is 2 characters long.

The file name can consist of any combination of characters, however the use of letters instead of numbers or symbols is recommended.  You run the risk of getting the error message "?NM Error" (Name Error) when using characters other than ordinary letters.  A legal file name must be entered if this error message is displayed.

An example of a legal file name with a file type extension:

```text
PC8201.BA
```

The ".BA" is the extension added by the PC-8201 when the file was saved.

The file name may be input in either upper or lower case characters, and will be saved and displayed on the screen exactly as typed.  The extension will always be displayed as upper case characters, so it does not matter which way it is typed if input by you.

The extensions represent specific file types:

- ".BA"    BASIC file.  BASIC programs are in Binary format.

- ".DO"    TEXT file.  TEXT and BASIC programs are in ASCII format.

- ".CO"    Machine Language file.  Programs and data are in Machine Language format.

The file type extension can be input by you, or the PC-8201 will assign one according to the mode you are using.  For the BASIC mode, the file type extension assigned by the PC-8201 would be ".BA".

The file names are displayed on the MENU screen in the following order:

```text
Machine Language files

TEXT files

BASIC files
```

You can also display the file names within the specific bank when in the BASIC mode by using the "FILES" command.  It is possible to execute BASIC programs from the MENU mode.

EXAMPLE:

Move the cursor onto the word "PC8201.BA" and then press the <!-- OCR: unclear (key symbol shown as small icon, likely ENTER or EXE key) --> Key.  The PC-8201 is now in the BASIC mode and the previously created BASIC program "PC8201.BA" is executed.  The screen will appear as shown:

<!-- FIGURE 5.1: Screen output of executing PC8201.BA from MENU mode, showing the text "The PC-8201 is a frendly computer! It offers many features, including the generation of sound, wordprocessing and many more." — deferred to image/table pass, source page 215 (target: image) -->


## Buffers

Buffer memory is reserved RAM area that is used by the PC-8201 to store transmitted and received data.  Each time you OPEN a file thru BASIC you reserve a buffer area.  The maximum number of OPEN files that are open at the same time is 15.  This means that the maximum number of buffers that you can reserve is also 15.


## File Handling

In order to read or write to a file you will have to prepare the file for this.  This is done by the use of the OPEN command.  The OPEN command utilizes the file number in conjunction with the file descriptor to assign a specific buffer area to that file.

After a file has been OPENed you can use the READ command to read records and the PRINT command to write records.  When you have completed your processing you will have to close the file by the use of the CLOSE command.


## Precautions for File Creation

When accessing files within the RAM of the PC-8201, the extensions are checked during the process.  This means that you can use identical file names for different files if the extensions of those names are different.  The PC-8201 will recognize the difference between each of these files during loading and saving, because it will check for an external device descriptor and file type extension, as well as for the file name.

The maximum number of files that can be stored in each of the three memory banks is 21, depending on the size of the individual files.  If an attempt is made to store more than the maximum allowable in a bank, an error will occur, and the message "?FL Error" is displayed.

When a Machine Language file is saved using the BASIC language "BSAVE" command, it can then be run directly from the MENU.  However, when a file created does not have a designated execute address, the Machine Language file is loaded into the memory, but the file does not run.
