// create a glowing container with a gradient background

import 'dart:math';

import 'package:flutter/material.dart';

class _GlowingContainer extends StatelessWidget {
  const _GlowingContainer({
    required this.child,
    this.gradient,
    this.glowColor,
  });

  final Widget child;
  final Gradient? gradient;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    // build neon border container
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: child,
      ),
    );
  }
}


class RandomGlowingContainer extends StatelessWidget {
  const RandomGlowingContainer({
    required this.child,
    required this.seedId,
    super.key,
  });

  final Widget child;
  final String seedId;

  @override
  Widget build(BuildContext context) {
    // generate random glow color and gradient

    // using the seed to generate a random color
    final randomSeed = seedId.hashCode;
    final random = Random(randomSeed);



    
    final randomHue = random.nextDouble() * 360;
    final randomSaturation = random.nextDouble();
    final randomLightness = random.nextDouble();
    final randomGradient = LinearGradient(
      colors: [
        HSLColor.fromAHSL(1.0, randomHue, randomSaturation, randomLightness)
            .toColor(),
        HSLColor.fromAHSL(1.0, (randomHue + 180) % 360, randomSaturation,
                randomLightness)
            .toColor(),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    // using the seed to generate a random color
    final randomColor = HSLColor.fromAHSL(
      1.0,
      randomHue,
      randomSaturation,
      randomLightness,
    ).toColor();
  
    return _GlowingContainer(
      gradient: randomGradient,
      glowColor: randomColor,
      child: child,
    );
  }
}