import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Component
abstract class Component {
  void draw(Canvas canvas);
  void add(Component component) {}
  void remove(Component component) {}
}

/// Turing Machine
class TuringMachine extends Component {
  final String name;
  Color fill;
  double distance;
  final List<Component> components;

  TuringMachine(
    this.components, {
    this.name = "",
    this.fill = Colors.white,
    this.distance = 0,
  });

  @override
  void draw(Canvas canvas) {
    for (Component component in this.components) component.draw(canvas);
  }

  @override
  void add(Component component) {
    this.components.add(component);
  }

  @override
  void remove(Component component) {
    this.components.remove(component);
  }
}

/// Tape
class Tape extends Component {
  final List<Component> components;
  final List<String> inputLeft;
  final List<String> inputRight;
  double tapeX;
  double tapeY;
  double cellHeight;
  double cellWidth;
  double cellStrokeWidth;
  Color cellStrokeColor;
  Color cellFillColor;
  Color symbolColor;
  double symbolFontSize;
  double headHeight;
  double headTipHeight;
  double headTipWidth;
  double headStrokeWidth;
  Color headStokeColor;

  Tape(
    this.components,
    this.inputLeft,
    this.inputRight, {
    this.tapeX = 0,
    this.tapeY = 0,
    this.cellHeight = 0,
    this.cellWidth = 0,
    this.cellStrokeWidth = 0,
    this.cellStrokeColor = Colors.black,
    this.cellFillColor = Colors.black,
    this.symbolColor = Colors.black,
    this.symbolFontSize = 0,
    this.headHeight = 0,
    this.headTipHeight = 0,
    this.headTipWidth = 0,
    this.headStrokeWidth = 0,
    this.headStokeColor = Colors.black,
  });

  @override
  void draw(Canvas canvas) {
    for (Component component in components) component.draw(canvas);
  }

  @override
  void add(Component component) {
    this.components.add(component);
  }

  @override
  void remove(Component component) {
    this.components.remove(component);
  }
}

/// Head
class Head extends Component {
  double headX;
  double headY;
  double headHeight;
  double headTipHeight;
  double headTipWidth;
  double headStrokeWidth;
  Color headStokeColor;

  Head({
    this.headX = 0,
    this.headY = 0,
    this.headHeight = 0,
    this.headTipHeight = 0,
    this.headTipWidth = 0,
    this.headStrokeWidth = 0,
    this.headStokeColor = Colors.black,
  });

  @override
  void draw(Canvas canvas) {
    Paint paint = Paint()
      ..color = headStokeColor
      ..strokeWidth = headStrokeWidth;

    canvas.drawLine(
      Offset(headX, headY - headHeight / 2),
      Offset(headX, headY + headHeight / 2),
      paint,
    );

    Path path = Path();
    path.moveTo(
      headX - headTipWidth / 2,
      headY + headHeight / 2 - headTipHeight,
    );
    path.lineTo(
      headX + headTipWidth / 2,
      headY + headHeight / 2 - headTipHeight,
    );
    path.lineTo(headX, headY + headHeight / 2);
    path.close();

    canvas.drawPath(path, paint);
  }
}

/// Cell
class Cell extends Component {
  String cellSymbol;
  double cellX;
  double cellY;
  double cellHeight;
  double cellWidth;
  double cellStrokeWidth;
  Color cellStrokeColor;
  Color cellFillColor;
  Color cellSymbolColor;
  double cellSymbolFontSize;

  Cell({
    this.cellSymbol = "",
    this.cellX = 0,
    this.cellY = 0,
    this.cellHeight = 0,
    this.cellWidth = 0,
    this.cellStrokeWidth = 0,
    this.cellStrokeColor = Colors.black,
    this.cellFillColor = Colors.black,
    this.cellSymbolColor = Colors.black,
    this.cellSymbolFontSize = 0,
  });

  @override
  void draw(Canvas canvas) {
    Paint paint = Paint()
      ..strokeWidth = cellStrokeWidth
      ..color = cellStrokeColor
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(
        cellX - cellWidth / 2,
        cellY - cellHeight / 2,
        cellWidth,
        cellHeight,
      ),
      paint,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: cellSymbol,
        style: TextStyle(
          color: cellSymbolColor,
          fontSize: cellSymbolFontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0, maxWidth: cellWidth);
    textPainter.paint(
      canvas,
      Offset(
        cellX - textPainter.width / 2,
        cellY - textPainter.height / 2,
      ),
    );
  }
}

/// States
class States extends Component {
  final List<Component> components;

  States({required this.components});

  @override
  void draw(Canvas canvas) {
    for (Component component in this.components) component.draw(canvas);
  }

  @override
  void add(Component component) {
    this.components.add(component);
  }

  @override
  void remove(Component component) {
    this.components.remove(component);
  }
}

/// State
class State_ extends Component {
  String symbol;
  double stateX;
  double stateY;
  double stateR;
  double stateStrokeWidth;
  Color stateStrokeColor;
  Color stateFillColor;
  Color stateSymbolColor;
  double stateSymbolMargin;
  double stateSymbolFontSize;
  bool isStateInitial;
  String stateType;

  State_({
    this.symbol = "",
    this.stateX = 0,
    this.stateY = 0,
    this.stateR = 0,
    this.stateStrokeWidth = 0,
    this.stateStrokeColor = Colors.black,
    this.stateFillColor = Colors.white,
    this.stateSymbolColor = Colors.black,
    this.stateSymbolMargin = 0,
    this.stateSymbolFontSize = 0,
    this.isStateInitial = false,
    this.stateType = "intermediate",
  });

  @override
  void draw(Canvas canvas) {
    Paint paint = Paint()
      ..strokeWidth = stateStrokeWidth
      ..color = stateStrokeColor
      ..style = PaintingStyle.stroke;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(
          color: stateSymbolColor,
          fontSize: stateSymbolFontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0);

    canvas.drawCircle(
      Offset(stateX, stateY),
      textPainter.width / 2 + stateSymbolMargin,
      paint,
    );

    textPainter.paint(
      canvas,
      Offset(
        stateX - textPainter.width / 2,
        stateY - textPainter.height / 2,
      ),
    );
  }
}

/// Transitions
class Transitions extends Component {
  final List<Component> components;

  Transitions({required this.components});

  @override
  void draw(Canvas canvas) {
    for (Component component in this.components) component.draw(canvas);
  }

  @override
  void add(Component component) {
    this.components.add(component);
  }

  @override
  void remove(Component component) {
    this.components.remove(component);
  }
}

/// Transition
class Transition extends Component {
  @override
  void draw(Canvas canvas) {}
}

/// Label
class Label extends Component {
  double labelX;
  double labelY;
  String first;
  Color firstTextColor;
  double firstFontSize;
  String middle;
  Color middleTextColor;
  double middleFontSize;
  String last;
  Color lastTextColor;
  double lastFontSize;
  double angle;

  Label({
    this.labelX = 0,
    this.labelY = 0,
    this.first = "",
    this.firstTextColor = Colors.black,
    this.firstFontSize = 0,
    this.middle = "",
    this.middleTextColor = Colors.black,
    this.middleFontSize = 0,
    this.last = "",
    this.lastTextColor = Colors.black,
    this.lastFontSize = 0,
    this.angle = 0,
  });

  @override
  void draw(Canvas canvas) {
    canvas.save();
    canvas.translate(labelX, labelY);
    canvas.rotate(angle);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: first,
          style: TextStyle(color: firstTextColor, fontSize: firstFontSize),
          children: [
            if (first.isNotEmpty) TextSpan(text: ","),
            TextSpan(
              text: middle,
              style: TextStyle(
                color: middleTextColor,
                fontSize: middleFontSize,
              ),
            ),
            if (middle.isNotEmpty) TextSpan(text: ","),
            TextSpan(
              text: last,
              style: TextStyle(
                color: lastTextColor,
                fontSize: lastFontSize,
              ),
            ),
          ]),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0);

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }
}
