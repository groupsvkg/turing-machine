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
                      child: Container(
                        width: width,
                        height: height,
                      ),
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

    canvas.drawRect(
        Rect.fromLTWH(0, 0, visibleSize.width, visibleSize.height),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 5);
    // TuringMachine tm = _constructTuringMachine(result, visibleSize);
    // tm.draw(canvas, visibleSize);
  }

  TuringMachine _constructTuringMachine(Result<dynamic> result, Size size) {
    TuringMachine tm = TuringMachine([]);
    Tape tape = _constructTape(result, size);
    States states = _constructStates(result, size);
    Transitions transitions = _constructTransitions(result, size);

    tm.add(tape);
    tm.add(states);
    tm.add(transitions);

    Map<String, dynamic> tmAttributes =
        (result.value[2]?[1] ?? {}) as Map<String, dynamic>;
    tm.tmName = result.value[1];
    tm.fill = tmAttributes["fill"] ?? Colors.white;
    tm.distance = double.parse(tmAttributes["distance"] ?? "100");

    return tm;
  }

  Tape _constructTape(Result<dynamic> result, Size size) {
    Tape tape = Tape([], [], []);
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
