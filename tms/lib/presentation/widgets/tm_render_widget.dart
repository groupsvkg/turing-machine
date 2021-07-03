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
                  initial: (Initial value) {},
                  description: (Description description) {
                    return InteractiveViewer(
                      constrained: false,
                      child: CustomPaint(painter: TuringMachinePainter()),
                    );
                  }),
            ),
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class TuringMachinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Head head = Head(x: size.width / 2, y: 20, color: Colors.green);
    // head.draw(canvas, size);
    // Cell cell = Cell();
    // cell.draw(canvas, size);
    // State_ state = State_();
    // state.draw(canvas, size);

    Label label = Label();
    label.draw(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
