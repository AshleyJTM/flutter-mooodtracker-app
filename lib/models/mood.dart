
class Mood {
  final int moodVal;
  final String taskDetails;
  final String colorVal;
  Mood(this.taskDetails,this.moodVal,this.colorVal);

  Mood.fromMap(Map<String, dynamic> map)
      : assert(map['taskDetails'] != null),
        assert(map['mood'] != null),
        assert(map['colorVal'] != null),
        taskDetails = map['taskDetails'],
        moodVal = map['mood'],
        colorVal=map['colorVal'];

  @override
  String toString() => "Record<$moodVal:$taskDetails>";
}
