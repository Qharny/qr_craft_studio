import 'package:flutter/material.dart';

/// Types of smooth transitions available for our custom route.
enum TransitionType {
  fade,
  scale,
  slideRight,
  slideUp,
  zoom,
}

/// A premium, highly customizable [PageRouteBuilder] that enables
/// smooth page transitions with elastic or decelerating animation curves.
class PremiumPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final TransitionType transitionType;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;

  PremiumPageRoute({
    required this.page,
    this.transitionType = TransitionType.zoom,
    this.duration = const Duration(milliseconds: 375),
    this.reverseDuration = const Duration(milliseconds: 275),
    this.curve = Curves.easeInOutCubic, // Elegant decelerating & accelerating curve
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: curve.flipped,
            );

            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: curvedAnimation,
                  child: child,
                );

              case TransitionType.scale:
                return ScaleTransition(
                  scale: curvedAnimation,
                  child: child,
                );

              case TransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                );

              case TransitionType.zoom:
                // Premium Zoom and Fade combined (elegant scale from 95% -> 100%)
                return FadeTransition(
                  opacity: curvedAnimation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
                    child: child,
                  ),
                );
            }
          },
        );
}
