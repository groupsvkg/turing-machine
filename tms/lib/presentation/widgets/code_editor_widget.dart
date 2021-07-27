import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/home_page/home_page_bloc.dart';

const String complex = """
tm M {
  tape : --|0000--;

  state[ x=300, y=390, initial ] : q1;
  state[ below of=q1, rejecting ] : qr;
  state[ right of=q1 ] : q2;
  state[ below of=q2, accepting ] : qa;
  state[ right of=q2, distance=300 ] : q3;
  state[ above right of=q2 ] : q5;
  state[ below of=q3 ] : q4;

  q1 -[ bend right ]-> qr : e, e, R;
  q1 -[ bend left ]-> qr : x, x, R;
  q1 --> q2 : 0, e, R;

  q2 --> qa : e, e, R;
  q2 --> q2 : x, x, R;
  q2 --> q3 : 0, x, R;

  q3 --> q3 : x, x, R;
  q3 --> q5 : e, e, L;
  q3 -[ bend right ]-> q4 : 0, 0, R;

  q4 -[ loop right ]-> q4 : x, x, R;
  q4 -[ bend right ]-> q3 : 0, x, R;
  q4 -[ bend left ]-> qr : e, e, R;

  q5 --> q5 : 0, 0, L;
  q5 -[ loop right ]-> q5 : x, x, L;
  q5 --> q2 : e, e, R;
}
""";

const String play = """
tm M {
  tape : --|0000--;

  state[ x=300, y=390, initial ] : q1;
  state[ below of=q1, rejecting ] : qr;
  state[ right of=q1 ] : q2;
  state[ below of=q2, accepting ] : qa;
  state[ right of=q2, distance=300 ] : q3;
  state[ above right of=q2 ] : q5;
  state[ below of=q3 ] : q4;

  q1 -[ bend right ]-> qr : e, e, R;
  q1 -[ bend left ]-> qr : x, x, R;
  q1 --> q2 : 0, e, R;

  q2 --> qa : e, e, R;
  q2 --> q2 : x, x, R;
  q2 --> q3: 0, x, R;

  q3 --> q3 : x, x, R;
  q3 --> q5 : e, e, L;
  q3 -[ bend right ]-> q4 : 0, 0, R;

  q4 -[ loop right ]-> q4 : x, x, R;
  q4 -[ bend right ]-> q3 : 0, x, R;
  q4 -[ bend left ]-> qr : e, e, R;

  q5 --> q5 : 0, 0, L;
  q5 -[ loop right ]-> q5 : x, x, L;
  q5 --> q2 : e, e, R;
}

play color=#blue;
""";

const String min = """
tm M {

}
""";

const String tape = """
tm M {
  --aa|bbba--;
}
""";

const String state = """
tm M {
  --aab|baa--;
  
  state : s1;
}
""";

const String transition = """
tm M {
  --aab|baa--;
  
  state : s1;
  state[ right of=s1 ] : s2;

  s1 -> s2 : a,b,R;
}
""";

class CodeEditorWidget extends StatefulWidget {
  const CodeEditorWidget({Key? key}) : super(key: key);

  @override
  _CodeEditorWidgetState createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Divider(
            color: Colors.white,
            height: 1,
          ),
          Material(
            elevation: 5,
            color: Colors.deepPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    controller.text = "";
                  },
                  icon: Icon(Icons.refresh),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = min;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(min));
                  },
                  child: const Text("MINIMUM"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = tape;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(tape));
                  },
                  child: const Text("TAPE"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = state;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(state));
                  },
                  child: const Text("STATE"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = transition;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(transition));
                  },
                  child: const Text("TRANSITION"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = complex;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(complex));
                  },
                  child: const Text("COMPLEX"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    controller.text = play;
                    BlocProvider.of<HomePageBloc>(context)
                      ..add(HomePageEvent.homeTmDescriptionChanged(play));
                  },
                  child: const Text("PLAY"),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 100,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter text description of Turing Machine",
                fillColor: Colors.black,
                filled: true,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (tmDescription) {
                BlocProvider.of<HomePageBloc>(context)
                  ..add(HomePageEvent.homeTmDescriptionChanged(tmDescription));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
