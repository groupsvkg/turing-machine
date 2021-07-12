import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/application/grammar/turing_machine_parser.dart';
import 'package:tms/application/home_page/home_page_bloc.dart';
import 'package:tms/domain/turing_machine.dart';

class TmRenderWidget extends StatelessWidget {
  const TmRenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previousState, state) {
        return previousState != state;
      },
      builder: (context, state) {
        return Expanded(
          child: InteractiveViewer(
            constrained: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: state.map(
                  homeInitial: (HomeInitial homeInitial) {},
                  homeParseSuccess: (HomeParseSuccess homeParseSuccess) {
                    double width = MediaQuery.of(context).size.width;
                    double height = MediaQuery.of(context).size.height;
                    Result<dynamic> result =
                        homeParseSuccess.result.map((element) => element[0]);

                    // TuringMachine tm = TuringMachine([]);
                    // return Text(
                    //   result.toString(),
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //   ),
                    // );

                    return CustomPaint(
                      painter: TuringMachinePainter(result),
                    );
                  },
                  homeParseFailure: (HomeParseFailure homeParseFailure) {
                    return Text(
                      homeParseFailure.errorMessage,
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class TuringMachinePainter extends CustomPainter {
  final Result<dynamic> result;

  TuringMachinePainter(this.result);

  @override
  void paint(Canvas canvas, Size size) {
    Size visibleSize = Size(size.width / 2, size.height);

    // canvas.drawRect(
    //     Rect.fromLTWH(0, 0, visibleSize.width, visibleSize.height),
    //     Paint()
    //       ..color = Colors.red
    //       ..strokeWidth = 5);
    TuringMachine tm = _constructTuringMachine(result, visibleSize);
    tm.draw(canvas, visibleSize);
  }

  TuringMachine _constructTuringMachine(Result<dynamic> result, Size size) {
    TuringMachine tm = TuringMachine([]);
    Tape tape = _constructTape(result, size);
    States states = _constructStates(result, size);
    Transitions transitions = _constructTransitions(result, size);

    tm.add(tape);
    tm.add(states);
    tm.add(transitions);

    Map<dynamic, dynamic> tmAttributes = (result.value[2]?[1] ?? {}) as Map;
    tm.tmName = result.value[1];
    tm.fill = tmAttributes["fill"] ?? Colors.white;
    tm.distance = double.parse(tmAttributes["distance"] ?? "100");

    return tm;
  }

  Tape _constructTape(Result<dynamic> result, Size size) {
    Tape tape = Tape([], [], []);
    Map<dynamic, dynamic> tapeAttributes =
        (result.value[4]?[0]?[1]?[1] ?? {}) as Map;
    tape.tapeX =
        double.parse(tapeAttributes["x"] ?? (size.width / 2).toString());
    tape.tapeY = double.parse(tapeAttributes["y"] ?? "100");

    tape.cellHeight = double.parse(tapeAttributes["cell height"] ?? "40");
    tape.cellWidth = double.parse(tapeAttributes["cell width"] ?? "40");
    tape.cellStrokeWidth =
        double.parse(tapeAttributes["cell stroke width"] ?? "3");
    tape.cellStrokeColor =
        tapeAttributes["cell stroke color"] ?? Colors.lightBlue;
    tape.cellFillColor = tapeAttributes["cell fill color"] ?? Colors.white;

    tape.cellSymbolColor = tapeAttributes["symbol color"] ?? Colors.red;
    tape.cellSymbolFontSize =
        double.parse(tapeAttributes["symbol font size"] ?? "30");

    tape.headHeight = double.parse(tapeAttributes["head height"] ?? "50");
    tape.headTipHeight =
        double.parse(tapeAttributes["head tip height"] ?? "16");
    tape.headTipWidth = double.parse(tapeAttributes["head tip width"] ?? "16");
    tape.headStrokeWidth =
        double.parse(tapeAttributes["head stroke width"] ?? "4");
    tape.headStrokeColor =
        tapeAttributes["head stroke color"] ?? Colors.brown[600];

    tape.tapeLeftData = (result.value[4]?[2]?[0] ?? []);
    tape.tapeRightData = (result.value[4]?[2]?[2] ?? []);

    if (tape.tapeLeftData.isEmpty && tape.tapeRightData.isEmpty) return tape;

    Head head = Head(
      headX: tape.tapeX,
      headY: tape.tapeY - tape.cellHeight / 2 - tape.headHeight / 2,
      headHeight: tape.headHeight,
      headTipHeight: tape.headTipHeight,
      headTipWidth: tape.headTipWidth,
      headStrokeWidth: tape.headStrokeWidth,
      headStokeColor: tape.headStrokeColor,
    );

    tape.add(head);

    tape.tapeRightData.asMap().forEach((key, value) {
      if (key == 0) return;
      Cell cell = Cell(
        cellX: tape.tapeX + key * tape.cellWidth,
        cellY: tape.tapeY,
        cellHeight: tape.cellHeight,
        cellWidth: tape.cellWidth,
        cellStrokeWidth: tape.cellStrokeWidth,
        cellStrokeColor: tape.cellStrokeColor,
        cellFillColor: tape.cellFillColor,
        cellSymbol: value,
        cellSymbolColor: tape.cellSymbolColor,
        cellSymbolFontSize: tape.cellSymbolFontSize,
      );
      tape.add(cell);
    });

    tape.tapeLeftData.asMap().forEach((key, value) {
      Cell cell = Cell(
        cellX: tape.tapeX - (tape.tapeLeftData.length - key) * tape.cellWidth,
        cellY: tape.tapeY,
        cellHeight: tape.cellHeight,
        cellWidth: tape.cellWidth,
        cellStrokeWidth: tape.cellStrokeWidth,
        cellStrokeColor: tape.cellStrokeColor,
        cellFillColor: tape.cellFillColor,
        cellSymbol: value,
        cellSymbolColor: tape.cellSymbolColor,
        cellSymbolFontSize: tape.cellSymbolFontSize,
      );
      tape.add(cell);
    });

    tape.add(Cell(
      cellX: tape.tapeX,
      cellY: tape.tapeY,
      cellHeight: tape.cellHeight,
      cellWidth: tape.cellWidth,
      cellStrokeWidth: tape.cellStrokeWidth + 1,
      cellStrokeColor: Colors.amber,
      cellFillColor: tape.cellFillColor,
      cellSymbol: tape.tapeRightData.isNotEmpty ? tape.tapeRightData[0] : "",
      cellSymbolColor: Colors.brown,
      cellSymbolFontSize: tape.cellSymbolFontSize + 8,
    ));

    return tape;
  }

  States _constructStates(Result<dynamic> result, Size size) {
    States states = States([]);
    Map<dynamic, Map<dynamic, dynamic>> statesAttributes = result.value[5];
    statesAttributes.forEach((key, value) {
      states.add(_constructState(statesAttributes, key, value, size));
    });
    return states;
  }

  State_ _constructState(Map<dynamic, Map<dynamic, dynamic>> statesAttributes,
      String name, Map<dynamic, dynamic> map, Size size) {
    State_ state = State_(
      symbol: name,
      stateX: double.parse(map["x"] ?? (size.width / 2).toString()),
      stateY: double.parse(map["y"] ?? (size.height / 2).toString()),
      stateR: double.parse(map["r"] ?? "5"),
      stateStrokeWidth: double.parse(map["stroke width"] ?? "4"),
      stateStrokeColor: map["stroke color"] ?? Colors.brown,
      stateFillColor: map["fill color"] ?? Colors.white,
      stateSymbolColor: map["symbol color"] ?? Colors.black,
      stateSymbolMargin: double.parse(map["symbol margin"] ?? "6"),
      stateSymbolFontSize: double.parse(map["symbol font size"] ?? "25"),
      isStateInitial: map["initial"] ?? false,
      distance: double.parse(map["distance"] ?? "150"),
    );

    if (map.containsKey("initial above"))
      state.initialPosition = "initial above";
    if (map.containsKey("initial below"))
      state.initialPosition = "initial below";
    if (map.containsKey("initial left")) state.initialPosition = "initial left";
    if (map.containsKey("initial right"))
      state.initialPosition = "initial right";

    if (map.containsKey("accepting")) {
      state.stateType = "accepting";
      state.stateFillColor = Colors.green;
    }
    if (map.containsKey("rejecting")) {
      state.stateType = "rejecting";
      state.stateFillColor = Colors.red;
    }

    if (map.containsKey("above of")) {
      state.relativePosition = "above of";
      state.relativeTo = map["above of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX;
        state.stateY = state.relativeY - state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("below of")) {
      state.relativePosition = "below of";
      state.relativeTo = map["below of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX;
        state.stateY = state.relativeY + state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("left of")) {
      state.relativePosition = "left of";
      state.relativeTo = map["left of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX - state.distance;
        state.stateY = state.relativeY;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("right of")) {
      state.relativePosition = "right of";
      state.relativeTo = map["right of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX + state.distance;
        state.stateY = state.relativeY;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }

    if (map.containsKey("above left of")) {
      state.relativePosition = "above left of";
      state.relativeTo = map["above left of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX - state.distance;
        state.stateY = state.relativeY + state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("above right of")) {
      state.relativePosition = "above right of";
      state.relativeTo = map["above right of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX + state.distance;
        state.stateY = state.relativeY + state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("below left of")) {
      state.relativePosition = "below left of";
      state.relativeTo = map["below left of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX - state.distance;
        state.stateY = state.relativeY - state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }
    if (map.containsKey("below right of")) {
      state.relativePosition = "below right of";
      state.relativeTo = map["below right of"];
      if (statesAttributes.containsKey(state.relativeTo)) {
        state.relativeX = double.parse(statesAttributes[state.relativeTo]
                ?["x"] ??
            (size.width / 2).toString());
        state.relativeY = double.parse(statesAttributes[state.relativeTo]
                ?["y"] ??
            (size.height / 2).toString());
        state.stateX = state.relativeX + state.distance;
        state.stateY = state.relativeY - state.distance;
        if (map.containsKey("x"))
          map.update("x", (value) => state.stateX.toString());
        else
          map.putIfAbsent("x", () => state.stateX.toString());
        if (map.containsKey("y"))
          map.update("y", (value) => state.stateY.toString());
        else
          map.putIfAbsent("y", () => state.stateY.toString());
      }
    }

    return state;
  }

  Transitions _constructTransitions(Result<dynamic> result, Size size) {
    Transitions transitions = Transitions([]);
    Map<dynamic, Map<dynamic, dynamic>> statesAttributes = result.value[5];
    List<dynamic> transitionsAttributes = result.value[6];

    transitionsAttributes.forEach((element) {
      Map<dynamic, dynamic> map = element[1];
      transitions.add(Transition_(
        _constructState(statesAttributes, element[0],
            statesAttributes[element[0]] ?? {}, size),
        _constructState(statesAttributes, element[2],
            statesAttributes[element[2]] ?? {}, size),
        // loopDirection: map["loop above"]
        //     ? "loop above"
        //     : map["loop below"]
        //         ? "loop below"
        //         : "",
        // bendDirection: map["bend right"]
        //     ? "bend right"
        //     : map["bend left"]
        //         ? "bend left"
        //         : "bend straight",
        transitionStrokeWidth: double.parse(map["stroke width"] ?? "4"),
        transitionStrokeColor: map["stroke color"] ?? Colors.brown,
        labelFirstColor: map["label first color"] ?? Colors.red,
        labelFirstText: element[3]?[0] ?? "",
        labelMiddleColor: map["label middle color"] ?? Colors.blue,
        labelMiddleText: element[3]?[1] ?? "",
        labelLastColor: map["label last color"] ?? Colors.green,
        labelLastText: element[3]?[2] ?? "",
        labelFontSize: double.parse(map["label font size"] ?? "25"),
        // labelPosition: map["below"] ? "below" : "above",
      ));
    });
    return transitions;
  }

  // Transition_ _constructTransition(List<dynamic> result, Size size) {
  //   Map<dynamic, dynamic> map = result[1];

  //   Transition_ transition = Transition_(
  //     result[0],
  //     result[2],
  //     result[3],
  //   );

  //   return transition;
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
