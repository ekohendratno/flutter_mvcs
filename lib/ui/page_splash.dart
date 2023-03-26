import 'package:flutter/material.dart';
import 'package:flutter_mvcs/ui/page_home.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'dart:async';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash>{

  Timer? _timer;

  void _startTimeout() {
    const duration = Duration(seconds: 3);
    _timer = Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageHome()),
      );
    });
  }

  void _cancelTimeout() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimeout();
  }

  @override
  void dispose() {
    _cancelTimeout();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      child: Scaffold(
        backgroundColor: Color(0xfffffffff),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.4,
                  ],
                  colors: [
                    Colors.yellow,
                    Colors.red,
                  ],
                )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'The MVCS',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Model, Views, Controller, Services',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
