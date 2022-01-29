import 'package:flutter/material.dart';
import 'package:firebase/code/mood.dart';
import 'package:firebase/code/moodrows.dart';

class MoodRowPage extends StatelessWidget {
  const MoodRowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        backgroundColor: Color(0xffE8005A),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MoodRow(),
      ));
}