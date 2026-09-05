import 'package:flutter/material.dart';

import '../controller/base_heartbeat_painter.dart';

class CircleHeartbeatPainter extends BaseHeartbeatPainter {
  CircleHeartbeatPainter(super.props);

  @override
  Path buildShapePath(double radius) {
    return Path()
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: radius));
  }
}
