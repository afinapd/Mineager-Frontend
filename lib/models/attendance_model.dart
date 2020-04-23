class Attendance{
  String id;
  String date;
  String time;
  String userId;

  Attendance({
    this.id,
    this.date,
    this.time,
    this.userId});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'date':date,
      'time':time,
      'userId':userId
    };
  }
}