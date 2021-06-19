import 'package:injectable/injectable.dart';
import 'package:petitparser/petitparser.dart';

/**
 * Example:
 * tm <tmName> [att_list] {
 *    tape[att_list]  : --|abba--;
 *    state[att_list] : q1;
 *    state[att_list] : q2;
 *    q1 -[att_list]-> q2 : label;
 *  }
 */

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

  Parser tmAttributes() => ref0(attributes).optional();
  Parser tmName() => word().plus();

  Parser statements() =>
      ref0(tape).optional() &
      ref0(states).optional() &
      ref0(transitions).optional();

  Parser attributes() =>
      ref0(leftSquareBracket) &
      ref0(pair) &
      (ref0(comma) & ref0(pair)).star() &
      ref0(rightSquareBracket);

  Parser pair() => ref0(key) & (ref0(equal) & ref0(value)).optional();
  Parser key() =>
      letter().plus() & (pattern(' ').plus() & letter().plus()).star();
  Parser value() => word().plus();

  // Tape
  Parser tape() =>
      (ref0(tapeToken) & ref0(tapeAttributes) & ref0(colon)).optional() &
      ref0(tapeData) &
      ref0(semicolon);

  Parser tapeAttributes() => ref0(attributes).optional();

  Parser tapeData() =>
      ref0(tapeStart) &
      word().star() &
      ref0(head) &
      word().star() &
      ref0(tapeEnd);

  // States
  Parser states() => ref0(state).star();
  Parser state() =>
      ref0(stateToken) &
      ref0(stateAttributes) &
      ref0(colon) &
      ref0(stateName) &
      ref0(semicolon);
  Parser stateAttributes() => ref0(attributes).optional();
  Parser stateName() => word().plus();

  // Transitions
  Parser transitions() => ref0(transition).star();
  Parser transition() =>
      ref0(source) &
      (ref0(transitionOperation) |
          string('-') & ref0(transitionAttributes) & string('->')) &
      ref0(destination) &
      (ref0(colon) & ref0(label)).optional() &
      ref0(semicolon);
  Parser source() => ref1(token, word().plus());
  Parser transitionAttributes() => ref0(attributes).optional();
  Parser destination() => ref1(token, word().plus());
  Parser label() =>
      ref0(labelFirst) &
      ref0(comma) &
      ref0(labelMiddle) &
      ref0(comma) &
      ref0(labelLast);
  Parser labelFirst() => word();
  Parser labelMiddle() => word();
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
  Parser left() => ref1(token, 'left');
  Parser right() => ref1(token, 'right');
  Parser above() => ref1(token, 'above');
  Parser below() => ref1(token, 'below');
  Parser direction() => ref0(left) | ref0(right) | ref0(above) | ref0(below);

  /**
   * Language Keywords
   */
  Parser tmToken() => ref1(token, 'tm');
  Parser otmToken() => ref1(token, 'otm');
  Parser tapeToken() => ref1(token, 'tape');
  Parser stateToken() => ref1(token, 'state');
}
