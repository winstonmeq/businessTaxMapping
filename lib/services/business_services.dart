import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/models/taxmapping.dart';
import 'package:businesstaxmap/repository/repository.dart';

class BusinessServices {
  Repository _repository;

  BusinessServices() {
    _repository = Repository();
  }


  sendBusiness(Business _business) async {
    return await _repository.httpPost('businesses/', _business.toJson());
  }


  sendBusiness2(Business _business) async {
    return await _repository.httpPost2('businesses/', _business.toJson());
  }


  sendLineBus(LineBusiness data) async {
    return await _repository.httpPost('business-categories/?format=json', data.toJson());
  }


  sendBusinessPeriod(BusinessPeriod _businessperiod) async {
    return await _repository.httpPost('businesses/', _businessperiod.toJson());
  }

  sendBusPeriod(BusinessPeriod data) async {
    return await _repository.httpPost('business-periods/',data.toJson());
  }



  downloadLineBus() async {
    return await _repository.httpGet('business-categories/');
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
    return await _repository.httpGet2('businesses/?size=',10000);
  }


  getBusiness2() async {
    return await _repository.httpGet('businesses/');
  }

//mao ni code na maka add business na blank
  getqrcodeBus() async {
    return await _repository.httpGet('businesses/?qrcode');
  }


  getPeriod() async {
    return await _repository.httpGet('periods/?active=true');
  }





  searchBus(String searchval) async {
    return await _repository.httpsearch('businesses/?search=',searchval);
  }


//dre gina add ang linebussiness
  addToLineBus(LineBusiness data) async {
    List<Map> items = await _repository.getLocalByCondition('businessTable', 'id', data.id);
    if(items.length > 0){
      return await _repository.updateLocal('businessTable', 'id', data.toMap());
    }
    return await _repository.saveLocal('businessTable', data.toMap());
  }


  //mao nih gamiton
  addBusinessSQL(Business data) async {
    List<Map> items = await _repository.getLocalByCondition('businessData', 'id', data.id);
    if(items.length > 0){
      return await _repository.updateLocal('businessData', 'id', data.toMap());
    }
    return await _repository.saveLocal('businessData', data.toMap());
  }


  addBarangaySQL(Barangay data) async {
    List<Map> items = await _repository.getLocalByCondition('barangayTable', 'id', data.id);
    if(items.length > 0){
      return await _repository.updateLocal('barangayTable', 'id', data.toMap());
    }
    return await _repository.saveLocal('barangayTable', data.toMap());
  }


  addCategorySQL(Category data) async {
    List<Map> items = await _repository.getLocalByCondition('categoryTable', 'id', data.id);
    if(items.length > 0){
      return await _repository.updateLocal('categoryTable', 'id', data.toMap());
    }
    return await _repository.saveLocal('categoryTable', data.toMap());
  }



  //mao nih code para mag kuha sang business details gamit ang qrcode string
  scanQRBusinessName(String qrstring) async{
    return await _repository.getLocalByCondition('businessData','qr_code', qrstring);
  }





//mao nih magkuha businessdata base sa business name para sa addbusiness nga page
  getBusinessName() async{
    return await _repository.getLocalByCondition('businessData','business_name', 'Business');
  }




//mao nih magkuha ka sa line business gamit Id sa business
  getLineBusByIdSQL(int busId) async{
    return await _repository.getLocalByCondition('businessTable','business', busId);
  }




//dire mag kuha sang SQl data para business
  getSQLdata2() async {
    return await _repository.getAllLocal('businessData');
  }


//dre mag kuha sang data para upload sa server
  getLineBusSQL() async {
    return await _repository.getAllLocal('businessTable');
  }


  getSQLBarangay() async {
    return await _repository.getAllLocal('barangayTable');
  }


  getSQLcategoryTable() async {
    return await _repository.getAllLocal('categoryTable');
  }










  delSQLdataById(int id) async {
    return await _repository.deleteLocalById('businessTable',id);
  }

  delSQLLineBus() async {
    return await _repository.deleteLocal('businessTable');
  }


  delSQLtable() async {
    return await _repository.deleteLocal('businessData');
  }

  delSQLbarangay() async {
    return await _repository.deleteLocal('barangayTable');
  }


  delSQLcategory() async {
    return await _repository.deleteLocal('categoryTable');
  }




  getCategory() async {
    return await _repository.httpGet('categories/?format=json');
  }

  getBarangay() async{
    return await _repository.httpGet('barangays/?format=json');
  }

  sendBarangay(Barangay _barangay) async {
    return await _repository.httpPost('barangays/', _barangay.toJson());
  }




}
