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
    if (components.isEmpty) return;
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    Paint emptyCircle = Paint()
      ..color = Colors.red
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;

    double cellCount = size.width / cellWidth;

    for (var i = 0; i < cellCount / 2 + 1; i++) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(tapeX + i * cellWidth, tapeY),
          width: cellWidth,
          height: cellHeight,
        ),
        paint,
      );
      canvas.drawCircle(Offset(tapeX + i * cellWidth, tapeY), 3, emptyCircle);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(tapeX - i * cellWidth, tapeY),
          width: cellWidth,
          height: cellHeight,
        ),
        paint,
      );
      canvas.drawCircle(Offset(tapeX - i * cellWidth, tapeY), 3, emptyCircle);
    }
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
    Paint emptyCircle = Paint()
      ..color = Colors.white
      ..strokeWidth = 0
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cellX, cellY), 4, emptyCircle);

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

    if (isStateInitial) {
      Paint initialPaint = Paint()
        ..color = stateStrokeColor
        ..strokeWidth = 4;
      if (initialPosition == "initial above") {
        canvas.drawLine(
          Offset(stateX, stateY - actualStateR - 50),
          Offset(stateX, stateY - actualStateR - 16),
          initialPaint,
        );

        Path path = Path();
        path.moveTo(stateX - 16 / 2, stateY - actualStateR - 16);
        path.lineTo(stateX + 16 / 2, stateY - actualStateR - 16);
        path.lineTo(stateX, stateY - actualStateR);
        path.close();

        canvas.drawPath(path, initialPaint);
      }
      if (initialPosition == "initial below") {
        canvas.drawLine(
          Offset(stateX, stateY + actualStateR + 50),
          Offset(stateX, stateY + actualStateR + 16),
          initialPaint,
        );

        Path path = Path();
        path.moveTo(stateX - 16 / 2, stateY + actualStateR + 16);
        path.lineTo(stateX + 16 / 2, stateY + actualStateR + 16);
        path.lineTo(stateX, stateY + actualStateR);
        path.close();

        canvas.drawPath(path, initialPaint);
      }
      if (initialPosition == "initial left") {
        canvas.drawLine(
          Offset(stateX - actualStateR - 50, stateY),
          Offset(stateX - actualStateR, stateY),
          initialPaint,
        );

        Path path = Path();
        path.moveTo(stateX - actualStateR - 16, stateY + 16 / 2);
        path.lineTo(stateX - actualStateR - 16, stateY - 16 / 2);
        path.lineTo(stateX - actualStateR, stateY);
        path.close();

        canvas.drawPath(path, initialPaint);
      }
      if (initialPosition == "initial right") {
        canvas.drawLine(
          Offset(stateX + actualStateR + 50, stateY),
          Offset(stateX + actualStateR, stateY),
          initialPaint,
        );

        Path path = Path();
        path.moveTo(stateX + actualStateR + 16, stateY + 16 / 2);
        path.lineTo(stateX + actualStateR + 16, stateY - 16 / 2);
        path.lineTo(stateX + actualStateR, stateY);
        path.close();

        canvas.drawPath(path, initialPaint);
      }
    }
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
  static const double bendDistance = 35;
  static const double bendAngle = pi / 5;
  static const double loopDistance = 60;

  Transition_(
    this.source,
    this.destination, {
    this.transitionStrokeWidth = 3,
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
    Paint paintArrow = Paint()
      ..color = transitionStrokeColor
      ..strokeWidth = transitionStrokeWidth
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    Offset sourceCenter = Offset(source.stateX, source.stateY);
    Offset destinationCenter = Offset(destination.stateX, destination.stateY);
    double slopeAngle = _slopeAngle(sourceCenter, destinationCenter);

    double p1BendAngle = 0;
    double p2BendAngle = 0;
    double distance = bendDistance;

    // BELOW RIGHT OF
    if (destinationCenter.dx > sourceCenter.dx &&
        destinationCenter.dy > sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = -bendAngle;
        p2BendAngle = -(pi - bendAngle);
        distance = -bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = bendAngle;
        p2BendAngle = pi - bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = 0;
        p2BendAngle = pi;
        distance = 0;
      }
    }

    // BELOW OF
    if (destinationCenter.dx == sourceCenter.dx &&
        destinationCenter.dy > sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = bendAngle;
        p2BendAngle = pi - bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = -bendAngle;
        p2BendAngle = -(pi - bendAngle);
        distance = -bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = 0;
        p2BendAngle = pi;
        distance = 0;
      }
    }

    // BELOW LEFT OF
    if (destinationCenter.dx < sourceCenter.dx &&
        destinationCenter.dy > sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = pi - bendAngle;
        p2BendAngle = bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = -(pi - bendAngle);
        p2BendAngle = -bendAngle;
        distance = -bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = pi;
        p2BendAngle = 0;
        distance = 0;
      }
    }

    // LEFT OF
    if (destinationCenter.dx < sourceCenter.dx &&
        destinationCenter.dy == sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = pi - bendAngle;
        p2BendAngle = bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = -(pi - bendAngle);
        p2BendAngle = -bendAngle;
        distance = -bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = pi;
        p2BendAngle = 0;
        distance = 0;
      }
    }

    // ABOVE LEFT OF
    if (destinationCenter.dx < sourceCenter.dx &&
        destinationCenter.dy < sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = pi - bendAngle;
        p2BendAngle = bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = -(pi - bendAngle);
        p2BendAngle = -bendAngle;
        distance = -bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = pi;
        p2BendAngle = 0;
        distance = 0;
      }
    }

    // ABOVE OF
    if (destinationCenter.dx == sourceCenter.dx &&
        destinationCenter.dy < sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = -bendAngle;
        p2BendAngle = -(pi - bendAngle);
        distance = -bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = bendAngle;
        p2BendAngle = pi - bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = 0;
        p2BendAngle = -pi;
        distance = 0;
      }
    }

    // ABOVE RIGHT OF
    if (destinationCenter.dx > sourceCenter.dx &&
        destinationCenter.dy < sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = -bendAngle;
        p2BendAngle = -(pi - bendAngle);
        distance = -bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = bendAngle;
        p2BendAngle = pi - bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = 0;
        p2BendAngle = -pi;
        distance = 0;
      }
    }

    // RIGHT OF
    if (destinationCenter.dx > sourceCenter.dx &&
        destinationCenter.dy == sourceCenter.dy) {
      if (bendDirection == "bend left") {
        p1BendAngle = -bendAngle;
        p2BendAngle = -(pi - bendAngle);
        distance = -bendDistance;
      }
      if (bendDirection == "bend right") {
        p1BendAngle = bendAngle;
        p2BendAngle = pi - bendAngle;
        distance = bendDistance;
      }
      if (bendDirection == "bend straight") {
        p1BendAngle = 0;
        p2BendAngle = -pi;
        distance = 0;
      }
    }

    Offset p1 = _pointOnCircle(
      sourceCenter,
      slopeAngle + p1BendAngle,
      source.actualStateR,
    );

    Offset p2 = _pointOnCircle(
      destinationCenter,
      slopeAngle + p2BendAngle,
      destination.actualStateR,
    );

    Offset controlPoint = _perpendicularPoint(p1, p2, distance);

    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      p2.dx,
      p2.dy,
    );

    canvas.drawPath(path, paintArrow);

    _drawHead(canvas, controlPoint, p2, destinationCenter);

    if (labelPosition == "above") {
      Offset labelCenter = Offset(0, 0);
      if (bendDirection == "bend left") {
        labelCenter = _perpendicularPoint(p1, p2, distance);
      }
      if (bendDirection == "bend right") {
        labelCenter = _perpendicularPoint(p1, p2, distance);
      }
      if (bendDirection == "bend straight") {
        labelCenter = _perpendicularPoint(p1, p2, -10);
      }
      Label label = Label(
        labelX: labelCenter.dx,
        labelY: labelCenter.dy,
        first: labelFirstText,
        middle: labelMiddleText,
        last: labelLastText,
        angle: slopeAngle,
      );
      label.draw(canvas, size);
    }

    if (labelPosition == "below") {
      Offset labelCenter = Offset(0, 0);
      if (bendDirection == "bend left") {
        labelCenter = _midPoint(p1, p2);
      }
      if (bendDirection == "bend right") {
        labelCenter = _midPoint(p1, p2);
      }
      if (bendDirection == "bend straight") {
        labelCenter = _perpendicularPoint(p1, p2, 10);
      }
      Label label = Label(
        labelX: labelCenter.dx,
        labelY: labelCenter.dy,
        first: labelFirstText,
        middle: labelMiddleText,
        last: labelLastText,
        angle: slopeAngle,
      );
      label.draw(canvas, size);
    }

    //DRAW LOOP
    if (source.symbol == destination.symbol) {
      if (loopDirection == "loop above") {
        distance = -loopDistance;
        Offset p1 = _pointOnCircle(
            sourceCenter, -(pi / 2 + bendAngle), source.actualStateR);
        Offset p2 = _pointOnCircle(
            sourceCenter, -(pi / 2 - bendAngle), source.actualStateR);
        Offset controlPoint = _perpendicularPoint(p1, p2, distance);

        Path path = Path();
        path.moveTo(p1.dx, p1.dy);
        path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p2.dx, p2.dy);

        canvas.drawPath(path, paintArrow);

        _drawHead(canvas, controlPoint, p2, destinationCenter);

        Label label = Label(
          labelX: controlPoint.dx,
          labelY: controlPoint.dy + 15,
          first: labelFirstText,
          middle: labelMiddleText,
          last: labelLastText,
          angle: _slopeAngle(p1, p2),
        );
        label.draw(canvas, size);
      }

      if (loopDirection == "loop below") {
        distance = loopDistance;
        Offset p1 = _pointOnCircle(
            sourceCenter, pi / 2 - bendAngle, source.actualStateR);
        Offset p2 = _pointOnCircle(
            sourceCenter, pi / 2 + bendAngle, source.actualStateR);
        Offset controlPoint = _perpendicularPoint(p1, p2, distance);

        Path path = Path();
        path.moveTo(p2.dx, p2.dy);
        path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p1.dx, p1.dy);

        canvas.drawPath(path, paintArrow);

        _drawHead(canvas, controlPoint, p1, destinationCenter);

        Label label = Label(
          labelX: controlPoint.dx,
          labelY: controlPoint.dy - 15,
          first: labelFirstText,
          middle: labelMiddleText,
          last: labelLastText,
          angle: _slopeAngle(p1, p2),
        );
        label.draw(canvas, size);
      }

      if (loopDirection == "loop left") {
        distance = -loopDistance;
        Offset p1 =
            _pointOnCircle(sourceCenter, pi - bendAngle, source.actualStateR);
        Offset p2 =
            _pointOnCircle(sourceCenter, pi + bendAngle, source.actualStateR);
        Offset controlPoint = _perpendicularPoint(p1, p2, distance);

        Path path = Path();
        path.moveTo(p2.dx, p2.dy);
        path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p1.dx, p1.dy);

        canvas.drawPath(path, paintArrow);

        _drawHead(canvas, controlPoint, p2, destinationCenter);

        Label label = Label(
          labelX: controlPoint.dx + 15,
          labelY: controlPoint.dy,
          first: labelFirstText,
          middle: labelMiddleText,
          last: labelLastText,
          angle: _slopeAngle(p1, p2),
        );
        label.draw(canvas, size);
      }

      // Workaround!!
      if (loopDirection == "loop right") {
        distance = -loopDistance;
        Offset p1 =
            _pointOnCircle(sourceCenter, -bendAngle, source.actualStateR);
        Offset p2 =
            _pointOnCircle(sourceCenter, bendAngle, source.actualStateR);
        Offset controlPoint = _perpendicularPoint(p1, p2, distance);

        Path path = Path();
        path.moveTo(p1.dx, p1.dy);
        path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p2.dx, p2.dy);

        canvas.drawPath(path, paintArrow);

        Paint hPaint = Paint()
          ..color = transitionStrokeColor
          ..style = PaintingStyle.fill;
        double slopeAngleCpP2 = _slopeAngle(controlPoint, p2);

        Offset hP1 = _pointOnCircle(p2, slopeAngleCpP2 + pi / 6, -16);
        if (_distance(hP1, destinationCenter) - destination.actualStateR < 0)
          hP1 = _pointOnCircle(p2, slopeAngleCpP2 + pi / 6, 16);

        Offset hP2 = _pointOnCircle(p2, slopeAngleCpP2 - pi / 6, 16);
        if (_distance(hP2, destinationCenter) - destination.actualStateR < 0)
          hP2 = _pointOnCircle(p2, slopeAngleCpP2 - pi / 6, 16);

        Path hPath = Path();
        hPath.moveTo(hP1.dx, hP1.dy);
        hPath.lineTo(hP2.dx, hP2.dy);
        hPath.lineTo(p2.dx, p2.dy);
        hPath.close();

        canvas.drawPath(hPath, hPaint);

        Label label = Label(
          labelX: controlPoint.dx - 15,
          labelY: controlPoint.dy,
          first: labelFirstText,
          middle: labelMiddleText,
          last: labelLastText,
          angle: _slopeAngle(p1, p2),
        );
        label.draw(canvas, size);
      }
    }
  }

  void _drawHead(
      Canvas canvas, Offset controlPoint, Offset p2, Offset destinationCenter) {
    Paint hPaint = Paint()
      ..color = transitionStrokeColor
      ..style = PaintingStyle.fill;
    double slopeAngleCpP2 = _slopeAngle(controlPoint, p2);

    Offset hP1 = _pointOnCircle(p2, slopeAngleCpP2 + pi / 6, -16);
    if (_distance(hP1, destinationCenter) - destination.actualStateR < 0)
      hP1 = _pointOnCircle(p2, slopeAngleCpP2 + pi / 6, 16);

    Offset hP2 = _pointOnCircle(p2, slopeAngleCpP2 - pi / 6, -16);
    if (_distance(hP2, destinationCenter) - destination.actualStateR < 0)
      hP2 = _pointOnCircle(p2, slopeAngleCpP2 - pi / 6, 16);

    Path hPath = Path();

    hPath.moveTo(hP1.dx, hP1.dy);
    hPath.lineTo(hP2.dx, hP2.dy);
    hPath.lineTo(p2.dx, p2.dy);
    hPath.close();

    canvas.drawPath(hPath, hPaint);
  }

  double _distance(Offset p1, Offset p2) {
    return sqrt(
        (p2.dx - p1.dx) * (p2.dx - p1.dx) + (p2.dy - p1.dy) * (p2.dy - p1.dy));
  }

  double _slope(Offset p1, Offset p2) {
    return (p2.dy - p1.dy) / (p2.dx - p1.dx);
  }

  double _slopeAngle(Offset p1, Offset p2) {
    return atan(_slope(p1, p2));
  }

  Offset _pointOnCircle(Offset center, double alpha, double radius) {
    return Offset(
      center.dx + radius * cos(alpha),
      center.dy + radius * sin(alpha),
    );
  }

  Offset _midPoint(Offset p1, Offset p2) {
    return Offset(
      (p1.dx + p2.dx) / 2,
      (p1.dy + p2.dy) / 2,
    );
  }

  Offset _perpendicularPoint(Offset p1, Offset p2, double distance) {
    double slopeAngle = _slopeAngle(p1, p2);
    Offset mid = _midPoint(p1, p2);
    return _pointOnCircle(
      mid,
      slopeAngle + pi / 2,
      distance,
    );
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
