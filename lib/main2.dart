import 'package:flutter/material.dart';
import 'MenuLateral.dart';
import 'main.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.green,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text(" "),),
          drawer: MenuLateral(),
          body: Center(
            child: Text("HOME"),
          ),
        )
    );
  }
}






