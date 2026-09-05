import 'package:flutter/material.dart';

import '../widget/wave.dart';

class CommonPainterProps {
  final bool isLoading;
  final bool isError;
  final ShapeMode shapeMode;
  final double circleFillRatio;
  final double pulseProgress;
  final double endProgress;
  final Color circleColor;
  final Color lineColor;
  final Color shadowColor;
  final Color outerCircleColor;
  final double strokeWidth;
  final double waveExpansion;
  final int waveCount;
  final double checkStrokeWidth;
  final Color checkColor;
  final double errorStrokeWidth;
  final Color errorColor;

  const CommonPainterProps({
    required this.isLoading,
    required this.isError,
    required this.shapeMode,
    required this.circleFillRatio,
    required this.pulseProgress,
    required this.endProgress,
    required this.circleColor,
    required this.lineColor,
    required this.shadowColor,
    required this.outerCircleColor,
    required this.strokeWidth,
    required this.waveExpansion,
    required this.waveCount,
    required this.checkStrokeWidth,
    required this.checkColor,
    required this.errorStrokeWidth,
    required this.errorColor,
  });
}

abstract class BaseHeartbeatPainter extends CustomPainter {
  final CommonPainterProps props;

  BaseHeartbeatPainter(this.props);

  // Cada subclase debe implementar su propia forma
  Path buildShapePath(double radius);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * (props.circleFillRatio / 2);
    final double scaleFactor = size.width / 400.0;

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.scale(scaleFactor);

    final double localRadius = radius / scaleFactor;
    final Path shapePath = buildShapePath(localRadius);

    if (props.isLoading) {
      _drawPulseShapes(canvas, shapePath, localRadius);
      _drawZigzagLines(canvas, shapePath, localRadius);
    } else if (props.isError) {
      _drawErrorAnimation(canvas, shapePath, localRadius);
    } else {
      _drawCheckAnimation(canvas, shapePath, localRadius);
    }
    canvas.restore();
  }

  void _drawPulseShapes(Canvas canvas, Path shapePath, double radius) {
    for (int i = 0; i < props.waveCount; i++) {
      final double phaseOffset = i / props.waveCount;
      final double waveProgress = (props.pulseProgress + phaseOffset) % 1.0;
      final double shapeScale = 1.0 + (waveProgress * props.waveExpansion);
      final double shapeOpacity = 1.0 - waveProgress;

      final Paint paintOuter = Paint()
        ..color = props.outerCircleColor.withValues(alpha: shapeOpacity);
      canvas.save();
      canvas.scale(shapeScale);
      canvas.drawPath(shapePath, paintOuter);
      canvas.restore();
    }
    canvas.drawPath(shapePath, Paint()..color = props.circleColor);
  }

  void _drawZigzagLines(Canvas canvas, Path shapePath, double circleRadius) {
    double frame = props.pulseProgress * 110.0;
    double endProg = (frame <= 71.4277) ? (frame / 71.4277) : 1.0;
    double startProg = (frame <= 40.0) ? 0.0 : ((frame - 40.0) / 70.0);

    final Path scaledPath = _createScaledZigzagPath(circleRadius);
    final Path trimmedPath = _trimPath(scaledPath, startProg, endProg);

    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = props.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double shadowOffsetX = 2.0;
    final double shadowOffsetY = props.strokeWidth;
    final double scaledOffsetX = props.shapeMode.zigzagOffset.dx;
    final double scaledOffsetY = props.shapeMode.zigzagOffset.dy;

    canvas.save();
    canvas.clipPath(shapePath);

    canvas.save();
    canvas.translate(
      shadowOffsetX + scaledOffsetX,
      shadowOffsetY + scaledOffsetY,
    );
    linePaint.color = props.shadowColor;
    canvas.drawPath(trimmedPath, linePaint);
    canvas.restore();

    canvas.save();
    canvas.translate(scaledOffsetX, scaledOffsetY);
    linePaint.color = props.lineColor;
    canvas.drawPath(trimmedPath, linePaint);
    canvas.restore();
    canvas.restore();
  }

  void _drawCheckAnimation(Canvas canvas, Path shapePath, double circleRadius) {
    canvas.drawPath(shapePath, Paint()..color = props.circleColor);
    if (props.endProgress <= 0) return;
    _drawCheckStroke(canvas, circleRadius, props.endProgress.clamp(0.0, 1.0));
  }

  void _drawCheckStroke(Canvas canvas, double circleRadius, double drawT) {
    final Offset offset = Offset(
      props.shapeMode.checkOffsetRatio.dx * circleRadius,
      props.shapeMode.checkOffsetRatio.dy * circleRadius,
    );
    Offset scaled(Offset base) =>
        (base * circleRadius * props.shapeMode.checkScale) + offset;

    final Path checkPath = Path()
      ..moveTo(
        scaled(const Offset(-0.583, 0.085)).dx,
        scaled(const Offset(-0.583, 0.085)).dy,
      )
      ..lineTo(
        scaled(const Offset(-0.120, 0.531)).dx,
        scaled(const Offset(-0.120, 0.531)).dy,
      )
      ..lineTo(
        scaled(const Offset(0.590, -0.410)).dx,
        scaled(const Offset(0.590, -0.410)).dy,
      );

    canvas.drawPath(
      _trimPath(checkPath, 0.0, drawT),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = props.checkStrokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = props.checkColor,
    );
  }

  void _drawErrorAnimation(Canvas canvas, Path shapePath, double circleRadius) {
    canvas.drawPath(shapePath, Paint()..color = props.circleColor);
    if (props.endProgress <= 0) return;
    _drawErrorStroke(canvas, circleRadius, props.endProgress.clamp(0.0, 1.0));
  }

  void _drawErrorStroke(Canvas canvas, double circleRadius, double drawT) {
    final Offset offset = Offset(
      props.shapeMode.errorOffsetRatio.dx * circleRadius,
      props.shapeMode.errorOffsetRatio.dy * circleRadius,
    );
    Offset scaled(Offset base) =>
        (base * circleRadius * props.shapeMode.errorScale) + offset;

    final Path errorPath = Path()
      ..moveTo(
        scaled(const Offset(-0.45, -0.45)).dx,
        scaled(const Offset(-0.45, -0.45)).dy,
      )
      ..lineTo(
        scaled(const Offset(0.45, 0.45)).dx,
        scaled(const Offset(0.45, 0.45)).dy,
      )
      ..moveTo(
        scaled(const Offset(0.45, -0.45)).dx,
        scaled(const Offset(0.45, -0.45)).dy,
      )
      ..lineTo(
        scaled(const Offset(-0.45, 0.45)).dx,
        scaled(const Offset(-0.45, 0.45)).dy,
      );

    canvas.drawPath(
      _trimPath(errorPath, 0.0, drawT),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = props.errorStrokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = props.errorColor,
    );
  }

  Path _trimPath(Path source, double startProgress, double endProgress) {
    final Path trimmedPath = Path();
    for (var metric in source.computeMetrics()) {
      double startDist = metric.length * startProgress;
      double endDist = metric.length * endProgress;
      if (startDist < endDist) {
        trimmedPath.addPath(
          metric.extractPath(startDist, endDist),
          Offset.zero,
        );
      }
    }
    return trimmedPath;
  }

  Path _createScaledZigzagPath(double circleRadius) {
    final List<Offset> rawVertices = const [
      Offset(-99.5, -1),
      Offset(-80.5, -20),
      Offset(-60.5, 0),
      Offset(-40.5, -20),
      Offset(-20.5, 0),
      Offset(-0.5, -60),
      Offset(19.5, 20),
      Offset(39.5, -20),
      Offset(59.5, 0),
      Offset(79.5, -20),
      Offset(99.5, 0),
    ];
    return _buildScaledZigzagPath(rawVertices, circleRadius, widthFactor: 1.6);
  }

  Path _buildScaledZigzagPath(
    List<Offset> rawVertices,
    double circleRadius, {
    required double widthFactor,
  }) {
    double minX = rawVertices.map((v) => v.dx).reduce((a, b) => a < b ? a : b);
    double maxX = rawVertices.map((v) => v.dx).reduce((a, b) => a > b ? a : b);
    final double totalScale =
        ((circleRadius * 2) * widthFactor) / (maxX - minX);

    final Path path = Path();
    path.moveTo(
      rawVertices[0].dx * totalScale,
      rawVertices[0].dy * totalScale * props.shapeMode.zigzagHeightScale,
    );
    for (int i = 1; i < rawVertices.length; i++) {
      path.lineTo(
        rawVertices[i].dx * totalScale,
        rawVertices[i].dy * totalScale * props.shapeMode.zigzagHeightScale,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant BaseHeartbeatPainter oldDelegate) {
    return oldDelegate.props.isLoading != props.isLoading ||
        oldDelegate.props.isError != props.isError ||
        oldDelegate.props.shapeMode != props.shapeMode ||
        oldDelegate.props.circleFillRatio != props.circleFillRatio ||
        oldDelegate.props.pulseProgress != props.pulseProgress ||
        oldDelegate.props.endProgress != props.endProgress ||
        oldDelegate.props.circleColor != props.circleColor ||
        oldDelegate.props.lineColor != props.lineColor ||
        oldDelegate.props.shadowColor != props.shadowColor ||
        oldDelegate.props.outerCircleColor != props.outerCircleColor ||
        oldDelegate.props.strokeWidth != props.strokeWidth ||
        oldDelegate.props.waveExpansion != props.waveExpansion ||
        oldDelegate.props.waveCount != props.waveCount ||
        oldDelegate.props.checkStrokeWidth != props.checkStrokeWidth ||
        oldDelegate.props.checkColor != props.checkColor ||
        oldDelegate.props.errorStrokeWidth != props.errorStrokeWidth ||
        oldDelegate.props.errorColor != props.errorColor;
  }
}
