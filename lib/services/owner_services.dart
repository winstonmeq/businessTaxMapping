import 'package:businesstaxmap/models/owner.dart';
import 'package:businesstaxmap/repository/repository.dart';
import 'package:businesstaxmap/screen/editOwner.dart';

class OwnerServices {
  Repository _repository;

  OwnerServices() {
    _repository = Repository();
  }

  ownerSend(Owner _owner) async {
    return await _repository.httpPost('owner/', _owner.toJson());
  }

  getOwner() async {
    return await _repository.httpGet('owner/');
  }


  // editOwner(int getId, Owner _owner) async {
  //   return await _repository.httpPut('owner/', getId, _owner.toJson());
  // }

}
