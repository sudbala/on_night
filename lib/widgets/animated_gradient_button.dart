import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedGradientButton extends StatefulWidget {
  AnimatedGradientButton({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AnimatedGradientButtonState createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2500));
    animationController.repeat(reverse: true);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {

        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //startAnim();
    return Scaffold(

      body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment(animation.value, animation.value),
                    focal: Alignment(1.5, -animation.value + 0.6),
                    focalRadius: 1.5,
                    colors: [
                      Color(0xffFFF250),
                      Color(0xffF77939),
                      Color(0xffF15F53),
                      Color(0xffDD2C83),
                      Color(0xffC12883),
                      Color(0xff992191),
                      Color(0xff7E1DA1),
                    ])
            ),
          )
      ),
    );
  }
}

enum _BgProps { color1, color2, color3, color4, color5, color6, color7 }

class AnimatedGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// The way i'm thinking about this is we create a simple gradient with a few
    /// colors and then use a package like hooks or simple_animations to tweak it
    /// In animation, inbetweening or tweening is a key process of generating
    /// intermediate frames betwen two key frames to give the appearance that the
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
