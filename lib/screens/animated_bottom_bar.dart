import 'package:flutter/material.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget{
  final double _preferredHeight = 90.0;

  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_preferredHeight);
}

class _AnimatedAppBarState extends State<AnimatedAppBar> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _pulseAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 180)
    );

    _pulseAnimation = CurvedAnimation(
        curve: Curves.linear,
        parent: _animationController
    );

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
