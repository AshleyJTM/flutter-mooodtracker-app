import 'package:flutter/material.dart';
import 'package:firebase/code/voteselect.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        backgroundColor: Color(0xffE8005A),
        ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MyHomePage(),
      ));
}