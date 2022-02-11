import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase/models/mood.dart';

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
  final CollectionReference cRef = FirebaseFirestore.instance.collection('graphmoods');

// Date & Time select function
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
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: const Text(
                'Select date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Colors.greenAccent,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': selectedDate,
                      'colorVal': "0xff06a118",
                      'moodDetails': "Very Happy",
                      //'desc': "I feel very happy today",
                    });

                    // Collects document from graph moods database and updates by one value
                   var docRef = cRef.doc('Very Happy');
                   docRef.get().then((doc) => {
                    docRef.update({'moodVal': doc.get('moodVal')+1})
                   });
                  },
                  child: Image.asset('images/5.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': selectedDate,
                      'colorVal': "0xff7be815",
                      'moodDetails': "Happy",
                    });

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Happy');
                    docRef.get().then((doc) => {
                      docRef.update({'moodVal': doc.get('moodVal')+1})
                    });
                  },
                  child: Image.asset('images/4.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': selectedDate,
                      'colorVal': "0xffe7f707",
                      'moodDetails': "Average",
                    });

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Average');
                    docRef.get().then((doc) => {
                      docRef.update({'moodVal': doc.get('moodVal')+1})
                    });
                  },
                  child: Image.asset('images/3.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': selectedDate,
                      'colorVal': "0xffff76b07",
                      'moodDetails': "Upset",
                    });

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Upset');
                    docRef.get().then((doc) => {
                      docRef.update({'moodVal': doc.get('moodVal')+1})
                    });
                  },
                  child: Image.asset('images/2.jpg',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': selectedDate,
                      'colorVal': "0xfff71f07",
                      'moodDetails': "Depressed",
                    });

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Depressed');
                    docRef.get().then((doc) => {
                      docRef.update({'moodVal': doc.get('moodVal')+1})
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
                            ListTile(title: Text('${e['moodDetails']}',),),
                            //Text('${e['date']}'),
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




class Record {
  final String name;
  final int mood;
  final DocumentReference? reference;

  Record.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : assert(map['moodDetails'] != null), // Assert checks for nul safety in values.
        assert(map['mood'] != null),
        name = map['moodDetails'], // Maps data from API to Variable
        mood = map['mood'];


  Record.fromSnapshot(DocumentSnapshot? snapshot)
      : this.fromMap(snapshot!.data() as Map<dynamic, dynamic>, reference: snapshot!.reference);

  @override
  String toString() => "Record<$name:$mood:>";
}
