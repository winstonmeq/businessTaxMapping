class Category {
  int id;
  String category_name;



  Category({this.id,this.category_name});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_name': category_name,

    };

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'category_name':category_name
    };
  }

}