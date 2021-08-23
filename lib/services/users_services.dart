import 'package:businesstaxmap/models/users.dart';
import 'package:businesstaxmap/repository/repository.dart';

class UsersServices {
  Repository _repository;

  UsersServices() {
    _repository = Repository();
  }


  sendUsers(Users _users) async {
    return await _repository.httpPost('users/', _users.toJson());
  }

  getUsers() async {
    return await _repository.httpGet('users/?format=json');
  }

  login(Users _users) async {
    return await _repository.httpPost('token/login/', _users.toJson());
  }


}
