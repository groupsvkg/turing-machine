import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:petitparser/petitparser.dart';

import '../grammar/turing_machine_parser.dart';

part 'home_page_bloc.freezed.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  Parser tmParser = TuringMachineParser().build();

  HomePageBloc() : super(const HomePageState.homeInitial());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    yield event.map(
      homeStarted: (HomeStarted homeStarted) {
        return HomePageState.homeInitial();
      },
      homeTmDescriptionChanged:
          (HomeTmDescriptionChanged homeTmDescriptionChanged) {
        String tmDescription = homeTmDescriptionChanged.tmDescription;
        Result<dynamic> result = tmParser.parse(tmDescription);

        if (result.isSuccess)
          return HomePageState.homeParseSuccess(result);
        else
          return HomePageState.homeParseFailure(result.message);
      },
    );
  }

  // @override
  // Stream<Transition<HomePageEvent, HomePageState>> transformEvents(
  //     Stream<HomePageEvent> events,
  //     TransitionFunction<HomePageEvent, HomePageState> transitionFn) {
  //   return events.debounceTime(Duration(seconds: 1)).switchMap(transitionFn);
  // }
}
