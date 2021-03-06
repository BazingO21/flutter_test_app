import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My test App",
      home: Center(
        child: RandomColor(),
      ),
    );
  }
}

class RandomColor extends StatefulWidget {
  @override
  _RandomColorState createState() => _RandomColorState();
}

class _RandomColorState extends State<RandomColor> {
  final Set<Color> _saved = Set<Color>();
  final List<Color> _randomColorsList = <Color>[];
  int currentPosition=0;
  Color mainColor=Colors.white;
  bool firstStep = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Test App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,),
        ],
      ),
      body: Material(
        color: mainColor,
        child: InkWell(
          child: Center(
            child: Text("Hey there",
              style: TextStyle(
                fontSize: 33,
              ),
            ),
          ),

          onTap: () {
            setState(() {
                if(currentPosition==_randomColorsList.length-1&&firstStep==false) {
                  _randomColorsList.add(Color.fromRGBO(
                      Random().nextInt(255), Random().nextInt(255),
                      Random().nextInt(255), 100));
                  mainColor = _randomColorsList[++currentPosition];
                }
                else {
                  if(firstStep==false)
                  mainColor = _randomColorsList[++currentPosition];
                }
                if(firstStep) {
                  _randomColorsList.add(mainColor);
                  _randomColorsList.add(Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256),100));
                  mainColor = _randomColorsList[++currentPosition];
                  firstStep= false;
                }
            });
          },

          onDoubleTap:() {
            setState(() {
              if(currentPosition-1>=0) {
                mainColor = _randomColorsList[--currentPosition];
              }
            });
          },

          onLongPress: (){
            setState(() {
              if (!_saved.contains(mainColor)) {
                _saved.add(mainColor);
              }
            });
          },
        ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<Container> tiles = _saved.map(
                (Color c) {
              return Container(
                color:c,
                child:ListTile(
                  title: Text(c.toString(),
                    style: TextStyle(
                      fontSize:21,
                    ),),
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Colors'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }


}