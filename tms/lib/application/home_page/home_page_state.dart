part of 'home_page_bloc.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState.initial() = Initial;
  const factory HomePageState.description(String description) = Description;
}
