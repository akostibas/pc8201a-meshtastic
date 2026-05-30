# Chapter 6: Directory Structure

> Auto-extracted from the OCR text layer of NEC8201A-TechRef.pdf
> (source pages 76-78). Prose is approximate and **tables
> are unreliable** — pending Tier B vision re-OCR. Do not treat
> numeric/tabular values here as authoritative.

```text
                                      .

                          CHAPTER 6

6.1   DIRECTORY CONFIGURATION PER ENTRY

        The directory area is allocated in th~ middle of the
bookkeeping   area.   The top of the address is F84F in
hexadecimal. The directory configuration is shown below.
        OIRTBL: BASIC
                  FILER
                           <--------- AXF84F
                  TELCOM
        NULOIR:   (Directory for non-r-egister-ed pr-ogram)
        SCRDER:   (Directory for- SCRAP)
        EDTOIR:   (Oirector-y for- EDIT command)
        USRDIR:   <Director-y for- user--defined files)

                  (( End-of-directory)) AXFF
         r-f. The non-r-egistered progr-am means non-saved BASIC
       . program.    Refer- to ·eA file· in the pr-evious section.
         •Directory for- SCRAP• and ·oirectory for- EDIT command•
         ar-e explained in ·oo·file·.

        Each slot in the directory consists of 11 bytes, 1
byte flag, 2 bytes address and 8 bytes file name. The first 6
slots in directory ar-ea ar-e initialized by INIT routine at the
COLO START.

               Oirf slot's configuration per entry

               Dir-Y f 1 ag       (1 byte)
               Adcfiel d          (2 bytes)
               Fi 1e              (8;bytes)
               · Tota 1 11 bytes.

               Bi~gnment of Directory flag

              Bi-Master bit       (1 when directory valid)
              Bi ASCII bit        (1 when ASCII-text file)
              Bi Binary bit       (1 when Machine-language file)
              Bi File-in-ROM      ( 1 when file is in ROM)
              Bi' Hidden fi 1e    (1 when file is hidden)
              Bi
              Bf RAM file open flag
              Sj for internal use (always set to 0 normally)

              VPf address-field

              B, e - Address which TXTTAB must be set to
              oe - Beginning address of file
              c,e -        ditto

              ,XTTAB in BASIC shows the lowest byte of the file,
      the fir~ink pointer in the BASIC program file.      Please
      refer to her manual to understand what 'link pointer'  is,
      if you wco handle the BASIC programs.
              :nitialized values for first 6 slots in Directory
     are shooelow.     The first 3 files are stored in ROM and
     displaye,the menu screen.   (These 3 files are called the
     'standar~ograms".) Next 3 files are used for hidden files
     created AM area. These hidden files will    not appear on
     the Menueen. Refer to previous section, 'DO file' and 'BA
     file'.     characteristics· of these hidden     files  are
     describeiere.

                                           ·-1

               rf. First 6 slots in Directory          (Initialized data
               stored in AX6C8E)
               08      AB1011000
               DI.J    Start address
                               ,     of a=p.sic
               DB      'BASIC
               DB      0
               DB      AB101-10000
               01.J    Start address
                                ,    of TEXT
               08      'TEXT
               DB      0
               OB      ""B10110000
               01.J    Start address of TELCOM
               OB      'TELCOM'
               DB      0
               ;for non-registered program
               DB      "'B10001000
               DI.J   0
                                                   •
               DB     0
               DB      'XXXXXXX'
               ;for SCRAP file
               OB      ""B11001000
               DI.J   0
               08     0
               DB      'YYYYYYY'
               ;for EDIT command of BASIC
               DB     AB01001000
               DI.J   0
               OB     0
               DC      'ZZZZZZZ'

                                   78 -

```
