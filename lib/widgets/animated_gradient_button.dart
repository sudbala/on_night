import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

/// An enum type is a special data type that enables variables to be a set of
/// predefined constants. Var is equal to one of the values that have been
/// predefined for it. Think of it like a preprocessor directive in C.
enum _BgProps { color1, color2, color3, color4, color5, color6, color7 }

class AnimatedGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// The way i'm thinking about this is we create a simple gradient with a few
    /// colors and then use a package like hooks or simple_animations to tweak it
    /// In animation, inbetweening or tweening is a key process of generating
    /// intermediate frames between two key frames to give the appearance that the
    /// first frame evolves smoothly into the second. I think we can use a
    /// [MultiTrackTween] (a tween that allows tweening of multiple properties
    /// at once) with a [ControlledAnimation) (widget to run tween based
    /// animation) in order to do it. Lettuce get to it yuh

    /// Again, only 3 colors, can add it to it. May seem odd because of the
    /// ..add(). That is used to add multiple adds to the [MultiTween] object.
    final tween = MultiTween<_BgProps>()
      ..add(_BgProps.color1, Color(0xffFFF250).tweenTo(Color(0xffF77939)))
      ..add(_BgProps.color3, Color(0xffF15F53).tweenTo(Color(0xffDD2C83)))
      ..add(_BgProps.color5, Color(0xffC12883).tweenTo(Color(0xff992191)));

    /// Use a mirror animation of [MultiTweenValues] to get the animatable effect
    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 1.5.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(

              /// As suspected, I was able to do this with a simple linear gradient
              /// and i just animate the colors associated with that linear gradient
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    /// Right now it uses 4 colors, even though it might look like
                    /// three. That's because these are actually "tweened" colors
                    /// or animated colors. 1 to 2, 2 to 3, and 3 to 4. If needed
                    /// we can add more colors, they are defined in the enum above,
                    /// not top difficult to do.
                    value.get(_BgProps.color1),
                    value.get(_BgProps.color3),
                    value.get(_BgProps.color5),
                  ]),

              /// Adding a small
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]),
        );
      },
    );
  }
}
