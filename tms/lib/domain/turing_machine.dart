import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

/// Component
abstract class Component {
  void draw(Canvas canvas, Size size);
  void add(Component component) {}
  void remove(Component component) {}
}

/// Turing Machine
class TuringMachine extends Component {
  String tmName;
  Color fill;
  double distance;
  final List<Component> components;

  TuringMachine(
    this.components, {
    this.tmName = "TM",
    this.fill = Colors.white,
    this.distance = 0,
  });

  @override
  void draw(Canvas canvas, Size size) {
    for (Component component in this.components) component.draw(canvas, size);
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
  List<String> tapeLeftData;
  List<String> tapeRightData;
  double tapeX;
  double tapeY;
  double cellHeight;
  double cellWidth;
  double cellStrokeWidth;
  Color cellStrokeColor;
  Color cellFillColor;
  Color cellSymbolColor;
  double cellSymbolFontSize;
  double headHeight;
  double headTipHeight;
  double headTipWidth;
  double headStrokeWidth;
  Color headStrokeColor;

  Tape(
    this.components,
    this.tapeLeftData,
    this.tapeRightData, {
    this.tapeX = 0,
    this.tapeY = 0,
    this.cellHeight = 0,
    this.cellWidth = 0,
    this.cellStrokeWidth = 0,
    this.cellStrokeColor = Colors.black,
    this.cellFillColor = Colors.black,
    this.cellSymbolColor = Colors.black,
    this.cellSymbolFontSize = 0,
    this.headHeight = 0,
    this.headTipHeight = 0,
    this.headTipWidth = 0,
    this.headStrokeWidth = 0,
    this.headStrokeColor = Colors.black,
  });

  @override
  void draw(Canvas canvas, Size size) {
    for (Component component in components) component.draw(canvas, size);
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
    this.headHeight = 50,
    this.headTipHeight = 16,
    this.headTipWidth = 16,
    this.headStrokeWidth = 4,
    this.headStokeColor = Colors.green,
  });

  @override
  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = headStokeColor
      ..strokeWidth = headStrokeWidth;

    canvas.drawLine(
      Offset(headX, headY - headHeight / 2),
      Offset(headX, headY + headHeight / 2 - headTipHeight),
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
  void draw(Canvas canvas, Size size) {
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

  States(this.components);

  @override
  void draw(Canvas canvas, Size size) {
    for (Component component in this.components) component.draw(canvas, size);
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
  double actualStateR;
  double stateStrokeWidth;
  Color stateStrokeColor;
  Color stateFillColor;
  Color stateSymbolColor;
  double stateSymbolMargin;
  double stateSymbolFontSize;
  bool isStateInitial;
  String initialPosition;
  String relativePosition;
  String relativeTo;
  double relativeX;
  double relativeY;
  String stateType;
  double distance;

  State_({
    this.symbol = "",
    this.stateX = 0,
    this.stateY = 0,
    this.stateR = 0,
    this.actualStateR = 0,
    this.stateStrokeWidth = 0,
    this.stateStrokeColor = Colors.black,
    this.stateFillColor = Colors.white,
    this.stateSymbolColor = Colors.black,
    this.stateSymbolMargin = 0,
    this.stateSymbolFontSize = 0,
    this.isStateInitial = false,
    this.initialPosition = "initial above",
    this.relativePosition = "",
    this.relativeTo = "",
    this.relativeX = 0,
    this.relativeY = 0,
    this.stateType = "intermediate",
    this.distance = 150,
  });

  @override
  void draw(Canvas canvas, Size size) {
    // if (relativePosition == "above of") {
    //   stateX = relativeX;
    //   stateY = relativeY - distance;
    // }
    // if (relativePosition == "below of") {
    //   stateX = relativeX;
    //   stateY = relativeY + distance;
    // }
    // if (relativePosition == "left of") {
    //   stateX = relativeX - distance;
    //   stateY = relativeY;
    // }
    // if (relativePosition == "right of") {
    //   stateX = relativeX + distance;
    //   stateY = relativeY;
    // }
    // if (relativePosition == "above left of") {
    //   stateX = relativeX - distance;
    //   stateY = relativeY - distance;
    // }
    // if (relativePosition == "above right of") {
    //   stateX = relativeX + distance;
    //   stateY = relativeY - distance;
    // }

    // if (relativePosition == "below left of") {
    //   stateX = relativeX - distance;
    //   stateY = relativeY + distance;
    // }
    // if (relativePosition == "below right of") {
    //   stateX = relativeX + distance;
    //   stateY = relativeY + distance;
    // }

    Paint paintStroke = Paint()
      ..strokeWidth = stateStrokeWidth
      ..color = stateStrokeColor
      ..style = PaintingStyle.stroke;
    Paint paintFill = Paint()
      ..strokeWidth = stateStrokeWidth
      ..color = stateFillColor
      ..style = PaintingStyle.fill;

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

    actualStateR = stateR + textPainter.width / 2 + stateSymbolMargin;
    canvas.drawCircle(
      Offset(stateX, stateY),
      actualStateR,
      paintStroke,
    );
    canvas.drawCircle(
      Offset(stateX, stateY),
      actualStateR,
      paintFill,
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

  Transitions(this.components);

  @override
  void draw(Canvas canvas, Size size) {
    for (Component component in this.components) component.draw(canvas, size);
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
class Transition_ extends Component {
  State_ source;
  State_ destination;

  double transitionStrokeWidth;
  Color transitionStrokeColor;
  Color labelFirstColor;
  String labelFirstText;
  Color labelMiddleColor;
  String labelMiddleText;
  Color labelLastColor;
  String labelLastText;
  double labelFontSize;
  String bendDirection;
  String loopDirection;
  String labelPosition;

  Transition_(
    this.source,
    this.destination, {
    this.transitionStrokeWidth = 4,
    this.transitionStrokeColor = Colors.brown,
    this.labelFirstColor = Colors.red,
    this.labelFirstText = "",
    this.labelMiddleColor = Colors.blue,
    this.labelMiddleText = "",
    this.labelLastColor = Colors.green,
    this.labelLastText = "",
    this.labelFontSize = 25,
    this.bendDirection = "bend straight",
    this.loopDirection = "loop above",
    this.labelPosition = "above",
  });

  @override
  void draw(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = transitionStrokeColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // path.moveTo(source.stateX, source.stateY);
    // path.quadraticBezierTo(
    //   source.stateX + (destination.stateX - source.stateX) / 2,
    //   source.stateY + (destination.stateY - source.stateY) / 2 + 100,
    //   destination.stateX,
    //   destination.stateY,
    // );
    // canvas.drawPath(path, paint);

    // canvas.drawLine(
    //   Offset(source.stateX, source.stateY),
    //   Offset(destination.stateX, destination.stateY),
    //   paint,
    // );

    // canvas.drawCircle(
    //   Offset(size.width / 2, size.height / 2),
    //   100,
    //   paint,
    // );
    // canvas.drawCircle(
    //   Offset(size.width / 2, size.height / 2),
    //   2,
    //   paint,
    // );

    // paint.color = Colors.blue;
    // canvas.drawCircle(
    //   Offset(size.width / 2 + 100 * cos(330 * pi / 180),
    //       size.height / 2 + 100 * sin(330 * pi / 180)),
    //   2,
    //   paint,
    // );

    // canvas.drawLine(
    //   Offset(100, 100),
    //   Offset(size.width, size.height),
    //   paint,
    // );
    // paint.color = Colors.blue;
    // canvas.drawCircle(
    //     Offset(
    //       100 + 300 * cos(atan((size.height - 100) / (size.width - 100))),
    //       100 + 300 * sin(atan((size.height - 100) / (size.width - 100))),
    //     ),
    //     2,
    //     paint);
  }
}

/// Label
class Label extends Component {
  double labelX;
  double labelY;
  String first;
  Color labelFirstColor;
  double firstFontSize;
  String middle;
  Color labelMiddleColor;
  double middleFontSize;
  String last;
  Color labelLastColor;
  double lastFontSize;
  double angle;

  Label({
    this.labelX = 0,
    this.labelY = 0,
    this.first = "",
    this.labelFirstColor = Colors.black,
    this.firstFontSize = 0,
    this.middle = "",
    this.labelMiddleColor = Colors.black,
    this.middleFontSize = 0,
    this.last = "",
    this.labelLastColor = Colors.black,
    this.lastFontSize = 0,
    this.angle = 0,
  });

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(labelX, labelY);
    canvas.rotate(angle);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: first,
          style: TextStyle(color: labelFirstColor, fontSize: firstFontSize),
          children: [
            if (first.isNotEmpty) TextSpan(text: ","),
            TextSpan(
              text: middle,
              style: TextStyle(
                color: labelMiddleColor,
                fontSize: middleFontSize,
              ),
            ),
            if (middle.isNotEmpty) TextSpan(text: ","),
            TextSpan(
              text: last,
              style: TextStyle(
                color: labelLastColor,
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
