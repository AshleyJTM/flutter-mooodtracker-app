import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Support(),
      ));
}

class Support extends StatelessWidget {
  Support({Key? key}) : super(key: key);

  static const textColor = Color(0xff3c73a8); //NTU Blue 0xFF004877
  var align = Alignment.center; // Allignment.centerLeft

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                'Support',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: align,
              child: Text(
                'NTU Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
             alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://www.ntu.ac.uk/studenthub/student-help-advice-and-services/health-and-wellbeing/mental-health'),
                builder: (context, followLink ) => ElevatedButton(
                  onPressed: followLink,
                  child: Text('Mental health support and services'),
                style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: align,
              child: Text(
                'Suicide Helpline',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
            alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://www.papyrus-uk.org/'),
                builder: (context, followLink ) => ElevatedButton(
                    onPressed: followLink,
                    child: Text('United Kingdom Suicide Support Line'),
                    style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
            Container(
          alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://unitedgmh.org/mental-health-support'),
                builder: (context, followLink ) => ElevatedButton(
                    onPressed: followLink,
                    child: Text('International Suicide Support Line'),
                    style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
            Container(
             alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://www.thecalmzone.net/'),
                builder: (context, followLink ) => ElevatedButton(
                    onPressed: followLink,
                    child: Text('Campaign Against Living Miserably'),
                    style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
           alignment: align,
              child: Text(
                'Healthy NTU',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
            alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://myntuac.sharepoint.com/sites/HealthyNTU'),
                builder: (context, followLink ) => ElevatedButton(
                    onPressed: followLink,
                    child: Text('NTU health promotion programme'),
                    style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
             alignment: align,
              child: Text(
                'Student Mind',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
          alignment: align,
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse('https://studentspace.org.uk/'),
                builder: (context, followLink ) => ElevatedButton(
                    onPressed: followLink,
                    child: Text('Student Space'),
                    style: ElevatedButton.styleFrom(primary: textColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
