import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hexcolor/hexcolor.dart';
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
      final result = parser.parse(input).map((element) => element[0]);
      print(result);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("TM full attribute extraction", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3, fill=#FFFAAA] {
          
        }
    ''';

      // Act
      final result = parser.parse(input).map((element) => element[0]);
      Map<String, dynamic> tmAttributes =
          (result.value[2]?[1] ?? {}) as Map<String, dynamic>;
      var tmName = result.value[1];
      var fill = tmAttributes["fill"] ?? Colors.white;
      var distance = double.parse(tmAttributes["distance"] ?? 100);

      // Assert
      expect(result.isSuccess, isTrue);
      expect(tmName, "MyTm");
      expect(fill, HexColor("#FFFAAA"));
      expect(distance, 3);
    });

    test("TM distance attribute missing", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [fill=#FFFAAA] {
          
        }
    ''';

      // Act
      final result = parser.parse(input).map((element) => element[0]);
      Map<String, dynamic> tmAttributes =
          (result.value[2]?[1] ?? {}) as Map<String, dynamic>;
      var tmName = result.value[1];
      var fill = tmAttributes["fill"] ?? Colors.white;
      var distance = double.parse(tmAttributes["distance"] ?? "100");

      // Assert
      expect(result.isSuccess, isTrue);
      expect(tmName, "MyTm");
      expect(fill, HexColor("#FFFAAA"));
      expect(distance, 100);
    });

    test("TM fill attribute missing", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm [distance=3] {
          
        }
    ''';

      // Act
      final result = parser.parse(input).map((element) => element[0]);
      Map<String, dynamic> tmAttributes =
          (result.value[2]?[1] ?? {}) as Map<String, dynamic>;
      var tmName = result.value[1];
      var fill = tmAttributes["fill"] ?? Colors.white;
      var distance = double.parse(tmAttributes["distance"] ?? "100");

      // Assert
      expect(result.isSuccess, isTrue);
      expect(tmName, "MyTm");
      expect(fill, Colors.white);
      expect(distance, 3);
    });

    test("Tape attribue and tape data extraction", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm{
          tape [  
            x=400,
            y=150,
            cell height=40,
            cell width=50,
            cell stroke width=4,
            cell stroke color=#FFFEEE,
            cell fill color=#FFFEEE,
            symbol color=#FFFEEE,
            symbol font size=40,
            head height=60,
            head tip height=16,
            head tip width=16,
            head stroke width=4,
            head stroke color=#8B0000,
          ] : --aaa|bbb--;
        }
    ''';

      // Act
      final result = parser.parse(input).map((element) => element[0]);

      Map<String, dynamic> tapeAttributes =
          (result.value[4]?[0]?[1]?[1] ?? {}) as Map<String, dynamic>;
      var x = double.parse(tapeAttributes["x"] ?? "0");
      var y = double.parse(tapeAttributes["y"] ?? "0");
      var cellHeight = double.parse(tapeAttributes["cell height"] ?? "30");
      var cellWidth = double.parse(tapeAttributes["cell width"] ?? "30");
      var cellStrokeWidth =
          double.parse(tapeAttributes["cell stroke width"] ?? "5");
      var cellStrokeColor =
          tapeAttributes["cell stroke color"] ?? Colors.lightBlue;
      var cellFillColor = tapeAttributes["cell fill color"] ?? Colors.white;
      var symbolColor = tapeAttributes["symbol color"] ?? Colors.red;
      var symbolFontSize =
          double.parse(tapeAttributes["symbol font size"] ?? "30");
      var headHeight = double.parse(tapeAttributes["head height"] ?? "200");
      var headTipHeight =
          double.parse(tapeAttributes["head tip height"] ?? "16");
      var headTipWidth = double.parse(tapeAttributes["head tip width"] ?? "16");
      var headStrokeWidth =
          double.parse(tapeAttributes["head stroke width"] ?? "5");
      var headStrokeColor = tapeAttributes["head stroke color"] ?? Colors.brown;

      var tapeLeftData = (result.value[4]?[2]?[0] ?? []) as List<String>;
      var tapeRightData = (result.value[4]?[2]?[2] ?? []) as List<String>;

      // Assert
      expect(result.isSuccess, isTrue);
      expect(x, 100);
      expect(y, 150);
      expect(cellHeight, 40);
      expect(cellWidth, 50);
      expect(cellStrokeWidth, 4);
      expect(cellStrokeColor, HexColor("#FFFEEE"));
      expect(cellFillColor, HexColor("#FFFEEE"));
      expect(symbolColor, HexColor("#FFFEEE"));
      expect(symbolFontSize, 40);
      expect(headHeight, 200);
      expect(headTipHeight, 16);
      expect(headTipWidth, 16);
      expect(headStrokeWidth, 4);
      expect(headStrokeColor, HexColor("#FFFEEE"));

      expect(tapeLeftData, ['a', 'a', 'a']);
      expect(tapeRightData, ['b', 'b', 'b']);
    });

    test("State attribute extraction", () {
      // Arrange
      final tmp = TuringMachineParser();
      final parser = tmp.build();

      String input = '''
        tm  MyTm {
          --aaa|bbb--;
          
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
            distance=80
          ] : s1;

          state [ 
            x=200,
            y=250,
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
        }
    ''';

      // Act
      final result = parser.parse(input).map((element) => element[0]);
      print(result.value[5]);
      print(result.value[5].runtimeType);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Transition attribute extraction", () {
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
      final result = parser.parse(input).map((element) => element[0]);
      print(result.value[6]);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
}
