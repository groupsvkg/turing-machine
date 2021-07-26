import 'package:injectable/injectable.dart';
import 'package:petitparser/petitparser.dart';

@injectable
class TuringMachineGrammar extends GrammarDefinition {
  /**
   * Parser Rules
   */
  @override
  Parser start() => ref0(tmDescription).end();

  Parser tmDescription() => ref0(tm) & ref0(cmds).optional();

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
  Parser tmAttributes() => (ref0(tmPair) | ref0(comma)).star();

  Parser tmPair() =>
      ref0(fill) & ref0(equal) & ref0(colorPattern) |
      ref0(distance) & ref0(equal) & digit().plus().flatten().trim();

  // Tape Syntax
  Parser tape() =>
      (ref0(tapeKeyword) &
              (ref0(leftSquareBracket) &
                      ref0(tapeAttributes) &
                      ref0(rightSquareBracket))
                  .optional() &
              ref0(colon))
          .optional() &
      ref0(doubleDash) &
      ref0(tapeData) &
      ref0(doubleDash) &
      ref0(semicolon);
  Parser tapeAttributes() =>
      (ref0(tapePair) | ref0(comma) | ref0(tapePair)).star();
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
  Parser tapeData() => word().star() & ref0(pipe) & word().star();

  // States  Syntax
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

  Parser stateAttributes() =>
      (ref0(statePair) | ref0(comma) | ref0(statePair)).star();
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
      // ignore: todo
      ref0(initialPosition) | // TODO: BUG for repetition
      ref0(initial) |
      ref0(stateType) |
      ref0(relativePosition) & ref0(equal) & word().plus().flatten().trim() |
      ref0(distance) & ref0(equal) & digit().plus().flatten().trim();
  Parser stateName() => word().plus().flatten().trim();

  // Transitions Syntax
  Parser transitions() => ref0(transition).star();
  Parser transition() =>
      ref0(source) &
      (ref0(hyphen) &
              ref0(leftSquareBracket) &
              ref0(transitionAttributes) &
              ref0(rightSquareBracket))
          .optional() &
      ref0(arrow) &
      ref0(destination) &
      ref0(colon) &
      ref0(label) &
      ref0(semicolon);
  Parser transitionAttributes() =>
      (ref0(transitionPair) | ref0(comma) | ref0(transitionPair)).star();
  Parser transitionPair() =>
      ref0(transitionStrokeWidth) &
          ref0(equal) &
          digit().plus().flatten().trim() |
      ref0(transitionStrokeColor) & ref0(equal) & ref0(colorPattern) |
      ref0(labelFirstColor) & ref0(equal) & ref0(colorPattern) |
      ref0(labelMiddleColor) & ref0(equal) & ref0(colorPattern) |
      ref0(labelLastColor) & ref0(equal) & ref0(colorPattern) |
      ref0(labelFontSize) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(bendDirection) |
      ref0(loopDirection) |
      ref0(loopDistance) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(labelPosition) |
      ref0(deviation) & ref0(equal) & digit().plus().flatten().trim();

  Parser source() => word().plus().flatten().trim();
  Parser destination() => word().plus().flatten().trim();
  Parser label() =>
      ref0(first) & ref0(comma) & ref0(middle) & ref0(comma) & ref0(last);
  Parser first() => word().trim();
  Parser middle() => word().trim();
  Parser last() => string("L").trim() | string("R").trim();

  // Cmds
  Parser cmds() => ref0(play).optional() & ref0(show).optional();
  // Play
  Parser play() => ref0(playKeyword) & ref0(playAttributes) & ref0(semicolon);
  Parser playAttributes() =>
      (ref0(playPair) | ref0(comma) | ref0(playPair)).star();
  Parser playPair() =>
      ref0(color) & ref0(equal) & ref0(colorPattern) |
      ref0(duration) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(from) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(to) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(max) & ref0(equal) & digit().plus().flatten().trim();

  // Show
  Parser show() => ref0(showKeyword) & ref0(showAttributes) & ref0(semicolon);
  Parser showAttributes() =>
      (ref0(showPair) | ref0(comma) | ref0(showPair)).star();
  Parser showPair() =>
      ref0(color) & ref0(equal) & ref0(colorPattern) |
      ref0(duration) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(from) & ref0(equal) & digit().plus().flatten().trim() |
      ref0(to) & ref0(equal) & digit().plus().flatten().trim();

  Parser playKeyword() => string("play").trim();
  Parser showKeyword() => string("show").trim();

  // Language Keywords, attributes, and symbols
  // Tm
  Parser tmKeyword() => string('tm').trim();

  // Tape Attributes
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

  // State Attributes
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
      (ref0(above) | ref0(below)) & (ref0(left) | ref0(right)) & ref0(of) |
      ref0(above) & ref0(of) |
      ref0(below) & ref0(of) |
      ref0(left) & ref0(of) |
      ref0(right) & ref0(of);

  // Transition Attributes
  Parser bendDirection() =>
      ref0(bend) & (ref0(left) | ref0(straight) | ref0(right));
  Parser loopDirection() =>
      ref0(loop) & ref0(above) & ref0(left) |
      ref0(loop) & ref0(above) & ref0(right) |
      ref0(loop) & ref0(below) & ref0(left) |
      ref0(loop) & ref0(below) & ref0(right) |
      ref0(loop) & ref0(above) |
      ref0(loop) & ref0(below) |
      ref0(loop) & ref0(left) |
      ref0(loop) & ref0(right);
  Parser loopDistance() => ref0(loop) & ref0(distance);

  Parser transitionStrokeWidth() => ref0(stroke) & ref0(width);
  Parser transitionStrokeColor() => ref0(stroke) & ref0(color);
  Parser labelFirstColor() =>
      ref0(transitionLabel) & ref0(labelFirst) & ref0(color);
  Parser labelMiddleColor() =>
      ref0(transitionLabel) & ref0(labelMiddle) & ref0(color);
  Parser labelLastColor() =>
      ref0(transitionLabel) & ref0(labelLast) & ref0(color);
  Parser labelFontSize() => ref0(transitionLabel) & ref0(font) & ref0(size);
  Parser labelPosition() => ref0(above) | ref0(below);

  // Terminals
  Parser hyphen() => string("-").trim();
  Parser arrow() => string("->").trim() | string("-->").trim();
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
  Parser loop() => string("loop").trim();
  Parser bend() => string("bend").trim();
  Parser transitionLabel() => string("label").trim();
  Parser labelFirst() => string("first").trim();
  Parser labelMiddle() => string("middle").trim();
  Parser labelLast() => string("last").trim();
  Parser straight() => string("straight").trim();
  Parser deviation() => string("deviation").trim();
  Parser duration() => string("duration").trim();
  Parser from() => string("from").trim();
  Parser to() => string("to").trim();
  Parser max() => string("max").trim();

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
              patternIgnoreCase('0-9a-f').optional() |
          string("#") & string("white") |
          string("#") & string("silver") |
          string("#") & string("gray") |
          string("#") & string("black") |
          string("#") & string("red") |
          string("#") & string("maroon") |
          string("#") & string("yellow") |
          string("#") & string("olive") |
          string("#") & string("lime") |
          string("#") & string("green") |
          string("#") & string("aqua") |
          string("#") & string("teal") |
          string("#") & string("blue") |
          string("#") & string("navy") |
          string("#") & string("fuchsia") |
          string("#") & string("purple"))
      .flatten()
      .trim();
}
