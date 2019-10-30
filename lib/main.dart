import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'dart:io';

const String homeUrl = 'https://creationdevs.in/sccn/homepagewebview.php';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => MaterialApp(
          home: Scaffold(
        body: Center(
          child: Container(
            child: Text(
              "Loading...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            color: Color(0xffC1FBCE),
          ),
        ),
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp is root widget

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(
        'assets/finallyfinal.flr', //Animation file
        HomePage(), //screen to load after animation
        startAnimation: 'Untitled',
        //Untitled is the animation name!
        until: () => Future.delayed(Duration(milliseconds: 200)),
        //delay for animation to run
        backgroundColor: Color(0xffC1FBCE),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  //Called by SplashScreen widget after running the animation

  @override
  _HomePageState createState() => _HomePageState(); //calls main page
}

class _HomePageState extends State<HomePage> {
  bool
      connectionStatus; //variable for checking if we are connected to the internet

  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
        //print("connected $connectionStatus");
      }
    } on SocketException catch (_) {
      connectionStatus = false;
      var webpage = "";
      webpage = await _loadLocalHTML();
      return webpage;
    }
  }

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: check(), //checks for internet
        builder: (context, snapshot) {
          //snapshot is data returned by check()
          if (connectionStatus == true) {
            //if Internet is connected
            return SafeArea(
                child: WebviewScaffold(
              url: homeUrl,
              initialChild: Center(
                  child: Container(
                child: Image.asset(
                  'assets/images/sccn_logo.png',
                  color: Colors.black,
                ),
              )),
            ));
          } else {
            //If internet is not connected
            return SafeArea(
                //this webpage is being fetched from assets folder
                child: WebviewScaffold(
              url: Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                  .toString(),
              initialChild: Center(
                  child: Container(
                child: Image.asset(
                  'assets/images/sccn_logo.png',
                  color: Colors.black,
                ),
              )),
            ));
          }
        });
  }
}

Future<String> _loadLocalHTML() async {
  var webPage = await rootBundle.loadString('assets/html_code.html');
  return webPage;
}
