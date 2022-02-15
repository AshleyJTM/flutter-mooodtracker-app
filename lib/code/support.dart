import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                'Support Page',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'NTU Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://www.ntu.ac.uk/studenthub/student-help-advice-and-services/health-and-wellbeing/mental-health'),
                builder: (context, followLink ) => ElevatedButton(
                  onPressed: followLink,
                  child: Text('Mental health support and services')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
