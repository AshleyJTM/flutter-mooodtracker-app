import 'package:firebase/pages/datepickerpage.dart';
import 'package:firebase/pages/row.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/pages/homepage.dart';
import 'package:firebase/pages/moodpage.dart';
import 'pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
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

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = const[
    HomePage(),
    MoodPage(),
    MoodRowPage(),
    DatePage(),
  ];

  @override // Test
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        selectedItemColor: Color(0xffE8005A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        //selectedFontSize: 16,
        //unselectedFontSize: 14,
        //showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Charts',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}