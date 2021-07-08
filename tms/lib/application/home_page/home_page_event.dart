part of 'home_page_bloc.dart';

@freezed
abstract class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.homeStarted(String initialTmDescription) =
      HomeStarted;
  const factory HomePageEvent.homeTmDescriptionChanged(String tmDescription) =
      HomeTmDescriptionChanged;
}
