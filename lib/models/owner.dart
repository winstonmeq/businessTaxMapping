class Owner {
  int id;
  int owner_code;
  String last_name;
  String first_name;
  String middle_name;
  String extension;
  String birth_date;
  String gender;
  String nationality;
  String contact_no;
  String photo;
  String address;
  String email;
  String update_by;

  Owner(
      {this.id,
      this.owner_code,
      this.last_name,
      this.first_name,
      this.middle_name,
      this.extension,
      this.birth_date,
      this.gender,
      this.nationality,
      this.contact_no,
      this.photo,
      this.address,
      this.email,
      this.update_by});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_code': owner_code,
      'last_name': last_name,
      'first_name': first_name,
      'middle_name': middle_name,
      'extension': extension,
      'birth_date': birth_date,
      'gender': gender,
      'nationality': nationality,
      'contact_no': contact_no,
      'photo': photo.toString(),
      'address': address,
      'email': email,
      'update_by': update_by,
    };
  }

  Map<String, dynamic>toJson() {
    return {
      'id': id.toString(),
      'owner_code': owner_code.toString(),
      'last_name': last_name,
      'first_name': first_name,
      'middle_name': middle_name,
      'extension': extension,
      'birth_date': birth_date,
      'gender': gender,
      'nationality': nationality,
      'contact_no': contact_no,
      'photo': photo.toString(),
      'address': address,
      'email': email,
      'update_by': update_by,
    };
  }






}
