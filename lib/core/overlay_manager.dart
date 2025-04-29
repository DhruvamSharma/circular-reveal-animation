import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/bouncy_animation.dart';
import 'package:widget_highlighter/core/global_key_registry.dart';
import 'package:widget_highlighter/core/reveal_animation.dart';

void showHighlighterOverlay(
  String id, {
  Offset? tapPosition,
  RevealAnimationType? revealAnimationType,
}) {
  final key = GlobalKeyRegistry.instance.getKey(id);
  final context = key.currentContext;
  if (context == null) return;

  final widget = context.widget;
  if (widget is! Container) return;
  final child = widget.child;
  if (child == null) return;

  final renderBox = context.findRenderObject() as RenderBox?;
  if (renderBox == null) return;
  final offset = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  OverlayManager.showSelectionOverlay(
    context,
    Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
    child,
    tapPosition: tapPosition,
    revealAnimationType: revealAnimationType,
  );
}

class OverlayManager {
  static void showSelectionOverlay(
    BuildContext context,
    Rect rect,
    Widget child, {
    Offset? tapPosition,
    RevealAnimationType? revealAnimationType,
  }) {
    // show the overlay with a dimmed background
    // and that removes the overlay when tapped

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => RevealAnimationWidget(
        rect: rect,
        center: tapPosition ?? rect.center,
        type: revealAnimationType,
        onTap: () => overlayEntry?.remove(),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.8),
            ),
            Positioned(
              left: rect.left,
              top: rect.top,
              width: rect.width,
              height: rect.height,
              child: Material(
                color: Colors.transparent,
                child: BouncyAnimation(
                  child: AbsorbPointer(child: child),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // insert the overlay entry into the overlay
    Overlay.of(context).insert(overlayEntry);
  }
}
