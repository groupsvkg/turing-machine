import 'package:hexcolor/hexcolor.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';

class TuringMachineParser extends TuringMachineGrammar {
  // TM
  // Parser tmName() => super.tmName().map((value) {
  //       return value;
  //     });

  // Parser tmPair() => super.tmPair().map((value) {
  //       tmProperties.putIfAbsent(value[0], () => value[2]);
  //       return super.tmPair();
  //     });

  // Parser tapePair() => super.tapePair().map((value) {
  //       tapeProperties.putIfAbsent(value[0], () => value[2]);
  //       return super.tapePair();
  //     });

  // Tape
  Parser cellHeight() => super.cellHeight().map((value) {
        return (value as List).join(" ");
      });

  Parser cellWidth() => super.cellWidth().map((value) {
        return (value as List).join(" ");
      });

  Parser cellStrokeWidth() => super.cellStrokeWidth().map((value) {
        return (value as List).join(" ");
      });

  Parser cellStrokeColor() => super.cellStrokeColor().map((value) {
        return (value as List).join(" ");
      });

  Parser cellFillColor() => super.cellFillColor().map((value) {
        return (value as List).join(" ");
      });
  Parser cellSymbolColor() => super.cellSymbolColor().map((value) {
        return (value as List).join(" ");
      });

  Parser cellSymbolFontSize() => super.cellSymbolFontSize().map((value) {
        return (value as List).join(" ");
      });

  Parser headHeight() => super.headHeight().map((value) {
        return (value as List).join(" ");
      });

  Parser headTipHeight() => super.headTipHeight().map((value) {
        return (value as List).join(" ");
      });
  Parser headTipWidth() => super.headTipWidth().map((value) {
        return (value as List).join(" ");
      });
  Parser headStrokeWidth() => super.headStrokeWidth().map((value) {
        return (value as List).join(" ");
      });
  Parser headStrokeColor() => super.headStrokeColor().map((value) {
        return (value as List).join(" ");
      });

  // State
  Parser stateStrokeWidth() => super.stateStrokeWidth().map((value) {
        return (value as List).join(" ");
      });
  Parser stateStrokeColor() => super.stateStrokeColor().map((value) {
        return (value as List).join(" ");
      });

  Parser stateFillColor() => super.stateFillColor().map((value) {
        return (value as List).join(" ");
      });

  Parser stateSymbolColor() => super.stateSymbolColor().map((value) {
        return (value as List).join(" ");
      });

  Parser stateSymbolMargin() => super.stateSymbolMargin().map((value) {
        return (value as List).join(" ");
      });

  Parser stateSymbolFontSize() => super.stateSymbolFontSize().map((value) {
        return (value as List).join(" ");
      });

  Parser initialPosition() => super.initialPosition().map((value) {
        return (value as List).join(" ");
      });

  Parser relativePosition() => super.relativePosition().map((value) {
        return (value as List).join(" ");
      });

  // Common
  Parser colorPattern() => super.colorPattern().map((value) {
        return HexColor(value);
      });
}
