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
  group("Parser:", () {
    test("Full Turing Machine description", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
      tm  MyTm [ #red, rows=555, cols=999, distance=88] {
        tape [ x=3, y=4, ch=6, cw=7, stroke width=89, bold, dotted, dashed, #0123Ff ] : --|abba--;
        state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
          ##blue, initial, initial below, accepting] : s1;
        state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
          ##blue, initial, initial below, accepting, above right of=s1] : s2;
        s1 -[ stroke width=5, bold, dotted, dashed, #green, ##red, bend, bend right, 
          loop, loop above ]-> s2 : a, b, L;
      }
    ''';

      // Act
      final result = parser.parse(input);
      // print(result.map((element) => element[0]));
      // print(result.map((element) => element[1]));
      // print(result.map((element) => element[2]));
      // print(result.map((element) => element[3])); // {
      print("------------ Tape -----------------");
      print(result.map((element) => element[4][0])); // Tape
      print(result.map((element) => element[4][0][0][1][1])); // Tape Attribute
      print(result.map((element) => element[4][0][1])); // Tape Data
      // print("------------ States -----------------");
      // print(result.map((element) => element[4][1])); // States
      // print("------------ Transitions -----------------");
      // print(result.map((element) => element[4][2])); // Transitions
      // print(result.map((element) => element[5])); // }

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Tape description", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm      MyTm       {
        tape [   x    =3, y=4] : --|abba--;
        
      }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);
      print(result.value[0].runtimeType);
      print(result.value[1].runtimeType);
      // print("------------ Tape -----------------");
      // print(result.map((element) => element[4][0])); // Tape
      // print(result.map((element) => element[4][0][0][1][1])); // Tape Attribute
      // print(result.map((element) => element[4][0][1])); // Tape Data

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
}
