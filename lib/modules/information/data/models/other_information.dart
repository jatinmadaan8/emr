class OtherInformationModel {
  int id;
  int resesitate;
  String poaname;
  String poaaddress1;
  String poaaddress2;
  String poacity;
  String poastate;
  String poazip;
  String gname;
  String gaddress1;
  String gaddress2;
  String gcity;
  String gstate;
  String gzip;
  String medicalRelNames;
  bool homeHealth;
  bool nursingHome;
  bool hospice;
  bool impairment;
  String homeHealthLoc;
  String nursingHomeLoc;
  String hospiceLoc;
  String impairmentLoc;
  String ecfirstName;
  String eclastName;
  String ecmiddleInitial;
  String ecrelationship;
  String ecphoneNumber;
  int livingWill;
  int publicityCodeId;
  int registryStatusCodeId;
  String publicityEffDate;
  String registryEffDate;
  int shareHealthData;
  String shareHealthDataEffDate;
  PublicityCodeNavigation publicityCodeNavigation;
  RegistryStatusCodeNavigation registryStatusCodeNavigation;

  OtherInformationModel(
      {this.id,
      this.resesitate,
      this.poaname,
      this.poaaddress1,
      this.poaaddress2,
      this.poacity,
      this.poastate,
      this.poazip,
      this.gname,
      this.gaddress1,
      this.gaddress2,
      this.gcity,
      this.gstate,
      this.gzip,
      this.medicalRelNames,
      this.homeHealth,
      this.nursingHome,
      this.hospice,
      this.impairment,
      this.homeHealthLoc,
      this.nursingHomeLoc,
      this.hospiceLoc,
      this.impairmentLoc,
      this.ecfirstName,
      this.eclastName,
      this.ecmiddleInitial,
      this.ecrelationship,
      this.ecphoneNumber,
      this.livingWill,
      this.publicityCodeId,
      this.registryStatusCodeId,
      this.publicityEffDate,
      this.registryEffDate,
      this.shareHealthData,
      this.shareHealthDataEffDate,
      this.publicityCodeNavigation,
      this.registryStatusCodeNavigation});

  OtherInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resesitate = json['resesitate'];
    poaname = json['poaname'];
    poaaddress1 = json['poaaddress1'];
    poaaddress2 = json['poaaddress2'];
    poacity = json['poacity'];
    poastate = json['poastate'];
    poazip = json['poazip'];
    gname = json['gname'];
    gaddress1 = json['gaddress1'];
    gaddress2 = json['gaddress2'];
    gcity = json['gcity'];
    gstate = json['gstate'];
    gzip = json['gzip'];
    medicalRelNames = json['medicalRelNames'];
    homeHealth = json['homeHealth'];
    nursingHome = json['nursingHome'];
    hospice = json['hospice'];
    impairment = json['impairment'];
    homeHealthLoc = json['homeHealthLoc'];
    nursingHomeLoc = json['nursingHomeLoc'];
    hospiceLoc = json['hospiceLoc'];
    impairmentLoc = json['impairmentLoc'];
    ecfirstName = json['ecfirstName'];
    eclastName = json['eclastName'];
    ecmiddleInitial = json['ecmiddleInitial'];
    ecrelationship = json['ecrelationship'];
    ecphoneNumber = json['ecphoneNumber'];
    livingWill = json['livingWill'];
    publicityCodeId = json['publicityCodeId'];
    registryStatusCodeId = json['registryStatusCodeId'];
    publicityEffDate = json['publicityEffDate'];
    registryEffDate = json['registryEffDate'];
    shareHealthData = json['shareHealthData'];
    shareHealthDataEffDate = json['shareHealthDataEffDate'];
    publicityCodeNavigation = json['publicityCodeNavigation'] != null
        ? new PublicityCodeNavigation.fromJson(json['publicityCodeNavigation'])
        : null;
    registryStatusCodeNavigation = json['registryStatusCodeNavigation'] != null
        ? new RegistryStatusCodeNavigation.fromJson(
            json['registryStatusCodeNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resesitate'] = this.resesitate;
    data['poaname'] = this.poaname;
    data['poaaddress1'] = this.poaaddress1;
    data['poaaddress2'] = this.poaaddress2;
    data['poacity'] = this.poacity;
    data['poastate'] = this.poastate;
    data['poazip'] = this.poazip;
    data['gname'] = this.gname;
    data['gaddress1'] = this.gaddress1;
    data['gaddress2'] = this.gaddress2;
    data['gcity'] = this.gcity;
    data['gstate'] = this.gstate;
    data['gzip'] = this.gzip;
    data['medicalRelNames'] = this.medicalRelNames;
    data['homeHealth'] = this.homeHealth;
    data['nursingHome'] = this.nursingHome;
    data['hospice'] = this.hospice;
    data['impairment'] = this.impairment;
    data['homeHealthLoc'] = this.homeHealthLoc;
    data['nursingHomeLoc'] = this.nursingHomeLoc;
    data['hospiceLoc'] = this.hospiceLoc;
    data['impairmentLoc'] = this.impairmentLoc;
    data['ecfirstName'] = this.ecfirstName;
    data['eclastName'] = this.eclastName;
    data['ecmiddleInitial'] = this.ecmiddleInitial;
    data['ecrelationship'] = this.ecrelationship;
    data['ecphoneNumber'] = this.ecphoneNumber;
    data['livingWill'] = this.livingWill;
    data['publicityCodeId'] = this.publicityCodeId;
    data['registryStatusCodeId'] = this.registryStatusCodeId;
    data['publicityEffDate'] = this.publicityEffDate;
    data['registryEffDate'] = this.registryEffDate;
    data['shareHealthData'] = this.shareHealthData;
    data['shareHealthDataEffDate'] = this.shareHealthDataEffDate;
    if (this.publicityCodeNavigation != null) {
      data['publicityCodeNavigation'] = this.publicityCodeNavigation.toJson();
    }
    if (this.registryStatusCodeNavigation != null) {
      data['registryStatusCodeNavigation'] =
          this.registryStatusCodeNavigation.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resesitate'] = this.resesitate;
    data['poaname'] = this.poaname;
    data['poaaddress1'] = this.poaaddress1;
    data['poaaddress2'] = this.poaaddress2;
    data['poacity'] = this.poacity;
    data['poastate'] = this.poastate;
    data['poazip'] = this.poazip;
    data['gname'] = this.gname;
    data['gaddress1'] = this.gaddress1;
    data['gaddress2'] = this.gaddress2;
    data['gcity'] = this.gcity;
    data['gstate'] = this.gstate;
    data['gzip'] = this.gzip;
    data['medicalRelNames'] = this.medicalRelNames;
    data['homeHealth'] = this.homeHealth;
    data['nursingHome'] = this.nursingHome;
    data['hospice'] = this.hospice;
    data['impairment'] = this.impairment;
    data['homeHealthLoc'] = this.homeHealthLoc;
    data['nursingHomeLoc'] = this.nursingHomeLoc;
    data['hospiceLoc'] = this.hospiceLoc;
    data['impairmentLoc'] = this.impairmentLoc;
    data['ecfirstName'] = this.ecfirstName;
    data['eclastName'] = this.eclastName;
    data['ecmiddleInitial'] = this.ecmiddleInitial;
    data['ecrelationship'] = this.ecrelationship;
    data['ecphoneNumber'] = this.ecphoneNumber;
    data['livingWill'] = this.livingWill;
    data['publicityCodeId'] = this.publicityCodeId;
    data['registryStatusCodeId'] = this.registryStatusCodeId;
    data['publicityEffDate'] = this.publicityEffDate;
    data['registryEffDate'] = this.registryEffDate;
    data['shareHealthData'] = this.shareHealthData;
    data['shareHealthDataEffDate'] = this.shareHealthDataEffDate;
  
    return data;
  }
}

class PublicityCodeNavigation {
  String code;
  String description;
  String codeSystem;
  int id;

  PublicityCodeNavigation(
      {this.code, this.description, this.codeSystem, this.id});

  PublicityCodeNavigation.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    codeSystem = json['codeSystem'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['codeSystem'] = this.codeSystem;
    data['id'] = this.id;
    return data;
  }
}

class RegistryStatusCodeNavigation {
  String code;
  String description;
  int id;

  RegistryStatusCodeNavigation({this.code, this.description, this.id});

  RegistryStatusCodeNavigation.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}
