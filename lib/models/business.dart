class Business {
 int id;
 String qr_code;
  int qrcode;
  String business_name;
  int barangay;
  String bar_name;
  String purok;
  String stall_no;
  String gps_longitude;
 String gps_latitude;
 String gps_altitud;
 String gps_accuracy;
  String owner_picture;
  String goods_services_picture;
  String business_permit_picture;
  String business_owner_name;
  String business_owner_number;
  String business_representative;
  String owner_gender;
  String ownership_type;
  String is_business_permit;
  String business_permit_status;
  String is_notice;
  String notice_remarks;
  String business_status;
  String payment_type;
  String inactive_remarks;
  String inactive_reason;
  String fsic;
  String fsic_number;
  String application_status;
 String capitalization_amount;
 String gross_sale_amount;
  int total_employees;
  int total_male;
  int total_female;
  String location_status;
 String location_rental_amount;
  String lessor_name;
  String owner_signature;
  String collector_signature;
  String collector_designation;
  String picture1;
  String picture2;
  String picture3;
  int team;
  int created_by;
  int modified_by;
  bool is_deleted;
  String submitted_from;
  String qrcode_url;


  Business({
    this.id,
    this.qr_code,
    this.qrcode,
    this.business_name,
    this.barangay,
    this.bar_name,
    this.purok,
    this.stall_no,
    this.gps_longitude,
    this.gps_latitude,
    this.gps_altitud,
    this.gps_accuracy,
    this.owner_picture,
    this.goods_services_picture,
    this.business_permit_picture,
    this.business_owner_name,
    this.business_owner_number,
    this.business_representative,
    this.owner_gender,
    this.ownership_type,
    this.is_business_permit,
    this.business_permit_status,
    this.is_notice,
    this.notice_remarks,
    this.business_status,
    this.payment_type,
    this.inactive_remarks,
    this.inactive_reason,
    this.fsic,
    this.fsic_number,
    this.application_status,
    this.capitalization_amount,
    this.gross_sale_amount,
    this.total_employees,
    this.total_male,
    this.total_female,
    this.location_status,
    this.location_rental_amount,
    this.lessor_name,
    this.owner_signature,
    this.collector_signature,
    this.collector_designation,
    this.picture1,
    this.picture2,
    this.picture3,
    this.team,
    this.created_by,
    this.modified_by,
    this.is_deleted,
    this.submitted_from,
    this.qrcode_url,

  });

  Map<String, String> toJson() {
    return {

      //'id': id.toString(),
      'qr_code':qr_code,
      'qrcode':qrcode.toString(),
      'business_name': business_name,
      'barangay': barangay.toString(),
      'purok': purok,
      'stall_no': stall_no,
      'gps_longitude': gps_longitude.toString(),
      'gps_latitude': gps_latitude.toString(),
      'gps_altitud': gps_altitud.toString(),
      'gps_accuracy': gps_accuracy.toString(),
      'owner_picture': owner_picture,
      'goods_service_picture': goods_services_picture,
      'business_permit_picture': business_permit_picture,
      'business_owner_name' : business_owner_name,
      'business_owner_number':business_owner_number,
       'business_representative':business_representative,
      'owner_gender':owner_gender,
      'ownership_type':ownership_type,
      'is_business_permit':is_business_permit,
       'business_permit_status':business_permit_status,
      'is_notice':is_notice,
      'notice_remarks':notice_remarks,
       'business_status':business_status,
       'payment_type':payment_type,
      'inactive_remarks':inactive_remarks,
       'inactive_reason': inactive_reason,
        'fsic':fsic,
      'fsic_number':fsic_number,
      'application_status':application_status,
      'capitalization_amount':capitalization_amount.toString(),
      'gross_sale_amount':gross_sale_amount.toString(),
      'total_employees':total_employees.toString(),
      'total_male':total_male.toString(),
      'total_female':total_female.toString(),
       'location_status':location_status,
       'location_rental_amount':location_rental_amount.toString(),
      'lessor_name':lessor_name,
      'owner_signature':owner_signature,
       'collector_signature':collector_signature,
       'collector_designation':collector_designation,
      'picture1':picture1,
      'picture2':picture1,
      'picture3':picture3,
      'team':team.toString(),
       'created_by':created_by.toString(),
      'modified_by':modified_by.toString(),
      'is_deleted':is_deleted.toString(),
      'submitted_from':submitted_from,
      'qrcode_url':qrcode_url,
    };
  }
}
