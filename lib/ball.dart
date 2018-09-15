
import 'package:flutter/material.dart';

class Ball extends StatefulWidget {
  Offset begin;
  Offset end;
  int duration;

  Ball(Offset begin, Offset end, int d) {
    this.begin = begin;
    this.end = end;
    this.duration = d;
  }

  @override
  BallState createState() => new BallState(begin, end, duration);
}

class BallState extends State<Ball> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Offset begin;
  Offset end;
  int duration;

  BallState(Offset begin, Offset end, int duration) {
    this.begin = begin;
    this.end = end;
    this.duration = duration;
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
    final double width = MediaQuery.of(context).size.width - 20;

    // heigth - appBar.height
    final double height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom * 2;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.translationValues(
            getValue(animation.value.dx, width)+10,
            getValue(animation.value.dy, height), 0.0),
          child: GestureDetector(
            onTap: animationController.stop,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 255, 1.0),
                borderRadius: BorderRadius.circular(20.0),
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