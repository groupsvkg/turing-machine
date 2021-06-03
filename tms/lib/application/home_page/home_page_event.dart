part of 'home_page_bloc.dart';

@freezed
abstract class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.initialized(String description) = Initialized;
  const factory HomePageEvent.descriptionChanged(String description) =
      DescriptionChanged;
}
