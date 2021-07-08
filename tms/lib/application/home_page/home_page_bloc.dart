import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:petitparser/petitparser.dart';
import 'package:tms/domain/turing_machine.dart';

import '../grammar/turing_machine_parser.dart';

part 'home_page_bloc.freezed.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  TuringMachineParser tmp = TuringMachineParser();
  Parser tmParser;

  HomePageBloc(this.tmParser) : super(const HomePageState.homeInitial());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    yield event.map(
      homeStarted: (HomeStarted homeStarted) {
        tmParser = tmp.build();
        return HomePageState.homeInitial();
      },
      homeTmDescriptionChanged:
          (HomeTmDescriptionChanged homeTmDescriptionChanged) {
        String tmDescription = homeTmDescriptionChanged.tmDescription;
        return HomePageState.homeInitial();
      },
    );
  }

  @override
  Stream<Transition<HomePageEvent, HomePageState>> transformEvents(
      Stream<HomePageEvent> events,
      TransitionFunction<HomePageEvent, HomePageState> transitionFn) {
    return events.debounceTime(Duration(seconds: 3)).switchMap(transitionFn);
  }
}
