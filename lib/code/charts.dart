import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/models/mood.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MoodChartsPage extends StatelessWidget {
  const MoodChartsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: MoodChart(),
      ));
}

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() {
    return _MoodChartState();
  }
}

class _MoodChartState extends State<MoodChart> {
  late List<charts.Series<Mood, String>> _seriesPieData;
  late List<Mood> mydata;
  _generateData(mydata) {
    _seriesPieData = <charts.Series<Mood, String>>[];
    _seriesPieData.add(
      charts.Series(
        domainFn: (Mood mood, _) => mood.moodDetails,
        measureFn: (Mood mood, _) => mood.moodVal,
        colorFn: (Mood mood, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(mood.colorVal))),
        id: 'moods',
        data: mydata,
        labelAccessorFn: (Mood row, _) => "${row.moodVal}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance.collection('graphmoods').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Mood> mood = snapshot.data!.docs
              .map((documentSnapshot) => Mood.fromMap(documentSnapshot.data()))
              .toList();
          return _buildChart(context, mood);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<Mood> mooddata) {
    mydata = mooddata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Feelings Graph',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 2),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        position: charts.BehaviorPosition.inside,
                        desiredMaxRows: 3,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}