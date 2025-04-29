import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/global_key_registry.dart';
import 'package:widget_highlighter/core/overlay_manager.dart';
import 'package:widget_highlighter/core/reveal_animation.dart';

class Highlighter extends StatelessWidget {
  const Highlighter({required this.id, required this.child, super.key});

  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKeyRegistry.instance.getKey(id),
      child: child,
    );
  }
}

class HighlighterController extends StatelessWidget {
  const HighlighterController({
    required this.id,
    required this.child,
    this.revealAnimationType,
    super.key,
  });

  final String id;
  final Widget child;
  final RevealAnimationType? revealAnimationType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        // Show overlay on long press
        showHighlighterOverlay(
          id,
          tapPosition: details.globalPosition,
          revealAnimationType: revealAnimationType,
        );
      },
      child: Highlighter(
        id: id,
        child: child,
      ),
    );
  }
}
