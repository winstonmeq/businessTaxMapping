class Barangay {
  int id;
  String barangay_name;


  Barangay({this.id,this.barangay_name});

 Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'barangay_name':barangay_name,

    };
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barangay_name': barangay_name,

    };

  }

}