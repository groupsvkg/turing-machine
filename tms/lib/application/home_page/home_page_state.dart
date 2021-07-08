part of 'home_page_bloc.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState.homeInitial() = HomeInitial;
  const factory HomePageState.homeParseSuccess(TuringMachine turingMachine) =
      HomeParseSuccess;
  const factory HomePageState.homeParseFailure(String errorMessage) =
      HomeParseFailure;
}
