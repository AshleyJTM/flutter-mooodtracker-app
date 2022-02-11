
class Mood {
  final int moodVal;
  final String moodDetails;
  final String colorVal;
  Mood(this.moodDetails,this.moodVal,this.colorVal);

  Mood.fromMap(Map<String, dynamic> map)
      : assert(map['moodDetails'] != null),
        assert(map['moodVal'] != null),
        assert(map['colorVal'] != null),
        moodDetails = map['moodDetails'],
        moodVal = map['moodVal'],
        colorVal=map['colorVal'];

  @override
  String toString() => "Record<$moodVal:$moodDetails>";
}
