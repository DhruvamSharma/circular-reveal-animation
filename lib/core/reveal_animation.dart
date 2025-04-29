import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/reveal_clipper.dart';

enum RevealAnimationType {
  circular,
  rectangular,
}

class RevealAnimationWidget extends StatefulWidget {
  const RevealAnimationWidget({
    required this.center,
    required this.child,
    required this.rect,
    super.key,
    this.type = RevealAnimationType.circular,
    this.onTap,
  });

  final Offset center;
  final Rect rect;
  final Widget child;
  final RevealAnimationType? type;
  final VoidCallback? onTap;

  @override
  State<RevealAnimationWidget> createState() => _RevealAnimationWidgetState();
}

class _RevealAnimationWidgetState extends State<RevealAnimationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: widget.type != RevealAnimationType.rectangular
              ? CircularRevealClipper(
                  center: widget.center,
                  radius: _animation.value *
                      MediaQuery.sizeOf(context).longestSide *
                      1.5,
                )
              : RectangularRevealClipper(
                  center: widget.center,
                  width: widget.rect.width * _animation.value * 20,
                  height: widget.rect.height * _animation.value * 20,
                ),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          _controller.reverse().then((_) {
            if (mounted) {
              widget.onTap?.call();
            }
          });
        },
        child: widget.child,
      ),
    );
  }
}

