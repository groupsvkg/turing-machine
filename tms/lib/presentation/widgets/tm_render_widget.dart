import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
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
                    if (description.result.isFailure)
                      return Text(
                        description.result.toString(),
                        style: TextStyle(color: Colors.red),
                      );
                    double width = MediaQuery.of(context).size.width;
                    double height = MediaQuery.of(context).size.height;

                    Map<String, String> tmAttributes = _getAttributeMap(
                        description.result.value[0]?[2]?[1] ?? []);
                    Map<String, String> tapeAttributes = _getAttributeMap(
                        description.result.value[0]?[4]?[0]?[1]?[1] ?? []);

                    print(tmAttributes);
                    print(tapeAttributes);
                    List<String> inputLeft =
                        description.result.value[0]?[4]?[2] ?? [];
                    List<String> inputRight =
                        description.result.value[0]?[4]?[4] ?? [];

                    Component tm =
                        TuringMachine([], name: tmAttributes["name"] ?? "MyTm");
                    Tape tape = Tape(
                      [],
                      inputLeft,
                      inputRight,
                      x: double.parse(
                          tapeAttributes["x"] ?? (width / 4).toString()),
                      y: double.parse(tapeAttributes["y"] ?? "100"),
                      ch: double.parse(tapeAttributes["ch"] ?? "30"),
                      cw: double.parse(tapeAttributes["cw"] ?? "30"),
                      color: HexColor(tapeAttributes["color"] ?? "#FF2196F3"),
                    );
                    if (inputLeft.isNotEmpty || inputRight.isNotEmpty) {
                      tape.add(Head(x: tape.x, y: tape.y - tape.ch - 16));
                      for (var i = (inputLeft.length - 1), j = 1;
                          i >= 0;
                          i--, j++) {
                        tape.add(Cell(
                            x: tape.x - j * tape.cw,
                            y: tape.y,
                            symbol: inputLeft[i]));
                      }

                      for (var i = 1, j = 1; i < inputRight.length; i++, j++) {
                        tape.add(Cell(
                          x: tape.x + j * tape.cw,
                          y: tape.y,
                          symbol: inputRight[i],
                        ));
                      }

                      if (inputRight.length >= 1)
                        tape.add(Cell(
                          x: tape.x,
                          y: tape.y,
                          symbol: inputRight[0],
                          color: Colors.brown,
                          textColor: Colors.green,
                        ));
                    }

                    tm.add(tape);

                    return CustomPaint(
                      painter: TuringMachinePainter(tm),
                    );
                  }),
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
    component.draw(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
