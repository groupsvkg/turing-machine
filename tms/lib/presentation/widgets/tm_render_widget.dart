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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: state.map(
                homeInitial: (HomeInitial homeInitial) {},
                homeParseSuccess: (HomeParseSuccess homeParseSuccess) {
                  final Result<dynamic> result = homeParseSuccess.result;

                  TuringMachine tm = TuringMachine([]);

                  // return Text(
                  //   result.toString(),
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  // );

                  return CustomPaint(
                    painter: TuringMachinePainter(tm),
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

  TuringMachinePainter(this.tm);

  @override
  void paint(Canvas canvas, Size size) {
    // tm.distance = double.parse(tmp.tmAttributeMap["distance"] ?? "3");
    // tm.fill = tmp.tmAttributeMap["fill"] ?? Colors.black;
    // Tape tape = Tape([], [], []);
    // tm.draw(canvas);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width / 2, size.height / 2),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 5);
  }

  // Tape _constructTape(TuringMachineParser tmp) {
  //   List<String> tapeDataLeft = tmp.tapeDataLeft;
  //   List<String> tapeDataRight = tmp.tapeDataRight;

  //   Tape tape = Tape([], [], []);

  //   return tape;
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
