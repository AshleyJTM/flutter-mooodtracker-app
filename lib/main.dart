import 'package:firebase/code/charts.dart';
import 'package:firebase/code/journal.dart';
import 'package:firebase/code/moodrows.dart';
import 'package:firebase/code/settings.dart';
import 'package:firebase/code/support.dart';
import 'package:firebase/services/notificationservice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/splash.dart';

import 'package:firebase/pages/auth_page.dart';
import 'package:firebase/pages/home_page.dart';
import 'package:firebase/utils.dart';
import 'package:firebase/widget/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = FirebaseAuth.instance.currentUser;
  NotificationService().initNotification();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'NTYOU';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      color: Color(0xffE8005A),
      home: Splash(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();

}

// Navigation pages which defines is create in an array
class _MainPageState extends State<MainPage> {
  int currentIndex = 2;
  final screens = const[
    SupportPage(),
    JournalPage(),
    MoodRowPage(),
    MoodChartsPage(),
    SettingsPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
            tooltip: 'Logout',
          )
        ],
        backgroundColor: Color(0xffE8005A), // NTU Pink 0xffE8005A
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xffE8005A),
        unselectedItemColor: Color(0xffB4B4B4),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        //selectedFontSize: 16,
        //unselectedFontSize: 14,
        //showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Support',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Journal',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Moods',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Charts',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}