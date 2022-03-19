import 'dart:ui';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Journal(),
      ));
}

class Journal extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text('Journal',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: StreamBuilder(stream: collectionReference.orderBy('date', descending: true).snapshots(), // Order ListView using Date
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                      return ListView(
                        children: snapshot.data!.docs.map((e) => Column(
                          children: [
                            ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('${e['image']}', width: 20,),
                                      SizedBox( width:5),
                                      Text('${e['moodDetails']} - ${e['date']}',),

                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text('${e['desc']}'),
                              trailing: IconButton(
                                onPressed: () => showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                  title: Text('Delete'),
                                  content: Text('Are you sure you want to delete this entry?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          e.reference.delete();
                                            var testX = cRef.doc('${e['moodDetails']}',);
                                            testX.get().then((doc) => {
                                              testX.update({'moodVal': doc.get('moodVal')-1})
                                            });
                                          Navigator.pop(context, 'Delete');
                                            },
                                          child: Text('Delete'))

                                  ],
                                )
                                //
                                ),
                                color: Colors.black,
                                icon: Icon(Icons.delete),
                                tooltip: 'Delete',
                              ),
                            ),

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
