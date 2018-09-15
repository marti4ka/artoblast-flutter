import 'package:Artoblast/ball.dart';
import 'package:flutter/material.dart';

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
  // we will have playing, exploding, finished

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text('Artoblast'));
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Ball(Offset(1.23, 0.6), Offset(9.23, 6.6), 50, appBar.preferredSize.height),
              Ball(Offset(1.0, 1.0), Offset(3.0, 3.0), 55, appBar.preferredSize.height),
            ],
          ),
        )
      )
    );
  }
}

