import 'package:flutter_test/flutter_test.dart';
import 'package:tms/application/grammar/turing_machine_parser.dart';

/**
 * Example:
 * [
 *   Token[1:9]: tm, // tmToken
 *   MyTm, // tmName
 *   [Token[1:16]: [, [key, [Token[1:20]: =, val1]], [[Token[1:25]: ,, [nextKey, [Token[1:34]: =, val2]]]], Token[1:39]: ]], // tmAttributes
 *   Token[1:41]: {,  // leftBrace
 *   [ // statements
 *     [ // tape
 *       [Token[2:11]: tape, [Token[2:15]: [, [key, [Token[2:19]: =, val1]], [[Token[2:24]: ,, [nextKey, [Token[2:33]: =, val2]]]], Token[2:38]: ]], Token[2:40]: :], 
 *       --abb|caa--, 
 *       Token[2:53]: ;
 *     ], 
 *     [], 
 *     []
 *   ], 
 *   Token[3:9]: } // rightBrace
 * ]
 */
main() {
  group("General", () {
    test("- empty body and no optional attribute", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm MyTm {

        }
      ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
  group("Tm Name", () {
    test('- flatten without space', () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm MyTm[key=val1, nextkey=val2] {

        }
      ''';

      // Act
      final result = parser.parse(input);

      // Assert
      expect(result.value[1], "MyTm");
    });

    test('- flatten with space', () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm   MyTm   [key=val1, nextkey=val2] {

        }
      ''';

      // Act
      final result = parser.parse(input);

      // Assert
      expect(result.value[1], "MyTm");
    });
  });

  group("Tape Data", () {
    test("- valid tape data with optional tape attribute", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm MyTm[key=val1, nextKey=val2] {
          tape[key=val1, nextKey=val2] : --abb|caa--;
        }
      ''';

      // Act
      final result = parser.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("- valid tape data without optional tape attribute", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm MyTm[key=val1, nextKey=val2] {
          --abb|caa--;
        }
      ''';

      // Act
      final result = parser.parse(input);
      // print(result);
      // print("Tape Data: " + result.value[4][0][1]);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });

  group("State", () {
    test("- valid state", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm MyTm[key=val1, nextKey=val2] {
          state[key=val1, nextKey=val2] : s1;
        }
      ''';

      // Act
      final result = parser.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("- without optional state attribute", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm MyTm[key=val1, nextKey=val2] {
          state : s1;
        }
      ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
}
