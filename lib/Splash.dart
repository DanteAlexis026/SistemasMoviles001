import 'package:flutter/material.dart';
import 'package:proyecto003/LoginForm.dart';
import 'main.dart';


class MyHomePageSplash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePageSplash> {
  @override
  void initState() {
    super.initState();
    _navigatehome();
  }

  _navigatehome() async {
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder:(context)=> LoginForm())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              height: 320,
              color: Colors.white,
              child: Image.asset('assets/FisInfo.jpg'),
            )
          ],
        ),
      ),
    );
  }
}

