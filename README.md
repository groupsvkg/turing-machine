# Turing Machine Simulator
Project to create a domain-specific language to describe a Turing machine for visual rendering

# Project Plan
![image](https://user-images.githubusercontent.com/366335/120553667-aa337b00-c3f0-11eb-847d-2d51b959314b.png)

<!-- # Turing Machine
![image](https://user-images.githubusercontent.com/366335/120821299-3fe41d00-c54d-11eb-932d-52b782945785.png)

## Example
![image](https://user-images.githubusercontent.com/366335/120823687-94889780-c54f-11eb-97c9-7d18798a05f4.png)
![image](https://user-images.githubusercontent.com/366335/120823720-9e11ff80-c54f-11eb-88bc-9c0a519d69dd.png)


## Turing-decidable versus Turing-recognizable
![image](https://user-images.githubusercontent.com/366335/120821427-5d18eb80-c54d-11eb-833a-06d948b83c3e.png)

## Hierarchy of languages
![image](https://user-images.githubusercontent.com/366335/120821586-86397c00-c54d-11eb-8f1d-d5facc3f1d8a.png) -->


# Sprints
## Sprint-1
- Created flutter project on Github. :heavy_check_mark:
- Implemented user interface. :heavy_check_mark:
- Implementes business logic component(BLoC) for HomePage. :heavy_check_mark:
- Test UI update on user text input. :heavy_check_mark:
- Deployed web build to Github. :heavy_check_mark:

## Sprint-2
- Designed language grammar. :heavy_check_mark:
- Implemented language grammar and parser. :heavy_check_mark:
- Written unit test cases for language grammar and parser. :heavy_check_mark:
- Integrated parser component in HomePage. :heavy_check_mark:

# Grammar
 | Operator | Description  |
 | -------- | ------------ |
 | *        | zero or more |
 | +        | one or more  |
 | ?        | optional     |
 
```bnf
<turing-machine> ::= <tm-token> <tm-name> <tm-attribute_list>? <left-curly-brace> <statements> <right-curly-brace>

<!-- Tm -->
<tm-token> ::= <ignore-character> "tm" <ignore-character>
<tm-name> = <ignore-character> <word>+ <ignore-character>
<tm-attribute_list> ::= <attributes>*

<!-- Attributes -->
<attributes> ::= <left-square-brace> <pair> ( <comma> <pair> )* <right-square-brace>
<pair> ::= <key> ( <assignment> <value> )*
<key> ::= <letter>+ ( <whitespace>+ <letter>+ )*
<value> ::= <word>+

<!-- Statements -->
<statements> ::= <tape>? <states>? <transitions>?

<!-- Tape -->
<tape> ::= (<tape-token> <tape-attributes> <colon>)? <tape-data> <semicolon>
<tape-token> ::= <ignore-character> "tape" <ignore-character>
<tape-attributes> ::= <attributes>?
<tape-data> ::= <tape-start> <word>* <head> <word>* <tape-end>
<tape-start> ::= "--"
<head> ::= "|"
<tape-end> ::= "--"

<!-- States -->
<states> ::= <state>*
<state> ::= <state-token> <state-attributes> <colon> <state-name> <semicolon>
<state-token> ::= <ignore-character> "state" <ignore-character>
<state-attributes> ::= <attributes>?
<state-name> ::= <word>+

<!-- Transitions -->
<transitions> ::= <transition>*
<transition> ::= <source> (<transition-operation> | <hyphen> <transition-attributes> <arrow>) <destination> (<colon> <label>)
<source> ::= <word>+
transition-operation ::= "->"
<transition-attributes> ::= <attributes>?
<destination> ::= <word>+
<label> ::= <label-first> <comma> <label-middle> <comma> <label-last>
<label-first> ::= <word>
<label-middle> ::= <word>
<label-last> ::= <head-left> | <head-right>

<head-left> ::= <ignore-character> "L" <ignore-character>
<head-right> ::= <ignore-character> "R" <ignore-character>

<word> ::= <letter> | <digit>
<letter> ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | 
             "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | 
             "U" | "V" | "W" | "X" | "Y" | "Z" | "a" | "b" | "c" | "d" | 
             "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | 
             "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | 
             "y" | "z"
 <digit> ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
 <ignore-character> ::= <tab> | <newline> | <whitespace>
 <tab> ::= "\t"
 <newline> ::= <unix-newline> | <windows-newline>
 <whitespace> ::= " "
 <unix-newline> ::= "\n"
 <windows-newline> ::= "\r\n"
 <comma> ::= <ignore-character> "," <ignore-character>
 <colon> ::= <ignore-character> ":" <ignore-character>
 <semicolon> ::= <ignore-character> ";" <ignore-character>
 <hyphen> ::= "-"
 <assignment> ::= <ignore-character> "=" <ignore-character>
 <arrow> ::= "->"
 <left-curly-brace> ::= <ignore-character> "{" <ignore-character>
 <right-curly-brace> ::= <ignore-character> "}" <ignore-character>
 <left-square-brace> ::= <ignore-character> "[" <ignore-character>
 <right-square-brace> ::= <ignore-character> "]" <ignore-character>
```
## Example
```
tm MyTm [ key = val1, nextKey = val2, testKey] {

  tape [ key = val1, nextKey = val2 ] : --|abba--;

  state [ key = val1, nextKey = val2 ] : s1;
  state [ key = val1, nextKey = val2 ] : s2;

  s1 -[ key = val1, nextKey = val2 ]-> s2 : a, b, L;
  s2 -[ key = val1, nextKey = val2 ]-> s3 : c,d,R;
  s1 -[ key = val1, nextKey = val2 ]-> s3 : c    ,         d,   R;
}

```

# User Interface

## Sprint-1
![image](https://user-images.githubusercontent.com/366335/120660513-4dcb6c80-c47f-11eb-8bd7-2cec86b8da30.png)
![image](https://user-images.githubusercontent.com/366335/120552021-9dae2300-c3ee-11eb-820b-73199dbebaba.png)

## Sprint-2
![image](https://user-images.githubusercontent.com/366335/122647734-93de2c80-d11d-11eb-9954-4ad5aca5cf88.png)
![image](https://user-images.githubusercontent.com/366335/122647650-2c27e180-d11d-11eb-9808-4639d6e2ea56.png)

# Code Generator
- Flutter
  - flutter packages pub run build_runner watch 
  - flutter packages pub run build_runner build

