import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:swipedetector/swipedetector.dart';


const String homeUrl = 'https://creationdevs.in/sccn/homepagewebview.php';

void main() {
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
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  Widget build(BuildContext context) {
    return SwipeDetector(
        child: WebviewScaffold(
            url: homeUrl,
            initialChild: Center(
                child: Container(
                    child: Image(
              image: AssetImage("assets/images/sccn_logo.png"),
              color: Colors.black,
            ))),
          ),
        onSwipeRight: (){
          debugPrint("HAHA");
            flutterWebviewPlugin.reload();
          },
        swipeConfiguration: SwipeConfiguration(
        verticalSwipeMinVelocity: 100.0,
        verticalSwipeMinDisplacement: 50.0,
        verticalSwipeMaxWidthThreshold: 100.0,
        horizontalSwipeMaxHeightThreshold: 50.0,
        horizontalSwipeMinDisplacement: 50.0,
        horizontalSwipeMinVelocity: 200.0),
    );
  }
}
