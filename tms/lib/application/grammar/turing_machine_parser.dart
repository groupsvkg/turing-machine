import 'package:hexcolor/hexcolor.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';

class TuringMachineParser extends TuringMachineGrammar {
  // TM
  Parser tmAttributes() => super.tmAttributes().map((value) {
        Map<String, dynamic> map = {};
        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List) map.putIfAbsent(element[0], () => element[2]);
          if (element is String) map.putIfAbsent(element[0], () => true);
        });
        return map;
      });

  // Tape
  Parser tapeAttributes() => super.tapeAttributes().map((value) {
        Map<String, dynamic> map = {};
        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List) map.putIfAbsent(element[0], () => element[2]);
          if (element is String) map.putIfAbsent(element[0], () => true);
        });
        return map;
      });

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
  Parser states() => super.states().map((value) {
        Map<String, Map<String, dynamic>> map = {};
        (value as List).where((element) => element != ",").forEach((element) {
          map.putIfAbsent(element[3], () => element[1]?[1] ?? {});
        });
        return map;
      });

  Parser stateAttributes() => super.stateAttributes().map((value) {
        Map<String, dynamic> map = {};

        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List) map.putIfAbsent(element[0], () => element[2]);
          if (element is String) map.putIfAbsent(element, () => true);
        });

        return map;
      });

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

  // Transition
  Parser transitions() => super.transitions().map((value) {
        List<dynamic> list = [];

        (value as List).where((element) => element != ",").forEach((element) {
          List<dynamic> transitions = [];
          String source = element[0];
          Map<String, dynamic> attributes = element[1]?[2] ?? {};
          String destination = element[3];
          List<dynamic> label = element[5];

          transitions.add(source);
          transitions.add(attributes);
          transitions.add(destination);
          transitions.add(label);

          list.add(transitions);
        });
        return list;
      });

  Parser label() => super.label().map((value) {
        return (value as List).where((element) => element != ",").toList();
      });

  Parser transitionAttributes() => super.transitionAttributes().map((value) {
        Map<String, dynamic> map = {};

        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List) map.putIfAbsent(element[0], () => element[2]);
          if (element is String) map.putIfAbsent(element, () => true);
        });

        return map;
      });

  Parser transitionStrokeWidth() => super.transitionStrokeWidth().map((value) {
        return (value as List).join(" ");
      });
  Parser transitionStrokeColor() => super.transitionStrokeColor().map((value) {
        return (value as List).join(" ");
      });
  Parser labelFirstColor() => super.labelFirstColor().map((value) {
        return (value as List).join(" ");
      });
  Parser labelMiddleColor() => super.labelMiddleColor().map((value) {
        return (value as List).join(" ");
      });
  Parser labelLastColor() => super.labelLastColor().map((value) {
        return (value as List).join(" ");
      });
  Parser labelFontSize() => super.labelFontSize().map((value) {
        return (value as List).join(" ");
      });
  Parser bendDirection() => super.bendDirection().map((value) {
        return (value as List).join(" ");
      });
  Parser loopDirection() => super.loopDirection().map((value) {
        return (value as List).join(" ");
      });

  // Common
  Parser colorPattern() => super.colorPattern().map((value) {
        return HexColor(value);
      });
}
