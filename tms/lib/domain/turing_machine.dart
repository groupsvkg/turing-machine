import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Component
abstract class Component {
  void draw(Canvas canvas, Size size);
  void add(Component component) {}
  void remove(Component component) {}
}

/// Turing Machine
class TuringMachine extends Component {
  final List<Component> components;

  TuringMachine({required this.components});

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

  Tape({required this.components});

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

/// Head
class Head extends Component {
  final double x;
  final double y;
  final double strokeWidth;
  final double lineHeight;
  final double tipHeight;
  final double tipWidth;
  final Color color;

  Head({
    this.x = 100,
    this.y = 100,
    this.strokeWidth = 3,
    this.lineHeight = 30,
    this.tipHeight = 16,
    this.tipWidth = 16,
    this.color = Colors.brown,
  });

  @override
  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    canvas.drawLine(
      Offset(x, y - lineHeight / 2),
      Offset(x, y + lineHeight / 2),
      paint,
    );

    Path path = Path();
    path.moveTo(x - tipWidth / 2, y + lineHeight / 2);
    path.lineTo(x + tipWidth / 2, y + lineHeight / 2);
    path.lineTo(x, y + lineHeight / 2 + tipHeight);
    path.close();

    canvas.drawPath(path, paint);
  }
}

/// Cell
class Cell extends Component {
  final String symbol;
  final double x;
  final double y;
  final double height;
  final double width;
  final double strokeWidth;
  final Color color;
  final Color fillColor;
  final Color textColor;
  final double fontSize;

  Cell({
    this.symbol = "a",
    this.x = 100,
    this.y = 100,
    this.height = 30,
    this.width = 30,
    this.strokeWidth = 3,
    this.color = Colors.blue,
    this.fillColor = Colors.white,
    this.textColor = Colors.red,
    this.fontSize = 30,
  });

  @override
  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(x - width / 2, y - height / 2, width, height),
      paint,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0, maxWidth: width);
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }
}

/// States
class States extends Component {
  final List<Component> components;

  States({required this.components});

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
  final String symbol;
  final double x;
  final double y;
  final double radius;
  final double strokeWidth;
  final Color color;
  final Color fillColor;
  final Color textColor;
  final double textMargin;
  final double fontSize;

  State_({
    this.symbol = "S",
    this.x = 100,
    this.y = 100,
    this.radius = 200,
    this.strokeWidth = 3,
    this.color = Colors.grey,
    this.fillColor = Colors.white,
    this.textColor = Colors.red,
    this.textMargin = 6,
    this.fontSize = 30,
  });

  @override
  void draw(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0);

    canvas.drawCircle(Offset(x, y), textPainter.width / 2 + textMargin, paint);

    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }
}

/// Transitions
class Transitions extends Component {
  final List<Component> components;

  Transitions({required this.components});

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
class Transition extends Component {
  @override
  void draw(Canvas canvas, Size size) {}
}

/// Label
class Label extends Component {
  final double x;
  final double y;
  final String first;
  final Color firstTextColor;
  final double firstFontSize;
  final String middle;
  final Color middleTextColor;
  final double middleFontSize;
  final String last;
  final Color lastTextColor;
  final double lastFontSize;
  final double angle;

  Label({
    this.x = 100,
    this.y = 100,
    this.first = "",
    this.firstTextColor = Colors.green,
    this.firstFontSize = 30,
    this.middle = "",
    this.middleTextColor = Colors.red,
    this.middleFontSize = 30,
    this.last = "",
    this.lastTextColor = Colors.blue,
    this.lastFontSize = 30,
    this.angle = 0,
  });

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: first,
          style: TextStyle(color: firstTextColor, fontSize: firstFontSize),
          children: [
            TextSpan(text: ","),
            TextSpan(
                text: middle,
                style: TextStyle(
                  color: middleTextColor,
                  fontSize: middleFontSize,
                )),
            TextSpan(text: ","),
            TextSpan(
                text: last,
                style: TextStyle(
                  color: lastTextColor,
                  fontSize: lastFontSize,
                )),
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
