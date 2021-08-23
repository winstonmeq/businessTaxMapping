class Barangay {
  int id;
  String barangay_name;
  String is_delete;
  String a;

  Barangay({this.id,this.barangay_name,this.is_delete,this.a});

 Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'barangay_name':barangay_name,
      'is_delete': is_delete,
     // 'a':a
    };
  }

}