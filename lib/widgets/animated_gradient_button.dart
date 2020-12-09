import 'package:flutter/material.dart';

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