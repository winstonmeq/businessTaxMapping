class LineBusiness {
  int id;
  int category;
  int business;
  String comment;
  bool is_pushed;
  String cat_name;
  int created_by;

  LineBusiness({this.id, this.category, this.business,this.comment,this.is_pushed, this.cat_name,  this.created_by});





/// mao ni json para ma save sang data sa sql.. dapat mao nih pud field na sudlan mo
  ///
  ///
  Map<String, dynamic> toMap() {
    return {
      //'id': id.toString(), dile na pud eh apil kay naa na automatic nga id sa sql
      'category': category.toString(),
      'business': business.toString(),

      //----comment naga error sya.. kay wala sya na add sa sql database
      //'comment': comment,
      'is_pushed': is_pushed,
      'cat_name': cat_name,

      'created_by': created_by.toString()

    };
  }



  Map<String, dynamic> toJson() {
    return {
      // 'id': id.toString(),
      'category': category.toString(),
      'business': business.toString(),
      //'comment': comment,
      // 'is_pushed': is_pushed,
      // 'cat_name': cat_name,
      // 'created_by': created_by.toString()

    };
  }



}
