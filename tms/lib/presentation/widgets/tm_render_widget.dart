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

    tape.cellHeight = double.parse(tapeAttributes["cell height"] ?? "35");
    tape.cellWidth = double.parse(tapeAttributes["cell width"] ?? "35");
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
      cellHeight: tape.cellHeight + 5,
      cellWidth: tape.cellWidth,
      cellStrokeWidth: 5,
      cellStrokeColor: Colors.amberAccent,
      cellFillColor: tape.cellFillColor,
      cellSymbol: tape.tapeRightData.isNotEmpty ? tape.tapeRightData[0] : "",
      cellSymbolColor: tape.cellSymbolColor,
      cellSymbolFontSize: tape.cellSymbolFontSize,
    ));

    return tape;
  }

  States _constructStates(Result<dynamic> result, Size size) {
    States states = States([]);
    return states;
  }

  Transitions _constructTransitions(Result<dynamic> result, Size size) {
    Transitions transitions = Transitions([]);
    return transitions;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
