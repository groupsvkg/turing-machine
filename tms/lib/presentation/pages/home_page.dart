import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tms/application/home_page/home_page_bloc.dart';
import 'package:tms/injection.dart';
import 'package:tms/presentation/widgets/code_editor_widget.dart';
import 'package:tms/presentation/widgets/tm_render_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          getIt<HomePageBloc>()..add(HomePageEvent.initialized('')),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Turing Machine Simulator'),
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
