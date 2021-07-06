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
      ref0(fill) & ref0(equal) & ref0(colorPattern) |
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
      ref0(tapeX) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(tapeY) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(cellHeight) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(cellWidth) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(cellStrokeWidth) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(cellStrokeColor) & ref0(equal) & ref0(colorPattern) |
      ref0(cellFillColor) & ref0(equal) & ref0(colorPattern) |
      ref0(cellSymbolColor) & ref0(equal) & ref0(colorPattern) |
      ref0(cellSymbolFontSize) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(headHeight) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(headTipHeight) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(headTipWidth) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(headStrokeWidth) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(headStrokeColor) & ref0(equal) & ref0(colorPattern);

  // States
  Parser states() => ref0(state).star();
  Parser state() =>
      ref0(stateKeyword) &
      (ref0(leftSquareBracket) &
              ref0(stateAttributes) &
              ref0(rightSquareBracket))
          .optional() &
      ref0(colon) &
      ref0(stateName) &
      ref0(semicolon);

  Parser stateAttributes() => ref0(statePair).star();
  Parser statePair() =>
      ref0(stateX) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(stateY) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(stateR) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(stateStrokeWidth) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(stateStrokeColor) & ref0(equal) & ref0(colorPattern) |
      ref0(stateFillColor) & ref0(equal) & ref0(colorPattern) |
      ref0(stateSymbolColor) & ref0(equal) & ref0(colorPattern) |
      ref0(stateSymbolMargin) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(stateSymbolFontSize) &
          ref0(equal) &
          digit().plus().flatten().trim() |
      ref0(initialPosition) | // TODO: BUG for repetition
      ref0(initial) |
      ref0(stateType) |
      ref0(relativePosition) & ref0(equal) & word().plus().flatten().trim() |
      ref0(distance) & ref0(equal) & digit().plus().flatten().trim();
  Parser stateName() => word().plus().flatten().trim();

  // Transitions
  Parser transitions() => ref0(transition).star();
  Parser transition() =>
      ref0(source) &
      ref0(hyphen) &
      (ref0(leftSquareBracket) &
              ref0(transitionAttributes) &
              ref0(rightSquareBracket))
          .optional() &
      ref0(arrow) &
      ref0(destination) &
      ref0(colon) &
      ref0(label) &
      ref0(semicolon);
  Parser transitionAttributes() => ref0(transitionPair).star();
  Parser transitionPair() => undefined();
  Parser source() => word().plus().flatten().trim();
  Parser destination() => word().plus().flatten().trim();
  Parser label() =>
      ref0(first) &
      ref0(comma) &
      ref0(middle) &
      (ref0(comma) & ref0(headMove)).optional();
  Parser first() => word().trim();
  Parser middle() => word().trim();

  Parser cmd() => undefined();

  // Language Keywords, attributes, and symbols
  // Tm
  Parser tmKeyword() => string('tm').trim();
  // Tape
  Parser tapeKeyword() => string('tape').trim();
  Parser tapeX() => string("x").trim();
  Parser tapeY() => string("y").trim();
  Parser cellHeight() => ref0(cell) & ref0(height);
  Parser cellWidth() => ref0(cell) & ref0(width);
  Parser cellStrokeWidth() => ref0(cell) & ref0(stroke) & ref0(width);
  Parser cellStrokeColor() => ref0(cell) & ref0(stroke) & ref0(color);
  Parser cellFillColor() => ref0(cell) & ref0(fill) & ref0(color);
  Parser cellSymbolColor() => ref0(symbol) & ref0(color);
  Parser cellSymbolFontSize() => ref0(symbol) & ref0(font) & ref0(size);
  Parser headHeight() => ref0(head) & ref0(height);
  Parser headTipHeight() => ref0(head) & ref0(tip) & ref0(height);
  Parser headTipWidth() => ref0(head) & ref0(tip) & ref0(width);
  Parser headStrokeWidth() => ref0(head) & ref0(stroke) & ref0(width);
  Parser headStrokeColor() => ref0(head) & ref0(stroke) & ref0(color);

  // State
  Parser stateKeyword() => string('state').trim();
  Parser stateX() => string("x").trim();
  Parser stateY() => string("y").trim();
  Parser stateR() => string("r").trim();
  Parser stateStrokeWidth() => ref0(stroke) & ref0(width);
  Parser stateStrokeColor() => ref0(stroke) & ref0(color);
  Parser stateFillColor() => ref0(fill) & ref0(color);
  Parser stateSymbolColor() => ref0(symbol) & ref0(color);
  Parser stateSymbolMargin() => ref0(symbol) & ref0(margin);
  Parser stateSymbolFontSize() => ref0(symbol) & ref0(font) & ref0(size);
  Parser stateType() => ref0(accepting) | ref0(rejecting) | ref0(intermediate);
  Parser initialPosition() =>
      ref0(initial) & (ref0(above) | ref0(below) | ref0(left) | ref0(right));
  Parser relativePosition() =>
      (ref0(above) | ref0(below)) & (ref0(left) | ref0(right)) & ref0(of);

  // Transition
  Parser headMove() => string("L") | string("R");

  // Terminals
  Parser hyphen() => string("-").trim();
  Parser arrow() => string("->").trim();
  Parser doubleDash() => string("--").trim();
  Parser pipe() => string("|");
  Parser leftSquareBracket() => string('[').trim();
  Parser rightSquareBracket() => string(']').trim();
  Parser leftCurlyBrace() => string('{').trim();
  Parser rightCurlyBrace() => string('}').trim();
  Parser equal() => string("=").trim();
  Parser colon() => string(":").trim();
  Parser comma() => string(",").trim();
  Parser semicolon() => string(";").trim();

  Parser fill() => string("fill").trim();
  Parser distance() => string("distance").trim();
  Parser cell() => string("cell").trim();
  Parser height() => string("height").trim();
  Parser width() => string("width").trim();
  Parser head() => string("head").trim();
  Parser stroke() => string("stroke").trim();
  Parser color() => string("color").trim();
  Parser symbol() => string("symbol").trim();
  Parser font() => string("font").trim();
  Parser size() => string("size").trim();
  Parser tip() => string("tip").trim();
  Parser above() => string('above').trim();
  Parser below() => string('below').trim();
  Parser left() => string("left").trim();
  Parser right() => string("right").trim();
  Parser of() => string("of").trim();
  Parser initial() => string("initial").trim();
  Parser accepting() => string("accepting").trim();
  Parser rejecting() => string("rejecting").trim();
  Parser intermediate() => string("intermediate").trim();
  Parser margin() => string("margin").trim();

  // Common
  Parser colorPattern() => (string("#") &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f') &
          patternIgnoreCase('0-9a-f').optional() &
          patternIgnoreCase('0-9a-f').optional() &
          patternIgnoreCase('0-9a-f').optional())
      .flatten()
      .trim();
}
