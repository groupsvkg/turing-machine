import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.map(
                homeInitial: (HomeInitial homeInitial) {},
                homeParseSuccess: (HomeParseSuccess homeParseSuccess) {
                  TuringMachineParser tmp =
                      homeParseSuccess.turingMachineParser;
                  TuringMachine tm = TuringMachine([]);

                  return CustomPaint(
                    painter: TuringMachinePainter(tm, tmp),
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
        );
      },
    );
  }
}

class TuringMachinePainter extends CustomPainter {
  final TuringMachine tm;
  final TuringMachineParser tmp;

  TuringMachinePainter(this.tm, this.tmp);

  @override
  void paint(Canvas canvas, Size size) {
    tm.distance = double.parse(tmp.tmAttributeMap["distance"] ?? "3");
    tm.fill = tmp.tmAttributeMap["fill"] ?? Colors.black;
    Tape tape = Tape([], [], []);
    // tm.draw(canvas);
  }

  Tape _constructTape(TuringMachineParser tmp) {
    List<String> tapeDataLeft = tmp.tapeDataLeft;
    List<String> tapeDataRight = tmp.tapeDataRight;

    Tape tape = Tape([], [], []);

    return tape;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
