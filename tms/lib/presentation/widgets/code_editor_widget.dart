import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/home_page/home_page_bloc.dart';

class CodeEditorWidget extends StatelessWidget {
  const CodeEditorWidget({Key? key}) : super(key: key);

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
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: const Text("EVEN"),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.white),
                  onPressed: () {},
                  child: const Text("ODD"),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
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
}
