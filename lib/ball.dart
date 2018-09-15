
import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  Offset begin;
  Offset end;
  int duration;
  double appBarHeight;

  Ball(Offset begin, Offset end, int d, double appBarHeight) {
    this.begin = begin;
    this.end = end;
    this.duration = d;
    this.appBarHeight = appBarHeight;
  }

  @override
  BallState createState() => new BallState(begin, end, duration, appBarHeight);
}

class BallState extends State<Ball> with SingleTickerProviderStateMixin {
  final double ballSize = 20.0;
  double appBarHeight;
  Animation animation;
  AnimationController animationController;
  Offset begin;
  Offset end;
  int duration;

  BallState(Offset begin, Offset end, int duration, double appBarHeight) {
    this.begin = begin;
    this.end = end;
    this.duration = duration;
    this.appBarHeight = appBarHeight;
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: duration), vsync: this);
    animation = Tween<Offset>(begin: begin, end: end).animate(CurvedAnimation(
        parent: animationController, curve: Curves.linear));

    animationController.forward();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - ballSize;
    final double height = MediaQuery.of(context).size.height - this.appBarHeight * 2;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.translationValues(
            getValue(animation.value.dx, width)+ballSize/2,
            getValue(animation.value.dy, height), 0.0),
          child: GestureDetector(
            onTap: animationController.stop,
            child: Container(
              width: ballSize,
              height: ballSize,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 255, 1.0),
                borderRadius: BorderRadius.circular(ballSize),
              ),
            )
          )
        );
      }
    );
  }

  num getValue(num x, num y) {
    num whole = x.floor();
    num rest = x - whole;
    if(whole % 2 == 0) {
      // goind right or down
      return (rest - 0.5) * y;
    } else {
      // goind left or up
      return (- rest + 0.5) * y;
    }
  }
}