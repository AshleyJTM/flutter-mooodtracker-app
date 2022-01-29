import 'package:flutter/material.dart';
import '../main.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new MainPage(),
      title: new Text('NTYOU',textScaleFactor: 2,),
      image: new Image.network('https://upload.wikimedia.org/wikipedia/en/thumb/b/bb/Nottingham_Trent_University_shield.svg/1200px-Nottingham_Trent_University_shield.svg.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Color(0xffE8005A),
    );
  }
}