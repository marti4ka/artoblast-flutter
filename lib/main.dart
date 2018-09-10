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
  // TODO this should have array of balls
  // TODO each ball should have an animation and animationController
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
    AppBar appBar = AppBar(title: Text('Artoblast'));
    final double appBarHeight = appBar.preferredSize.height * 2;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            appBar: appBar,
            body: Transform(
              transform: Matrix4.translationValues(
                getValue(animation.value.dx, width - 10),
                getValue(animation.value.dy, height - appBarHeight), 0.0),
              child: new Center (
                child: GestureDetector(
                onTap: animationController.stop,
                child: Container(
                  child: Text('o', style: TextStyle(fontSize: 50.0, fontFamily: 'VT323'))
                )
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
