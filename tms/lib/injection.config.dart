// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:petitparser/petitparser.dart' as _i4;

import 'application/grammar/turing_machine_grammar.dart' as _i6;
import 'application/grammar/turing_machine_grammar_1.dart' as _i5;
import 'application/home_page/home_page_bloc.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.HomePageBloc>(
      () => _i3.HomePageBloc(get<_i4.Parser<dynamic>>()));
  gh.factory<_i5.TuringMachineGrammar>(() => _i5.TuringMachineGrammar());
  gh.factory<_i6.TuringMachineGrammar>(() => _i6.TuringMachineGrammar());
  return get;
}
