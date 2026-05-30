# Chapter 3: Expressions and Operations

> Vision-OCR'd from the image-only scan of NEC8201A-BasicReference.pdf
> (source pages 31–57). Transcribed faithfully; **numeric/tabular values
> are pending Tier B verification** — do not treat as authoritative yet.


## Variables

Variables are distinct quantities for different types of elements within your N82-BASIC programs that are represented by unique names. The two types of variables used are numeric and string variables.

An example of a numeric variable is when you want to use the element CHARACTERS within a program, and 40 characters are needed. You can then assign the name "CHARACTERS" to represent the quantity of 40 items of that variable.

When you assign variable names, try to use names that are meaningful to you, and related to the element that they represent. The N82-BASIC language utilizes only the first two characters of the variable name to distinguish between variables. A variable type specified character placed at the end of the variable name, indicates whether a variable is string or numeric.

Variable names may be any length up to 255 characters, however keep in mind that the longer the variable names the less RAM available for your sub-sequent use. The recommended characters to use for a variable name are letters and numbers.

The first character for the variable must be a letter. There are also certain words that are reserved for use within N82-BASIC that are not available for your use, such as all BASIC Reserved Words.


### Examples of Reserved Variables

| Variable | Description |
|----------|-------------|
| TIME$ | This variable holds the time in hours, minutes and seconds (HH:MM:SS). |
| DATE$ | This variable holds the year, month and date (YY/MM/DD). |
| ERL | This variable holds the line number where an error occurs during program execution. |
| ERR | This variable holds the error code which causes the interrupt. |

> **See Appendix A1 for a complete listing of Reserved Words.**

Before utilizing a variable within your program you should initialize it to some type of a value. As an example we will initialize CHARACTERS with the following statement:

```text
CHARACTERS=40
```

If you do not initialize your variables, then the numeric variables are automatically initialized to zero, the character variables are initialized to empty (null) string ("").


### Types of Variables

The last character of a variable name determines the type of variable. The 4 types of variables are, integers, single precision real numbers, double precision real numbers, and string variables. If the variable type is omitted, it is assigned single precision (!) by default.

Following is a table of the different types of variables:

<!-- FIGURE 3.1: Variable type hierarchy tree (Variable → Character Variable / Numeric Variable → Real Number Variable / Integer Variable → Single Precision / Double Precision → Fixed Decimal / Floating Decimal) — deferred to image/table pass, source page 33 (target: image) -->

Variable type can be designated by using declaration statements.

Examples of different types of variables:

| Name | Type |
|------|------|
| A$ | String variable |
| A! or A | Single precision real number variable (default) |
| A# | Double precision real number variable |
| A% | Integer variable |

As you can see in the above example the variable name "A" in conjuction with special characters represent 4 different types of variables.

> **Please refer to DEFINT, DEFSNG, DEFDBL and DEFSTR commands, in Chapter 4.**


### String Variables

String variables are a collection of characters with a non-numeric value. String Variables are composed of letters (both upper and lower case letters), numbers or special symbols. If double quotations are used inside the character variable, CHR$(34) should be used to enter the double quotations. The maximum length of a String Variable is 255 characters, and it should not be used in an arithmetical operation.


### Numeric Variables

Numeric variables are integers or real numbers, represented by a numeric variable name.


### Integer Variable

In N82-BASIC, integers are numbers that have the following characteristics:

- Numbers with no decimal point.
- Numbers in the range from −32768 to +32767.
- Numbers followed by % (percentage sign).

```text
EXAMPLES:    NUMBER% = 1234
             NUMBER% = 123%
```


### Real Number Variables

Real numbers are subdivided into single precision format and double precision format. Both single and double precision can have the numbers expressed in either fixed decimal form or floating decimal form.

A fixed decimal form number may have a decimal point (a decimal point is assumed at the end of the number if it is not specified).

A floating decimal form number represents its value in scientific notation with an exponent.


### Single Precision Format

The floating decimal, single precision number has two parts, the magnitude and the exponent.

The magnitude is stored in 7 significant (high order) digits internally. When displaying the numeric value, the seventh digit is rounded off and trailing zeroes are deleted to show 6 digits or less on the screen.

The exponent portion is attached to the magnitude. It consists of the letter E, a sign, and a two digit number. The valid exponent number is from 01 to 38.

Single precision numbers have the following characteristics:

- Real numbers of less than 7 digits.
- Real numbers followed by an exclamation mark (!). The exclamation mark is optional.
- Real numbers range from −1.70141E+38 to 1.70141E+38.
- Exponent is indicated by E.

```text
EXAMPLES:    Fixed decimal:     NUMBER = 1.23
                                NUMBER! = 3.14!

             Floating decimal:  NUMBER = −7.06E+06
                                NUMBER! = 1.23E+10!
```


### Double Precision Format

The double precision floating decimal number consists of magnitude and exponent as in the single precision format.

The magnitude is stored with a precision of 17 significant digits and can be displayed in up to 16 digits, the 17th digit is rounded off. The exponent is indicated by the letter D, followed by a sign and a two digit number. The valid exponent range is from 01 to 38.

Double precision numbers have the following characteristics:

- Numbers containing from 8 to 16 digits.
- Exponent indicated by the letter D.
- Numbers followed by a pound sign (#).

```text
EXAMPLES:    Fixed decimal:     NUMBER# = 123456789012345
                                NUMBER# = 0657036.1543976

             Floating decimal:  NUMBER# = −1.09432D+06
                                NUMBER# = 0.3141592653D+01
```


## Array

A group of logically related variables designated by the same variable name is called an Array. The items of an array are called elements. Each element is assigned a unique number called the subscript, to distinguish each of them.

Array values are indexed by subscript value. More than one subscript may be designated, thus specifying the dimension of the array. A single dimension array has one subscript index:

```text
Subscripts:  0   1   2   3   4   5

Values:     11  91  36  12  19  50
```

When the elements of an array are designated with two subscripts then the array has two dimensions. This is explained with the following example. Let the array "ITEMS%" be two-dimensional to a size of 4 rows by 8 columns. To reserve memory space for the array, the statement DIM ITEMS%(3,7) would be used. Following is the layout of the location of each element of an array ITEMS% :

<!-- TODO(tier-b): verify table values against source page 37 -->

**COLUMNS**

|      |   | 0  | 1  | 2  | 3  | 4  | 5   | 6   | 7  |
|------|---|----|----|----|----|----|----|-----|----|
| **ROWS** | 0 | 8  | 12 | 99 | 0  | 70 | 88  | 123 | 9  |
|      | 1 | 23 | 88 | 56 | 91 | 87 | 72  | 192 | 23 |
|      | 2 | 43 | 71 | 92 | 3  | 9  | 62  | 11  | 10 |
|      | 3 | 51 | 82 | 95 | 64 | 93 | 57  | 26  | 4  |

As shown in the table, in order to access the fourth element of the second row, you will have use the name ITEMS%(1,3), this element contains the value 91.

The subscripts are always enclosed in parentheses and they have a numeric integer value greater than or equal to zero. Numeric variables that follow the above rules can also be used when designating subscripts.

N82-BASIC requires information such as the maximum number of elements within each dimension of an array, so storage space can be allocated for the entire array. This is possible through the use of a DIM statement.

```text
Sample format: DIM ITEMS%(I,T)
```

In this example "I" represents the ROWS and "T" represents the COLUMNS. Notice that although there are 4 rows and 8 columns for each row, DIM(3, 7) was specified. This is because the DIM statement starts reserve space beginning with element 0. We could have started with row1 and column 1, but memory space would have been wasted.

The layout for the array with dimensions (3,7) is addressed by subscripts according to the following table:

<!-- TODO(tier-b): verify table values against source page 38 -->

**COLUMNS**

|      |   | 0     | 1     | 2     | 3     | 4     | 5     | 6     | 7     |
|------|---|-------|-------|-------|-------|-------|-------|-------|-------|
| **ROWS** | 0 | (0,0) | (0,1) | (0,2) | (0,3) | (0,4) | (0,5) | (0,6) | (0,7) |
|      | 1 | (1,0) | (1,1) | (1,2) | (1,3) | (1,4) | (1,5) | (1,6) | (1,7) |
|      | 2 | (2,0) | (2,1) | (2,2) | (2,3) | (2,4) | (2,5) | (2,6) | (2,7) |
|      | 3 | (3,0) | (3,1) | (3,2) | (3,3) | (3,4) | (3,5) | (3,6) | (3,7) |

An array can be expanded to include over 100 dimensions, (subelements of each element). The number of elements of an array is limited by the amount of memory space available.

The array names, like the four different variable names, could represent the same types of information. The same rules as in the variables govern the different types of arrays. In addition to those rules, all the elements of an array can be only of one type. Also, if the array is a character array, no element should be longer than 255 characters.


## Constants

Constants are values that you assign to variable names for use throughout your program or while in the Direct Mode. Constants are elements that do not and cannot change during the execution of a program.

Constants could represent the same types of information as variables. The same rules regarding designation of variables apply to constants. The following table illustrates types of constants used in BASIC:

<!-- FIGURE 3.2: Constant type hierarchy tree (Constant → Character Constant / Numeric Constant → Real Number / Integer Number → Single Precision / Double Precision → Fixed Decimal / Floating Decimal) — deferred to image/table pass, source page 39 (target: image) -->


### Numeric Constants

A numeric constant has between 1 and 16 digits, either positive or negative. Numeric constants cannot contain any spaces. When numeric constants of more than 16 characters are used, the least significant digits are rounded off by N82-BASIC, and the number will be displayed in floating format. The following numeric constants are valid:

```text
25.              234567

−1234.01         32760

12345678901.23   .1234567890123

3.14159

.0000002
```

It is possible to enter numeric constants longer than 16 characters using the following format:

```text
(+ or −)x.xxxxxxxxxxxxxxxxD(+ or −) nn
```

where:

- **(+ or −)** — is the sign of the number. The minus sign is required with negative numbers.
- **x** — is the number with up to 16 significant digits.
- **D** — represents the Exponent (the power of 10)
- **nn** — is the exponential value in the range of −38 to +37.

The Exponent in this format can be 0 but never blank. The following are valid numeric constants in D format:

```text
1.2568D10              8.25468132525 7D−30

−1.234567890123D−12    2358.25624798D2

1235D−30               1.2D20
```


### Integer Constants

An integer constant is a special type of numeric constant that is a whole number written without a decimal point and in the range of −32768 to +32767. For example, the following numbers are all integer constants:

```text
1          0         −1234

25         −15        100

32767      −32767     10000
```


### Character Constants

A character constant is one or more alphanumeric and/or special characters, enclosed in double quotation marks ("). Include both the starting and ending delimiters (quotation marks) when typing a character constant in a program. Each character can be a letter, a number, a space, or any ASCII character except a control character and quotation marks. In such cases use CHR$ function and concatenate (connect) them into the string with the + sign.

The following is an example of acceptable character constants:

**Character Constant**

```text
"Another "+CHR$(34)+"Constant"+CHR$(34)
```

**Internal Representation**

```text
Another "Constant"
```


## Type Conversion

Numeric variables can be converted from one type to another in N82-BASIC. Character constants can be converted into numeric types and vice versa. The following are rules for type conversions:

1. When assigning variables, the type of numeric value being transferred depends upon the type of receiving variable.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 43 -->

   | Statement | Variable | Value |
   |-----------|----------|-------|
   | ABC%=1.234 | ABC% | 1 |
   | ABC=1.234 | ABC | 1.234 |

2. Numeric types are arranged in the order of precedence:

   - Integer
   - Single Precision
   - Double Precision

   Integer, as shown abive <!-- OCR: unclear ("abive" vs "above") — likely "above" -->, is the lowest degree of precision. Arithmetic operations are performed in numeric values with the same degree of precision. If different types of numeric values are involved in an operation, the lower ordered values are converted into the higher ordered format first, before the operation is performed.

   EXAMPLE:

   ```text
   10#/3 is first converted to 10#/3#
   ```

3. All numeric values used in logical operations are converted into integers. Integers are returned as the result of the operation.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 44 -->

   | Statement | Variable | Content |
   |-----------|----------|---------|
   | A#=12.34 | A# | 12.34000015258789 |
   | B=NOT A# | B | −13 |

4. Digits after a decimal point are omitted when real numbers are converted to integers. Numbers converted outside the valid range for integers (−32768 to +32767) would cause an overflow error.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 44 -->

   | Statement | Variable | Content |
   |-----------|----------|---------|
   | A%=34.4 | A% | 34 |
   | B%=34.5 | B% | 34 |

5. Values of Double Precision real numbers are rounded to 7 signigicant <!-- OCR: unclear ("signigicant" vs "significant") — scan reads "signigicant" --> digits when converting to Single Precision numbers. An overflow error could occur if rounded values exceed the valid Single Precision range of −1.7014E+38 to +1.70141E+38.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 44 -->

   | Statement | Variable | Content |
   |-----------|----------|---------|
   | A#=1.23456789# | A# | 1.23456789 |
   | B!=A# | B! | 1.234567 |

6. Numbers within strings can be converted to numeric variables by using the VAL function.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 45 -->

   | Statement | Variable | Content |
   |-----------|----------|---------|
   | A#=12.34 | A# | 12.34000015258789 error factor |
   | A!=12.34 | A! | 12.34 |
   | A#=VAL(STR$(A!)) | A# | 12.34  no error factor |

7. Numeric variables can be converted into strings by using the STR$ function.

   EXAMPLE:

   <!-- TODO(tier-b): verify table values against source page 45 -->

   | Statement | Variable | Content |
   |-----------|----------|---------|
   | A!=1.234 | A! | 1.234 |
   | A$=STR$(A!) | A$ | " 1.234" |


## Logical Expressions

A Logical Expression is the specification of a series of operations to be performed on variables, constants, and functions, resulting in one value. The types of logical expressions used in N82-BASIC are:

- Arithmetic expressions
- Relational expressions
- Logical expressions
- String expressions


### Arithmetic Expressions:

<!-- TODO(tier-b): verify table values against source page 46 -->

| Priority | Operator | Function |
|----------|----------|----------|
| 1 | ^ | Exponentiation |
| 2 | − | Negative sign |
| 3 | * | Multiplication |
| 3 | / | Division |
| 4 | \ | Integer division |
| 5 | MOD | Modulo division (Remainder) |
| 6 | + | Addition |
| 6 | − | Subtraction |

An arithmetic expression is defined as:

```text
〈 arithmetic term 〉 [ 〈 arithmetic operator 〉 〈 arithmetic term 〉 ]
```

The follwing <!-- OCR: unclear ("follwing" vs "following") — scan reads "follwing" --> are examples of valid arithmetic expressions:

```text
NOT A%                           Integer result

A%+23                            Integer result

SUB.TOTAL+CURRENT*UNIT.PRICE     Single precision

ONE%*THREE                       Single precision

+1/−4                            Single precision

3.14159*RADIUS^+2                Single precision

3*4/(PI#*R^2)                    Double precision
```

Rules for arithmetic expressions:

1. When there are different operators with the same priority, calculation is performed from left to right.

2. All arithmetic expressions are calculated from left to right with the highest priority (the lower priority number) operations being calculated first, followed by the lower order ones.

3. Lower priority expressions enclosed in parentheses in an arithmetic expression are performed before the higher priority ones (outside the parentheses).

4. Priority order is in effect inside parentheses.

5. Any division with zeroes will cause an error. This is also the case if a zero is raised to a power of a negative number for example (0^−6).

6. An overflow error occurs whenever the results of an operation exceed the assigned variable type limits.

Example:

<!-- TODO(tier-b): verify table values against source page 48 -->

| Statement | Meaning | Result |
|-----------|---------|--------|
| Z*X+Y | ZX+Y | |
| X/Y+2 | X/Y+2 | |
| (X+Y)/2 | (X+Y)/2 | |
| X^2+2*X+1 | X²+2X+1 | |
| X^(Y^2) | X^(Y²) | |
| X^Y^2 | (X^Y)² | |
| X*(−X) | Y(−X) | |
| 2/0 | 2/0 | ?/0 ERROR |
| 0/−1 | 0/−1 | |
| 10\3 | INT(10/3) | 3 |
| 15 MOD 4 | 15−4(INT(15/4)) | 3 |


### Relational Expressions

A Relational Expression is defined as:

```text
〈 arithmetic term 〉 〈 relational operator 〉 〈 arithmetic term 〉
```

or

```text
〈 string term 〉 〈 relational operator 〉 〈 string term 〉
```

The following are all acceptable Relational Expressions:

<!-- OCR: the source font renders the relational operators < and > as
     slanted angle-bracket glyphs (the same shape used for metavariable
     delimiters). Transcribed as the operators they denote: > , <= , <> -->

```text
STRING$ > "HELLO"           String relation

NUM1 <= NUM2                Numeric relation

NUMBER% <> 225*(5−ONE)      Numeric relation with arithmetic sub-expression

539 = ONE                   Numeric relation
```


### Logical Expressions

A Logical Expression operates on integer values and produces an integer value. A Logical Expression is defined as:

```text
〈 arithmetic term 〉 〈 logical operator 〉 〈 arithmetic term 〉
```

A logical operator is any of the following:

| Operator | Function |
|----------|----------|
| NOT | Invert bits (ON to OFF; OFF to ON) in one term |
| AND | Tests for bit ON in both terms |
| OR | Tests for bit ON in either term |
| XOR | Tests for bit ON in either but not both terms |
| IMP | Tests both terms, it returns bit OFF if the first term bit is ON and the second term bit is OFF |
| EQV | Tests for equality, it returns bit ON only if both bits are ON or both OFF |

> **The binary representation of ON is −1, and 0 is the binary representation of OFF.**

Logical Expressions are comparisons between the corresponding "bits" of the two terms of the expression. A bit is a binary (either ON or OFF) piece of information. An integer value is composed of sixteen bits. A decimal integer is expressed in bits by converting the number to base 2 notation and adding any leading binary zeros, if necessary. The following is a list of some equivalent values in decimal and binary:

<!-- TODO(tier-b): verify table values against source page 51 -->

| Decimal | Binary Bits |
|---------|-------------|
| 0 | 0000000000000000 |
| 1 | 0000000000000001 |
| 5 | 0000000000000101 |
| 23 | 0000000000010111 |
| 100 | 0000000001100100 |
| −1 | 1111111111111111 |

Note that a decimal zero has all zero bits and a decimal minus one has all one bits. This relationship between decimal and binary is used in the result of relational expressions. Logical expressions are valid wherever arithmetic expressions are allowed, however, both terms must be integers. The following tables are called truth tables. They show graphically the results of the logical operations for every possible combination of two bits:

<!-- TODO(tier-b): verify truth table values against source pages 51–52 -->

**NOT**

| A% | NOT A% |
|----|--------|
| 0 | −1 |
| −1 | 0 |

**OR**

| A% | B% | A% OR B% |
|----|----|----------|
| 0 | 0 | 0 |
| 0 | −1 | −1 |
| −1 | 0 | −1 |
| −1 | −1 | −1 |

**AND**

| A% | B% | A% AND B% |
|----|----|----|
| 0 | 0 | 0 |
| 0 | −1 | 0 |
| −1 | 0 | 0 |
| −1 | −1 | −1 |

**XOR**

| A% | B% | A% XOR B% |
|----|----|----|
| 0 | 0 | 0 |
| 0 | −1 | −1 |
| −1 | 0 | −1 |
| −1 | −1 | 0 |

**IMP**

| A% | B% | A% IMP B% |
|----|----|----|
| 0 | 0 | −1 |
| 0 | −1 | −1 |
| −1 | 0 | 0 |
| −1 | −1 | −1 |

**EQV**

| A% | B% | A% EQV B% |
|----|----|----|
| 0 | 0 | −1 |
| 0 | −1 | 0 |
| −1 | 0 | 0 |
| −1 | −1 | −1 |

The following are examples of logical expressions:

```text
NUM1% OR NUM2%

I% AND 23

I% AND (NUMBER XOR TOTAL) IMP TEST%

(A AND B) OR (A AND C)

STRING$ >= "A" AND STRING$ <= "Z"
```

Logical expressions are normally used to evaluate terms that are the result of relational expressions (bits all ON or all OFF). However, since the logical expression compares all sixteen bits of each of the terms there are many other uses for logical expressions. One of the more common of these other uses is binary coded information, or "bit switches".

Some examples will illustrate how the logical operators work on non-relational values:

<!-- TODO(tier-b): verify logical operator worked examples against source page 53 -->

```text
15 AND 14        0000000000001111   (15)
            AND  0000000000001110   (14)
                 0000000000001110   (14)    (TRUE)

10 OR 23         0000000000001010   (10)
            OR   0000000000010111   (23)
                 0000000000011111   (31)    (TRUE)

NOT 153     NOT  0000000000011001   (153)
                 1111111111100110   (−154)  (TRUE)

25 XOR 13        0000000000011001   (25)
            XOR  0000000000001101   (13)
                 0000000000010100   (20)    (TRUE)

234 EQV 3429     0000000011101010   (234)
            EQV  0001110100100101   (34299)
                 1111001001110000   (−3472) (TRUE)

56 IMP 720       0000000000111000   (56)
            IMP  0000001011010000   (720)
                 1111111111010111   (−41)   (TRUE)
```

As you can see, there does not appear to be a relationship between the decimal terms and the decimal result of the expression. However, using the binary representations of the integers, there is a definite, Boolean, relationship. This can be utilized to make an integer value contain sixteen binary (ON/OFF) switches. When using binary switches the logical expressions can be utilized to set or mask the number to expose the bit switch desired.


### String Expressions

Character strings can be joined together, broken down into shorter strings, and sorted into order.


### Connecting Strings:

A string can be concatenated (connected end to end) with another string by the "+" operator. The resulting string cannot be longer than 255 characters.

EXAMPLE:

<!-- TODO(tier-b): verify table values against source page 54 -->

| Statement | Variable | Content |
|-----------|----------|---------|
| A$="NEC " | A$ | NEC |
| B$=CHR$(34)+"PORTABLE " | B$ | "PORTABLE |
| C$="COMPUTER"+CHR$(34) | C$ | COMPUTER" |
| D$=A$+B$+C$ | D$ | NEC "PORTABLE COMPUTER" |


### Comparing Strings:

When sorting strings, relational operators are used for the comparison of letters and numbers. Strings are compared one character at a time, starting from the beginning until there are no more related conditions.

Two strings are equal if they have the same character in the respective position, and both strings have the same number of characters. Otherwise, they are not equal.

EXAMPLES:

<!-- TODO(tier-b): verify table values against source page 55 -->

| Relational Testing | Result |
|--------------------|--------|
| "AA" ( "AB" | TRUE |
| "BASIC"="BASIC" | TRUE |
| "PENX" ( "PEN" | FALSE |
| "cm" = "CM" | FALSE |
| "cm" ) "CM" | TRUE |
| "DESK" ( "DESKS" | TRUE |


## Mathematical Functions

Mathematical functions are designated by enclosing the numeric value or numeric variable in parentheses and placing the value or variable after the function name.

Most functions do calculations in single precision format. For integer functions all real numbers are converted into integers before function operation is performed.

EXAMPLES:

```text
A=SIN(3.14) + COS(3.14)

PRINT 2, 2*2, SQR(2)
```

> **See Chapter 4 for a complete listing of functions available with N82-BASIC.**

Mathematical formulas are a combination of numbers and variables related with arithmetic operators.

EXAMPLES:

```text
"N82"+"BASIC"

3.14159*2

10+3/5

A+B/C−D

TAN(DO)+COS(DO)

10\3/2

13 MOD 2
```


## Hierarchy of Operations

N82-BASIC operations are performed in the following order:

<!-- TODO(tier-b): verify precedence table against source page 57 -->

| Precedence | Operation |
|-----------|-----------|
| 1 | Expressions enclosed by parentheses |
| 2 | Functions |
| 3 | Exponential arithmetic (^) |
| 4 | Negative sign (−) |
| 5 | Multiplication and division (*, /) |
| 6 | Integer division (\) |
| 7 | Modulo division (MOD) |
| 8 | Addition and subtraction (+, −) |
| 9 | Relational operators (=, <, >, < >, <=, >=, etc.) |
| 10 | Logical operator NOT |
| 11 | Logical operator AND |
| 12 | Logical operator OR |
| 13 | Logical operator XOR |
| 14 | Logical operator IMP |
| 15 | Logical operator EQV |
