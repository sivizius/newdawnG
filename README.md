newdawn
=======
Newdawn is an attempt to create a new kind of compiler.
In this new approach, I have split the project in seperate compilers;
these that compiles from source to [fruitbot-code](bytecode) in an [#uf4](internal format),
these that converts bytecode to the final format.
and some that just do useful stuff with the internal format.
These compilers are independent from each other and have only the internal format and maybe the bytecode in common.
Furthermore all parts are modular, so different input and output formats can be processed respectively processed.
How the source will be processed depends entirely on the source-code itself.
I planned to provide implementations in other languages.

usage and key files
-------------------
You need [flatassembler g](http://flatassembler.net/download.php "click here to download flatassembler G") for building this project and
also the text editor of your choice to view and edit the files locally.

| file name       | description                                                       |
| ---             | ---                                                               |
| *build/*        | working directory of the compilers (logs, etc.).                  |
| *compilers/*    | directory for different compilers used by *make.sh*.              |
| *final/*        | final output of the compilers (bin, deasm, etc.).                 |
| *include/*      | some source code. actually the core of this repository.           |
| *yasic/*        | directory for yasic source code.                                  |
| *README.md*     | this file.                                                        |
| *LICENCE.md*    | this is the licence that applies to this repository.              |
| *conf.sh*       | perhaps useful sometime in the future.                            |
| *edit.sh*       | edit repository with system editor (nano, vim, etc.).             |
| *make.sh*       | build repository.                                                 |
| *exec.sh*       | run repository, this may launch teh nukes.                        |

coding conventions
------------------
I tried and try to follow the following conventions:
* I indented the code with two spaces
* The following criteria must apply on names:
    * Internal variables and macros of modules, which are not present in the actual source, starts with the name of the file or module,
      then »@@«, and then the actual name of the symbol: *format@@addFormat*.
    * Names do not contain abbreviation, except common and unambiguous ones like
      *ctr* (a counter), *num* (number of), *ptr* (pointer), *len* (length), *args* (arguments), *lst* (list), *func* (function), *dns* (domain name system), etc.
    * Lower case camel casing of variables (*numOfPointers*)
    * Names are descriptive, however *i*/*j*/*k* for iteratives in loops are allowed.
    * I utilized the British English spelling: *colour*, *organisation*, *centre*, *licence*, etc.; this will probably confuse a lot of people, but it is intended.
* the code should have a tabular shape. E.g. »=« in `a = b ;comment` should have an offset of 41, the »b« an offset of 81, »;the comment« an offset of 121, etc.;
  Sometimes multiple of 10 plus 1 (11, 21, 31, ..., 10·n+1) are more rational.
  
make.sh
-------
I provide a commandline tool to build which you can call like this:
```
./make.sh <mode> <filename>
```
The following *modes* are implemented or planned:
- [x] *yasic2fbc0* to compile [yasic](#yasic) source code to [fruitbot code version 0](#fruitbot-code) in an internal format ([uf4](#uf4)).
- [x] *deasm* to disassemble `<filename>`.
- [ ] *fbc2amd64* to compile fb-code to amd64-code. This is still an internal format ([uf4](#uf4)).
- [ ] *uf42elf* creates an binary file in the executable and linking format.

edit.sh
-------
I provide a commandline tool to edit which you can simply call with:
```
./edit.sh
```
I hope, I will provide a better version someday.

uf4
---
*uf4* is an acronym for »universal fluffy & fancy file format« and could be spelled like »ufo«.
The format could be descriped as:

    magic_number:
      ascii(»#!uf4:newdawn\r\n\0«)
    yapter-table:
      yapter*
      [...]
    ycontent:
      [...]

The file format is actually a container format for so-called yapters, named after chapters of a book.
Every of these yapters has an 16-byte-entry in the yapter-table.
All bytes, except the first two, can be used freely.
The first word defines the type of the entry and the yapter-table always has a final yapter.
I recomment the value `null` as the `type` of the final yapter.
After this final yapter could be some bytes, that could be used and refered freely by the yapters.
I recomment to refer relatively to the label `ycontent`.
There is no list of types yet, so except for type null every other value between 0 and 2^16 could be used.

I hope, I will provide a list soon.

The following pseudo-code describes how to parse a uf4 file:
```
function parseFile( fileName )
  file theFile = openFile( fileName )
  int  size    = sizeOfFile( theFile )
  int  pointer
  word type
  if ( size < 16 )
    fail( »file too small!« )
  end if
  if ( readStringFromFile( theFile, offset = 0, lenght = 16) != »#!uf4:newdawn\r\n\0« )
    fail( »invalid magic number!« )
  end if
  pointer = 0
  while ( true )
    if (( size - pointer ) < 16 )
      fail( »reached end of file before end of yapter-table!« )
    end if
    pointer = pointer + 16
    type = readWordFromFile( theFile, offset = pointer )
    if ( buildYapter( type, pointer ) == null )
      break
    end if
  end while
  pointer = 0
  while ( true )
    pointer = pointer + 16
    type = readWordFromFile( theFile, offset = pointer )
    if ( loadYapter( type, pointer ) == null )
      break
    end if
  end while
end function
```

fruitbot-code
-------------
Fruitbot was an IRC-bot I wrote in python about 5-8 years ago.
I am not really sure when I wrote the bot.
I rewrote it multiple times in purebasic and I created an bytecode, so the bot could remotly execute scripts.
The bot only had a small instruction-set and I do not had to worry much about malicious scripts.

Today *fruitbot-code* is the name of various bytecodes by me, so fruitbot code version 0 is actually version over 9000.
But fbc0 shall be the first documented version and I will provide further Information in the *include/fruitbot*-directory.

yasic
-----
This repository provides raw assembly code for the bytecode as well as a high level language called *yasic*.
Yasic is an acronym for »Yet Another Symbolic Instruction Code«.
Do not get confused with the repository *yasic*, it is another language.
I am looking forward to solve this contradiction soon.

Some examples are provided in the *yasic*-directory.
I will provide further documentation about *yasic* in the *include/yasic*-directory.