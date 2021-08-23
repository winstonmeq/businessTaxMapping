class Users {
  int id;

  String username;
  String password;



  Users({this.id,this.username,this.password});

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),

      'username':username,
      'password':password,

    };
  }

}