import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tms/application/home_page/home_page_bloc.dart';

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
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.map(
                  initial: (Initial value) {},
                  description: (Description description) {
                    return Text(
                      description.description,
                      style: TextStyle(color: Colors.black),
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
