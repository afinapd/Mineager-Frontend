class Department {
  String id;
  String businessId;
  String name;

  Department({
   this.id,
   this.businessId,
   this.name});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'businessId':businessId,
      'name':name
    };
  }
}