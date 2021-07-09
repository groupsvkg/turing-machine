import 'package:hexcolor/hexcolor.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';
import 'package:tms/domain/turing_machine.dart';

class TuringMachineParser extends TuringMachineGrammar {
  Map<String, dynamic> tmAttributeMap = {};
  Map<String, dynamic> tapeAttributeMap = {};
  List<String> tapeDataLeft = [];
  List<String> tapeDataRight = [];
  Map<String, Map<String, dynamic>> statesMap = {};
  Map<String, Map<String, Map<String, dynamic>>> transitionsMap = {};

  // TM
  Parser tmName() => super.tmName().map((value) {
        tmAttributeMap.putIfAbsent("tmName", () => value);
        return value;
      });
  Parser tmPair() => super.tmPair().map((value) {
        tmAttributeMap.putIfAbsent(value[0], () => value[2]);
        return value;
      });

  // Tape
  Parser tapePair() => super.tapePair().map((value) {
        if (value is List)
          tapeAttributeMap.putIfAbsent(value[0], () => value[2]);
        return value;
      });

  Parser tapeData() => super.tapeData().map((value) {
        tapeDataLeft = value[0];
        tapeDataRight = value[2];
        return value;
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
  Parser state() => super.state().map((value) {
        if (statesMap.containsKey(value[3]))
          throw ParserException(
              Failure("", 0, 'State ${value[3]} already exists'));
        statesMap.putIfAbsent(value[3], () => value[1]?[1] ?? {});

        if ((value[1]?[1] ?? {}).containsKey("initial"))
          tmAttributeMap.putIfAbsent("initialState", () => value[3]);
        return value;
      });
  Parser stateAttributes() => super.stateAttributes().map((value) {
        Map<String, dynamic> stateAttributeMap = {};

        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List)
            stateAttributeMap.putIfAbsent(element[0], () => element[2]);
          if (element is String)
            stateAttributeMap.putIfAbsent(element, () => true);
        });

        bool isValid = checkSingleKeyConstrained([
          "initial above",
          "initial below",
          "initial left",
          "initial right",
        ], stateAttributeMap);

        if (!isValid)
          throw ParserException(
            Failure("", 0,
                'Only one key is allowed: "initial above", "initial below", "initial left", "initial right"'),
          );

        isValid = checkSingleKeyConstrained([
          "accepting",
          "rejecting",
          "intermediate",
        ], stateAttributeMap);

        if (!isValid)
          throw ParserException(
            Failure(
              "",
              0,
              'Only one key is allowed: "accepting", "rejecting", "intermediate"',
            ),
          );

        isValid = checkSingleKeyConstrained([
          "above of",
          "below of ",
          "left of",
          "right of",
          "above left of",
          "above right of",
          "below left of",
          "below right of",
        ], stateAttributeMap);

        if (!isValid)
          throw ParserException(
            Failure(
              "",
              0,
              'Only one key is allowed: "above of", "below of", "left of", "right of", "above left of", "above right of", "below left of", "below right of"',
            ),
          );

        isValid = checkRelativeStateConstrained([
          "above of",
          "below of ",
          "left of",
          "right of",
          "above left of",
          "above right of",
          "below left of",
          "below right of",
        ], stateAttributeMap);

        if (!isValid)
          throw ParserException(
            Failure("", 0, 'Relative state do not exist'),
          );

        return stateAttributeMap;
      });

  bool checkSingleKeyConstrained(List<String> keys, Map<String, dynamic> map) {
    int len = keys
        .map((key) => map.containsKey(key))
        .where((element) => element)
        .length;
    if (len > 1) return false;
    return true;
  }

  bool checkRelativeStateConstrained(
      List<String> keys, Map<String, dynamic> map) {
    int len = keys
        .map((key) => map.containsKey(key))
        .where((element) => element)
        .length;

    if (len == 1)
      for (String key in keys) {
        if (map.containsKey(key)) return statesMap.containsKey(map[key]);
      }
    return true;
  }

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
  Parser transition() => super.transition().map((value) {
        Map<String, Map<String, dynamic>> transitionMap = {};
        String source = value[0];
        String destination = value[3];
        String first = value[5][0];
        String middle = value[5][2];
        String last = value[5][4];

        if (!statesMap.containsKey(source))
          throw ParserException(Failure(
              "", 0, "Invalid transition: Source state does not exist"));
        if (!statesMap.containsKey(destination))
          throw ParserException(Failure(
              "", 0, "Invalid transition: Destination state does not exist"));

        Map<String, dynamic> transitionAttributes = value[1]?[2] ?? {};
        transitionAttributes.putIfAbsent("destination", () => destination);
        transitionAttributes.putIfAbsent("middle", () => middle);
        transitionAttributes.putIfAbsent("last", () => last);
        transitionMap.putIfAbsent(first, () => transitionAttributes);

        if (transitionAttributes.containsKey("loop above") ||
            transitionAttributes.containsKey("loop below") ||
            transitionAttributes.containsKey("loop left") ||
            transitionAttributes.containsKey("loop right")) {
          if (source != destination)
            throw ParserException(Failure("", 0,
                "Invalid transition: Loop must have same source and destination state"));
        }
        transitionsMap.putIfAbsent(source, () => transitionMap);

        return transitionMap;
      });

  Parser transitionAttributes() => super.transitionAttributes().map((value) {
        Map<String, dynamic> transitionAttributeMap = {};

        (value as List).where((element) => element != ",").forEach((element) {
          if (element is List)
            transitionAttributeMap.putIfAbsent(element[0], () => element[2]);
          if (element is String)
            transitionAttributeMap.putIfAbsent(element, () => true);
        });

        bool isValid = checkSingleKeyConstrained([
          "loop above",
          "loop below",
          "loop left",
          "loop right",
        ], transitionAttributeMap);
        if (!isValid)
          throw ParserException(Failure("", 0,
              'Only one key is allowed: "loop above", "loop below", "loop left", "loop right"'));

        isValid = checkSingleKeyConstrained([
          "bend left",
          "bend right",
        ], transitionAttributeMap);
        if (!isValid)
          throw ParserException(Failure(
              "", 0, 'Only one key is allowed: "bend left", "bend right"'));
        return transitionAttributeMap;
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
