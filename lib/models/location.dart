class Location {
  int id;
  String address;
  String idd;
  String image;
  double lat;
  double long;
  String name;
  String phone;
  String region;


  Location({this.id, this.address, this.idd, this.image, this.lat, this.long, this.name, this.phone, this.region});

  toMap(){
    var map = Map<String, dynamic>();
    map['Id'] = id;
    map['address'] = address;
    map['idd'] = idd;
    map['image'] = image;
    map['lat'] = lat;
    map['long'] = long;
    map['name'] = name;
    map['phone'] = phone;
    map['region'] = region;

    return map;
  }

  Location.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    address = json['address'];
    idd = json['idd'];
    image = json['image'];
    lat = json['lat'];
    long = json['long'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];

  }


  Map<String, dynamic>toJson() {
    return {
      'Id' : id.toString(),
      'address' : address,
      'idd' : idd,
      'image' : image,
      'lat' : lat.toString(),
      'long': long.toString(),
      'name': name,
      'phone' : phone,
      'region' : region
    };
  }
}