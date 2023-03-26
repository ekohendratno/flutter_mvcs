import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_mvcs/ui/page_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "the movies",
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          // add tabBarTheme
          tabBarTheme: const TabBarTheme(
              labelColor: Color(0xfffcfcfc),
              labelStyle: TextStyle(color: Color(0xfffcfcfc)), // color for text
              indicator: UnderlineTabIndicator( // color for indicator (underline)
                  borderSide: BorderSide(color: Color(0xfffcfcfc)))),
          primaryColor: Color(0xfffcfcfc), // outdated and has no effect to Tabbar
          accentColor: Color(0xfffcfcfc) // deprecated,
      ),
      home: PageSplash(),
    );
  }

}
