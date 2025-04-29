import 'package:flutter/widgets.dart';

class CircularRevealClipper extends CustomClipper<Path> {

  CircularRevealClipper({
    required this.center,
    required this.radius,
  });
  
  final Offset center;
  final double radius;

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RectangularRevealClipper extends CustomClipper<Path> {
  /// Creates a rectangular reveal clipper.
  ///
  /// The [center] is the starting point of the rectangle.
  /// [width] and [height] are the initial dimensions of the rectangle.
  /// [radius] is the radius of the rounded corners.
  /// If [expanding] is true, the rectangle expands to fill the screen, otherwise, it shrinks.
  RectangularRevealClipper({
    required this.center,
    required this.width,
    required this.height,
    this.radius = 0.0,
    this.expanding = true,
  });

  final Offset center;
  final double width;
  final double height;
  final double radius; // Added for rounded corners
  final bool expanding;

  @override
  Path getClip(Size size) {
    // Calculate the maximum width and height to fill the screen.
    final maxWidth = size.width;
    final maxHeight = size.height;

    // Determine the current width and height based on whether we are expanding or shrinking.
    final currentWidth = expanding ? width : maxWidth - width;
    final currentHeight = expanding ? height : maxHeight - height;

    // Calculate the top-left corner of the rectangle.
    var left = expanding
        ? center.dx - width / 2
        : center.dx - (maxWidth - width) / 2;
    var top = expanding
        ? center.dy - height / 2
        : center.dy - (maxHeight - height) / 2;

    // Ensure that the left and top values are within the bounds of the screen.
     left = left.clamp(0, size.width);
     top = top.clamp(0, size.height);


    // Create the rectangle.
    final rect = Rect.fromLTWH(left, top, currentWidth, currentHeight);


    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(radius), // Use the provided radius
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is RectangularRevealClipper) {
      return center != oldClipper.center ||
          width != oldClipper.width ||
          height != oldClipper.height ||
          radius != oldClipper.radius ||
          expanding != oldClipper.expanding;
    }
    return true;
  }
}