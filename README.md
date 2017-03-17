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
| LICENCE.md      | this is the licence that applies to this repository.              |
| *edit.sh*       | edit repository with system-editor (nano, vim, etc.).             |
| *make.sh*       | build repository.                                                 |
| *exec.sh*       | run repository, this may launch teh nukes.                        |
| *conf.sh*       | perhaps useful sometime later.                                    |
| *\*.fincg*      | this files are indented to be included and have the fasmg-syntax. |
| *formats.fincg* | for the `format <name>`-`end format`-structure.                   |

conventions
-----------
I try to follow the following conventions:
* Line-indentation are 2 space-characters.
* The following criteria must apply on names:
    * Internal variables and macros of modules, which are not present in the actual source, starts with the filename, then »@@«, and then the actual name of the symbol: *format@@addFormat*.
    * Names do not contain abbreviation, except common ones like
      *ctr* (a counter), *num* (number of), *ptr* (pointer), *len* (length), *args* (arguments), *lst* (list), *func* (function), *dns* (domain name system), etc.
    * If the name should be composed of multiple words, each word, except the first, starts with a capital, but does not contain capitals: *foo*, *fooBar*, *fooBarVariable*.
    * Names are descriptive, however *i*/*j*/*k* for iteratives in loops are allowed.
    * The British English spelling should be used: *colour*, *organisation*, *centre*, *licence*, etc.; this will probably confuse a lot of people, but this is intended.
* the code should have a tabular shape. E.g. »=« in `a = b ;comment` should have an offset of 41, the »b« an offset of 81, »;the comment« an offset of 121, etc.;
  Sometimes multiple of 10 plus 1 are more rational.
  
yasic
-----
This repository provides raw assembly for this bytecode as well as a higher-level language called *yasic*.
Yasic stands for »Yet Another Symbolic Instruction Code«.
Do not get confused with the repository *yasic*, this is currently another language.
I am looking forward to solve this contradiction soon.

To use this language, just create a file like this:
```
  include 'libs/main.flibg'
  format uf4
    import 'display'
    import 'fruitbotcode_v0'
    code yasic
      ;<    ....    >
      ;< yasic-code >
      ;<    ....    >
    end code
  end format
```
I recommend to include another file in the code-segment, so you just have the actual yasic-code without the rest.
Valid code could look like this:
```
  qword a = 5
  qword x
  a = ( 1 + 2 )
  x = ( string.size ('hello'..' '..'world!') + 2)
  qword string.size ( string message )
    qword b
    b = message.size
    return b
  end qword
```