import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turing Machine Simulator'),
      ),
      body: Row(
        children: [
          Expanded(
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
                        icon: Icon(Icons.airplanemode_on_sharp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.access_alarm_sharp),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 44,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter text description of Turing Machine",
                      fillColor: Colors.black,
                      filled: true,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
