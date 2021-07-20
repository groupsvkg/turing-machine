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
  double loopDistance;
  String labelPosition;
  double deviationAngle;

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
    this.loopDistance = 70,
    this.labelPosition = "above",
    this.deviationAngle = pi / 5,
  });

  @override
  void draw(Canvas canvas, Size size) {
    if (source.symbol == destination.symbol) {
      _drawArrowLoop(canvas, size);
    } else {
      _drawArrowBetweenStates(canvas, size);
    }
  }

  void _drawArrowLoop(Canvas canvas, Size size) {
    Paint paintArrow = Paint()
      ..color = transitionStrokeColor
      ..strokeWidth = transitionStrokeWidth
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    double transitionSlopeAngle = 0;

    if (loopDirection == "loop right")
      transitionSlopeAngle = 0;
    else if (loopDirection == "loop below right")
      transitionSlopeAngle = pi / 4;
    else if (loopDirection == "loop below")
      transitionSlopeAngle = pi / 2;
    else if (loopDirection == "loop below left")
      transitionSlopeAngle = 3 * pi / 4;
    else if (loopDirection == "loop left")
      transitionSlopeAngle = pi;
    else if (loopDirection == "loop above left")
      transitionSlopeAngle = 5 * pi / 4;
    else if (loopDirection == "loop above")
      transitionSlopeAngle = 3 * pi / 2;
    else if (loopDirection == "loop above right")
      transitionSlopeAngle = 7 * pi / 4;

    Offset sourceCenter = Offset(source.stateX, source.stateY);

    Offset p1 = Offset(
        sourceCenter.dx +
            source.actualStateR * cos(transitionSlopeAngle + deviationAngle),
        sourceCenter.dy +
            source.actualStateR * sin(transitionSlopeAngle + deviationAngle));
    Offset p2 = Offset(
        sourceCenter.dx +
            source.actualStateR * cos(transitionSlopeAngle - deviationAngle),
        sourceCenter.dy +
            source.actualStateR * sin(transitionSlopeAngle - deviationAngle));

    Offset pm = Offset(
        sourceCenter.dx + source.actualStateR * cos(transitionSlopeAngle),
        sourceCenter.dy + source.actualStateR * sin(transitionSlopeAngle));

    Offset mid = _midPoint(p1, p2);
    double slopeAngle = _slopeAngle(mid, pm);
    if (pm.dx < sourceCenter.dx) {
      slopeAngle = slopeAngle + pi;
    }

    Offset cp = Offset(pm.dx + loopDistance * cos(slopeAngle),
        pm.dy + loopDistance * sin(slopeAngle));

    Path path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(cp.dx, cp.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paintArrow);
    if (bendDirection == "bend right")
      _drawHead(canvas, cp, p2);
    else if (bendDirection == "bend left")
      _drawHead(canvas, cp, p1);
    else if (bendDirection == "bend straight") _drawHead(canvas, cp, p1);
    _drawLabel(canvas, size, cp, _slopeAngle(p1, p2));
  }

  void _drawArrowBetweenStates(Canvas canvas, Size size) {
    Paint paintArrow = Paint()
      ..color = transitionStrokeColor
      ..strokeWidth = transitionStrokeWidth
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    Offset sourceCenter = Offset(source.stateX, source.stateY);
    Offset destinationCenter = Offset(destination.stateX, destination.stateY);

    double transitionSlopeAngle = _slopeAngle(sourceCenter, destinationCenter);

    if (destinationCenter.dx < sourceCenter.dx) {
      transitionSlopeAngle = transitionSlopeAngle + pi;
    }
    double d = _distance(sourceCenter, destinationCenter);

    Offset p1r = Offset(
        sourceCenter.dx +
            source.actualStateR * cos(transitionSlopeAngle + deviationAngle),
        sourceCenter.dy +
            source.actualStateR * sin(transitionSlopeAngle + deviationAngle));
    Offset p1l = Offset(
        sourceCenter.dx +
            source.actualStateR * cos(transitionSlopeAngle - deviationAngle),
        sourceCenter.dy +
            source.actualStateR * sin(transitionSlopeAngle - deviationAngle));

    Offset p2r = Offset(
        destinationCenter.dx +
            destination.actualStateR *
                cos(transitionSlopeAngle + pi - deviationAngle),
        destinationCenter.dy +
            destination.actualStateR *
                sin(transitionSlopeAngle + pi - deviationAngle));
    Offset p2l = Offset(
        destinationCenter.dx +
            destination.actualStateR *
                cos(transitionSlopeAngle + pi + deviationAngle),
        destinationCenter.dy +
            destination.actualStateR *
                sin(transitionSlopeAngle + pi + deviationAngle));

    Offset p1m = Offset(
        sourceCenter.dx + source.actualStateR * cos(transitionSlopeAngle),
        sourceCenter.dy + source.actualStateR * sin(transitionSlopeAngle));
    Offset p2m = Offset(
        destinationCenter.dx +
            destination.actualStateR * cos(transitionSlopeAngle + pi),
        destinationCenter.dy +
            destination.actualStateR * sin(transitionSlopeAngle + pi));

    // 0 < deviationAngle < pi/2
    double cpd1 = d / (2 * cos(deviationAngle)) - source.actualStateR;

    Offset cpr = Offset(
        sourceCenter.dx +
            (source.actualStateR + cpd1) *
                cos(transitionSlopeAngle + deviationAngle),
        sourceCenter.dy +
            (source.actualStateR + cpd1) *
                sin(transitionSlopeAngle + deviationAngle));

    Offset cpl = Offset(
        sourceCenter.dx +
            (source.actualStateR + cpd1) *
                cos(transitionSlopeAngle - deviationAngle),
        sourceCenter.dy +
            (source.actualStateR + cpd1) *
                sin(transitionSlopeAngle - deviationAngle));

    Path path = Path();
    if (bendDirection == "bend left") {
      path.moveTo(p1l.dx, p1l.dy);
      path.quadraticBezierTo(cpl.dx, cpl.dy, p2l.dx, p2l.dy);
      canvas.drawPath(path, paintArrow);
      _drawHead(canvas, cpl, p2l);
      _drawLabel(canvas, size, cpl, _slopeAngle(p1l, p2l));
    }
    if (bendDirection == "bend right") {
      path.moveTo(p1r.dx, p1r.dy);
      path.quadraticBezierTo(cpr.dx, cpr.dy, p2r.dx, p2r.dy);
      canvas.drawPath(path, paintArrow);
      _drawHead(canvas, cpr, p2r);
      _drawLabel(canvas, size, cpr, _slopeAngle(p1r, p2r));
    }
    if (bendDirection == "bend straight") {
      canvas.drawLine(p1m, p2m, paintArrow);
      _drawHead(canvas, p1m, p2m);
      _drawLabel(canvas, size, _midPoint(p1m, p2m), _slopeAngle(p1m, p2m));
    }
  }

  void _drawHead(Canvas canvas, Offset cp, Offset p) {
    double slopeAngle = _slopeAngle(cp, p);
    if (p.dx >= cp.dx) {
      slopeAngle = slopeAngle + pi;
    }

    double r = 20;
    double angle = pi / 6;

    Paint hPaint = Paint()
      ..color = transitionStrokeColor
      ..style = PaintingStyle.fill;

    Offset p1r = Offset(
      p.dx + r * cos(slopeAngle + angle),
      p.dy + r * sin(slopeAngle + angle),
    );
    Offset p1l = Offset(
      p.dx + r * cos(slopeAngle - angle),
      p.dy + r * sin(slopeAngle - angle),
    );

    Path hPath = Path();

    hPath.moveTo(p1l.dx, p1l.dy);
    hPath.lineTo(p1r.dx, p1r.dy);
    hPath.lineTo(p.dx, p.dy);
    hPath.close();

    canvas.drawPath(hPath, hPaint);
  }

  void _drawLabel(Canvas canvas, Size size, Offset cp, double angle) {
    Label label = Label(
      labelX: cp.dx,
      labelY: cp.dy,
      first: labelFirstText,
      middle: labelMiddleText,
      last: labelLastText,
      angle: angle,
    );
    label.draw(canvas, size);
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
