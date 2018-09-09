import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

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
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    animation = Tween<Offset>(begin: const Offset(-0.5, -0.5), end: const Offset(0.5, 0.5)).animate(CurvedAnimation(
        parent: animationController, curve: Curves.linear));

    animation.addStatusListener((AnimationStatus newStatus) {
      if(newStatus == AnimationStatus.completed) {
        animationController.reverse();
      } else if (newStatus == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.forward();
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
              transform: Matrix4.translationValues((animation.value.dx) * width, animation.value.dy * height, 0.0),
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
}
