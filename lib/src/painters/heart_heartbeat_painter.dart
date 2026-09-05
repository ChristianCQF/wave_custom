import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../controller/base_heartbeat_painter.dart';

class HeartHeartbeatPainter extends BaseHeartbeatPainter {
  HeartHeartbeatPainter(super.props);

  Offset _towards(Offset from, Offset to, double distance) {
    final Offset dir = to - from;
    final double length = dir.distance;
    if (length == 0) return from;
    return from + dir * (distance / length);
  }

  @override
  Path buildShapePath(double radius) {
    const double vbHalfWidth = 16.0;
    const double vbHalfHeight = 14.35;
    final double scale = radius / math.max(vbHalfWidth, vbHalfHeight);
    final double roundness = props.waveCustom.heartTipRoundness ?? 2.6;

    Offset tr(Offset p) =>
        Offset((p.dx - vbHalfWidth) * scale, (p.dy - vbHalfHeight) * scale);
    void cubicTo(Path path, Offset c1, Offset c2, Offset end) {
      path.cubicTo(
        tr(c1).dx,
        tr(c1).dy,
        tr(c2).dx,
        tr(c2).dy,
        tr(end).dx,
        tr(end).dy,
      );
    }

    const Offset tip = Offset(16, 28.7);
    final Offset pointBeforeTip = _towards(
      tip,
      const Offset(32, 18),
      roundness,
    );
    final Offset pointAfterTip = _towards(tip, const Offset(0, 18), roundness);

    final Path path = Path()
      ..moveTo(tr(pointAfterTip).dx, tr(pointAfterTip).dy);
    cubicTo(path, tip, const Offset(0, 18), const Offset(0, 8.5));
    cubicTo(
      path,
      const Offset(0, 3.8),
      const Offset(3.8, 0),
      const Offset(8.5, 0),
    );
    cubicTo(
      path,
      const Offset(11.6, 0),
      const Offset(14.3, 1.6),
      const Offset(16, 4.1),
    );
    cubicTo(
      path,
      const Offset(17.7, 1.6),
      const Offset(20.4, 0),
      const Offset(23.5, 0),
    );
    cubicTo(
      path,
      const Offset(28.2, 0),
      const Offset(32, 3.8),
      const Offset(32, 8.5),
    );
    cubicTo(path, const Offset(32, 18), tip, pointBeforeTip);
    path.quadraticBezierTo(
      tr(tip).dx,
      tr(tip).dy,
      tr(pointAfterTip).dx,
      tr(pointAfterTip).dy,
    );
    path.close();
    return path;
  }
}
