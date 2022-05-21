class BusinessPeriod {

  int period;
  int business;
  int collector;
  String comment;
  int created_by;


  BusinessPeriod({this.period, this.business,this.collector, this.comment,this.created_by});



  Map<String, dynamic> toJson() {
    return {

      'period': period.toString(),
      'business': business.toString(),
      'collectorId': collector.toString(),
      'comment': comment,
      'created_by': created_by.toString(),
    };
  }



}
