import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MoodRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuthDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class FirebaseAuthDemo extends StatefulWidget {
  @override
  State<FirebaseAuthDemo> createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('moods');

  var selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Select date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Colors.greenAccent,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    await collectionReference.add({
                      'mood': 5,
                      'date': selectedDate,
                    });
                  },
                  child: Image.asset('images/5.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await collectionReference.add({
                      'mood': 4,
                      'date': selectedDate,
                    });
                  },
                  child: Image.asset('images/4.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await collectionReference.add({
                      'mood': 3,
                      'date': selectedDate,
                    });
                  },
                  child: Image.asset('images/3.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await collectionReference.add({
                      'mood': 2,
                      'date': selectedDate,
                    });
                  },
                  child: Image.asset('images/2.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await collectionReference.add({
                      'mood': 1,
                      'date': selectedDate,
                    });
                  },
                  child: Image.asset('images/1.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Expanded(
                child: StreamBuilder(stream: collectionReference.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                      return ListView(
                        children: snapshot.data!.docs.map((e) => Column(
                          children: [
                            ListTile(title: Text('${e['mood']}'),),
                            Divider(color: Colors.black.withOpacity(0.6), thickness: 2,)
                          ],
                        )).toList(),
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
