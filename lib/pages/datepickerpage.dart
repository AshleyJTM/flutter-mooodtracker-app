import 'package:flutter/material.dart';
import 'package:firebase/code/datepicker.dart';
import 'package:firebase/code/moodhomepage.dart';

class DatePage extends StatelessWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        backgroundColor: Color(0xffE8005A),
        ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MoodHomePage(),
      ));
}