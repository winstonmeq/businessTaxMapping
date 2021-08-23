import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/repository/repository.dart';

class CategoryServices {
  Repository _repository;

  CategoryServices() {
    _repository = Repository();
  }

  sendCategory(Category _category) async {
    return await _repository.httpPost('categories/?format=json', _category.toJson());
  }

  getCategory() async {
    return await _repository.httpGet('categories/?format=json');
  }


}
