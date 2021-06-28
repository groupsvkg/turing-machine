import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:petitparser/petitparser.dart';
import '../grammar/turing_machine_parser.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

part 'home_page_bloc.freezed.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  Parser parser = TuringMachineParser().build();

  HomePageBloc() : super(const HomePageState.initial());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    yield event.map(
      initialized: (Initialized initialValue) {
        return HomePageState.initial();
      },
      descriptionChanged: (DescriptionChanged description) {
        // if (description.description == "")
        //   return HomePageState.description(description.description);

        return HomePageState.description(parser.parse(description.description));
      },
    );
  }
}
