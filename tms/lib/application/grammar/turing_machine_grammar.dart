import 'package:injectable/injectable.dart';
import 'package:petitparser/petitparser.dart';

@injectable
class TuringMachineGrammar extends GrammarDefinition {
  Parser token(Object input) {
    if (input is Parser) {
      return input.token().trim(ref0(ignoreCharacter));
    } else if (input is String) {
      return token(input.toParser());
    }
    throw ArgumentError.value(input, 'Invalid token parser');
  }

  /**
   * Parser Rules
   */
  @override
  Parser start() => ref0(tmDescription).end();

  Parser tmDescription() => ref0(tm);

  // TM
  Parser tm() =>
      ref0(tmToken) &
      ref0(tmName) &
      ref0(tmAttributes) &
      ref0(leftBrace) &
      ref0(statements) &
      ref0(rightBrace);

  Parser tmName() => word().plus().flatten();

  Parser tmAttributes() => (ref0(leftSquareBracket) &
          ref0(tmPair) &
          (ref0(comma) & ref0(tmPair)).star() &
          ref0(rightSquareBracket))
      .optional();

  Parser tmPair() =>
      ref0(backgroundColor) |
      ref0(rows) & ref0(equal) & digit().plus().flatten() |
      ref0(cols) & ref0(equal) & digit().plus().flatten() |
      ref0(distance) & ref0(equal) & digit().plus().flatten();

  Parser statements() =>
      ref0(tape).optional() &
      ref0(states).optional() &
      ref0(transitions).optional();

  // Tape
  Parser tape() =>
      (ref0(tapeToken) & ref0(tapeAttributes) & ref0(colon)).optional() &
      ref0(tapeData) &
      ref0(semicolon);

  Parser tapeAttributes() => (ref0(leftSquareBracket) &
          ref0(tapePair) &
          (ref0(comma) & ref0(tapePair)).star() &
          ref0(rightSquareBracket))
      .optional();

  Parser tapePair() =>
      ref0(x) & ref0(equal) & digit().plus().flatten() |
      ref0(y) & ref0(equal) & digit().plus().flatten() |
      ref0(cellHeight) & ref0(equal) & digit().plus().flatten() |
      ref0(stroke) & ref0(width) & ref0(equal) & digit().plus().flatten() |
      ref0(bold) |
      ref0(dotted) |
      ref0(dashed) |
      ref0(strokeColor);

  Parser tapeData() =>
      ref0(tapeStart) &
      word().star().flatten() &
      ref0(head) &
      word().star().flatten() &
      ref0(tapeEnd);

  // States
  Parser states() => ref0(state).star();
  Parser state() =>
      ref0(stateToken) &
      ref0(stateAttributes) &
      ref0(colon) &
      ref0(stateName) &
      ref0(semicolon);
  Parser stateAttributes() => (ref0(leftSquareBracket) &
          ref0(statePair) &
          (ref0(comma) & ref0(statePair)).star() &
          ref0(rightSquareBracket))
      .optional();

  Parser statePair() =>
      ref0(x) & ref0(equal) & digit().plus().flatten() |
      ref0(y) & ref0(equal) & digit().plus().flatten() |
      ref0(r) & ref0(equal) & digit().plus().flatten() |
      ref0(stroke) & ref0(width) & ref0(equal) & digit().plus().flatten() |
      ref0(bold) |
      ref0(dotted) |
      ref0(dashed) |
      ref0(strokeColor) |
      ref0(fillColor) |
      ref0(initial) & ref0(text) & ref0(equal) & word().plus().flatten() |
      ref0(initial) & ref0(where) & ref0(equal) & ref0(direction) |
      ref0(initial) & ref0(direction) |
      ref0(initial) |
      ref0(accepting) |
      ref0(intermediate) |
      ref0(rejecting) |
      ref0(vDirection) &
          ref0(hDirection) &
          ref0(of) &
          ref0(equal) &
          ref0(stateName);
  Parser stateName() => word().plus().flatten();

  // Transitions
  Parser transitions() => ref0(transition).star();
  Parser transition() =>
      ref0(source) &
      (ref0(transitionOperation) |
          string('-') & ref0(transitionAttributes) & string('->')) &
      ref0(destination) &
      (ref0(colon) & ref0(label)).optional() &
      ref0(semicolon);
  Parser source() => ref1(token, word().plus().flatten());
  Parser transitionAttributes() => (ref0(leftSquareBracket) &
          ref0(transitionPair) &
          (ref0(comma) & ref0(transitionPair)).star() &
          ref0(rightSquareBracket))
      .optional();

  Parser transitionPair() =>
      ref0(stroke) & ref0(width) & ref0(equal) & digit().plus().flatten() |
      ref0(bold) |
      ref0(dotted) |
      ref0(dashed) |
      ref0(strokeColor) |
      ref0(labelColor) |
      ref0(bend) & ref0(hDirection) |
      ref0(bend) |
      ref0(loop) & ref0(direction) |
      ref0(loop) |
      ref0(vDirection);
  Parser destination() => ref1(token, word().plus().flatten());
  Parser label() =>
      ref0(labelFirst) &
      ref0(comma) &
      ref0(labelMiddle) &
      ref0(comma) &
      ref0(labelLast);
  Parser labelFirst() => word().flatten();
  Parser labelMiddle() => word().flatten();
  Parser labelLast() => ref0(headLeft) | ref0(headRight);

  /**
   * Lexer Rules
   */
  Parser ignoreCharacter() => pattern(' \t\n\r').plus();
  Parser transitionOperation() => ref1(token, '->');
  Parser equal() => ref1(token, '=');
  Parser head() => string('|');
  Parser headLeft() => string('L');
  Parser headRight() => string('R');
  Parser tapeStart() => string('--');
  Parser tapeEnd() => string('--');
  Parser semicolon() => ref1(token, ';');
  Parser colon() => ref1(token, ':');
  Parser comma() => ref1(token, ',');
  Parser leftBrace() => ref1(token, '{');
  Parser rightBrace() => ref1(token, '}');
  Parser leftSquareBracket() => ref1(token, '[');
  Parser rightSquareBracket() => ref1(token, ']');

  /**
   * Attribute keywords
   */

  // TM
  Parser rows() => ref1(token, 'rows');
  Parser cols() => ref1(token, 'cols');
  Parser distance() => ref1(token, 'distance');

  // Tape
  Parser x() => ref1(token, 'x');
  Parser y() => ref1(token, 'y');
  Parser cellHeight() => ref1(token, 'h');

  // State
  Parser r() => ref1(token, 'r');
  Parser initial() => ref1(token, 'initial');
  Parser text() => ref1(token, 'text');
  Parser where() => ref1(token, 'where');
  Parser accepting() => ref1(token, 'accepting');
  Parser rejecting() => ref1(token, 'rejecting');
  Parser intermediate() => ref1(token, 'intermediate');
  Parser of() => ref1(token, 'of');

  // Transition
  Parser bend() => ref1(token, 'bend');
  Parser loop() => ref1(token, 'loop');

  /**
   * Common Attributes
   */
  Parser stroke() => ref1(token, 'stroke');
  Parser width() => ref1(token, 'width');
  Parser bold() => ref1(token, 'bold');
  Parser dotted() => ref1(token, 'dotted');
  Parser dashed() => ref1(token, 'dashed');
  Parser left() => ref1(token, 'left');
  Parser right() => ref1(token, 'right');
  Parser above() => ref1(token, 'above');
  Parser below() => ref1(token, 'below');
  Parser color() =>
      string('red') |
      string('blue') |
      string('green') |
      (patternIgnoreCase('0-9a-f') &
              patternIgnoreCase('0-9a-f') &
              patternIgnoreCase('0-9a-f') &
              patternIgnoreCase('0-9a-f') &
              patternIgnoreCase('0-9a-f') &
              patternIgnoreCase('0-9a-f'))
          .flatten();
  Parser strokeColor() => string('#') & ref0(color);
  Parser backgroundColor() => string('#') & ref0(color);
  Parser fillColor() => string('##') & ref0(color);
  Parser labelColor() => string('##') & ref0(color);
  Parser direction() => ref0(above) | ref0(below) | ref0(left) | ref0(right);
  Parser vDirection() => ref0(above) | ref0(below);
  Parser hDirection() => ref0(left) | ref0(right);

  /**
   * Language Keywords
   */
  Parser tmToken() => ref1(token, 'tm');
  Parser otmToken() => ref1(token, 'otm');
  Parser tapeToken() => ref1(token, 'tape');
  Parser stateToken() => ref1(token, 'state');
}
