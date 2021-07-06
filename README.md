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

## Sprint-3
- Updated grammar to fix visual attributes associated with state, transition, and Turing Machine. :heavy_check_mark:
- Written testcases for the updated grammar. :heavy_check_mark:
- Able to render Tape cell, State. :heavy_check_mark:
- Refined grammar. 
  - Replaced comma with space for attribute seperation. :heavy_check_mark:
- Finalized code representation of Cell, Head, Tape, States, State, Transitions, Transition, and Turing Machine. :heavy_check_mark:
- Implemented Composite pattern to represent Turing Machine. :heavy_check_mark:
- Able to render complete Tape i.e. Tape with Cells and Head. :heavy_check_mark:
- User can control various attributes of Tape i.e. position, border and text color. :heavy_check_mark:
- TODO
  - Update testcases.
  - Update Grammar in this document.
## Sprint-2
- Designed language grammar. :heavy_check_mark:
- Implemented language grammar and parser. :heavy_check_mark:
- Written unit test cases for language grammar and parser. :heavy_check_mark:
- Integrated parser component in HomePage. :heavy_check_mark:
- Able to extract data from user input. :heavy_check_mark:
- Deployed new web build on Github. :heavy_check_mark:
## Sprint-1
- Created flutter project on Github. :heavy_check_mark:
- Implemented user interface for HomePage. :heavy_check_mark:
- Implemented business logic component(BLoC) for HomePage. :heavy_check_mark:
- Tested UI update on user text input. :heavy_check_mark:
- Deployed web build to Github. :heavy_check_mark:


# Grammar
 | Operator | Description  |
 | -------- | ------------ |
 | *        | zero or more |
 | +        | one or more  |
 | ?        | optional     |
 
```bnf
<turing-machine> ::= <tm-token> <tm-name> <tm-attribute-list>? <left-curly-brace> <statements> <right-curly-brace>

<!-- Tm -->
<tm-token> ::= <ignore-character> "tm" <ignore-character>
<tm-name> = <ignore-character> <word>+ <ignore-character>
<tm-attribute-list> ::= <attributes>*

<!-- Attributes -->
<attributes> ::= <left-square-bracket> <pair> ( <comma> <pair> )* <right-square-bracket>
<pair> ::= <key> ( <assignment> <value> )?
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
 <left-square-bracket> ::= <ignore-character> "[" <ignore-character>
 <right-square-bracket> ::= <ignore-character> "]" <ignore-character>
```
## Example
```
tm MyTm [ #red, rows=555, cols=999, distance=88] {
  tape [ x=3, y=4, ch=6, cw=7, stroke width=89, bold, dotted, dashed, #0123Ff ] : --|abba--;
  state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
    ##blue, initial, initial below, accepting] : s1;
  state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
    ##blue, initial, initial below, accepting, above right of=s1] : s2;
  s1 -[ stroke width=5, bold, dotted, dashed, #green, ##red, bend, bend right, 
    loop, loop above ]-> s2 : a, b, L;
}
```
## Turing Machine Attributes
| Key      | Value Type | Description             |
| -------- | ---------- | ----------------------- |
| #color   | -          | background color        |
| rows     | number     | grid rows               |
| cols     | number     | grid columns            |
| distance | number     | distance between states |

## Tape Attributes
| Key          | Value Type | Description                 |
| ------------ | ---------- | --------------------------- |
| x            | number     | x coordinate of tape center |
| y            | number     | y coordinate of tape center |
| ch           | number     | cell height                 |
| cw           | number     | cell width                  |
| stroke width | number     | stroke width                |
| bold         | -          | bold stroke                 |
| dotted       | -          | dotted stroke               |
| dashed       | -          | dashed stroke               |
| #color       | -          | stroke color                |

## State Attributes
| Key            | Value Type               | Description                        |
| -------------- | ------------------------ | ---------------------------------- |
| x              | number                   | x coordinate of state center       |
| y              | number                   | y coordinate of state center       |
| r              | number                   | radius of state circle             |
| stroke width   | number                   | stroke width                       |
| bold           | -                        | bold stroke                        |
| dotted         | -                        | dotted stroke                      |
| dashed         | -                        | dashed stroke                      |
| #color         | -                        | stroke color                       |
| ##color        | -                        | fill color                         |
| initial        | -                        | initial state, default left        |
| initial text   | string                   | initial state text label           |
| initial where  | above,below, left, right | initial state text label placement |
| initial above  | -                        | initial state with arrow above     |
| initial below  | -                        | initial state with arrow below     |
| initial left   | -                        | initial state with arrow left      |
| initial right  | -                        | initial state with arrow right     |
| accepting      | -                        | accepting state, double circle     |
| intermediate   | -                        | intermediate state                 |
| rejecting      | -                        | rejecting state, double circle     |
| above right of | node name                | relative state placement           |
| above left of  | node name                | relative state placement           |
| below right of | node name                | relative state placement           |
| below left of  | node name                | relative state placement           |

## Transition Attributes
| Key          | Value Type | Description                              |
| ------------ | ---------- | ---------------------------------------- |
| stroke width | number     | stroke width                             |
| bold         | -          | bold arrow                               |
| dotted       | -          | dotted arrow                             |
| dashed       | -          | dashed arrow                             |
| #color       | -          | arrow color                              |
| ##color      | -          | Label text color                         |
| bend         | -          | straight arrow                           |
| bend right   | -          | bend arrow right from arrow tail to head |
| bend left    | -          | bend arrow left from arrow tail to head  |
| loop         | -          | loops arrow above                        |
| loop above   | -          | loops arrow above                        |
| loop below   | -          | loops arrow below                        |
| loop right   | -          | loops arrow to the right                 |
| loop left    | -          | loops arrow to the  left                 |
| above        | -          | puts label above arrow                   |
| below        | -          | puts label below arrow                   |

# User Interface
## Sprint-3
![image](https://user-images.githubusercontent.com/366335/124586471-621fd200-de4e-11eb-889a-69bdec630031.png)
![image](https://user-images.githubusercontent.com/366335/124586585-854a8180-de4e-11eb-92e8-83d85df1620f.png)
![image](https://user-images.githubusercontent.com/366335/124586685-a3b07d00-de4e-11eb-9259-dd6a78d1e555.png)
![image](https://user-images.githubusercontent.com/366335/124586718-b2972f80-de4e-11eb-9b6b-b73dc982da65.png)
![image](https://user-images.githubusercontent.com/366335/124586764-c347a580-de4e-11eb-867e-53631036c47d.png)
![image](https://user-images.githubusercontent.com/366335/124586815-d3f81b80-de4e-11eb-96f3-6f4f40ec1bd3.png)
![image](https://user-images.githubusercontent.com/366335/124586895-eb370900-de4e-11eb-9842-9a819de04112.png)

## Sprint-2
![image](https://user-images.githubusercontent.com/366335/122647734-93de2c80-d11d-11eb-9954-4ad5aca5cf88.png)
![image](https://user-images.githubusercontent.com/366335/122647650-2c27e180-d11d-11eb-9808-4639d6e2ea56.png)

## Sprint-1
![image](https://user-images.githubusercontent.com/366335/120660513-4dcb6c80-c47f-11eb-8bd7-2cec86b8da30.png)
![image](https://user-images.githubusercontent.com/366335/120552021-9dae2300-c3ee-11eb-820b-73199dbebaba.png)

# Motivation
![image](https://user-images.githubusercontent.com/366335/122753906-d3765700-d28a-11eb-823e-59e9e1d48f8d.png)

Credit: [TikZ & PGF Manual](https://mirror.ox.ac.uk/sites/ctan.org/graphics/pgf/base/doc/pgfmanual.pdf)

- https://anorien.csc.warwick.ac.uk/mirrors/CTAN/graphics/pgf/base/doc/pgfmanual.pdf
- https://plantuml.com/

# References
- https://dart.dev/
- https://flutter.dev/
- https://pub.dev/packages/petitparser
- https://pub.dev/packages/flutter_bloc
- https://pub.dev/packages/test

# Code Generator
- Flutter
  - flutter packages pub run build_runner watch 
  - flutter packages pub run build_runner build --delete-conflicting-outputs

