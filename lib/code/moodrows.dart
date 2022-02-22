import 'dart:ui';
import 'package:firebase/main.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'journal.dart';

class MoodRowPage extends StatefulWidget {
  const MoodRowPage({Key? key}) : super(key: key);

  @override
  State<MoodRowPage> createState() => _MoodRowPageState();
}

class _MoodRowPageState extends State<MoodRowPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MoodRow(),
      ));
}

class MoodRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuthDemo(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class FirebaseAuthDemo extends StatefulWidget {
  @override
  State<FirebaseAuthDemo> createState() => _FirebaseAuthDemoState();
}

class _FirebaseAuthDemoState extends State<FirebaseAuthDemo> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('moods');
  final CollectionReference cRef =
      FirebaseFirestore.instance.collection('graphmoods');

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

  final TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60.0),
              child: RaisedButton(
                onPressed: () => _selectDate(context),
                child: const Text(
                  'Select Date',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,),
                ),
                color: Color(0xff3c73a8), // NTU Blue 0xff004877
              ),
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

                    // Snack bar shows notification and navigates to JournalPage.
                    final snackBar = SnackBar(
                      content: Text('Mood added successfully!'),
                      action: SnackBarAction(
                        label: 'View',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JournalPage(),
                              ));
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
                      'colorVal': "0xff06a118",
                      'moodDetails': "Very Happy",
                      'desc': myController.text,
                      'image': 'images/5.png',
                    });

                    // Clears data in TextField
                    myController.clear();

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Very Happy');
                    docRef.get().then((doc) => {
                          docRef.update({'moodVal': doc.get('moodVal') + 1})
                        });
                  },
                  child: Image.asset(
                    'images/5.png',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Snack bar shows notification and navigates to JournalPage.
                    final snackBar = SnackBar(
                      content: Text('Mood added successfully!'),
                      action: SnackBarAction(
                        label: 'View',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JournalPage(),
                              ));
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
                      'colorVal': "0xff7be815",
                      'moodDetails': "Happy",
                      'desc': myController.text,
                      'image': 'images/4.png',
                    });

                    // Clears data in TextField
                    myController.clear();

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Happy');
                    docRef.get().then((doc) => {
                          docRef.update({'moodVal': doc.get('moodVal') + 1})
                        });
                  },
                  child: Image.asset(
                    'images/4.png',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Snack bar shows notification and navigates to JournalPage.
                    final snackBar = SnackBar(
                      content: Text('Mood added successfully!'),
                      action: SnackBarAction(
                        label: 'View',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JournalPage(),
                              ));
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
                      'colorVal': "0xffe7f707",
                      'moodDetails': "Average",
                      'desc': myController.text,
                      'image': 'images/3.png',
                    });

                    // Clears data in TextField
                    myController.clear();

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Average');
                    docRef.get().then((doc) => {
                          docRef.update({'moodVal': doc.get('moodVal') + 1})
                        });
                  },
                  child: Image.asset(
                    'images/3.png',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Snack bar shows notification and navigates to JournalPage.
                    final snackBar = SnackBar(
                      content: Text('Mood added successfully!'),
                      action: SnackBarAction(
                        label: 'View',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalPage(),
                            ));
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
                      'colorVal': "0xffff76b07",
                      'moodDetails': "Sad",
                      'desc': myController.text,
                      'image': 'images/2.png',
                    });

                    // Clears data in TextField
                    myController.clear();

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Sad');
                    docRef.get().then((doc) => {
                          docRef.update({'moodVal': doc.get('moodVal') + 1}),
                        });
                  },
                  child: Image.asset(
                    'images/2.png',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    // Snack bar shows notification and navigates to JournalPage.
                    final snackBar = SnackBar(
                      content: Text('Mood added successfully!'),
                      action: SnackBarAction(
                        label: 'View',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JournalPage(),
                              ));
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    // Adds data into mood database as a new document
                    await collectionReference.add({
                      'date': DateFormat('dd-MM-yyyy').format(selectedDate),
                      'colorVal': "0xfff71f07",
                      'moodDetails': "Very Sad",
                      'desc': myController.text,
                      'image': 'images/1.png',
                    });

                    // Clears data in TextField
                    myController.clear();

                    // Collects document from graph moods database and updates by one value
                    var docRef = cRef.doc('Very Sad');
                    docRef.get().then((doc) => {
                          docRef.update({'moodVal': doc.get('moodVal') + 1})
                        });
                  },
                  child: Image.asset(
                    'images/1.png',
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.message),
                hintText: 'How has your day been today?',
              ),
            ),
            // Expanded(
            //     child: StreamBuilder(stream: collectionReference.orderBy('date', descending: true).snapshots(), // Order ListView using Date
            //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //         if(snapshot.hasData){
            //           return ListView(
            //             children: snapshot.data!.docs.map((e) => Column(
            //               children: [
            //                 ListTile(
            //                   title: Text('${e['moodDetails']} - ${e['date']}',),
            //                   subtitle: Text('${e['desc']}'),
            //                   trailing: IconButton(
            //                     onPressed: () async{
            //                       e.reference.delete();
            //                       var testX = cRef.doc('${e['moodDetails']}',);
            //                       testX.get().then((doc) => {
            //                         testX.update({'moodVal': doc.get('moodVal')-1})
            //                       });
            //                     },
            //                     color: Colors.black,
            //                     icon: Icon(Icons.delete),
            //                     tooltip: 'Delete',
            //                   ),
            //                 ),
            //                 Divider(color: Colors.black.withOpacity(0.6), thickness: 2,)
            //               ],
            //             )).toList(),
            //           );
            //         }
            //         return Center(child: CircularProgressIndicator(),);
            //       },
            //     )),
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
      : assert(map['moodDetails'] != null),
        // Assert checks for nul safety in values.
        assert(map['mood'] != null),
        name = map['moodDetails'],
        // Maps data from API to Variable
        mood = map['mood'];

  Record.fromSnapshot(DocumentSnapshot? snapshot)
      : this.fromMap(snapshot!.data() as Map<dynamic, dynamic>,
            reference: snapshot!.reference);

  @override
  String toString() => "Record<$name:$mood:>";
}
