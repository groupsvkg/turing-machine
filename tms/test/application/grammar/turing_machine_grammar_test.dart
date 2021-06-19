import 'package:flutter_test/flutter_test.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';

/**
 * Example:
 * tm <tmName> [att_list] {
 *    tape[att_list]  : --|abba--;
 *    state[att_list] : q1;
 *    state[att_list] : q2;
 *    q1 -[att_list]-> q2 : label;
 *  }
 */

main() {
  group("Tape", () {
    test(" - with optional keyword", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
        tm MyTm {
          tape[key, newKey = value] : --ab|bba--;
        }
      ''';
      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test(" - with optional keyword and subkey", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
        tm MyTm {
          tape[key, newKey subkey = value] : --ab|bba--;
        }
      ''';
      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test(" - without optional keyword", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
        tm MyTm {
          --ab|bba--;
        }
      ''';
      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test(" - head at start", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
        tm MyTm {
          --|abbba--;
        }
      ''';
      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test(" - head at end", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
        tm MyTm {
          --abbba|--;
        }
      ''';
      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });

  test("Empty description is allowed", () {
    // Arrange
    final tmg = TuringMachineGrammar().build();
    String input = '''
      tm MyTm {
        
      }
    ''';

    // Act
    final result = tmg.parse(input);

    // Assert
    expect(result.isSuccess, isTrue);
  });

  test("Single tape with no optional attributes", () {
    // Arrange
    final tmg = TuringMachineGrammar().build();
    String input = '''
      tm MyTm {
        --|abba--;
      }
    ''';

    // Act
    final result = tmg.parse(input);

    // Assert
    expect(result.isSuccess, isTrue);
  });

  test("Single tape with turing machine optional attributes", () {
    // Arrange
    final tmg = TuringMachineGrammar().build();
    String input = '''
      tm MyTm[  key =  123  , nextKey    = xyz] {
        --|abba--;
      }
    ''';

    // Act
    final result = tmg.parse(input);

    // Assert
    expect(result.isSuccess, isTrue);
  });

  test("Single tape with optional attributes", () {
    // Arrange
    final tmg = TuringMachineGrammar().build();
    String input = '''
      tm MyTm [key=val1] {
        tape[key=val2] : --|abba--;
      }
    ''';

    // Act
    final result = tmg.parse(input);

    // Assert
    expect(result.isSuccess, isTrue);
  });

  test("Full description", () {
    // Arrange
    final tmg = TuringMachineGrammar().build();
    String input = '''
      tm MyTm [ key = val1, nextKey = val2, testKey] {
        tape [ key = val1, nextKey = val2 ] : --|abba--;
        state [ key = val1, nextKey = val2 ] : s1;
        state [ key = val1, nextKey = val2 ] : s2;
        s1 -[ key = val1, nextKey = val2 ]-> s2 : a, b, L;
        s1 -[ key = val1, nextKey = val2 ]-> s2 : c,d,R;
      }
    ''';

    // Act
    final result = tmg.parse(input);

    // Assert
    expect(result.isSuccess, isTrue);
  });
}
