import 'package:flutter/material.dart';

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve easeOutCurve = Curves.easeOutCubic;
  static const Curve easeInOutCurve = Curves.easeInOutCubic;

  static SlideTransition slideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(0.1, 0),
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: easeOutCurve,
      )),
      child: child,
    );
  }

  static FadeTransition fadeTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: easeOutCurve,
      ),
      child: child,
    );
  }

  static ScaleTransition scaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: easeOutCurve,
      ),
      child: child,
    );
  }

  static Widget slideUpTransition({
    required Widget child,
    required int index,
    Duration? duration,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: easeOutCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
