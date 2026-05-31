# Chapter 9: Sample Programs

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 247–263). Transcribed faithfully and Tier B figure/table pass complete
> (figures rendered, tables checked against the source scan). Remaining
> items needing a human eye are tracked in the BASIC Reference Tier B
> review issue.

## PSET Routine

The PSET routine is used to draw lines and functions.  It
specifically draws boxes and circles.  You should feel free to use
required segments from this program by themselves to function as
subroutines when creating new programs.

```text
 10 '                LINE BOX CIRCLE
 20 SCREEN 0,0:CLS
 30 PRINT
 40 PRINT ' PSET PRACTICE'
 50 PRINT
 60 PRINT ' 1 LINE'
 70 PRINT ' 2 BOX'
 80 PRINT ' 3 CIRCLE'
 90 PRINT
100 INPUT' WHAT DO YOU WANT TO DRAW?';A$
110 ON VAL(A$) GOTO 130,260,400
120 BEEP: GOTO 20
130 '              LINE
140 CLS:PRINT
150 INPUT'COORDINATE FOR POINT X';X0: IF X0<0
    OR X0>239 THEN BEEP: GOTO 150
170 INPUT'COORDINATE FOR POINT Y';Y0: IF Y0<0
    OR Y0>63 THEN BEEP: GOTO 170
190 INPUT'COORDINATE FOR ENDPOINT X';X1:IF X1<0
    OR X1>239 THEN BEEP:GOTO 190
200 INPUT'COORDINATE FOR ENDPOINT Y';Y1:IF Y1<0
    OR Y1>63 THEN BEEP:GOTO 210
230 CLS:GOSUB 520
240 FOR I=0 TO 1000:NEXT:BEEP:GOTO 20
260 '              BOX
270 CLS:PRINT
290 INPUT'X COORDINATE';X0:IF X0<0 OR X0>239
    THEN BEEP:GOTO 290
310 INPUT'Y COORDINATE';Y0:IF Y0<0 OR Y0>63
    THEN BEEP:GOTO 310
330 INPUT'SECOND X COORDINATE';X1:IF X1<0 OR
    X1>239 THEN BEEP:GOTO 330
350 INPUT'SECOND Y COORDINATE';Y1:IF Y1<0 OR
    Y1>63 THEN BEEP:GOTO 350
370 CLS:GOSUB 660
380 FOR I=0 TO 1000:NEXT:BEEP:GOTO 20
400 '              CIRCLE
410 CLS:PRINT
420 PRINT'CENTER COORDINATES:'
430 INPUT'X COORDINATE';X0:IF X0<0 OR X0>239
    THEN BEEP:GOTO 430
450 INPUT'Y COORDINATE';Y0:IF Y0<0 OR Y0>63
    THEN BEEP:GOTO 450
470 INPUT'RADIUS';R:IF R<0 THEN BEEP:GOTO 470
490 CLS:GOSUB 740
500 FOR I=0 TO 1000:NEXT:BEEP:GOTO 20
520 '          SUB LINE
530 XD=ABS(X1-X0):YD=ABS(Y1-Y0)
540 XS=SGN(X1-X0):YS=SGN(Y1-Y0)
550 IF XD>YD THEN 600
560 F=-1:T=X0:X0=Y0:Y0=T
570 T=X1:X1=Y1:Y1=T
580 T=XD:XD=YD:YD=T
590 T=XS:XS=YS:YS=T
600 R=XD/2
610 IF F THEN PSET(Y0,X0) ELSE PSET(X0,Y0)
620 IF X0=X1 THEN RETURN
630 X0=X0+XS:R=R+YD
640 IF R>=XD THEN R=R-XD:Y0=Y0+YS
650 GOTO 610
660 '          SUB BOX
670 FOR I=X0 TO X1 STEP SGN(X1-X0)
680 PSET(I,Y0):PSET(I,Y1)
690 NEXT
700 FOR I=Y0 TO Y1 STEP SGN(Y1-Y0)
710 PSET(X0,I):PSET(X1,I)
720 NEXT
730 RETURN
740 '          SUB CIRCLE
750 FOR I=0 TO 1 STEP 1/(R*2)
760 II=I*I
770 X=R*I*2/(II+1)
780 Y=R*(1-II)/(II+1)
790 X2=X0-X:IF X2<0 THEN X2=0
800 Y2=Y0-Y:IF Y2<0 THEN Y2=0
810 X1=X0+X:Y1=Y0+Y
820 PSET(X1,Y1):PSET(X1,Y2)
830 PSET(X2,Y1):PSET(X2,Y2)
840 NEXT
850 RETURN
```

## Character Definition Program

There are many characters that can be defined by you through the
character definition function.  When you type in the following
program, such composition is greatly simplified because up to 125
individual graphics characters can be created at one time using the
screen editing process.  A group of characters that have been
defined at one time as a character set can be loaded one after
another by means of a BLOAD command, to bring out a hundred or
even a thousand graphics characters to work with if so desired.

Since characters can be skipped over when the <!-- OCR: graphics char at line (inline), source page 249 (target: image) --> Key and the "E"
Key are used, you can even replace individual characters in a given
set without erasing or altering others that you wish to retain (and if
nothing is newly defined, it is also possible to eliminate all if so
desired).

The newly defined characters are stored into a machine language
program.  The value of the character corresponds to the ASCII
character code represented on the keyboard.  The graphic characters
are accessed by pressing the <!-- OCR: graphics char at line (inline), source page 249 (target: image) --> Key and any other key at the same
time.

```text
 10 REM COPYRIGHT (C) NEC 1983
100 REM CHARACTER GENERATOR
110 REM USING ADRESS E960-EACF
120 CLEAR 256,59743!:DIM M(5,7):DEFINTB-Z
130 REM ***** INITIALIZE *****
140 SCREEN 0,0:CLS
150 POKE 65215!,96:POKE 65216!,233
160 H=131:C=0:AD=59744!
170 REM ***** MAIN LOOP1 *****
180 LOCATE 20,0:PRINT ' USING KEY'
190 LOCATE 15,1:PRINT 'SPACE = MODE'
200 LOCATE 15,2:PRINT 'CURSOR = MOVE'
210 LOCATE 15,3:PRINT ''ESC' = NEXT'
220 LOCATE 15,4:PRINT ' = DEFINE CHARACTER'
230 LOCATE 15,5:PRINT 'E = END'
240 LOCATE 10,7:PRINT 'CHR$(';
250 PRINT MID$(STR$(H),2);')BEING DEFINED';
260 X=0:Y=0:MX=0:MY=0:H=H+1:IF H=160 THEN H=224
270 FOR Y1=0 TO 63:PSET(36,Y1):NEXT:
280 REM ***** MAIN LOOP2 *****
290 IF T=0 THEN C$='ERASE' ELSE C$='WRITE'
300 LOCATE 10,0:PRINT C$
310 LOCATE X,Y:I$=INPUT$(1)
320 IF I$=CHR$(27) THEN 450
330 IF I$=CHR$(28) THEN X=X+1:IF X=6 THEN X=5
    ELSE MX=MX+1
340 IF I$=CHR$(29) THEN X=X-1:IF X=-1 THEN X=0
    ELSE MX=MX-1
350 IF I$=CHR$(30) THEN Y=Y-1:IF Y=-1 THEN Y=0
    ELSE MY=MY-1
360 IF I$=CHR$(31) THEN Y=Y+1:IF Y=8 THEN Y=7
    ELSE MY=MY+1
370 IF I$=CHR$(32) THEN T=NOT T
380 IF I$='E' OR I$='e' THEN 600
390 IF I$=CHR$(13) THEN GOSUB 490:GOTO 450
400 M(MX,MY)=-T:LOCATE X,Y
410 IF T THEN PRINT'#'; ELSE PRINT' ';
420 PSET(MX+40,MY+30,-T)
430 GOTO 290
440 REM ***** END OF LOOP*****
450 IF H=256 THEN 600
460 C=C+1:CLS
470 GOTO 180
480 REM ***** DATA POKE  *****
490 FOR X=0 TO 5
500 FOR Y=0 TO 7
510 M=M+M(X,Y)*2^Y
520 NEXT Y
530 POKE AD+C*6+X,M
540 M=0
550 NEXT X
560 FOR Q=0 TO 5:FOR R=0 TO 7:M(Q,R)=0
570 NEXT R,Q
580 RETURN
590 REM ***** LISTING *****
600 CLS:PRINT 'DEFINED CHARACTER(131-159)'
610 FOR I=131 TO 159
620 PRINT CHR$(I);'  ';:NEXT:PRINT
630 PRINT 'AND(224-255)'
640 FOR I=224 TO 255
650 PRINT CHR$(I);'  ';:NEXT:PRINT
660 INPUT'BSAVE (Y/N)';Y$
670 IF Y$='Y' OR Y$='y' THEN INPUT'FILE NAME';N$
    ELSE END
680 REM ***** FILE SAVE *****
690 BSAVE N$,59744!,366
700 END
```

<!-- OCR: line 220 — `PRINT ' = DEFINE CHARACTER'` leading space in string likely represents the GRP key graphics symbol (shown as a box icon in prose); source page 249 (target: image) -->
<!-- OCR: line 210 — `PRINT ''ESC' = NEXT'` double apostrophe before ESC is as printed; in N82-BASIC the string delimiter is `'`, so `''ESC'` represents the string `'ESC`; source page 249 -->

## Music Program

The SOUND command in N82-BASIC can be used to create
sophisticated music compositions consisting of simple half
notes.  The number 1 parameter determines the precise musical
step.  The SOUND command will also work quite effectively in
programs where a composition is to be performed.  The program
that follows is exclusively for musical composition.

The keyboard of the PC-8201 is turned into an actual keyboard of a
musical instrument in terms of input.  This keyboard input is
organized in the following order of input:

a) Length of note (the 'L' Key + a length designation between 1
   and 9 with an initial automatic designation of '5');

b) Octave (the 'O' Key + an octave designation between 1 and 4
   with an initial automatic designation of '2');

c) Note the keys "Z", "X", "C", "V", "B", "N", and "M" on
   the keyboard correspond to the whole notes "do", "re", "mi",
   "fa", "so", "la", and "ti" in the key of C, while the keys "S",
   "D", "G", "H" and "J" located obliquely above the first group
   on the keyboard correspond to half notes.  The designated
   length of a note consists of the following.  A rest is input by
   the SPACE bar.

**Figure 9.1** — Note-length designations (the value `1`–`9` following the `L` key):

| Value | Note | Length |
|-------|------|--------|
| 1 | thirty-second note (filled head, three flags) | 1/32 |
| 2 | sixteenth note (filled head, two flags) | 1/16 |
| 3 | eighth note (filled head, one flag) | 1/8 |
| 4 | dotted eighth note (filled head, one flag, dot) | 1/8 + 1/16 |
| 5 | quarter note (filled head, stem) | 1/4 |
| 6 | dotted quarter note (filled head, stem, dot) | 1/4 + 1/8 |
| 7 | half note (open head, stem) | 1/2 |
| 8 | dotted half note (open head, stem, dot) | 1/2 + 1/4 |
| 9 | whole note (open head, no stem) | 1 |

The length of a note and the octave can be omitted if these are not
to be modified because they will automatically be set at the values
indicated above.  A single note at a time can be modified by using
the <!-- OCR: graphics char at line (inline), source page 252 (target: image) --> Key.

It is a useful practice to press the "E" Key after every 20 or so notes
have been input because this will cause an immediate review of those
input notes and will define that series of notes as a 'Part' before a
prompt is displayed inquiring whether you want to redo or save that
series of notes.

If you dislike what you heard during the playback review, the entire
series can be discarded and you can begin again.  The input will be
displayed on the screen as capital letters "A" through "G" the sharps
displayed as lower case letters that correspond to "1a" through "so"
(in the key of C).  The input process can be stopped at any time by
the "Q" Key.

The data can be performed after it has been input at any time that
you desire, once this data has been converted into a file.  Tempo
and transposition functions are also available during playback.  You
simply have to follow carefully the instructions in the program.

If you desire to compose longer compositions, useful modifications
can be made to the input and editing methods by manipulating the
data as string arrays (the original data) and numerical arrays (data for
the performance of a composition).  In addition, the structure of
the original data itself can be directly rewritten while that data is
open to editing in the TEXT mode.

```text
 10 REM COPYRIGHT(C)  1983 NEC
 20 REM *** MUSIC ***
 30 CLEAR 2000!:MAXFILES=1
 40 DEFINT A-T:DEFSNG U-Y:DEFDBL Z
 50 DIM A(48),M$(49),S(500),L(500)
 60 SCREEN 0,0:Z=9394#
 70 FOR I=0 TO 47
 80 A(I)=Z:Z=Z/1.0594639#
 90 NEXT I
100 FOR I=1 TO 9:READ LN(I):NEXT
110 DATA 4,8,16,24,32,48,64,96,128
120 REM *** MENU ***
130 CLS:PRINT' *** MUSIC ***'
140 PRINT:PRINT' --- Play or Input ---'
150 PRINT:INPUT'(P/I)';Y$
160 IF Y$='P' OR Y$='p' THEN 200
170 IF Y$='I' OR Y$='i' THEN 710
180 PRINT'????':BEEP:BEEP:GOTO 130
190 REM *** PLAY ***
200 CLS:PRINT' --- PLAYER ---'
210 PRINT:PRINT'Type music data'
220 INPUT'file name.';N$
230 OPEN N$ FOR INPUT AS #1
240 S=0:E=0
250 IF EOF(1) THEN 280
260 LINEINPUT #1,M$(E)
270 E=E+1:GOTO 250
280 CLOSE:PRINT'End of road.'
290 PRINT'Data conversion.'
300 PRINT'You may transpose for music from 01G to
    04G.'
310 PRINT'You may change to tempo.(but L1=4)'
320 INPUT'Are you change transpose?(Y/N)';I$
330 IF I$='Y' OR I$='y' THEN GOTO 350
340 IF I$='N' OR I$='n' THEN GOTO 350 ELSE BEEP: CLS:
    GOTO 200
350 INPUT'Are you change tempo?(Y/N)';Y$
360 IF Y$='Y' OR Y$='y' THEN GOTO 380
370 IF Y$='N' OR Y$='n' THEN GOTO 380 ELSE BEEP: CLS:
    GOTO 280
380 IF I$<>'Y' AND I$<>'y' THEN 420
390 INPUT' Change transpose of a unit.(from -7 to
    7)';D:IF D<-7 OR D>7 THEN 390
400 IF D>0 THEN FOR I=0 TO 41:A(I)=A(I+D):NEXT:GOTO
    420
410 FOR I=47 TO 7 STEP -1:A(I)=A(I+D):NEXT
420 IF Y$='Y' OR Y$='y' THEN INPUT'V (From .25 to
    2)';V ELSE V=1
430 PRINT' ---Just moment please---'
440 C=0:FOR I=0 TO E-1
450 T$=M$(I):GOSUB 610
460 NEXT I
470 BEEP:CLS
480 PRINT N$;' End of change data.'
490 LOCATE 10,3:PRINT N$:LOCATE 10,4
500 PRINT' Hit any key.!'
510 IF INKEY$<>'' THEN 510
520 IF INKEY$='' THEN 520
530 LOCATE 10,4:PRINT SPACE$(14)
540 FOR I=0 TO C-1:SOUND S(I),L(I)*V:NEXT I
550 INPUT'Onece more (Y/N)';Y$
560 IF Y$='Y' OR Y$='y' THEN 490
570 IF Y$='N' OR Y$='n' THEN GOTO 580 ELSE BEEP: CLS:
    GOTO 480
580 IF I$='Y' OR I$='y' THEN PRINT'I must do
    initialize over again.':RUN
590 GOTO 130
600 REM *** DATA COMPILER ***
610 FOR T=1 TO LEN(T$)
620 N=INSTR('CcDdEFfGgAaB LO',MID$(T$,T,1))
630 IF N>13 THEN GOSUB 670:GOTO 620
640 M=N+M:S(C)=A(M-1):L(M)=L:M=M-N
650 IF N=13 THEN S(C)=0
660 C=C+1:NEXT T:RETURN
670 IF N=15 THEN M=12*(VAL(MID$(T$,T+1,1))-1):T=T+2:
    RETURN
680 L=VAL(MID$(T$,T+1,1)):L=LN(L)
690 T=T+2:RETURN
700 REM *** INPUT ***
710 CLS:PRINT' --- INPUT ---'
720 S=0:E=0:C=0
730 INPUT' Append or New data (A/N)';Y$
740 IF Y$='N' OR Y$='n' THEN GOTO 760
750 IF Y$='A' OR Y$='a' THEN GOTO 760 ELSE  BEEP: CLS:
    GOTO 720
760 INPUT'File name.';N$
770 IF Y$='A' OR Y$='a' THEN OPEN N$ FOR APPEND AS #1
    ELSE 800
780 PRINT'Please input continue':GOTO 820
790 REM *** NEW DATA ***
800 OPEN N$ FOR OUTPUT AS #1
810 PRINT'Please input new music '
820 PRINT'Data.'
830 INPUT'Are you want explanation for input?(Y/N)';Y$
840 IF Y$='Y' OR Y$='y' THEN GOSUB 1390
850 IF Y$='N' OR Y$='n' THEN GOTO 860 ELSE BEEP : CLS:
    GOTO 810
860 REM *** KEY INPUT ***
870 CLS:L$='L5':O$='O2':S=C:M$(E)='':B=0:T$='':F=1:
    L=32
880 LOCATE 0,0:PRINT L$
890 LOCATE 3,0:PRINT O$
900 LOCATE 6,0:I$=INPUT$(1)
910 P=INSTR('ZSXDCVGBHNJM LOE'+CHR$(27)+'Q',I$)
920 IF P=0 THEN 900
930 I$=MID$('CcDdEFfGgAaB ',P,1)
940 IF F=1 THEN T$=L$+O$+I$
950 IF F=2 THEN T$=O$+I$
960 IF F=3 THEN T$=L$+I$
970 IF F=0 THEN T$=I$
980 IF B=0 THEN T$=L$+O$+I$
990 IF P=17 THEN IF F<>0 OR B=0 THEN 880 ELSE B=0:
    GOTO 1220
1000 IF P=18 THEN IF S=C THEN E=E-1:GOTO 1250 ELSE
     1250
1010 IF P>13 THEN 1070
1020 X$=T$:B=1
1030 PRINT I$;:M$(E)=M$(E)+T$
1040 LOCATE 0,5:PRINT M$(E)+SPACE$(10);
1050 GOSUB 610:SOUND S(C-1),L(C-1):F=0
1060 GOTO 880
1070 ON P-13 GOTO 1080,1110,1140
1080 IF S=C THEN F=1 ELSE IF F=2 THEN F=1 ELSE
     F=3
1090 LOCATE 0,0:Y$=INPUT$(1):P=INSTR('123456789',Y$):
     IF P=0 THEN 1080
1100 L$='L'+Y$:GOTO 880
1110 LOCATE 3,0:Y$=INPUT$(1):P=INSTR('1234',Y$):IF P=0
     THEN 1110
1120 IF S=C THEN F=1 ELSE IF F=3 THEN F=1 ELSE
     F=2
1130 O$='O'+Y$:GOTO 880
1140 LOCATE 0,3:PRINT 'END OF PART':E;
1150 FOR I=S TO C-1:SOUND S(I),L(I):NEXT
1160 INPUT' OK(Y/N)';Y$:IF Y$='Y' THEN 1200
1170 IF Y$='N' OR Y$='n' THEN GOTO 1190 ELSE BEEP: CLS:
     GOTO 1140
1180 IF Y$='Y' OR Y$='y' THEN GOTO 1190 ELSE BEEP: CLS
     :GOTO 1140
1190 C=S:PRINT'Try again.':BEEP:GOTO 870
1200 S=C:IF E<49 THEN E=E+1:M$(E)='':F=1:B=0:CLS:GOTO
     880
1210 BEEP:PRINT'OUT OF DATA SPACE':GOTO 1280
1220 M$(E)=LEFT$(M$(E),LEN(M$(E))-LEN(X$))
1230 C=C-1:BEEP:LOCATE 0,3:PRINT'1 STEP BACK':
     BEEP
1240 LOCATE 0,3:PRINT SPACE$(12);:GOTO 880
1250 PRINT:PRINT'END OF MUSIC'
1260 C=C+1
1270 REM *** END ***
1280 PRINT'Your music.':FOR I=0 TO 200:NEXT
1290 FOR I=0 TO C-2:SOUND S(I),L(I):NEXT
1300 CLS:PRINT'Save to start.'
1310 PRINT'File name.';N$:PRINT'Hit any key.'
1320 IF INKEY$='' THEN 1320
1330 FOR I=0 TO E:PRINT #1,M$(I):NEXT I
1340 CLOSE:BEEP
1350 PRINT'End of save. Hit any key.'
1360 IF INKEY$='' THEN 1360
1370 GOTO 130
1380 REM *** EXPLAIN ***
1390 PRINT '   EXPLANATIONS.'
1400 PRINT'1 Please push 'CAPS' key!.'
1410 PRINT'2 'ZSXDCVGBHNJM'keys are music keybord.'
1420 PRINT'3 'ZSXDCVGBHNJM'keys changed 'CcDdEFfGgAaB'
     keys.'
1430 LOCATE 0,7:PRINT' Hit any key.';
1440 IF INKEY$='' THEN 1440
1450 PRINT:PRINT'4 Push 'E' key end to one brock.'
1460 PRINT'5 Push 'Q' key end of input.'
1470 PRINT'6 Push 'ESC' key return one music
     brock.'
1480 PRINT'7 Space is a rest.'
1490 LOCATE 0,7:PRINT' Hit any key.';
1500 IF INKEY$='' THEN 1500
1510 PRINT:PRINT'8 L=LENGTH(1-9),O=OCTAVE(1-4)'
1520 PRINT'9  input about 20 keys,push 'E' key goto
     next step.!'
1530 PRINT'10 End to part 49.'
1540 PRINT'11 'L' and 'O' keys could change many
     times,if you not push 'ESC' key.'
1550 LOCATE 0,7:PRINT' Hit any key.';
1560 IF INKEY$='' THEN 1560
1570 RETURN 860
```

## Random Display Printing Program

Data that is placed in an array can be easily used for calculation or
for display.  If data is properly combined with the RND function
the RESULTS are very interesting.  It is even possible to INTE-
GRATE this type of process with the Character Definition program
introduced previously.

Please use any alphabetical or numerical characters when you run the
program.

```text
 10 '              DEMO
 20 CLEAR 256,62336!
 30 SCREEN 0,0:CLS
 40 DIM C%(39,7),X%(319,1):C=0
 50 PRINT 'READING DATA'  [CHAR?]
 60 FOR X=0 TO 39
 70 FOR Y=0 TO 7
 80 X%(Y*40+X,0)=X:X%(Y*40+X,1)=Y
 90 READ C%(X,Y)
100 NEXT Y,X
110 '              MAKE DATA
120 SCREEN 0,0:CLS:PRINT
130 PRINT 'DATA SCRAMBLING'
140 FOR I=0 TO 200
150 R=RND(1)*319
160 R1=RND(1)*319
170 N=X%(R,0):X%(R,0)=X%(R1,0):X%(R1,0)=N
180 N=X%(R,1):X%(R,1)=X%(R1,1):X%(R1,1)=N
190 NEXT
200 '              PRINT
210 BEEP:CLS:PRINT CHR$(27)+'V'
220 PRINT 'HIT ANY KEY';:A$=INPUT$(1)
230 PRINT A$:PRINT
240 PRINT 'HIT ANOTHER KEY';:B$=INPUT$(1)
250 PRINT B$:CLS
260 FOR N=0 TO 319
270 X=X%(N,0):Y=X%(N,1)
280 SOUND X*200+200,3
290 LOCATE X,Y
300 IF C%(X,Y)=1 THEN PRINT A$; ELSE PRINT B$;
310 NEXT
320 BEEP:LOCATE 0,0:PRINT A$; ELSE PRINT B$;
330 FOR I=0 TO 500:NEXT
340 LOCATE 0,0:GOTO 130
350 DATA 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,1,
    0,0,0,1,0,0,0,1,0,0,0,1,0,0
360 DATA 0,1,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,0,
    0,1,0,0,0,0,0,0,0,0,0,0,0,0
370 DATA 0,0,0,1,1,1,0,0,0,0,1,0,0,0,1,0,0,1,
    0,0,0,0,0,1,0,1,0,0,0,0,0,1
380 DATA 0,1,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,
    0,0,0,0,0,0,0,0,0,0,1,0,0,0
390 DATA 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
    1,1,0,1,1,0,0,1,0,0,1,0,0,1
400 DATA 0,1,0,0,1,0,0,1,0,1,0,0,1,0,0,1,0,0,
    1,1,0,1,1,0,0,0,0,0,0,0,0,0
410 DATA 0,0,1,0,0,0,1,1,0,1,0,0,0,1,0,1,0,1,
    0,0,1,0,0,1,0,1,0,0,1,0,0,1
420 DATA 0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
    1,1,1,1,1,0,0,1,0,0,0,0,0,1
430 DATA 0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,
    1,1,1,1,1,0,0,0,0,0,0,0,0,0
440 DATA 0,0,1,0,0,0,0,1,0,1,1,1,1,1,1,1,0,0,
    0,0,0,0,0,1,0,0,0,0,0,0,0,0
```

<!-- OCR: line 50 — `[CHAR?]` placeholder = unidentified graphics/special character printed after the closing string quote on `PRINT 'READING DATA'`; resembles a double-quote or graphics symbol; source page 257 (target: image) -->
## Game Program

The missile base is moved by using the left and right Cursor
Movement keys, while pressing the Space bar shoots a missile.  As
presently set, the game will end after one minute but play can easily
be extended by simply modifying the TIME$ function in line 130.

```text
 10 '              GAME
 20 DEFINT A-Z
 30 SCREEN 0,0:CLS
 40 TIME$='00:00:00'
 50 SC=0
 60 '              START
 70 X=RND(1)*35+1
 80 LOCATE X,0:PRINT ' >O< ';
 90 I$=INKEY$
100 IF I$=CHR$(28) THEN  M=M+1
110 IF I$=CHR$(29) THEN M=M-1
120 IF I$=' ' THEN GOSUB 230
130 IF TIME$>'00:01:00' THEN 460
140 IF M<0 THEN M=37:LOCATE 0,6:PRINT '  ';
150 IF M>38 THEN M=1:LOCATE 38,6:PRINT '  ';
160 LOCATE M,6:PRINT ' M ';
170 LOCATE 2,7:PRINT TIME$;
180 LOCATE 18,7:PRINT SC;'POINTS';
190 P=INT(RND(1)*3)-1:X=X+P
200 IF X<1 THEN X=1
210 IF X>35 THEN X=35
220 GOTO 80
230 '              MISSILE SUB
240 FOR Y=6 TO 0 STEP -1
250 LOCATE M+1,Y:PRINT '!';
260 SOUND Y*1000+1000,1
270 LOCATE M+1,Y:PRINT ' ';
280 NEXT
290 IF M=X OR M=X+2 THEN SC=SC+1:BEEP:GOSUB
    330:RETURN 70
300 IF M=X+1 THEN GOSUB 390
310 RETURN
320 '              MISS
330 FOR I=0 TO 10
340 LOCATE X,0:PRINT 'OOPS!'
350 FOR J=0 TO 20:NEXT:LOCATE X,0:PRINT '  ';
360 SOUND 16000,1:NEXT
370 RETURN
380 '              SOLID HIT
390 SC=SC+5:SOUND 440,10
400 FOR I=0 TO 10
410 LOCATE X-1,0:PRINT 'HOORAY!'
420 SOUND 1760,1
430 NEXT I
440 LOCATE X-1,0:PRINT '        '
450 RETURN
460 LOCATE 10,4:PRINT 'END OF GAME':END
```

## Score Ranking Program

This program uses the sequential file management function which
N82-BASIC contains, in order to manipulate results, scores, ranks,
etc.  It can be used in a variety of applications if the kinds of items
and number of items are appropriately adjusted to specific require-
ments.

```text
 10 SCREEN 0,0:CLS
 20 PRINT '*** RANKING SCORES ***'
 30 PRINT
 40 PRINT'PLEASE INPUT SCORE TITLE '
 50 PRINT,':';
 60 LINE INPUT TI$
 70 PRINT
 80 INPUT 'NUMBER OF ITEM    ';NC
 90 INPUT 'NUMBER OF PERSONS';NR
100 DIM D(NC,NR),IT$(NC),NA$(NR),RSUM(NR),RMEAN(NR),
    SUM(NC),SSM(NC),MEAN(NC),SD(NC)
110 CLS
120 PRINT 'NAME OF ITEMS:'
130 FOR I=1 TO NC
140    LOCATE 0,2:PRINT SPACE$(40)
150    LOCATE 0,2:PRINT 'NAME OF ITEM';I;
160    INPUT ITM$(I)
170 NEXT
180 CLS
190 PRINT 'INPUT THE DATA'
200 FOR J=1 TO NR
210    LOCATE 0,2:PRINT SPACE$(40):BEEP
220    LOCATE 0,2:PRINT 'NO.';J;'NAME';
230    INPUT NA$(J)
240    FOR I=1 TO NC
250       LOCATE 0,4:PRINT SPACE$(40)
260       LOCATE 0,4:PRINT ITM$(I);' POINTS';
270       INPUT DA
280       D(I,J)=DA:RSUM(J)=RSUM(J)+DA
290       SUM(I)=SUM(I)+DA
300       SSM(I)=SSM(I)+DA^2
310    NEXT I
320    LOCATE 0,4:PRINT SPACE$(40)
330    RMEAN(J)=RSUM(J)/NC
340 NEXT J
350 FOR I=1 TO NC
360    MEAN(I)=SUM(I)/NR
370    SD(I)=SSM(I)/NR-MEAN(I)^2
380 NEXT I
390 '              OUTPUT
400 PRINT'PLEASE PRESS THE SPACE BAR TO FINISH.'
410 OPEN 'SCRN:' FOR OUTPUT AS #1
420 FOR I=0 TO 1000:NEXT:BEEP:CLS
430 TT=200:GOSUB 600
440 CLOSE#1:PRINT
450 PRINT 'DO YOU WANT TO CREATE A FILE  (Y/N)';
460 Y$=INPUT$(1):PRINT Y$:IF Y$<>'Y' AND Y$<>'y'
    THEN 540
470 ON ERROR GOTO 540
480 INPUT 'NAME OF FILE';A$
490 OPEN A$ FOR OUTPUT AS #1
500 ON ERROR GOTO 0
510 TT=0:GOSUB 600
520 CLOSE#1
530 PRINT
540 PRINT''DO YOU TO PRINT IT (Y/N)';
550 Y$=INPUT$(1):PRINT Y$:IF Y$<>'Y' AND Y$<>'y'
    THEN END
560 OPEN 'LPT:' FOR OUTPUT AS #1
570 TT=0:GOSUB 600
580 CLOSE#1:END
590 RESUME 480
600 '              OUTPUT SUBROUTINE
610 PRINT#1,SPACE$(12);LEFT$(TI$,30)
620 PRINT#1,
630 PRINT#1,SPACE$(9);
640 FOR I=1 TO NC
650    PRINT#1,LEFT$(ITM$(I)+SPACE$(12),12);
660 NEXT I
670 PRINT#1,'TOTAL   MEAN'
680 FOR J=1 TO NR
690    PRINT#1,LEFT$(NA$(J)+SPACE$(10),10);
700    FOR I=1 TO NC
710       PRINT#1, USING'######      ';D(I,J);
720    NEXT I
730    PRINT#1, USING'#### ####.#';RSUM(J);RMEAN(J)
740    IF TT<>0 THEN IF INKEY$=' ' THEN A$=INPUT$(1)
750    FOR T=0 TO TI:NEXT
760 NEXT J
770 PRINT#1,
780 PRINT#1,'TOTAL'
790 PRINT#1,'POINTS    ';
800 FOR I=1 TO NC
810    PRINT#1, USING'#######      ';SUM(I);:NEXT
820 PRINT#1,
830 PRINT#1,'MEAN      ';
840 FOR I=1 TO NC
850    PRINT#1, USING'######      ';MEAN(I);;
     NEXT
860 PRINT#1,
870 PRINT#1,'DEVIATION ';
880 FOR I=1 TO NC
890    PRINT#1, USING'#######.#   ';SQR(SD(I));
     :NEXT
900 PRINT#1,
910 RETURN
```

<!-- OCR: line 540 — `PRINT''` has double apostrophe as printed; may be `PRINT'` (single) with typographic artifact, or intentional empty-string PRINT followed by literal; source page 262 (target: image) -->
<!-- OCR: line 750 — variable `TI` as printed; differs from `TT` set at line 430; may be intentional (loop on uninitialized/zero `TI`), or `TT` misread; source page 262 (target: image) -->
<!-- OCR: line 440 (Game Program, p-260) — `PRINT '        '` string content is spaces; trailing period in scan appears typographic (sentence end), not part of string -->

Sample output:

```
                    STUDENT ACHIEVEMENT BY SUBJECT

             ENGLISH   MATHEMATICS HISTORY   TOTAL   MEAN
JOHN            71          78        73      222    74.0
JAMES           53          78        80      211    70.3
MARY            83          62        48      193    64.3
ANN             78          91        45      214    71.3
BOB             73          46        43      162    54.0
HELEN           43          75        72      190    63.3
DORIS           80          71        72      223    74.3
ALEX            78          64        69      211    70.3
LOIS            68          82        70      220    73.3
ADAM            60          58        93      211    70.3

TOTAL
POINTS         687         705       665
MEAN            69          71        67
DEVIATION      12.3        12.5      15.4
```
