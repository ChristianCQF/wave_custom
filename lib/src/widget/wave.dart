import 'package:flutter/material.dart';

import '../enum/heartbeat_shape.dart';

class WaveCustom {
  final HeartbeatShape shape;
  final double zigzagHeightScale;
  final Offset zigzagOffset;
  final double checkScale;
  final double errorScale;
  final Offset checkOffsetRatio;
  final Offset errorOffsetRatio;
  final double? heartTipRoundness;
  final double? shieldTipRoundness;

  const WaveCustom._({
    required this.shape,
    required this.zigzagHeightScale,
    required this.zigzagOffset,
    required this.checkScale,
    required this.errorScale,
    required this.checkOffsetRatio,
    required this.errorOffsetRatio,
    this.heartTipRoundness,
    this.shieldTipRoundness,
  });

  factory WaveCustom.circle({
    double zigzagHeightScale = 0.7,
    Offset zigzagOffset = const Offset(0, 0),
    double checkScale = 0.6,
    double errorScale = 0.6,
    Offset checkOffsetRatio = const Offset(0, 0),
    Offset errorOffsetRatio = const Offset(0, 0),
  }) {
    return WaveCustom._(
      shape: HeartbeatShape.circle,
      zigzagHeightScale: zigzagHeightScale,
      zigzagOffset: zigzagOffset,
      checkScale: checkScale,
      errorScale: errorScale,
      checkOffsetRatio: checkOffsetRatio,
      errorOffsetRatio: errorOffsetRatio,
    );
  }

  factory WaveCustom.heart({
    double zigzagHeightScale = 0.5,
    Offset zigzagOffset = const Offset(0, 40),
    double checkScale = 0.6,
    double errorScale = 0.6,
    Offset checkOffsetRatio = const Offset(0, -0.12),
    Offset errorOffsetRatio = const Offset(0, -0.12),
    double heartTipRoundness = 2.6,
  }) {
    return WaveCustom._(
      shape: HeartbeatShape.heart,
      zigzagHeightScale: zigzagHeightScale,
      zigzagOffset: zigzagOffset,
      checkScale: checkScale,
      errorScale: errorScale,
      checkOffsetRatio: checkOffsetRatio,
      errorOffsetRatio: errorOffsetRatio,
      heartTipRoundness: heartTipRoundness,
    );
  }

  factory WaveCustom.shield({
    double zigzagHeightScale = 0.6,
    Offset zigzagOffset = const Offset(0, 50),
    double checkScale = 0.6,
    double errorScale = 0.6,
    Offset checkOffsetRatio = const Offset(0, 0),
    Offset errorOffsetRatio = const Offset(0, 0),
    double shieldTipRoundness = 5.0,
  }) {
    return WaveCustom._(
      shape: HeartbeatShape.shield,
      zigzagHeightScale: zigzagHeightScale,
      zigzagOffset: zigzagOffset,
      checkScale: checkScale,
      errorScale: errorScale,
      checkOffsetRatio: checkOffsetRatio,
      errorOffsetRatio: errorOffsetRatio,
      shieldTipRoundness: shieldTipRoundness,
    );
  }
}
