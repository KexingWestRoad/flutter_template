
import 'package:flutter/material.dart';
import 'dart:async';

class ColorCircleLoader extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;

  ColorCircleLoader({this.colors, this.duration});

  @override
  _ColorCircleLoaderState createState() =>
      _ColorCircleLoaderState(this.colors, this.duration);
}

class _ColorCircleLoaderState extends State<ColorCircleLoader>
    with SingleTickerProviderStateMixin {
  final List<Color> colors;
  final Duration duration;
  Timer timer;

  _ColorCircleLoaderState(this.colors, this.duration);

  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  AnimationController controller;
  List<Animation<Color>> colorAnimations = [];

  @override
  void initState() {
    super.initState();
    
    controller = new AnimationController(
      vsync: this,
      duration: duration,
    );

    for (int i = 0; i < colors.length - 1; i++) {
      tweenAnimations.add(ColorTween(begin: colors[i], end: colors[i + 1]));
    }

    tweenAnimations
        .add(ColorTween(begin: colors[colors.length - 1], end: colors[0]));

    for (int i = 0; i < colors.length; i++) {
      Animation<Color> animation = tweenAnimations[i].animate(CurvedAnimation(
          parent: controller,
          curve: Interval((1 / colors.length) * (i + 1) - 0.05,
              (1 / colors.length) * (i + 1),
              curve: Curves.linear)));

      colorAnimations.add(animation);
    }

    print(colorAnimations.length);

    tweenIndex = 0;

    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % colors.length;
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: colorAnimations[tweenIndex],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
