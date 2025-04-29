// bouncy animation widget
// this widget should take in a hild and animate it like a bouncy ball
import 'package:flutter/widgets.dart';

class BouncyAnimation extends StatefulWidget {
  const BouncyAnimation({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 700),
    this.scale = 1.2,
  });

  final Widget child;
  final Duration duration;
  final double scale;

  @override
  _BouncyAnimationState createState() => _BouncyAnimationState();
}

class _BouncyAnimationState extends State<BouncyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: widget.scale)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: widget.scale, end: 0.95)
          .chain(CurveTween(curve: Curves.easeIn)), 
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.02)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.02, end: 0.98)
          .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.98, end: 1)
          .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
    ]).animate(
      _controller
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
