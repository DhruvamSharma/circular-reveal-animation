import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/reveal_clipper.dart';

class CircularRevealPageRoute<T> extends PageRouteBuilder<T> {
  CircularRevealPageRoute({
    required this.page,
    required this.centerAlignment,
    super.settings,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return ClipPath(
            clipper: CircularRevealClipper(
              center: centerAlignment,
              radius: Tween<double>(
                begin: 0,
                end: MediaQuery.of(context).size.longestSide * 1.5,
              ).evaluate(animation),
            ),
            child: child,
          );
        },
        child: child,
      );
    },
  );

  final Widget page;
  final Offset centerAlignment;
}