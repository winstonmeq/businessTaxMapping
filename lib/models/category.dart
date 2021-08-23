class Category {
  int id;
  String category_name;
  bool is_pushed;


  Category({this.id,this.category_name, this.is_pushed});


  Map<String, dynamic> toMap() {
    return {
    'id': id,
      'category_name': category_name,
      'iis_pushed': is_pushed
    };

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'category_name':category_name
    };
  }

}