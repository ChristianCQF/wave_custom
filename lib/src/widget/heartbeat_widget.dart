import 'package:flutter/material.dart';

import '../enum/heartbeat_shape.dart';
import '../widget/wave.dart';

import '../controller/base_heartbeat_painter.dart';
import '../painters/circle_heartbeat_painter.dart';
import '../painters/heart_heartbeat_painter.dart';
import '../painters/shield_heartbeat_painter.dart';

class HeartbeatWidget extends StatefulWidget {
  final double size;
  final bool isLoading;
  final bool isError;
  final ShapeMode shapeMode;

  final double circleFillRatio;
  final Color circleColor;
  final Color lineColor;
  final Color shadowColor;
  final Color outerCircleColor;

  final double strokeWidth;
  final double waveExpansion;
  final int waveCount;

  final double? checkStrokeWidth;
  final Color? checkColor;
  final double? errorStrokeWidth;
  final Color? errorColor;

  final Duration pulseDuration;
  final Duration endAnimationDuration;

  final VoidCallback? onAnimationStart;
  final VoidCallback? onAnimationEnd;

  const HeartbeatWidget({
    super.key,
    required this.size,
    required this.isLoading,
    this.isError = false,
    required this.shapeMode,
    this.circleFillRatio = 1.0,
    required this.circleColor,
    required this.lineColor,
    required this.shadowColor,
    required this.outerCircleColor,
    required this.strokeWidth,
    this.waveExpansion = 0.5,
    this.waveCount = 1,
    this.checkStrokeWidth,
    this.checkColor,
    this.errorStrokeWidth,
    this.errorColor,
    this.pulseDuration = const Duration(milliseconds: 2200),
    this.endAnimationDuration = const Duration(milliseconds: 750),
    this.onAnimationStart,
    this.onAnimationEnd,
  });

  @override
  State<HeartbeatWidget> createState() => _HeartbeatWidgetState();
}

class _HeartbeatWidgetState extends State<HeartbeatWidget>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _endAnimationController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: widget.pulseDuration,
    );
    _endAnimationController = AnimationController(
      vsync: this,
      duration: widget.endAnimationDuration,
    );
    _endAnimationController.addStatusListener(_handleEndAnimationStatus);
    _updateStateBasedOnProps();
  }

  @override
  void didUpdateWidget(covariant HeartbeatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading != widget.isLoading ||
        oldWidget.isError != widget.isError) {
      _updateStateBasedOnProps();
    }
  }

  void _updateStateBasedOnProps() {
    if (widget.isLoading) {
      _endAnimationController.stop();
      _endAnimationController.value = 0.0;
      widget.onAnimationStart?.call();
      _pulseController
        ..value = 0.0
        ..repeat();
    } else {
      _pulseController.stop();
      _endAnimationController
        ..value = 0.0
        ..forward();
    }
  }

  void _handleEndAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) widget.onAnimationEnd?.call();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _endAnimationController.removeStatusListener(_handleEndAnimationStatus);
    _endAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _endAnimationController]),
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(painter: _createPainter()),
        );
      },
    );
  }

  CustomPainter _createPainter() {
    final commonProps = CommonPainterProps(
      isLoading: widget.isLoading,
      isError: widget.isError,
      waveCustom: widget.shapeMode,
      circleFillRatio: widget.circleFillRatio,
      pulseProgress: _pulseController.value,
      endProgress: _endAnimationController.value,
      circleColor: widget.circleColor,
      lineColor: widget.lineColor,
      shadowColor: widget.shadowColor,
      outerCircleColor: widget.outerCircleColor,
      strokeWidth: widget.strokeWidth,
      waveExpansion: widget.waveExpansion,
      waveCount: widget.waveCount,
      checkStrokeWidth: widget.checkStrokeWidth ?? widget.strokeWidth,
      checkColor: widget.checkColor ?? widget.lineColor,
      errorStrokeWidth: widget.errorStrokeWidth ?? widget.strokeWidth,
      errorColor: widget.errorColor ?? widget.lineColor,
    );

    switch (widget.shapeMode.shape) {
      case HeartbeatShape.circle:
        return CircleHeartbeatPainter(commonProps);
      case HeartbeatShape.heart:
        return HeartHeartbeatPainter(commonProps);
      case HeartbeatShape.shield:
        return ShieldHeartbeatPainter(commonProps);
    }
  }
}
