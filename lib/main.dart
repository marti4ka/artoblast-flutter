import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

void main() => runApp(new Artoblast());

class Artoblast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GameArea());
  }
}

class GameArea extends StatefulWidget {
  @override
  GameState createState() => new GameState();
}

class GameState extends State<GameArea> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 50), vsync: this);
    animation = Tween<Offset>(begin: const Offset(1.23, 0.6), end: const Offset(9.23, 6.6)).animate(CurvedAnimation(
        parent: animationController, curve: Curves.linear));

    animationController.forward();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: Transform(
              transform: Matrix4.translationValues(getValue(animation.value.dx, width), getValue(animation.value.dy, height), 0.0),
              child: new Center(
                child: Container(
                  // TODO on click, animationController.stop()
                  child: Text('o', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                )
              )
            )
          );
        });
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
