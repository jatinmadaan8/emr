class PatientInformationModel {
  int id;
  String billingID;
  String patientName;
  int age;
  String dob;
  String firstName;
  String lastName;
  String nicknameAc;
  String mi;
  String maidenName;
  String primaryCareDoctor;
  String phoneNumber;
  String ssn;
  String pharmacy;
  int doctorId;
  int providerId;
  String address1;
  String address2;
  String city;
  String state;
  String zipCode;
  String billAddress1;
  String billAddress2;
  String billCity;
  String billState;
  String billZip;
  int genderId;
  bool disallowScheduling;
  String referredBy;
  String email;
  String picture;
  String spouseName;
  bool historyOfDrugAbuse;
  String historyOfDrugAbuseComments;
  bool inCollections;
  String inCollectionsComments;
  String alertText;
  bool idVerified;
  String idVerifiedBy;
  String idVerifiedDate;
  bool customAlert1;
  bool customAlert2;
  bool customAlert3;
  bool transferOfCare;
  String mobilePhoneNumber;
  String workPhoneNumber;
  int preferredPhoneNumber;
  String religionOther;
  String religion;
  String height;
  bool portalOptedOut;
  int billType;
  String language;
  String ethnicity;
  String patientSigned;
  String billingSelection;
  String prefContact;
  String livesWith;
  String maritalStatus;
  String scheduleAlert;
  bool patientHxexists;
  int resesitate;
  bool alert;
  bool resultsEmail;
  bool resultsMail;
  bool resultsPickup;
  bool resultsPhone;
  bool resultsFax;
  bool resultsEaccess;
  bool billSameAsRes;
  String pgxReportId;
  List<PatientRaces> patientRaces;
  bool rpm;
  bool pgx;

  PatientInformationModel(
      {this.id,
      this.billingID,
      this.patientName,
      this.age,
      this.dob,
      this.firstName,
      this.lastName,
      this.nicknameAc,
      this.mi,
      this.maidenName,
      this.primaryCareDoctor,
      this.phoneNumber,
      this.ssn,
      this.pharmacy,
      this.doctorId,
      this.providerId,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zipCode,
      this.billAddress1,
      this.billAddress2,
      this.billCity,
      this.billState,
      this.billZip,
      this.genderId,
      this.disallowScheduling,
      this.referredBy,
      this.email,
      this.picture,
      this.spouseName,
      this.historyOfDrugAbuse,
      this.historyOfDrugAbuseComments,
      this.inCollections,
      this.inCollectionsComments,
      this.alertText,
      this.idVerified,
      this.idVerifiedBy,
      this.idVerifiedDate,
      this.customAlert1,
      this.customAlert2,
      this.customAlert3,
      this.transferOfCare,
      this.mobilePhoneNumber,
      this.workPhoneNumber,
      this.preferredPhoneNumber,
      this.religionOther,
      this.religion,
      this.height,
      this.portalOptedOut,
      this.billType,
      this.language,
      this.ethnicity,
      this.patientSigned,
      this.billingSelection,
      this.prefContact,
      this.livesWith,
      this.maritalStatus,
      this.scheduleAlert,
      this.patientHxexists,
      this.resesitate,
      this.alert,
      this.resultsEmail,
      this.resultsMail,
      this.resultsPickup,
      this.resultsPhone,
      this.resultsFax,
      this.resultsEaccess,
      this.billSameAsRes,
      this.pgxReportId,
      this.patientRaces,
      this.rpm,
      this.pgx});

  PatientInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billingID = json['billingID'];
    patientName = json['patientName'];
    age = json['age'];
    dob = json['dob'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    nicknameAc = json['nicknameAc'];
    mi = json['mi'];
    maidenName = json['maidenName'];
    primaryCareDoctor = json['primaryCareDoctor'];
    phoneNumber = json['phoneNumber'];
    ssn = json['ssn'];
    pharmacy = json['pharmacy'];
    doctorId = json['doctorId'];
    providerId = json['providerId'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    billAddress1 = json['billAddress1'];
    billAddress2 = json['billAddress2'];
    billCity = json['billCity'];
    billState = json['billState'];
    billZip = json['billZip'];
    genderId = json['genderId'];
    disallowScheduling = json['disallowScheduling'];
    referredBy = json['referredBy'];
    email = json['email'];
    picture = json['picture'];
    spouseName = json['spouseName'];
    historyOfDrugAbuse = json['historyOfDrugAbuse'];
    historyOfDrugAbuseComments = json['historyOfDrugAbuseComments'];
    inCollections = json['inCollections'];
    inCollectionsComments = json['inCollectionsComments'];
    alertText = json['alertText'];
    idVerified = json['idVerified'];
    idVerifiedBy = json['idVerifiedBy'];
    idVerifiedDate = json['idVerifiedDate'];
    customAlert1 = json['customAlert1'];
    customAlert2 = json['customAlert2'];
    customAlert3 = json['customAlert3'];
    transferOfCare = json['transferOfCare'];
    mobilePhoneNumber = json['mobilePhoneNumber'];
    workPhoneNumber = json['workPhoneNumber'];
    preferredPhoneNumber = json['preferredPhoneNumber'];
    religionOther = json['religionOther'];
    religion = json['religion'];
    height = json['height'];
    portalOptedOut = json['portalOptedOut'];
    billType = json['billType'];
    language = json['language'];
    ethnicity = json['ethnicity'];
    patientSigned = json['patientSigned'];
    billingSelection = json['billingSelection'];
    prefContact = json['prefContact'];
    livesWith = json['livesWith'];
    maritalStatus = json['maritalStatus'];
    scheduleAlert = json['scheduleAlert'];
    patientHxexists = json['patientHxexists'];
    resesitate = json['resesitate'];
    alert = json['alert'];
    resultsEmail = json['resultsEmail'];
    resultsMail = json['resultsMail'];
    resultsPickup = json['resultsPickup'];
    resultsPhone = json['resultsPhone'];
    resultsFax = json['resultsFax'];
    resultsEaccess = json['resultsEaccess'];
    billSameAsRes = json['billSameAsRes'];
    pgxReportId = json['pgxReportId'];
    if (json['patientRaces'] != null) {
      patientRaces = new List<PatientRaces>();
      json['patientRaces'].forEach((v) {
        patientRaces.add(new PatientRaces.fromJson(v));
      });
    }
    rpm = json['rpm'];
    pgx = json['pgx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['billingID'] = this.billingID;
    data['patientName'] = this.patientName;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['nicknameAc'] = this.nicknameAc;
    data['mi'] = this.mi;
    data['maidenName'] = this.maidenName;
    data['primaryCareDoctor'] = this.primaryCareDoctor;
    data['phoneNumber'] = this.phoneNumber;
    data['ssn'] = this.ssn;
    data['pharmacy'] = this.pharmacy;
    data['doctorId'] = this.doctorId;
    data['providerId'] = this.providerId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['billAddress1'] = this.billAddress1;
    data['billAddress2'] = this.billAddress2;
    data['billCity'] = this.billCity;
    data['billState'] = this.billState;
    data['billZip'] = this.billZip;
    data['genderId'] = this.genderId;
    data['disallowScheduling'] = this.disallowScheduling;
    data['referredBy'] = this.referredBy;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['spouseName'] = this.spouseName;
    data['historyOfDrugAbuse'] = this.historyOfDrugAbuse;
    data['historyOfDrugAbuseComments'] = this.historyOfDrugAbuseComments;
    data['inCollections'] = this.inCollections;
    data['inCollectionsComments'] = this.inCollectionsComments;
    data['alertText'] = this.alertText;
    data['idVerified'] = this.idVerified;
    data['idVerifiedBy'] = this.idVerifiedBy;
    data['idVerifiedDate'] = this.idVerifiedDate;
    data['customAlert1'] = this.customAlert1;
    data['customAlert2'] = this.customAlert2;
    data['customAlert3'] = this.customAlert3;
    data['transferOfCare'] = this.transferOfCare;
    data['mobilePhoneNumber'] = this.mobilePhoneNumber;
    data['workPhoneNumber'] = this.workPhoneNumber;
    data['preferredPhoneNumber'] = this.preferredPhoneNumber;
    data['religionOther'] = this.religionOther;
    data['religion'] = this.religion;
    data['height'] = this.height;
    data['portalOptedOut'] = this.portalOptedOut;
    data['billType'] = this.billType;
    data['language'] = this.language;
    data['ethnicity'] = this.ethnicity;
    data['patientSigned'] = this.patientSigned;
    data['billingSelection'] = this.billingSelection;
    data['prefContact'] = this.prefContact;
    data['livesWith'] = this.livesWith;
    data['maritalStatus'] = this.maritalStatus;
    data['scheduleAlert'] = this.scheduleAlert;
    data['patientHxexists'] = this.patientHxexists;
    data['resesitate'] = this.resesitate;
    data['alert'] = this.alert;
    data['resultsEmail'] = this.resultsEmail;
    data['resultsMail'] = this.resultsMail;
    data['resultsPickup'] = this.resultsPickup;
    data['resultsPhone'] = this.resultsPhone;
    data['resultsFax'] = this.resultsFax;
    data['resultsEaccess'] = this.resultsEaccess;
    data['billSameAsRes'] = this.billSameAsRes;
    data['pgxReportId'] = this.pgxReportId;
    if (this.patientRaces != null) {
      data['patientRaces'] = this.patientRaces.map((v) => v.toJson()).toList();
    }
    data['rpm'] = this.rpm;
    data['pgx'] = this.pgx;
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['billingID'] = this.billingID;
    data['patientName'] = this.patientName;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['nicknameAc'] = this.nicknameAc;
    data['mi'] = this.mi;
    data['maidenName'] = this.maidenName;
    data['primaryCareDoctor'] = this.primaryCareDoctor;
    data['phoneNumber'] = this.phoneNumber;
    data['ssn'] = this.ssn;
    data['pharmacy'] = this.pharmacy;
    data['doctorId'] = this.doctorId;
    data['providerId'] = this.providerId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['billAddress1'] = this.billAddress1;
    data['billAddress2'] = this.billAddress2;
    data['billCity'] = this.billCity;
    data['billState'] = this.billState;
    data['billZip'] = this.billZip;
    data['genderId'] = this.genderId;
    data['disallowScheduling'] = this.disallowScheduling;
    data['referredBy'] = this.referredBy;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['spouseName'] = this.spouseName;
    data['historyOfDrugAbuse'] = this.historyOfDrugAbuse;
    data['historyOfDrugAbuseComments'] = this.historyOfDrugAbuseComments;
    data['inCollections'] = this.inCollections;
    data['inCollectionsComments'] = this.inCollectionsComments;
    data['alertText'] = this.alertText;
    data['idVerified'] = this.idVerified;
    data['idVerifiedBy'] = this.idVerifiedBy;
    data['idVerifiedDate'] = this.idVerifiedDate;
    data['customAlert1'] = this.customAlert1;
    data['customAlert2'] = this.customAlert2;
    data['customAlert3'] = this.customAlert3;
    data['transferOfCare'] = this.transferOfCare;
    data['mobilePhoneNumber'] = this.mobilePhoneNumber;
    data['workPhoneNumber'] = this.workPhoneNumber;
    data['preferredPhoneNumber'] = this.preferredPhoneNumber;
    data['religionOther'] = this.religionOther;
    data['religion'] = this.religion;
    data['height'] = this.height;
    data['portalOptedOut'] = this.portalOptedOut;
    data['billType'] = this.billType;
    data['language'] = this.language;
    data['ethnicity'] = this.ethnicity;
    data['patientSigned'] = this.patientSigned;
    data['billingSelection'] = this.billingSelection;
    data['prefContact'] = this.prefContact;
    data['livesWith'] = this.livesWith;
    data['maritalStatus'] = this.maritalStatus;
    data['scheduleAlert'] = this.scheduleAlert;
    data['patientHxexists'] = this.patientHxexists;
    data['resesitate'] = this.resesitate;
    data['alert'] = this.alert;
    data['resultsEmail'] = this.resultsEmail;
    data['resultsMail'] = this.resultsMail;
    data['resultsPickup'] = this.resultsPickup;
    data['resultsPhone'] = this.resultsPhone;
    data['resultsFax'] = this.resultsFax;
    data['resultsEaccess'] = this.resultsEaccess;
    data['billSameAsRes'] = this.billSameAsRes;
    data['pgxReportId'] = this.pgxReportId;
    if (this.patientRaces != null) {
      data['patientRaces'] =
          this.patientRaces.map((v) => v.toUpdateJson()).toList();
    }
    data['rpm'] = this.rpm;
    data['pgx'] = this.pgx;
    return data;
  }
}

class PatientRaces {
  int raceId;
  RaceNavigation raceNavigation;

  PatientRaces({this.raceId, this.raceNavigation});

  PatientRaces.fromJson(Map<String, dynamic> json) {
    raceId = json['raceId'];
    raceNavigation = json['raceNavigation'] != null
        ? new RaceNavigation.fromJson(json['raceNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raceId'] = this.raceId;
    if (this.raceNavigation != null) {
      data['raceNavigation'] = this.raceNavigation.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raceId'] = this.raceId;
    return data;
  }
}

class RaceNavigation {
  int raceId;
  String race;
  String description;
  String code;
  String codeSystem;

  RaceNavigation(
      {this.raceId, this.race, this.description, this.code, this.codeSystem});

  RaceNavigation.fromJson(Map<String, dynamic> json) {
    raceId = json['raceId'];
    race = json['race'];
    description = json['description'];
    code = json['code'];
    codeSystem = json['codeSystem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raceId'] = this.raceId;
    data['race'] = this.race;
    data['description'] = this.description;
    data['code'] = this.code;
    data['codeSystem'] = this.codeSystem;
    return data;
  }
}

//class PatientInformationModel {
//  bool rpm;
//  bool pgx;
//  List<PatientGuarantorInfo> items;
//  List<PatientRaces> patientRaces;
//
//  PatientInformationModel({this.rpm, this.pgx, this.items, this.patientRaces});
//
//  PatientInformationModel.fromJson(Map<String, dynamic> json) {
//    rpm = json['rpm'];
//    pgx = json['pgx'];
//    if (json['items'] != null) {
//      items = new List<PatientGuarantorInfo>();
//      json['items'].forEach((v) {
//        items.add(new PatientGuarantorInfo.fromJson(v));
//      });
//    }
//    if (json['patientRaces'] != null) {
//      patientRaces = new List<PatientRaces>();
//      json['patientRaces'].forEach((v) {
//        patientRaces.add(new PatientRaces.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['rpm'] = this.rpm;
//    data['pgx'] = this.pgx;
//    if (this.items != null) {
//      data['items'] = this.items.map((v) => v.toJson()).toList();
//    }
//    if (this.patientRaces != null) {
//      data['patientRaces'] = this.patientRaces.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//
//  Map<String, dynamic> toUpdateJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['rpm'] = this.rpm;
//    data['pgx'] = this.pgx;
//
//    data['id'] = this.items[0].id;
//    data['billingID'] = this.items[0].billingID;
//    data['patientName'] = this.items[0].patientName;
//    data['age'] = this.items[0].age;
//    data['dob'] = this.items[0].dob;
//    data['firstName'] = this.items[0].firstName;
//    data['lastName'] = this.items[0].lastName;
//    data['nicknameAc'] = this.items[0].nicknameAc;
//    data['mi'] = this.items[0].mi;
//    data['maidenName'] = this.items[0].maidenName;
//    data['primaryCareDoctor'] = this.items[0].primaryCareDoctor;
//    data['phoneNumber'] = this.items[0].phoneNumber;
//    data['ssn'] = this.items[0].ssn;
//    data['pharmacy'] = this.items[0].pharmacy;
//    data['doctorId'] = this.items[0].doctorId;
//    data['providerId'] = this.items[0].providerId;
//    data['address1'] = this.items[0].address1;
//    data['address2'] = this.items[0].address2;
//    data['city'] = this.items[0].city;
//    data['state'] = this.items[0].state;
//    data['zipCode'] = this.items[0].zipCode;
//    data['billAddress1'] = this.items[0].billAddress1;
//    data['billAddress2'] = this.items[0].billAddress2;
//    data['billCity'] = this.items[0].billCity;
//    data['billState'] = this.items[0].billState;
//    data['billZip'] = this.items[0].billZip;
//    data['genderId'] = this.items[0].genderId;
//    data['disallowScheduling'] = this.items[0].disallowScheduling;
//    data['referredBy'] = this.items[0].referredBy;
//    data['email'] = this.items[0].email;
//    data['spouseName'] = this.items[0].spouseName;
//    data['historyOfDrugAbuse'] = this.items[0].historyOfDrugAbuse;
//    data['historyOfDrugAbuseComments'] =
//        this.items[0].historyOfDrugAbuseComments;
//    data['inCollections'] = this.items[0].inCollections;
//    data['inCollectionsComments'] = this.items[0].inCollectionsComments;
//    data['alertText'] = this.items[0].alertText;
//    data['idVerified'] = this.items[0].idVerified;
//    data['idVerifiedBy'] = this.items[0].idVerifiedBy;
//    data['idVerifiedDate'] = this.items[0].idVerifiedDate;
//    data['customAlert1'] = this.items[0].customAlert1;
//    data['customAlert2'] = this.items[0].customAlert2;
//    data['customAlert3'] = this.items[0].customAlert3;
//    data['transferOfCare'] = this.items[0].transferOfCare;
//    data['mobilePhoneNumber'] = this.items[0].mobilePhoneNumber;
//    data['workPhoneNumber'] = this.items[0].workPhoneNumber;
//    data['preferredPhoneNumber'] = this.items[0].preferredPhoneNumber;
//    data['religionOther'] = this.items[0].religionOther;
//    data['religion'] = this.items[0].religion;
//    data['height'] = this.items[0].height;
//    data['portalOptedOut'] = this.items[0].portalOptedOut;
//    data['billType'] = this.items[0].billType;
//    data['language'] = this.items[0].language;
//    data['ethnicity'] = this.items[0].ethnicity;
//    data['patientSigned'] = this.items[0].patientSigned;
//    data['billingSelection'] = this.items[0].billingSelection;
//    data['prefContact'] = this.items[0].prefContact;
//    data['livesWith'] = this.items[0].livesWith;
//    data['maritalStatus'] = this.items[0].maritalStatus;
//    data['scheduleAlert'] = this.items[0].scheduleAlert;
//    data['patientHxexists'] = this.items[0].patientHxexists;
//    data['resesitate'] = this.items[0].resesitate;
//    data['alert'] = this.items[0].alert;
//    data['resultsEmail'] = this.items[0].resultsEmail;
//    data['resultsMail'] = this.items[0].resultsMail;
//    data['resultsPickup'] = this.items[0].resultsPickup;
//    data['resultsPhone'] = this.items[0].resultsPhone;
//    data['resultsFax'] = this.items[0].resultsFax;
//    data['resultsEaccess'] = this.items[0].resultsEaccess;
//    data['billSameAsRes'] = this.items[0].billSameAsRes;
//    data['pgxReportId'] = this.items[0].pgxReportId;
//    data['resultsHomeHealth'] = this.items[0].resultsHomeHealth;
//    data['resultsNursingHome'] = this.items[0].resultsNursingHome;
//    data['resultsHospice'] = this.items[0].resultsHospice;
//    data['resultsImpairments'] = this.items[0].resultsImpairments;
//    if (this.items[0].referralSources != null) {
//      data['referralSources'] =
//          this.items[0].referralSources.map((v) => v.toJson()).toList();
//    }
//
//    if (this.patientRaces != null) {
//      data['patientRaces'] = this.patientRaces.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class PatientGuarantorInfo {
//  int id;
//  String billingID;
//  String patientName;
//  int age;
//  String dob;
//  String firstName;
//  String lastName;
//  String nicknameAc;
//  String mi;
//  String maidenName;
//  String primaryCareDoctor;
//  String phoneNumber;
//  String ssn;
//  String pharmacy;
//  int doctorId;
//  int providerId;
//  String address1;
//  String address2;
//  String city;
//  String state;
//  String zipCode;
//  String billAddress1;
//  String billAddress2;
//  String billCity;
//  String billState;
//  String billZip;
//  int genderId;
//  bool disallowScheduling;
//  String referredBy;
//  String email;
//  String picture;
//  String spouseName;
//  bool historyOfDrugAbuse;
//  String historyOfDrugAbuseComments;
//  bool inCollections;
//  String inCollectionsComments;
//  String alertText;
//  bool idVerified;
//  String idVerifiedBy;
//  String idVerifiedDate;
//  bool customAlert1;
//  bool customAlert2;
//  bool customAlert3;
//  bool transferOfCare;
//  String mobilePhoneNumber;
//  String workPhoneNumber;
//  int preferredPhoneNumber;
//  String religionOther;
//  String religion;
//  String height;
//  bool portalOptedOut;
//  int billType;
//  String language;
//  String ethnicity;
//  String patientSigned;
//  String billingSelection;
//  String prefContact;
//  String livesWith;
//  String maritalStatus;
//  String scheduleAlert;
//  bool patientHxexists;
//  int resesitate;
//  bool alert;
//  bool resultsEmail;
//  bool resultsMail;
//  bool resultsPickup;
//  bool resultsPhone;
//  bool resultsFax;
//  bool resultsEaccess;
//  bool billSameAsRes;
//  String pgxReportId;
//  bool resultsHomeHealth;
//  bool resultsNursingHome;
//  bool resultsHospice;
//  bool resultsImpairments;
//  List<ReferralSources> referralSources;
//  PatientInformationLookUpData preferredContactType;
//
//  PatientGuarantorInfo(
//      {this.id,
//      this.billingID,
//      this.patientName,
//      this.age,
//      this.dob,
//      this.firstName,
//      this.lastName,
//      this.nicknameAc,
//      this.mi,
//      this.maidenName,
//      this.primaryCareDoctor,
//      this.phoneNumber,
//      this.ssn,
//      this.pharmacy,
//      this.doctorId,
//      this.providerId,
//      this.address1,
//      this.address2,
//      this.city,
//      this.state,
//      this.zipCode,
//      this.billAddress1,
//      this.billAddress2,
//      this.billCity,
//      this.billState,
//      this.billZip,
//      this.genderId,
//      this.disallowScheduling,
//      this.referredBy,
//      this.email,
//      this.picture,
//      this.spouseName,
//      this.historyOfDrugAbuse,
//      this.historyOfDrugAbuseComments,
//      this.inCollections,
//      this.inCollectionsComments,
//      this.alertText,
//      this.idVerified,
//      this.idVerifiedBy,
//      this.idVerifiedDate,
//      this.customAlert1,
//      this.customAlert2,
//      this.customAlert3,
//      this.transferOfCare,
//      this.mobilePhoneNumber,
//      this.workPhoneNumber,
//      this.preferredPhoneNumber,
//      this.religionOther,
//      this.religion,
//      this.height,
//      this.portalOptedOut,
//      this.billType,
//      this.language,
//      this.ethnicity,
//      this.patientSigned,
//      this.billingSelection,
//      this.prefContact,
//      this.livesWith,
//      this.maritalStatus,
//      this.scheduleAlert,
//      this.patientHxexists,
//      this.resesitate,
//      this.alert,
//      this.resultsEmail,
//      this.resultsMail,
//      this.resultsPickup,
//      this.resultsPhone,
//      this.resultsFax,
//      this.resultsEaccess,
//      this.billSameAsRes,
//      this.pgxReportId,
//      this.referralSources,
//      this.preferredContactType,
//      this.resultsHomeHealth,
//      this.resultsNursingHome,
//      this.resultsHospice,
//      this.resultsImpairments});
//
//  PatientGuarantorInfo.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    billingID = json['billingID'];
//    patientName = json['patientName'];
//    age = json['age'];
//    dob = json['dob'];
//    firstName = json['firstName'];
//    lastName = json['lastName'];
//    nicknameAc = json['nicknameAc'];
//    mi = json['mi'];
//    maidenName = json['maidenName'];
//    primaryCareDoctor = json['primaryCareDoctor'];
//    phoneNumber = json['phoneNumber'];
//    ssn = json['ssn'];
//    pharmacy = json['pharmacy'];
//    doctorId = json['doctorId'];
//    providerId = json['providerId'];
//    address1 = json['address1'];
//    address2 = json['address2'];
//    city = json['city'];
//    state = json['state'];
//    zipCode = json['zipCode'];
//    billAddress1 = json['billAddress1'];
//    billAddress2 = json['billAddress2'];
//    billCity = json['billCity'];
//    billState = json['billState'];
//    billZip = json['billZip'];
//    genderId = json['genderId'];
//    disallowScheduling = json['disallowScheduling'];
//    referredBy = json['referredBy'];
//    email = json['email'];
//    picture = json['picture'];
//    spouseName = json['spouseName'];
//    historyOfDrugAbuse = json['historyOfDrugAbuse'];
//    historyOfDrugAbuseComments = json['historyOfDrugAbuseComments'];
//    inCollections = json['inCollections'];
//    inCollectionsComments = json['inCollectionsComments'];
//    alertText = json['alertText'];
//    idVerified = json['idVerified'];
//    idVerifiedBy = json['idVerifiedBy'];
//    idVerifiedDate = json['idVerifiedDate'];
//    customAlert1 = json['customAlert1'];
//    customAlert2 = json['customAlert2'];
//    customAlert3 = json['customAlert3'];
//    transferOfCare = json['transferOfCare'];
//    mobilePhoneNumber = json['mobilePhoneNumber'];
//    workPhoneNumber = json['workPhoneNumber'];
//    preferredPhoneNumber = json['preferredPhoneNumber'];
//    religionOther = json['religionOther'];
//    religion = json['religion'];
//    height = json['height'];
//    portalOptedOut = json['portalOptedOut'];
//    billType = json['billType'];
//    language = json['language'];
//    ethnicity = json['ethnicity'];
//    patientSigned = json['patientSigned'];
//    billingSelection = json['billingSelection'];
//    prefContact = json['prefContact'];
//    livesWith = json['livesWith'];
//    maritalStatus = json['maritalStatus'];
//    scheduleAlert = json['scheduleAlert'];
//    patientHxexists = json['patientHxexists'];
//    resesitate = json['resesitate'];
//    alert = json['alert'];
//    resultsEmail = json['resultsEmail'];
//    resultsMail = json['resultsMail'];
//    resultsPickup = json['resultsPickup'];
//    resultsPhone = json['resultsPhone'];
//    resultsFax = json['resultsFax'];
//    resultsEaccess = json['resultsEaccess'];
//    billSameAsRes = json['billSameAsRes'];
//    pgxReportId = json['pgxReportId'];
//    resultsHomeHealth = json['resultsHomeHealth'];
//    resultsNursingHome = json['resultsNursingHome'];
//    resultsHospice = json['resultsHospice'];
//    resultsImpairments = json['resultsImpairments'];
//    if (json['referralSources'] != null) {
//      referralSources = new List<ReferralSources>();
//      json['referralSources'].forEach((v) {
//        referralSources.add(new ReferralSources.fromJson(v));
//      });
//    }
//    preferredContactType = json['preferredContactType'] != null
//        ? new PatientInformationLookUpData.fromJson(
//            json['preferredContactType'])
//        : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['billingID'] = this.billingID;
//    data['patientName'] = this.patientName;
//    data['age'] = this.age;
//    data['dob'] = this.dob;
//    data['firstName'] = this.firstName;
//    data['lastName'] = this.lastName;
//    data['nicknameAc'] = this.nicknameAc;
//    data['mi'] = this.mi;
//    data['maidenName'] = this.maidenName;
//    data['primaryCareDoctor'] = this.primaryCareDoctor;
//    data['phoneNumber'] = this.phoneNumber;
//    data['ssn'] = this.ssn;
//    data['pharmacy'] = this.pharmacy;
//    data['doctorId'] = this.doctorId;
//    data['providerId'] = this.providerId;
//    data['address1'] = this.address1;
//    data['address2'] = this.address2;
//    data['city'] = this.city;
//    data['state'] = this.state;
//    data['zipCode'] = this.zipCode;
//    data['billAddress1'] = this.billAddress1;
//    data['billAddress2'] = this.billAddress2;
//    data['billCity'] = this.billCity;
//    data['billState'] = this.billState;
//    data['billZip'] = this.billZip;
//    data['genderId'] = this.genderId;
//    data['disallowScheduling'] = this.disallowScheduling;
//    data['referredBy'] = this.referredBy;
//    data['email'] = this.email;
//    data['picture'] = this.picture;
//    data['spouseName'] = this.spouseName;
//    data['historyOfDrugAbuse'] = this.historyOfDrugAbuse;
//    data['historyOfDrugAbuseComments'] = this.historyOfDrugAbuseComments;
//    data['inCollections'] = this.inCollections;
//    data['inCollectionsComments'] = this.inCollectionsComments;
//    data['alertText'] = this.alertText;
//    data['idVerified'] = this.idVerified;
//    data['idVerifiedBy'] = this.idVerifiedBy;
//    data['idVerifiedDate'] = this.idVerifiedDate;
//    data['customAlert1'] = this.customAlert1;
//    data['customAlert2'] = this.customAlert2;
//    data['customAlert3'] = this.customAlert3;
//    data['transferOfCare'] = this.transferOfCare;
//    data['mobilePhoneNumber'] = this.mobilePhoneNumber;
//    data['workPhoneNumber'] = this.workPhoneNumber;
//    data['preferredPhoneNumber'] = this.preferredPhoneNumber;
//    data['religionOther'] = this.religionOther;
//    data['religion'] = this.religion;
//    data['height'] = this.height;
//    data['portalOptedOut'] = this.portalOptedOut;
//    data['billType'] = this.billType;
//    data['language'] = this.language;
//    data['ethnicity'] = this.ethnicity;
//    data['patientSigned'] = this.patientSigned;
//    data['billingSelection'] = this.billingSelection;
//    data['prefContact'] = this.prefContact;
//    data['livesWith'] = this.livesWith;
//    data['maritalStatus'] = this.maritalStatus;
//    data['scheduleAlert'] = this.scheduleAlert;
//    data['patientHxexists'] = this.patientHxexists;
//    data['resesitate'] = this.resesitate;
//    data['alert'] = this.alert;
//    data['resultsEmail'] = this.resultsEmail;
//    data['resultsMail'] = this.resultsMail;
//    data['resultsPickup'] = this.resultsPickup;
//    data['resultsPhone'] = this.resultsPhone;
//    data['resultsFax'] = this.resultsFax;
//    data['resultsEaccess'] = this.resultsEaccess;
//    data['billSameAsRes'] = this.billSameAsRes;
//    data['pgxReportId'] = this.pgxReportId;
//    if (this.referralSources != null) {
//      data['referralSources'] =
//          this.referralSources.map((v) => v.toJson()).toList();
//    }
//    if (this.preferredContactType != null) {
//      data['preferredContactType'] = this.preferredContactType.toJson();
//    }
//    return data;
//  }
//}

class ReferralSources {
  int referralId;
  String referralSource;

  ReferralSources({this.referralId, this.referralSource});

  ReferralSources.fromJson(Map<String, dynamic> json) {
    referralId = json['referralId'];
    referralSource = json['referralSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referralId'] = this.referralId;
    data['referralSource'] = this.referralSource;
    return data;
  }
}

class PatientInformationLookUpData {
  int id;
  String name;
  String code;

  PatientInformationLookUpData({this.id, this.name, this.code});

  PatientInformationLookUpData.fromJson(Map<String, dynamic> json) {
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

class DefaultProviderModel {
  int userId;
  String userFullName;
  String emailAddress;
  String firstName;
  String lastName;

  DefaultProviderModel(
      {this.userId,
      this.userFullName,
      this.emailAddress,
      this.firstName,
      this.lastName});

  DefaultProviderModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullName = json['userFullName'];
    emailAddress = json['emailAddress'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userFullName'] = this.userFullName;
    data['emailAddress'] = this.emailAddress;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class PreferredPhoneModel {
  String dataValue;
  String displayTest;

  PreferredPhoneModel({this.dataValue, this.displayTest});

  PreferredPhoneModel.fromJson(Map<String, dynamic> json) {
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

class BillType {
  int id;
  String value;
  BillType({this.id, this.value});

  BillType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
