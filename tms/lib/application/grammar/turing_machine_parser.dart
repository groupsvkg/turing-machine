import 'package:petitparser/petitparser.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';

class TuringMachineParser extends TuringMachineGrammar {
  Parser tmName() => super.tmName().flatten();

  // Tape
  Parser tapeData() => super.tapeData().flatten();

  // State
  Parser stateName() => super.stateName().flatten();

  // Transition
  Parser source() => super.source().flatten();
  Parser destination() => super.destination().flatten();
  Parser labelFirst() => super.labelFirst().flatten();
  Parser labelMiddle() => super.labelMiddle().flatten();
  Parser labelLast() => super.labelLast().flatten();

  // Attributes
  Parser key() => super.key().flatten();
  Parser value() => super.value().flatten();
}
