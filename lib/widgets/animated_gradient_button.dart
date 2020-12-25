import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';


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

    final tween = MultiTween<_BgProps>()
      ..add(_BgProps.color1, Color(0xffFFF250).tweenTo(Color(0xffF77939)))
//      ..add(_BgProps.color2, Color(0xffF77939).tweenTo(Color(0xffF15F53)))
      ..add(_BgProps.color3, Color(0xffF15F53).tweenTo(Color(0xffDD2C83)))
//      ..add(_BgProps.color4, Color(0xffDD2C83).tweenTo(Color(0xffC12883)))
      ..add(_BgProps.color5, Color(0xffC12883).tweenTo(Color(0xff992191)));
//      ..add(_BgProps.color6, Color(0xff992191).tweenTo(Color(0xff7E1DA1)))
//      ..add(_BgProps.color7, Color(0xff7E1DA1).tweenTo(Color(0xffFFF250)));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 1.5.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    value.get(_BgProps.color1),
//                value.get(_BgProps.color2),
                    value.get(_BgProps.color3),
//                value.get(_BgProps.color4),
                    value.get(_BgProps.color5),
//                value.get(_BgProps.color6),
//                value.get(_BgProps.color7),
                  ]
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]
          ),
        );
      },
    );
  }
}
