# Chapter 6: Machine Language Programming

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 218–219). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.

Machine Language Programming is a collection of meaningful coded instructions that the PC-8201 can execute.  All other programming languages must be compiled or translated into Machine Language before they can be executed.  Machine Language is also known as Assembler Language or Code.

Machine Language programs execute much faster than any other programs, such as BASIC.  They take less memory, and they have virtually no limit to the things they can be programmed to do.

With Machine Language programs you have the ability to get into any memory location of the PC-8201.  It is necessary to save important programs or files on external devices, such as a data recorder, because a simple mistake can easily wipe out files in RAM.

If you alter vital memoty locations, such as the programs that operate the PC-8201, you could get the PC-8201 into a "hung up" situation, meaning that it does not respond, no matter what you input.

In the case of such a problem, you will have to perform a Cold Start.  After a Cold Start only the primary programs of BASIC, TEXT and TELCOM are displayed on the screen.  The rest of the files are destroyed.  This is why it is so important to save your files before attempting to run your Machine Language program.

> **See the User's Guide for more detail on how to execute a Cold Start.**

## Creating Machine Language Programs

In order to write Machine Language programs you will have to know the 8085 Assembler Language.  An Assembler program can be written in the TEXT mode and then use the optional Assembler Language compiler to create Machine Language code, or use the POKE command to actually create a Machine Language routine in the PC-8201 RAM.

Since creating a Machine Language program is tedious work, make sure you save it using the BSAVE command before attempting to test it, which avoids the loss of effort.  When debugging (testing) your Machine Language programs you can use the PEEK command to check the value of a specific memory location.

> **See Chapter 4 for an explanation on how to use the BSAVE, POKE, and PEEK commands.**

Once the Machine Language routine has been tested and saved, the BLOAD command can be used to load your program into the PC-8201 RAM.  The EXEC command is then used from within BASIC mode to run it.  Before loading a Machine Language routine, enough space must be reserved within the RAM for the routine.

> **For more datails on BLOAD and EXEC commands, please refer to Chapter 4.**

The Machine Language program should include a RET command at the end of the routine, so control can be returned to BASIC mode.
