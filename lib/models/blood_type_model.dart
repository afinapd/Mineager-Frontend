class BloodType {
  int id;
  String type;

  BloodType({
    this.id,
    this.type});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'type':type,
    };
  }
}