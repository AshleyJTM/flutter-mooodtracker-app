import 'package:flutter/material.dart';
import 'package:firebase/code/settings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase/services/notificationservice.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  bool click = true;
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('NTYOU'),
        backgroundColor: Color(0xffE8005A),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  click = !click;
                });
                if (click == true){
                  NotificationService().showNotification(1, "NTYOU", "Have you entered how your feeling today? ", 5);};
                if (click == false) {NotificationService().cancelAllNotifications();}},
              icon: Icon((click) ? Icons.notifications_active : Icons.notifications_off))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Settings(),
      ));
}