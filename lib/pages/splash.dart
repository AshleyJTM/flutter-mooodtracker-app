import 'package:firebase/pages/auth_page.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase/widget/login_widget.dart';

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
      navigateAfterSeconds: new Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError){
                return Center(child: Text('Something went wrong!'));
              } else if (snapshot.hasData) {
                return MainPage();
              } else {
                return AuthPage();
              }
            }),
      ),
      title: new Text('NTYOU',textScaleFactor: 2,),
      image: new Image.network('https://upload.wikimedia.org/wikipedia/en/thumb/b/bb/Nottingham_Trent_University_shield.svg/1200px-Nottingham_Trent_University_shield.svg.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Color(0xffE8005A),
    );
  }
}