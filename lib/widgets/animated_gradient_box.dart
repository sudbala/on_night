import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'animated_gradient.dart';

/// AnimatedGradientBox is an animated gradient widget that is used in making
/// the animated navigation button
class AnimatedGradientBox extends HookWidget {
  final List<Gradient> gradients;
  final Curve curve;

  AnimatedGradientBox(this.gradients, [this.curve = Curves.linear]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: useAnimatedGradient(gradients: gradients, curve: curve),
      ),
    );
  }
}
