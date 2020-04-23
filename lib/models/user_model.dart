class User{
  String id;
  String qrId;
  String nfcId;
  String name;
  String birth;
  String email;
  String livingPartner;
  String phone;
  String photoUrl;
  String departmentId;
  int bloodTypeId;
  int genderId;

  User({
    this.id,
    this.qrId,
    this.nfcId,
    this.name,
    this.birth,
    this.email,
    this.livingPartner,
    this.phone,
    this.photoUrl,
    this.departmentId,
    this.bloodTypeId,
    this.genderId});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'qrId':qrId,
      'nfcId':nfcId,
      'name':name,
      'birth':birth,
      'email':email,
      'livingPartner':livingPartner,
      'phone':phone,
      'photoUrl':photoUrl,
      'departmentId':departmentId,
      'bloodTypeId':bloodTypeId,
      'genderId':genderId,
    };
  }
}


