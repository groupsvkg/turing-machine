// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'home_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomePageEventTearOff {
  const _$HomePageEventTearOff();

  HomeStarted homeStarted(String initialTmDescription) {
    return HomeStarted(
      initialTmDescription,
    );
  }

  HomeTmDescriptionChanged homeTmDescriptionChanged(String tmDescription) {
    return HomeTmDescriptionChanged(
      tmDescription,
    );
  }
}

/// @nodoc
const $HomePageEvent = _$HomePageEventTearOff();

/// @nodoc
mixin _$HomePageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String initialTmDescription) homeStarted,
    required TResult Function(String tmDescription) homeTmDescriptionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String initialTmDescription)? homeStarted,
    TResult Function(String tmDescription)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStarted value) homeStarted,
    required TResult Function(HomeTmDescriptionChanged value)
        homeTmDescriptionChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStarted value)? homeStarted,
    TResult Function(HomeTmDescriptionChanged value)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageEventCopyWith<$Res> {
  factory $HomePageEventCopyWith(
          HomePageEvent value, $Res Function(HomePageEvent) then) =
      _$HomePageEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomePageEventCopyWithImpl<$Res>
    implements $HomePageEventCopyWith<$Res> {
  _$HomePageEventCopyWithImpl(this._value, this._then);

  final HomePageEvent _value;
  // ignore: unused_field
  final $Res Function(HomePageEvent) _then;
}

/// @nodoc
abstract class $HomeStartedCopyWith<$Res> {
  factory $HomeStartedCopyWith(
          HomeStarted value, $Res Function(HomeStarted) then) =
      _$HomeStartedCopyWithImpl<$Res>;
  $Res call({String initialTmDescription});
}

/// @nodoc
class _$HomeStartedCopyWithImpl<$Res> extends _$HomePageEventCopyWithImpl<$Res>
    implements $HomeStartedCopyWith<$Res> {
  _$HomeStartedCopyWithImpl(
      HomeStarted _value, $Res Function(HomeStarted) _then)
      : super(_value, (v) => _then(v as HomeStarted));

  @override
  HomeStarted get _value => super._value as HomeStarted;

  @override
  $Res call({
    Object? initialTmDescription = freezed,
  }) {
    return _then(HomeStarted(
      initialTmDescription == freezed
          ? _value.initialTmDescription
          : initialTmDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeStarted with DiagnosticableTreeMixin implements HomeStarted {
  const _$HomeStarted(this.initialTmDescription);

  @override
  final String initialTmDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageEvent.homeStarted(initialTmDescription: $initialTmDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageEvent.homeStarted'))
      ..add(DiagnosticsProperty('initialTmDescription', initialTmDescription));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HomeStarted &&
            (identical(other.initialTmDescription, initialTmDescription) ||
                const DeepCollectionEquality()
                    .equals(other.initialTmDescription, initialTmDescription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(initialTmDescription);

  @JsonKey(ignore: true)
  @override
  $HomeStartedCopyWith<HomeStarted> get copyWith =>
      _$HomeStartedCopyWithImpl<HomeStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String initialTmDescription) homeStarted,
    required TResult Function(String tmDescription) homeTmDescriptionChanged,
  }) {
    return homeStarted(initialTmDescription);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String initialTmDescription)? homeStarted,
    TResult Function(String tmDescription)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) {
    if (homeStarted != null) {
      return homeStarted(initialTmDescription);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStarted value) homeStarted,
    required TResult Function(HomeTmDescriptionChanged value)
        homeTmDescriptionChanged,
  }) {
    return homeStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStarted value)? homeStarted,
    TResult Function(HomeTmDescriptionChanged value)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) {
    if (homeStarted != null) {
      return homeStarted(this);
    }
    return orElse();
  }
}

abstract class HomeStarted implements HomePageEvent {
  const factory HomeStarted(String initialTmDescription) = _$HomeStarted;

  String get initialTmDescription => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeStartedCopyWith<HomeStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeTmDescriptionChangedCopyWith<$Res> {
  factory $HomeTmDescriptionChangedCopyWith(HomeTmDescriptionChanged value,
          $Res Function(HomeTmDescriptionChanged) then) =
      _$HomeTmDescriptionChangedCopyWithImpl<$Res>;
  $Res call({String tmDescription});
}

/// @nodoc
class _$HomeTmDescriptionChangedCopyWithImpl<$Res>
    extends _$HomePageEventCopyWithImpl<$Res>
    implements $HomeTmDescriptionChangedCopyWith<$Res> {
  _$HomeTmDescriptionChangedCopyWithImpl(HomeTmDescriptionChanged _value,
      $Res Function(HomeTmDescriptionChanged) _then)
      : super(_value, (v) => _then(v as HomeTmDescriptionChanged));

  @override
  HomeTmDescriptionChanged get _value =>
      super._value as HomeTmDescriptionChanged;

  @override
  $Res call({
    Object? tmDescription = freezed,
  }) {
    return _then(HomeTmDescriptionChanged(
      tmDescription == freezed
          ? _value.tmDescription
          : tmDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeTmDescriptionChanged
    with DiagnosticableTreeMixin
    implements HomeTmDescriptionChanged {
  const _$HomeTmDescriptionChanged(this.tmDescription);

  @override
  final String tmDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageEvent.homeTmDescriptionChanged(tmDescription: $tmDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'HomePageEvent.homeTmDescriptionChanged'))
      ..add(DiagnosticsProperty('tmDescription', tmDescription));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HomeTmDescriptionChanged &&
            (identical(other.tmDescription, tmDescription) ||
                const DeepCollectionEquality()
                    .equals(other.tmDescription, tmDescription)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tmDescription);

  @JsonKey(ignore: true)
  @override
  $HomeTmDescriptionChangedCopyWith<HomeTmDescriptionChanged> get copyWith =>
      _$HomeTmDescriptionChangedCopyWithImpl<HomeTmDescriptionChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String initialTmDescription) homeStarted,
    required TResult Function(String tmDescription) homeTmDescriptionChanged,
  }) {
    return homeTmDescriptionChanged(tmDescription);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String initialTmDescription)? homeStarted,
    TResult Function(String tmDescription)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) {
    if (homeTmDescriptionChanged != null) {
      return homeTmDescriptionChanged(tmDescription);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeStarted value) homeStarted,
    required TResult Function(HomeTmDescriptionChanged value)
        homeTmDescriptionChanged,
  }) {
    return homeTmDescriptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeStarted value)? homeStarted,
    TResult Function(HomeTmDescriptionChanged value)? homeTmDescriptionChanged,
    required TResult orElse(),
  }) {
    if (homeTmDescriptionChanged != null) {
      return homeTmDescriptionChanged(this);
    }
    return orElse();
  }
}

abstract class HomeTmDescriptionChanged implements HomePageEvent {
  const factory HomeTmDescriptionChanged(String tmDescription) =
      _$HomeTmDescriptionChanged;

  String get tmDescription => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeTmDescriptionChangedCopyWith<HomeTmDescriptionChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$HomePageStateTearOff {
  const _$HomePageStateTearOff();

  HomeInitial homeInitial() {
    return const HomeInitial();
  }

  HomeParseSuccess homeParseSuccess(Result<dynamic> result) {
    return HomeParseSuccess(
      result,
    );
  }

  HomeParseFailure homeParseFailure(String errorMessage) {
    return HomeParseFailure(
      errorMessage,
    );
  }
}

/// @nodoc
const $HomePageState = _$HomePageStateTearOff();

/// @nodoc
mixin _$HomePageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeInitial,
    required TResult Function(Result<dynamic> result) homeParseSuccess,
    required TResult Function(String errorMessage) homeParseFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeInitial,
    TResult Function(Result<dynamic> result)? homeParseSuccess,
    TResult Function(String errorMessage)? homeParseFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeInitial value) homeInitial,
    required TResult Function(HomeParseSuccess value) homeParseSuccess,
    required TResult Function(HomeParseFailure value) homeParseFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeInitial value)? homeInitial,
    TResult Function(HomeParseSuccess value)? homeParseSuccess,
    TResult Function(HomeParseFailure value)? homeParseFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  final HomePageState _value;
  // ignore: unused_field
  final $Res Function(HomePageState) _then;
}

/// @nodoc
abstract class $HomeInitialCopyWith<$Res> {
  factory $HomeInitialCopyWith(
          HomeInitial value, $Res Function(HomeInitial) then) =
      _$HomeInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomeInitialCopyWithImpl<$Res> extends _$HomePageStateCopyWithImpl<$Res>
    implements $HomeInitialCopyWith<$Res> {
  _$HomeInitialCopyWithImpl(
      HomeInitial _value, $Res Function(HomeInitial) _then)
      : super(_value, (v) => _then(v as HomeInitial));

  @override
  HomeInitial get _value => super._value as HomeInitial;
}

/// @nodoc

class _$HomeInitial with DiagnosticableTreeMixin implements HomeInitial {
  const _$HomeInitial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.homeInitial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'HomePageState.homeInitial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is HomeInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeInitial,
    required TResult Function(Result<dynamic> result) homeParseSuccess,
    required TResult Function(String errorMessage) homeParseFailure,
  }) {
    return homeInitial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeInitial,
    TResult Function(Result<dynamic> result)? homeParseSuccess,
    TResult Function(String errorMessage)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeInitial != null) {
      return homeInitial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeInitial value) homeInitial,
    required TResult Function(HomeParseSuccess value) homeParseSuccess,
    required TResult Function(HomeParseFailure value) homeParseFailure,
  }) {
    return homeInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeInitial value)? homeInitial,
    TResult Function(HomeParseSuccess value)? homeParseSuccess,
    TResult Function(HomeParseFailure value)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeInitial != null) {
      return homeInitial(this);
    }
    return orElse();
  }
}

abstract class HomeInitial implements HomePageState {
  const factory HomeInitial() = _$HomeInitial;
}

/// @nodoc
abstract class $HomeParseSuccessCopyWith<$Res> {
  factory $HomeParseSuccessCopyWith(
          HomeParseSuccess value, $Res Function(HomeParseSuccess) then) =
      _$HomeParseSuccessCopyWithImpl<$Res>;
  $Res call({Result<dynamic> result});
}

/// @nodoc
class _$HomeParseSuccessCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res>
    implements $HomeParseSuccessCopyWith<$Res> {
  _$HomeParseSuccessCopyWithImpl(
      HomeParseSuccess _value, $Res Function(HomeParseSuccess) _then)
      : super(_value, (v) => _then(v as HomeParseSuccess));

  @override
  HomeParseSuccess get _value => super._value as HomeParseSuccess;

  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(HomeParseSuccess(
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result<dynamic>,
    ));
  }
}

/// @nodoc

class _$HomeParseSuccess
    with DiagnosticableTreeMixin
    implements HomeParseSuccess {
  const _$HomeParseSuccess(this.result);

  @override
  final Result<dynamic> result;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.homeParseSuccess(result: $result)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState.homeParseSuccess'))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HomeParseSuccess &&
            (identical(other.result, result) ||
                const DeepCollectionEquality().equals(other.result, result)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(result);

  @JsonKey(ignore: true)
  @override
  $HomeParseSuccessCopyWith<HomeParseSuccess> get copyWith =>
      _$HomeParseSuccessCopyWithImpl<HomeParseSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeInitial,
    required TResult Function(Result<dynamic> result) homeParseSuccess,
    required TResult Function(String errorMessage) homeParseFailure,
  }) {
    return homeParseSuccess(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeInitial,
    TResult Function(Result<dynamic> result)? homeParseSuccess,
    TResult Function(String errorMessage)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeParseSuccess != null) {
      return homeParseSuccess(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeInitial value) homeInitial,
    required TResult Function(HomeParseSuccess value) homeParseSuccess,
    required TResult Function(HomeParseFailure value) homeParseFailure,
  }) {
    return homeParseSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeInitial value)? homeInitial,
    TResult Function(HomeParseSuccess value)? homeParseSuccess,
    TResult Function(HomeParseFailure value)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeParseSuccess != null) {
      return homeParseSuccess(this);
    }
    return orElse();
  }
}

abstract class HomeParseSuccess implements HomePageState {
  const factory HomeParseSuccess(Result<dynamic> result) = _$HomeParseSuccess;

  Result<dynamic> get result => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeParseSuccessCopyWith<HomeParseSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeParseFailureCopyWith<$Res> {
  factory $HomeParseFailureCopyWith(
          HomeParseFailure value, $Res Function(HomeParseFailure) then) =
      _$HomeParseFailureCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class _$HomeParseFailureCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res>
    implements $HomeParseFailureCopyWith<$Res> {
  _$HomeParseFailureCopyWithImpl(
      HomeParseFailure _value, $Res Function(HomeParseFailure) _then)
      : super(_value, (v) => _then(v as HomeParseFailure));

  @override
  HomeParseFailure get _value => super._value as HomeParseFailure;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(HomeParseFailure(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeParseFailure
    with DiagnosticableTreeMixin
    implements HomeParseFailure {
  const _$HomeParseFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState.homeParseFailure(errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState.homeParseFailure'))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HomeParseFailure &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorMessage);

  @JsonKey(ignore: true)
  @override
  $HomeParseFailureCopyWith<HomeParseFailure> get copyWith =>
      _$HomeParseFailureCopyWithImpl<HomeParseFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() homeInitial,
    required TResult Function(Result<dynamic> result) homeParseSuccess,
    required TResult Function(String errorMessage) homeParseFailure,
  }) {
    return homeParseFailure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? homeInitial,
    TResult Function(Result<dynamic> result)? homeParseSuccess,
    TResult Function(String errorMessage)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeParseFailure != null) {
      return homeParseFailure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeInitial value) homeInitial,
    required TResult Function(HomeParseSuccess value) homeParseSuccess,
    required TResult Function(HomeParseFailure value) homeParseFailure,
  }) {
    return homeParseFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeInitial value)? homeInitial,
    TResult Function(HomeParseSuccess value)? homeParseSuccess,
    TResult Function(HomeParseFailure value)? homeParseFailure,
    required TResult orElse(),
  }) {
    if (homeParseFailure != null) {
      return homeParseFailure(this);
    }
    return orElse();
  }
}

abstract class HomeParseFailure implements HomePageState {
  const factory HomeParseFailure(String errorMessage) = _$HomeParseFailure;

  String get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeParseFailureCopyWith<HomeParseFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
