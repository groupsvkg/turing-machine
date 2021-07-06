import 'package:injectable/injectable.dart';
import 'package:petitparser/petitparser.dart';

@injectable
class TuringMachineGrammar extends GrammarDefinition {
  /**
   * Parser Rules
   */
  @override
  Parser start() => ref0(tmDescription).end();

  Parser tmDescription() => ref0(tm) & ref0(cmd).optional();

  Parser tm() =>
      ref0(tmKeyword) &
      ref0(tmName) &
      (ref0(leftSquareBracket) & ref0(tmAttributes) & ref0(rightSquareBracket))
          .optional() &
      ref0(leftCurlyBrace) &
      ref0(tape).optional() &
      ref0(states).optional() &
      ref0(transitions).optional() &
      ref0(rightCurlyBrace);

  // TM
  Parser tmName() => word().plus().flatten().trim();
  Parser tmAttributes() => ref0(tmPair).star();

  Parser tmPair() =>
      ref0(fill) & ref0(equal) & ref0(color) |
      ref0(distance) & ref0(equal) & digit().plus().flatten().trim();

  // Tape
  Parser tape() =>
      (ref0(tapeKeyword) &
              (ref0(leftSquareBracket) &
                      ref0(tapeAttributes) &
                      ref0(rightSquareBracket))
                  .optional() &
              ref0(colon))
          .optional() &
      ref0(doubleDash) &
      word().star() &
      ref0(pipe) &
      word().star() &
      ref0(doubleDash) &
      ref0(semicolon);
  Parser tapeAttributes() => ref0(tapePair).star();
  Parser tapePair() =>
      ref0(x) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(y) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(ch) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(cw) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(fill) & ref0(equal) & ref0(color) |
      ref0(borderColor) & ref0(equal) & ref0(color);

  // States
  Parser states() => undefined();

  // Transitions
  Parser transitions() => undefined();

  Parser cmd() => undefined();

  // Language Keywords, attributes, and symbols
  Parser tmKeyword() => string('tm').trim();
  Parser tapeKeyword() => string('tape').trim();
  Parser x() => string("x").trim();
  Parser y() => string("y").trim();
  Parser ch() => string("ch").trim();
  Parser cw() => string("cw").trim();
  Parser doubleDash() => string("--").trim();
  Parser pipe() => string("|").trim();
  Parser stateKeyword() => string('state').trim();
  Parser leftSquareBracket() => string('[').trim();
  Parser rightSquareBracket() => string(']').trim();
  Parser leftCurlyBrace() => string('{').trim();
  Parser rightCurlyBrace() => string('}').trim();
  Parser equal() => string("=").trim();
  Parser fill() => string("fill").trim();
  Parser borderColor() => string("color").trim();
  Parser distance() => string("distance").trim();
  Parser colon() => string(":").trim();
  Parser semicolon() => string(";").trim();

  Parser color() => (string("#") &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f'))
      .flatten()
      .trim();
}
