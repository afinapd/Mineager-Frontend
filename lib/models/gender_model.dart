class Gender {
  int id;
  String gender;

  Gender({
    this.id,
    this.gender});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'gender':gender,
    };
  }
}