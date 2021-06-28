import 'package:flutter_test/flutter_test.dart';
import 'package:tms/application/grammar/turing_machine_grammar.dart';

main() {
  group('Turing Machine:', () {
    test("Full Turing Machine description", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm [ #red, rows=5, cols=9] {
        tape [ x=3, y=4, h=6, stroke width=89, bold, dotted, dashed, #0123Ff ] : --|abba--;
        state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
          ##blue, initial, initial below, accepting] : s1;
        state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
          ##blue, initial, initial below, accepting, above right of=s1] : s2;
        s1 -[ stroke width=5, bold, dotted, dashed, #green, ##red, bend, bend right, 
          loop, loop above ]-> s2 : a, b, L;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Minimum Turing Machine description", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm{
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional attributes", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #red, rows=5, cols=9]{
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional attributes with spaces", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm   [ #red,    rows   =  5   ,   cols  =9   ]   {
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional attributes with hex color", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm   [ #0123Ff,    rows   =  5   ,   cols  =9   ]   {
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional attributes with invalid hex color", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm   [ #FZZ13A,    rows   =  5   ,   cols  =9   ]   {
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isFalse);
    });

    test("Optional attributes with case insensitive hex color", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm   [ #FfA1aB,    rows   =  5   ,   cols  =9   ]   {
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Optional attributes with non-numeric value for rows and cols", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm [ #0123Ff, rows=abc   ,   cols=def ] {
        
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isFalse);
    });
  });

  group('Tape:', () {
    test("Only single tape", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        tape [ x=3, y=4, h=6, stroke width=89, bold, dotted, dashed, #0123Ff ] : --|abba--;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Only single tape without optional attributes", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        tape : --|abba--;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Only single tape without optional attributes and tape keyword", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        --|abba--;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Invalid - No head in tape input", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        --abba--;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isFalse);
    });
  });

  group('State:', () {
    test("Single state", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        state [ x=3, y=4, r=6, stroke width=5, bold, dotted, dashed, #0123Ff, 
          ##blue, initial, initial below, accepting] : s1;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single state with multiple spaces", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        state [ x  =  3  , y  =   4, r =6, stroke   width= 5, bold  , dotted , dashed, #0123Ff, 
          ##blue,    initial  , initial    below, accepting  ] : s1;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single state without optional attributes", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        state : s1;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
  group('Transition:', () {
    test("Single transition", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        s1 -[ stroke width=5, bold, dotted, dashed, #green, ##red, bend, bend right, 
          loop, loop above ]-> s2 : a, b, L;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single transition without optional attributes", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        s1 -> s2 : a, b, L;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });

    test("Single transition with multiple spaces", () {
      // Arrange
      final tmg = TuringMachineGrammar().build();
      String input = '''
      tm MyTm[ #0123Ff, rows=4, cols=5 ] {
        s1 -[   stroke    width =5, bold  , dotted   , dashed, #green  , ##red, bend, bend    right, 
          loop, loop above ]   -> s2   :    a   , b  ,   L   ;
      }
    ''';

      // Act
      final result = tmg.parse(input);

      // Assert
      expect(result.isSuccess, isTrue);
    });
  });
}
