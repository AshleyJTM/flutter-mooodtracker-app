import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase/services/notificationservice.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Settings(),
      ));
}

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;
  bool click = true;
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(Icons.notifications),
                SizedBox(width: 5),
                Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Switch(
                  value: click,
                  onChanged: (value){
                    setState(() {
                      click = !click;
                    });
                    if (click == true){
                      NotificationService().showNotification(1, "NTYOU", "Have you entered how your feeling today? ", 5);};
                    if (click == false) {NotificationService().cancelAllNotifications();}},
                  ),
              ],
            ),
            SizedBox(height: 300),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signed in as',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.email!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                      icon: Icon(Icons.logout, size: 32),
                      label: Text(
                        'Logout',
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
