import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tms/application/home_page/home_page_bloc.dart';
import 'package:tms/injection.dart';
import 'package:tms/presentation/widgets/code_editor_widget.dart';
import 'package:tms/presentation/widgets/tm_render_widget.dart';
import 'dart:js' as js;

const _url = "https://github.com/groupsvkg/turing-machine";

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        return getIt<HomePageBloc>()..add(HomePageEvent.homeStarted(''));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Turing Machine Simulator'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                js.context.callMethod('open', [_url]);
              },
              child: const Text('Documentation'),
            ),
            SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                js.context.callMethod('open', [_url]);
              },
              child: const Text('Vedio'),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Row(
          children: [
            CodeEditorWidget(),
            TmRenderWidget(),
          ],
        ),
      ),
    );
  }
}
