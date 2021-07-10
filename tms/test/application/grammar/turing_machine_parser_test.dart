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
    test("Minimum description", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm {}
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Minimum description with redundant spaces", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm      MyTm     {      }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Minimum description with redundant newlines", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm
          MyTm 
            {

              }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional tm attributes", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {}
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional tm attributes with redundant spaces", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm     MyTm    [    distance   =  3    fill   =  #FFFAAA   ] {   }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single tape", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          --aaa|bbb--;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single tape with tape keywords", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single tape with full attributes", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape [  
            x=100,
            y=100,
            cell height=30,
            cell width=30,
            cell stroke width=4,
            cell stroke color=#FFFEEE,
            cell fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol font size=40,
            head height=200,
            head tip height=16,
            head tip width=16,
            head stroke width=4,
            head stroke color=#FFFEEE
            ] : --aaa|bbb--;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single State", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();
      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });
    test("Single State with full attributes", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state[ 
            x=100,
            y=100,
            r=20,
            stroke width=4,
            stroke color=#FFFEEEABC,
            fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol margin=6,
            symbol font size=30,
            initial,
            initial above,
            accepting,
            above right of=s1,
            distance=80
          ] : s2;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });
    test("Multiple State", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state[ 
            x=100,
            y=100,
            r=20,
            stroke width=4,
            stroke color=#FFFEEEABC,
            fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol margin=6,
            symbol font size=30,
            initial,
            initial above,
            accepting,
            above right of=s1,
            distance=80
          ] : s2;
        
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("State attribute comma seperation ", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state[ 
            x=100,
            y=100, 
            r=20, 
            stroke width=4, 
            stroke color=#FFFEEEABC,
            fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol margin=6,
            symbol font size=30,
            initial,
            initial above,
            above of=s1,
            accepting,
            distance=80
          ] : s2;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single Transaction", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state : s2;
          s1 -[]-> s2:a,b,L;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Multiple Transaction", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state : s2;
          state : s3;
          s1 -[]-> s2 : a,b,L;
          s2 -[]-> s3 : b,d,R;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });
    test("Single Transaction with full attribute", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3 fill=#FFFAAA] {
          tape : --aaa|bbb--;
          state : s1;
          state : s2;
          s1 -[
            loop above
            bend right
            stroke width=5
            stroke color=#FFFEEE
            label first color=#AAAFFF
            label middle color=#AAAFFF
            label last color=#AAAFFF
            label font size=30
            above
          ]-> s2:a,b,L;
          s1 -> s2: a,b,R;
        }
    ''';

      // Act
      final result = parser.parse(input);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Full Turing Machine description", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3, fill=#FFFAAA] {
          tape [  
            x=100,
            y=100,
            cell height=30,
            cell width=30,
            cell stroke width=4,
            cell stroke color=#FFFEEE,
            cell fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol font size=40,
            head height=200,
            head tip height=16,
            head tip width=16,
            head stroke width=4,
            head stroke color=#FFFEEE,
          ] : --aaa|bbb--;
          
          state : s1;
          state[ 
            x=100,
            y=100,
            r=20,
            stroke width=4,
            stroke color=#FFFEEEABC,
            fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol margin=6,
            symbol font size=30,
            initial,
            initial above,
            above right of=s1,
            accepting,
            distance=80
          ] : s2;

          s1 -[
            loop above,
            bend right,
            stroke width=5,
            stroke color=#FFFEEE,
            label first color=#AAAFFF,
            label middle color=#AAAFFF,
            label last color=#AAAFFF,
            label font size=30,
            above
          ]-> s1:a,b,L;
          s1 -> s2: a,b,R;
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
