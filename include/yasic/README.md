yet another symbolic instruction code
=====================================

Yasic is an implementation of a basic-like object high-level programming language as a compiled language.
It allows object-oriented programming and is entirely implemented with macros in flatassembler G.
I do not recomment it, but it is possible to use fasmG-syntax inside yasic source code.
Keep in mind that every thing is a macro and syntax-errors are fasmG-errors and yasic could not handle them all.

some basics
-----------

Every variable must be declared, otherwise they are seen as contant values.
You can declare a variable like this:
```
  ;type name
  qword foo
  ;type name = value
  qword bar = 123
```

Allowed types are `byte` (8 bit), `word` (16 bit), `dword` (32 bit) and `qword` (64 bit), but other types can be simply implemented with the `yasic@@newType` macro:
```
  yasic@@newType newType, theSizeInBytes
```

You can also define functions with a certain type of the return-value, parameters and optional parameters:
```
  qword foobar(qword a, qword b, qword c = 0x1337)
    qword d = a
    return b
  end qword
  foobar(12,34)
```

Yasic now has conditionals like `while`, `if`, `elif` and `else`.
But they are case-sensitive. You could use `If`  for conditionals at compile-time, like:
```
  If __debug__
     display 'this text will be shown at compile-time, but not at runtime!', 10
  End If
  if a = 1
    aFunctionThatIsOnlyCalledIfAIstEqualToOneHolyShitThisNameIsHuge ()
  end if
```
