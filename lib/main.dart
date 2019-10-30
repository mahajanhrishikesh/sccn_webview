import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:flare_splash_screen/flare_splash_screen.dart';

const String homeUrl = 'https://creationdevs.in/sccn/homepagewebview.php';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(
        'assets/finallyfinal.flr',
        HomePage(),
        startAnimation: 'Untitled',
        until: () => Future.delayed(Duration(milliseconds: 200)),
        backgroundColor: Color(0xffC1FBCE),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebviewScaffold(
          url: homeUrl,
        initialChild: Center(child: Container(child: Text("Okay")/*Image(image: AssetImage("assets/images/sccn_logo.png"),)*/)),
      ),
    );
  }
}
