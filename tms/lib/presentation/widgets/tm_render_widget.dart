import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/application/home_page/home_page_bloc.dart';
import 'package:tms/domain/turing_machine.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class TmRenderSlWidget extends StatelessWidget {
  const TmRenderSlWidget({Key? key}) : super(key: key);

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
            boundaryMargin: EdgeInsets.all(double.infinity),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: state.map(
                homeInitial: (HomeInitial homeInitial) {},
                homeParseSuccess: (HomeParseSuccess homeParseSuccess) {
                  TuringMachine tm = _constructTuringMachine(
                    homeParseSuccess.result.map((element) => element[0]),
                    Size(MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height),
                  );

                  Tape tape = tm.components[0] as Tape;
                  States states = tm.components[1] as States;
                  Transitions transitions = tm.components[2] as Transitions;
                  List<Command> commands = _constructCommands(
                    tm,
                    tape,
                    states,
                    transitions,
                    homeParseSuccess.result.map((element) => element[1]),
                    Size(MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height),
                  );

                  if (commands.isEmpty)
                    return RepaintBoundary(
                      child: CustomPaint(
                        size: Size(double.infinity, double.infinity),
                        painter: SimpleTmPainter(tm),
                      ),
                    );
                  else
                    return TmRenderWidget(tm, commands);
                },
                homeParseFailure: (HomeParseFailure homeParseFailure) {
                  return ColoredBox(color: Colors.red[300]!);
                },
              ),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  List<Command> _constructCommands(
    TuringMachine tm,
    Tape tape,
    States states,
    Transitions transitions,
    Result<dynamic> result,
    Size size,
  ) {
    List<Command> commands = [];

    Map<dynamic, dynamic> playAttributes = result.value[0]?[1] ?? {};
    if (playAttributes.entries.length > 0) {
      Command playCommand = PlayCommand(tm, tape, states, transitions)
        ..color = playAttributes["color"] ?? Colors.blue
        ..duration = int.parse(playAttributes["duration"] ?? "5")
        ..from = int.parse(playAttributes["from"] ?? "0")
        ..to = int.parse(playAttributes["to"] ?? "-1")
        ..max = int.parse(playAttributes["max"] ?? "100");
      commands.add(playCommand);
    }

    Map<dynamic, dynamic> showAttributes = result.value[1]?[1] ?? {};
    if (showAttributes.entries.length > 0) {
      Command showCommand = ShowCommand(Tape, tape, states, transitions)
        ..color = showAttributes["color"] ?? Colors.blue
        ..duration = int.parse(showAttributes["duration"] ?? "5")
        ..from = int.parse(showAttributes["from"] ?? "0")
        ..to = int.parse(showAttributes["to"] ?? "-1");
      commands.add(showCommand);
    }

    return commands;
  }

  TuringMachine _constructTuringMachine(Result<dynamic> result, Size size) {
    TuringMachine tm = TuringMachine([]);
    Tape tape = _constructTape(result, size);
    States states = _constructStates(result, size);
    Transitions transitions = _constructTransitions(states, result, size);

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
      stateStrokeWidth: double.parse(map["stroke width"] ?? "6"),
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

    return state;
  }

  Transitions _constructTransitions(
      States states, Result<dynamic> result, Size size) {
    Transitions transitions = Transitions([]);
    List<dynamic> transitionsAttributes = result.value[6];

    transitionsAttributes.forEach((element) {
      Map<dynamic, dynamic> map = element[1];
      transitions.add(Transition_(
        _getStateByName(states, element[0]),
        _getStateByName(states, element[2]),
        loopDirection: map.containsKey("loop above left")
            ? "loop above left"
            : map.containsKey("loop above right")
                ? "loop above right"
                : map.containsKey("loop below left")
                    ? "loop below left"
                    : map.containsKey("loop below right")
                        ? "loop below right"
                        : map.containsKey("loop above")
                            ? "loop above"
                            : map.containsKey("loop below")
                                ? "loop below"
                                : map.containsKey("loop left")
                                    ? "loop left"
                                    : map.containsKey("loop right")
                                        ? "loop right"
                                        : "loop above",
        loopDistance: map.containsKey("loop distance")
            ? double.parse(map["loop distance"])
            : 70,
        bendDirection: map["bend right"] ?? false
            ? "bend right"
            : map["bend left"] ?? false
                ? "bend left"
                : "bend straight",
        transitionStrokeWidth: double.parse(map["stroke width"] ?? "3"),
        transitionStrokeColor: map["stroke color"] ?? Colors.brown,
        labelFirstColor: map["label first color"] ?? Colors.red,
        labelFirstText: element[3]?[0] ?? "",
        labelMiddleColor: map["label middle color"] ?? Colors.blue,
        labelMiddleText: element[3]?[1] ?? "",
        labelLastColor: map["label last color"] ?? Colors.green,
        labelLastText: element[3]?[2] ?? "",
        labelFontSize: double.parse(map["label font size"] ?? "25"),
        labelPosition: map.containsKey("below") ? "below" : "above",
        deviationAngle: map.containsKey("deviation")
            ? double.parse(map["deviation"]) * pi / 180
            : pi / 5,
      ));
    });
    return transitions;
  }

  State_ _getStateByName(States states, String stateName) {
    for (var s in states.components) {
      if ((s as State_).symbol == stateName) return s;
    }
    return State_();
  }
}

class TmRenderWidget extends StatefulWidget {
  final TuringMachine tm;
  final List<Command> commands;

  TmRenderWidget(this.tm, this.commands, {Key? key}) : super(key: key);

  @override
  _TmRenderWidgetState createState() => _TmRenderWidgetState();
}

class _TmRenderWidgetState extends State<TmRenderWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation;
  late Animation<double> animation;
  late int duration = 5;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: widget.commands[0].duration),
      vsync: this,
    );
    colorAnimation = ColorTween(
      begin: Colors.brown,
      end: widget.commands.isNotEmpty ? widget.commands[0].color : Colors.green,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));
    colorAnimation.addListener(() {
      setState(() {});
    });

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));
    animation.addListener(() {
      setState(() {});
    });
    if (widget.commands.isNotEmpty) controller.forward();
  }

  @override
  void didUpdateWidget(covariant TmRenderWidget oldWidget) {
    controller.stop();
    controller = AnimationController(
      duration: Duration(seconds: widget.commands[0].duration),
      vsync: this,
    );
    colorAnimation = ColorTween(
      begin: Colors.brown,
      end: widget.commands.isNotEmpty ? widget.commands[0].color : Colors.green,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));
    colorAnimation.addListener(() {
      setState(() {});
    });

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    ));
    animation.addListener(() {
      setState(() {});
    });
    if (widget.commands.isNotEmpty) controller.forward();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 3.0;
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: TuringMachinePainter(
          widget.tm,
          widget.commands,
          colorAnimation,
          animation,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class TuringMachinePainter extends CustomPainter {
  final TuringMachine tm;
  final List<Command> commands;
  final Animation<Color?> colorAnimation;
  final Animation<double> animation;

  TuringMachinePainter(
    this.tm,
    this.commands,
    this.colorAnimation,
    this.animation,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Size visibleSize = Size(size.width / 2, size.height);

    tm.draw(canvas, visibleSize);

    for (Command command in commands) {
      canvas.save();
      canvas.drawRect(Rect.largest, Paint()..blendMode = BlendMode.clear);
      canvas.restore();
      if (command is PlayCommand) {
        // command.color = colorAnimation.value;
        command.value = animation.value;
        command.execute(canvas, visibleSize);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return commands.isNotEmpty;
  }
}

class SimpleTmPainter extends CustomPainter {
  final TuringMachine tm;

  SimpleTmPainter(this.tm);

  @override
  void paint(Canvas canvas, Size size) {
    Size visibleSize = Size(size.width / 2, size.height);
    tm.draw(canvas, visibleSize);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
