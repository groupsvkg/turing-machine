import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  TuringMachine tm = homeParseSuccess.turingMachine;
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

  Map<String, String> _getAttributeMap(List list) {
    Map<String, String> map = {};
    for (var item in list) {
      map.putIfAbsent(item[0], () => item[2]);
    }
    return map;
  }
}

class TuringMachinePainter extends CustomPainter {
  final Component component;

  TuringMachinePainter(this.component);

  @override
  void paint(Canvas canvas, Size size) {
    // Head head = Head(x: size.width / 2, y: 20, color: Colors.green);
    // head.draw(canvas, size);
    // Cell cell = Cell();
    // cell.draw(canvas, size);
    // State_ state = State_();
    // state.draw(canvas, size);

    // Label label = Label();
    // label.draw(canvas, size);
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 5,
    //     Paint()..color = Colors.blue);
    // canvas.drawLine(Offset(size.width / 2, size.height / 2),
    //     Offset(size.width / 2, 0), Paint()..color = Colors.red);
    component.draw(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
