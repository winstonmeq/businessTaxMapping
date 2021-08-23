
import 'package:businesstaxmap/repository/repository.dart';

class LocationService{
  Repository _repository;

  LocationService(){
    _repository = Repository();
  }

  getLocation() async {
    return await _repository.httpGet3('locations.json');
  }




}// end class