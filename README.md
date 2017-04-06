newdawn
=======
Newdawn is a new attempt to create a new kind of compiler.
In this new approach, I split the project up in a compiler from source to bytecode and a compiler from bytecode to the final format.
Both parts are independend and have only the bytecode-format in common.
Furthermore both parts are modular, so different input and output formats could be processed respective produced.
With the first operating mode, a bytecode-output and a final-output in a desired format will be created.
I also try to have a second operating mode, where this bytecode is hidden in an virtual-memory-environment and it is just one compile-step in the view of fasmg.
How the source will be processed depends entirely on the source-code it self.

usage and key files
-------------------
You need [flatassembler g](http://flatassembler.net/download.php "click here to download flatassembler G"),
to build the repository and an editor, if you want to view and edit the files locally.

| file name       | description                                                       |
| ---             | ---                                                               |
| *build/*        | working directory of the compilers. (logs, etc.)                  |
| *compilers/*    | directory for different compilers used by *make.sh*.              |
| *final/*        | final output of the compilers. (bin, deasm, etc.)                 |
| *include/*      | some source code. actually the core of this repository.           |
| *yasic/*        | directory for yasic source code.                                  |
| ---             | ---                                                               |
| *README.md*     | this file.                                                        |
| *LICENCE.md*    | this is the licence that applies to this repository.              |
| *conf.sh*       | perhaps useful sometime later.                                    |
| *edit.sh*       | edit repository with system editor (nano, vim, etc.).             |
| *make.sh*       | build repository.                                                 |
| *exec.sh*       | run repository, this may launch teh nukes.                        |

coding conventions
------------------
I try to follow the following conventions:
* Line indentation are 2 space characters.
* The following criteria must apply on names:
    * Internal variables and macros of modules, which are not present in the actual source, starts with the filename, then »@@«, and then the actual name of the symbol: *format@@addFormat*.
    * Names do not contain abbreviation, except common ones like
      *ctr* (a counter), *num* (number of), *ptr* (pointer), *len* (length), *args* (arguments), *lst* (list), *func* (function), *dns* (domain name system), etc.
    * If the name should be composed of multiple words, each word, except the first, starts with a capital, but does not contain capitals: *foo*, *fooBar*, *fooBarVariable*.
    * Names are descriptive, however *i*/*j*/*k* for iteratives in loops are allowed.
    * The British English spelling should be used: *colour*, *organisation*, *centre*, *licence*, etc.; this will probably confuse a lot of people, but this is intended.
* the code should have a tabular shape. E.g. »=« in `a = b ;comment` should have an offset of 41, the »b« an offset of 81, »;the comment« an offset of 121, etc.;
  Sometimes multiple of 10 plus 1 are more rational.
  
make.sh
-------
This is a commandline tool you can call like this:
    ./make.sh <mode> <filename>
The following *modes* are implemented or planned:
- [x] *yasic2fbc0* to compile yasic source code to fruitbot code version 0 in an internal format ([uf4](#uf4)).
- [x] *deasm* to disassemble <filename>.
- [ ] *fbc2amd64* to compile fb-code to amd64-code. This is still an internal format ([uf4](#uf4)).
- [ ] *uf42elf* creates an binary file in the executable and linking format.

uf4
---
*uf4* is an acronym for »universal fluffy & fancy file format« and could be spelled like »ufo«.
The format has the following structure
|        |»#!uf4:newdawn\r\n\0« (magic number) |
|        | |
|null -> | |

yasic
-----
This repository provides raw assembly for this bytecode as well as a higher level language called *yasic*.
Yasic stands for »Yet Another Symbolic Instruction Code«.
Do not get confused with the repository *yasic*, this is currently another language.
I am looking forward to solve this contradiction soon.

Just create a file in the *yasic* directory.
Some examples and further documentation are provided there.
