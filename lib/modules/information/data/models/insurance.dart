class InsuranceModel {
  int id;
  int gigenderCodeId;
  int girelOfGuarantorCodeId;
  String gifirstName;
  String gilastName;
  String giaddress1;
  String giaddress2;
  String gicity;
  String gizip;
  String gihomePhone;
  String gicellPhone;
  String giworkPhone;
  String gcity;
  String gstate;
  String gzip;
  int gistatesCodeId;
  int giprefferedContactCodeId;
  String dob;

  InsuranceModel(
      {this.id,
      this.gigenderCodeId,
      this.girelOfGuarantorCodeId,
      this.gifirstName,
      this.gilastName,
      this.giaddress1,
      this.giaddress2,
      this.gicity,
      this.gizip,
      this.gihomePhone,
      this.gicellPhone,
      this.giworkPhone,
      this.gcity,
      this.gstate,
      this.gzip,
      this.gistatesCodeId,
      this.giprefferedContactCodeId,
      this.dob,
      });

  InsuranceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gigenderCodeId = json['gigenderCodeId'];
    girelOfGuarantorCodeId = json['girelOfGuarantorCodeId'];
    gifirstName = json['gifirstName'];
    gilastName = json['gilastName'];
    giaddress1 = json['giaddress1'];
    giaddress2 = json['giaddress2'];
    gicity = json['gicity'];
    gizip = json['gizip'];
    gihomePhone = json['gihomePhone'];
    gicellPhone = json['gicellPhone'];
    giworkPhone = json['giworkPhone'];
    gcity = json['gcity'];
    gstate = json['gstate'];
    gzip = json['gzip'];
    giprefferedContactCodeId = json['giprefferedContactCodeId'];
    dob = json['dob'];
    // publicityCodeNavigation = json['publicityCodeNavigation'] != null
    //     ? new PublicityCodeNavigation.fromJson(json['publicityCodeNavigation'])
    //     : null;
    // registryStatusCodeNavigation = json['registryStatusCodeNavigation'] != null
    //     ? new RegistryStatusCodeNavigation.fromJson(
    //         json['registryStatusCodeNavigation'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gigenderCodeId'] = this.gigenderCodeId;
    data['girelOfGuarantorCodeId'] = this.girelOfGuarantorCodeId;
    data['gifirstName'] = this.gifirstName;
    data['gilastName'] = this.gilastName;
    data['giaddress1'] = this.giaddress1;
    data['giaddress2'] = this.giaddress2;
    data['gicity'] = this.gicity;
    data['gizip'] = this.gizip;
    data['gihomePhone'] = this.gihomePhone;
    data['gicellPhone'] = this.gicellPhone;
    data['giworkPhone'] = this.giworkPhone;
    data['gcity'] = this.gcity;
    data['gstate'] = this.gstate;
    data['gzip'] = this.gzip;
    data['gistatesCodeId'] = this.gistatesCodeId;
    data['giprefferedContactCodeId'] = this.giprefferedContactCodeId;
    data['dob'] = this.dob;
    // if (this.publicityCodeNavigation != null) {
    //   data['publicityCodeNavigation'] = this.publicityCodeNavigation.toJson();
    // }
    // if (this.registryStatusCodeNavigation != null) {
    //   data['registryStatusCodeNavigation'] =
    //       this.registryStatusCodeNavigation.toJson();
    // }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gigenderCodeId'] = this.gigenderCodeId;
    data['girelOfGuarantorCodeId'] = this.girelOfGuarantorCodeId;
    data['gifirstName'] = this.gifirstName;
    data['gilastName'] = this.gilastName;
    data['giaddress1'] = this.giaddress1;
    data['giaddress2'] = this.giaddress2;
    data['gicity'] = this.gicity;
    data['gizip'] = this.gizip;
    data['gihomePhone'] = this.gihomePhone;
    data['gicellPhone'] = this.gicellPhone;
    data['giworkPhone'] = this.giworkPhone;
    data['gcity'] = this.gcity;
    data['gstate'] = this.gstate;
    data['gzip'] = this.gzip;
    data['gistatesCodeId'] = this.gistatesCodeId;
    data['giprefferedContactCodeId'] = this.giprefferedContactCodeId;
    data['dob'] = this.dob;
  
    return data;
  }
}

class GenderNavigation {
  int id;
  String name;
  String code;

  GenderNavigation(this.id, this.name, this.code);

  GenderNavigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class PrefferedContactNavigation {
  String dataValue;
  String displayTest;

  PrefferedContactNavigation(this.dataValue, this.displayTest);

  PrefferedContactNavigation.fromJson(Map<String, dynamic> json) {
    dataValue = json['dataValue'];
    displayTest = json['displayTest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataValue'] = this.dataValue;
    data['displayTest'] = this.displayTest;
    return data;
  }
}


// class PublicityCodeNavigation {
//   String code;
//   String description;
//   String codeSystem;
//   int id;

//   PublicityCodeNavigation(
//       {this.code, this.description, this.codeSystem, this.id});

//   PublicityCodeNavigation.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     description = json['description'];
//     codeSystem = json['codeSystem'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['description'] = this.description;
//     data['codeSystem'] = this.codeSystem;
//     data['id'] = this.id;
//     return data;
//   }
// }

// class RegistryStatusCodeNavigation {
//   String code;
//   String description;
//   int id;

//   RegistryStatusCodeNavigation({this.code, this.description, this.id});

//   RegistryStatusCodeNavigation.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     description = json['description'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['description'] = this.description;
//     data['id'] = this.id;
//     return data;
//   }
// }
