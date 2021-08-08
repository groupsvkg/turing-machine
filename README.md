# Turing Machine Simulator
Project to create a domain-specific language to describe a Turing machine for visual rendering.

## Demo
**Application URL -** https://groupsvkg.github.io

[![Turing Machine Simulator](https://img.youtube.com/vi/dtkoPT20jss/0.jpg)](https://www.youtube.com/watch?v=dtkoPT20jss)

## Example
![image](https://user-images.githubusercontent.com/366335/126882788-3b208ad8-a5d0-4474-a278-a72569fe3480.png)

```
tm M {
  tape : --|0000--;

  state[ x=250, y=390, initial ] : q1;
  state[ below of=q1, rejecting ] : qr;
  state[ right of=q1 ] : q2;
  state[ below of=q2, accepting ] : qa;
  state[ right of=q2, distance=300 ] : q3;
  state[ above right of=q2 ] : q5;
  state[ below of=q3 ]: q4;

  q1 -[ bend right ]-> qr : e, e, R;
  q1 -[ bend left ]-> qr : x, x, R;
  q1 --> q2 : 0, e, R;

  q2 --> qa : e, e, R;
  q2 --> q2 : x, x, R;
  q2 --> q3: 0, x, R;

  q3 --> q3: x, x, R;
  q3 --> q5: e, e, L;
  q3 -[ bend right ]-> q4 : 0, 0, R;

  q4 -[ loop right ]-> q4 : x, x, R;
  q4 -[ bend right ]-> q3 : 0, x, R;
  q4 -[ bend left ]-> qr : e, e, R;

  q5 --> q5 : 0, 0, L;
  q5 -[ loop right ]-> q5: x, x, L;
  q5 --> q2 : e, e, R;
}

play color=#blue duration=4;

```

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

## Sprint-5
- Added "play" command to trigger animation :heavy_check_mark:
- Implemented new logic for transition arrow rendering. :heavy_check_mark:
- Implemented color name in addition to hex color code. :heavy_check_mark:
- Added deviation attribute for transition arrow to vary bezier control point. :heavy_check_mark:
- Able to show computations. :heavy_check_mark:
- Able to list computations. :heavy_check_mark:
- Added documentation link :heavy_check_mark:
- Added video link :heavy_check_mark:
- Fixed computation rendering issue :heavy_check_mark:
- Fixed animation restart issue :heavy_check_mark:
- Implemented Accept/Reject indication to occur after animation completes :heavy_check_mark:
- Implemented rendering of tape with no input initialized i.e. --|-- :heavy_check_mark:
- Implemented "duration" parameter to control animation duration :heavy_check_mark:
- Fixed incorrect transition rendering count :heavy_check_mark:
- Added code snippet buttons in toolbar :heavy_check_mark:
- Implemented timeout message if number of computation exceeds "max" value (default max=100) :heavy_check_mark:
- Fixed transition arrow issue for the case of states having different radius :heavy_check_mark:

## Sprint-4
- Implemented state rendering and logic for state attributes. :heavy_check_mark:
- Implemented rendering for initial state indicator. :heavy_check_mark:
- Implemented accepting and rejecting state. :heavy_check_mark:
- Implemented transition rendering and logic for state attributes. :heavy_check_mark:
- Implemented self loop transitions. :heavy_check_mark:
- Implemented label rendering on transition arrows. :heavy_check_mark:
- Implemented empty cells for tape rendering. :heavy_check_mark:
- Highlighted current head cell on tape. :heavy_check_mark:
- Implemented error indication of parse failure. :heavy_check_mark:
- Implemented delay of 700 milliseconds for rendering. :heavy_check_mark:
- TODO
  - Implement loop distance attribute so that arrow bending can be controlled by user.
  - Implement animation for computations.
  - Add vedio demo for application functionality.
  - Create survey for user feedback.
  - Allow color names in addition to hex code.
  - Update testcases.
  - Update Grammar in this document.
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
Below is the Turing Machine M for language L consisting of all strings of 0s whose length is a power of 2.

![image](https://user-images.githubusercontent.com/366335/126900898-dcc3ab69-2f5f-4766-b0ab-79a47655b56a.png)

```
tm M {
  tape : --|0000--;

  state[ x=250, y=390, initial ] : q1;
  state[ below of=q1, rejecting ] : qr;
  state[ right of=q1 ] : q2;
  state[ below of=q2, accepting ] : qa;
  state[ right of=q2, distance=300 ] : q3;
  state[ above right of=q2 ] : q5;
  state[ below of=q3 ]: q4;

  q1 -[ bend right ]-> qr : e, e, R;
  q1 -[ bend left ]-> qr : x, x, R;
  q1 --> q2 : 0, e, R;

  q2 --> qa : e, e, R;
  q2 --> q2 : x, x, R;
  q2 --> q3: 0, x, R;

  q3 --> q3: x, x, R;
  q3 --> q5: e, e, L;
  q3 -[ bend right ]-> q4 : 0, 0, R;

  q4 -[ loop right ]-> q4 : x, x, R;
  q4 -[ bend right ]-> q3 : 0, x, R;
  q4 -[ bend left ]-> qr : e, e, R;

  q5 --> q5 : 0, 0, L;
  q5 -[ loop right ]-> q5: x, x, L;
  q5 --> q2 : e, e, R;
}

play color=#blue;

```
![image](https://user-images.githubusercontent.com/366335/126882795-ac42b2bc-318c-42b0-877b-1f2918080886.png)

## Turing Machine Attributes
| Key      | Value Type | Description             |
| -------- | ---------- | ----------------------- |
| fill     | color      | background color        |
| distance | number     | distance between states |

## Tape Attributes
| Key               | Value Type | Description                        |
| ----------------- | ---------- | ---------------------------------- |
| x                 | number     | x coordinate of tape center        |
| y                 | number     | y coordinate of tape center        |
| cell height       | number     | cell height                        |
| cell width        | number     | cell width                         |
| cell stroke width | number     | cell stroke width                  |
| cell stroke color | color      | cell stroke color                  |
| cell fill color   | color      | cell fill color                    |
| symbol color      | color      | cell label color                   |
| symbol font size  | number     | cell label font size               |
| head height       | number     | head vertical length including tip |
| head tip height   | number     | head tip height                    |
| head tip width    | number     | head tip width                     |
| head stroke width | number     | head stroke width                  |
| head stroke color | color      | head stroke color                  |

## State Attributes
| Key              | Value Type | Description                                  |
| ---------------- | ---------- | -------------------------------------------- |
| x                | number     | x coordinate of state center                 |
| y                | number     | y coordinate of state center                 |
| r                | number     | radius of state circle                       |
| stroke width     | number     | stroke width                                 |
| stroke color     | color      | stroke color                                 |
| fill color       | color      | fill color of state circle                   |
| symbol color     | color      | state label color                            |
| symbol margin    | number     | label left and right margin                  |
| symbol font size | number     | label font size                              |
| initial          | -          | indicates that state is initial              |
| initial above    | -          | initial arrow is above the state vertically  |
| initial below    | -          | initial arrow is below the state vertically  |
| initial left     | -          | initial arrow is left the state vertically   |
| initial right    | -          | initial arrow is right the state vertically  |
| accepting        | -          | indicates accepting state                    |
| rejecting        | -          | indicates rejecting state                    |
| intermediate     | -          | indicates intermediate state                 |
| above of         | string     | indicates relative position of state         |
| below of         | string     | indicates relative position of state         |
| left of          | string     | indicates relative position of state         |
| right of         | string     | indicates relative position of state         |
| above right of   | string     | indicates relative position of state         |
| above left of    | string     | indicates relative position of state         |
| below right of   | string     | indicates relative position of state         |
| below left of    | string     | indicates relative position of state         |
| distance         | number     | indicates relative distance with other state |

## Transition Attributes
| Key                | Value Type | Description                        |
| ------------------ | ---------- | ---------------------------------- |
| stroke width       | number     | stroke width                       |
| stroke color       | color      | stroke color                       |
| loop above         | -          | self loop position                 |
| loop above left    | -          | self loop position                 |
| loop above right   | -          | self loop position                 |
| loop below         | -          | self loop position                 |
| loop below left    | -          | self loop position                 |
| loop below right   | -          | self loop position                 |
| loop left          | -          | self loop position                 |
| loop right         | -          | self loop position                 |
| loop distance      | number     | self loop height                   |
| bend left          | -          | bend arrow left                    |
| bend right         | -          | bend arrow right                   |
| label first color  | color      | arrow label first character color  |
| label middle color | color      | arrow label middle character color |
| label last color   | color      | arrow label last character color   |
| label font size    | number     | label font size                    |
| above              | -          | label above arrow                  |
| below              | -          | label below arrow                  |
| deviation          | number     | transition arrow end points angle  |

## Commands
| Name | Description                                |
| ---- | ------------------------------------------ |
| play | command to start Turing Machine simulation |
| show | command to show subset of transitions      |

### Play Attributes
| Key      | Value Type | Description                    |
| -------- | ---------- | ------------------------------ |
| color    | color      | simulation color indication    |
| duration | number     | simulation duration in seconds |
| from     | number     | transition start number        |
| to       | number     | transition end number          |
| max      | number     | maximum transition to display  |

**Example:** play color=#red duration=3

### Show Attributes
| Key      | Value Type | Description                 |
| -------- | ---------- | --------------------------- |
| color    | color      | simulation color indication |
| duration | number     | simulation duration         |
| from     | number     | transition start number     |
| to       | number     | transition end number       |

**Example:** show color=#green duration=4 from=2 to=4

### Colors
| Name     | Hexcode |
| -------- | ------- |
| #white   | #FFFFFF |
| #silver  | #C0C0C0 |
| #gray    | #808080 |
| #black   | #000000 |
| #red     | #FF0000 |
| #maroon  | #800000 |
| #yellow  | #FFFF00 |
| #olive   | #808000 |
| #lime    | #00FF00 |
| #green   | #008000 |
| #aqua    | #00FFFF |
| #teal    | #008080 |
| #blue    | #0000FF |
| #navy    | #000080 |
| #fuchsia | #FF00FF |
| #purple  | #800080 |

# User Interface
## Sprint-5
![image](https://user-images.githubusercontent.com/366335/127021585-dd938752-513f-4f64-a6a2-6ccff897fe1f.png)
![image](https://user-images.githubusercontent.com/366335/127021384-956cb743-4c75-4234-bfbf-1ed235419d9e.png)
![image](https://user-images.githubusercontent.com/366335/126882781-785a1416-f5f3-4243-8d67-3282333801ce.png)
![image](https://user-images.githubusercontent.com/366335/126669358-0e5d2d80-4a67-40a7-841f-1e5f066f800e.png)

## Sprint-4
![image](https://user-images.githubusercontent.com/366335/126081935-4b9d1bd6-28c4-4345-be21-7fea2943e977.png)
![image](https://user-images.githubusercontent.com/366335/126080944-f288ed6d-61bb-4275-9078-e922c2657ec9.png)
![image](https://user-images.githubusercontent.com/366335/126045341-c78b9c5c-d071-4220-b8af-4650ac196021.png)
![image](https://user-images.githubusercontent.com/366335/126043166-ffb7bd92-472a-451d-b1e4-acf24b21b1fb.png)
![image](https://user-images.githubusercontent.com/366335/126042018-33730834-ffda-48c4-8ed0-3c89cc8e2920.png)
![image](https://user-images.githubusercontent.com/366335/125213516-55fe9f00-e2aa-11eb-9673-a8a0581b859e.png)
![image](https://user-images.githubusercontent.com/366335/125271461-b1f51200-e302-11eb-82b1-05e39654774b.png)
![image](https://user-images.githubusercontent.com/366335/125271533-c9cc9600-e302-11eb-9125-e21f026897f0.png)

## Sprint-3
![image](https://user-images.githubusercontent.com/366335/124586471-621fd200-de4e-11eb-889a-69bdec630031.png)
![image](https://user-images.githubusercontent.com/366335/124586585-854a8180-de4e-11eb-92e8-83d85df1620f.png)
![image](https://user-images.githubusercontent.com/366335/124586685-a3b07d00-de4e-11eb-9259-dd6a78d1e555.png)
![image](https://user-images.githubusercontent.com/366335/124586718-b2972f80-de4e-11eb-9b6b-b73dc982da65.png)
![image](https://user-images.githubusercontent.com/366335/124586764-c347a580-de4e-11eb-867e-53631036c47d.png)
![image](https://user-images.githubusercontent.com/366335/124587307-63053380-de4f-11eb-9236-7892ecc80fa7.png)
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

