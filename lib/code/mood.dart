import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyMoodPage extends StatefulWidget {
  @override
  _MyMoodPageState createState() {
    return _MyMoodPageState();
  }
}

class _MyMoodPageState extends State<MyMoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Page')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('moods').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.mood.toString()),
          onTap: () =>  FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference ref = record.reference as DocumentReference;
            final freshSnapshot = await transaction.get(ref);
            final fresh = Record.fromSnapshot(freshSnapshot);

            await transaction
                .update(ref, {'mood': fresh.mood + 1});
          }),
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
      : assert(map['taskDetails'] != null),
        assert(map['mood'] != null),
        name = map['taskDetails'],
        mood = map['mood'];

  Record.fromSnapshot(DocumentSnapshot? snapshot)
      : this.fromMap(snapshot!.data() as Map<dynamic, dynamic>, reference: snapshot!.reference);

  @override
  String toString() => "Record<$name:$mood>";
}
