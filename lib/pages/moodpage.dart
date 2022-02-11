import 'package:firebase/code/mood.dart';
import 'package:firebase/code/voteselect.dart';
import 'package:flutter/material.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        backgroundColor: Color(0xffE8005A),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MyMoodPage(),
      ));
}