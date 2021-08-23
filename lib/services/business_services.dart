import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/repository/repository.dart';

class BusinessServices {
  Repository _repository;

  BusinessServices() {
    _repository = Repository();
  }


  sendBusiness(Business _business) async {
    return await _repository.httpPost('businesses/', _business.toJson());
  }


  // editBusiness(int getId, Business _owner) async {
  //   return await _repository.httpPut('businesses/', getId, _owner.toJson());
  // }

  sendLineBus(LineBusiness data) async {
    return await _repository.httpPost('business-categories/?format=json', data.toJson());
  }

  getLineBus(int getId) async {
    return await _repository.httpGet2('business-categories/?business=', getId);
  }

  delLineBus(int getId) async {
    return await _repository.httpDelete('business-categories/', getId);
  }

  scanQR(String code) async {
    return await _repository.httpScanQR('businesses/?scan=', code);
  }



  editBusiness(int getId, Business _owner) async {
    return await _repository.httpPatcher('businesses/', getId, _owner.toJson());
  }


  getBusiness() async {
    return await _repository.httpGet('businesses/?format=json');
  }


  getqrcodeBus() async {
    return await _repository.httpGet('businesses/?qrcode');
  }




  addToDB(LineBusiness data) async {
    List<Map> items = await _repository.getLocalByCondition('businessTable', 'category', data.category);
    if(items.length > 0){
      return await _repository.updateLocal('businessTable', 'category', data.toMap());
    }
    return await _repository.saveLocal('businessTable', data.toMap());
  }

  getSQLdata() async {
    return await _repository.getAllLocal('businessTable');
  }


  delSQLdataById(int id) async {
    return await _repository.deleteLocalById('businessTable',id);
  }

  delSQLtable() async {
    return await _repository.deleteLocal('businessTable');
  }






  //testapi nga Barangay--------------------------

  getBarangay() async{
    return await _repository.httpGet('barangays/?format=json');
  }

  sendBarangay(Barangay _barangay) async {
    return await _repository.httpPost('barangays/', _barangay.toJson());
  }




}
