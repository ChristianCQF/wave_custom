import 'package:flutter/material.dart';

import '../controller/base_heartbeat_painter.dart';

class ShieldHeartbeatPainter extends BaseHeartbeatPainter {
  ShieldHeartbeatPainter(super.props);

  @override
  Path buildShapePath(double radius) {
    const double width = 32.0;
    const double height = 38.0;
    final double scale = radius / 19.0;
    Offset p(double x, double y) =>
        Offset((x - width / 2) * scale, (y - height / 2) * scale);

    final path = Path()..moveTo(p(13.5, 3.2).dx, p(13.5, 3.2).dy);
    path.cubicTo(
      p(14.8, 1.2).dx,
      p(14.8, 1.2).dy,
      p(17.2, 1.2).dx,
      p(17.2, 1.2).dy,
      p(18.5, 3.2).dx,
      p(18.5, 3.2).dy,
    );
    path.cubicTo(
      p(21.5, 5.8).dx,
      p(21.5, 5.8).dy,
      p(25.0, 6.5).dx,
      p(25.0, 6.5).dy,
      p(29.0, 6.5).dx,
      p(29.0, 6.5).dy,
    );
    path.cubicTo(
      p(31.0, 6.7).dx,
      p(31.0, 6.7).dy,
      p(32.0, 8.0).dx,
      p(32.0, 8.0).dy,
      p(32.0, 10.0).dx,
      p(32.0, 10.0).dy,
    );
    path.lineTo(p(32.0, 22.0).dx, p(32.0, 22.0).dy);
    path.cubicTo(
      p(32.0, 28.5).dx,
      p(32.0, 28.5).dy,
      p(25.0, 34.0).dx,
      p(25.0, 34.0).dy,
      p(16.0, 38.0).dx,
      p(16.0, 38.0).dy,
    );
    path.cubicTo(
      p(7.0, 34.0).dx,
      p(7.0, 34.0).dy,
      p(0.0, 28.5).dx,
      p(0.0, 28.5).dy,
      p(0.0, 22.0).dx,
      p(0.0, 22.0).dy,
    );
    path.lineTo(p(0.0, 10.0).dx, p(0.0, 10.0).dy);
    path.cubicTo(
      p(0.0, 8.0).dx,
      p(0.0, 8.0).dy,
      p(1.0, 6.7).dx,
      p(1.0, 6.7).dy,
      p(3.0, 6.5).dx,
      p(3.0, 6.5).dy,
    );
    path.cubicTo(
      p(7.0, 6.5).dx,
      p(7.0, 6.5).dy,
      p(10.5, 5.8).dx,
      p(10.5, 5.8).dy,
      p(13.5, 3.2).dx,
      p(13.5, 3.2).dy,
    );
    path.close();
    return path;
  }
}
