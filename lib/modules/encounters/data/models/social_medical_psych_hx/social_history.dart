class SocialHistoryModel {
  int id;
  int encounterId;
  bool employed;
  String occupation;
  bool exercise;
  String exerciseType;
  bool drugs;
  String streetDrugDesc;
  bool substanceAbuse;
  bool seatBelt;
  bool physicalAbuse;
  int coitusAge;
  int maritalStatusId;
  int smokingStatusId;
  int sexualActivityId;
  bool hasCompliantPrescribedTreatment;
  String hasCompliantPrescribedTreatmentDesc;
  bool drinksYesNo;
  int drinksPerWeek;
  int sexpartnerNumber;
  String comments;
  MaritalStatus maritalStatus;
  SexualActivity sexualActivity;
  SexualActivity smokingStatus;

  SocialHistoryModel(
      {this.id,
      this.encounterId,
      this.employed,
      this.occupation,
      this.exercise,
      this.exerciseType,
      this.drugs,
      this.streetDrugDesc,
      this.substanceAbuse,
      this.seatBelt,
      this.physicalAbuse,
      this.coitusAge,
      this.maritalStatusId,
      this.smokingStatusId,
      this.sexualActivityId,
      this.hasCompliantPrescribedTreatment,
      this.hasCompliantPrescribedTreatmentDesc,
      this.drinksYesNo,
      this.drinksPerWeek,
      this.sexpartnerNumber,
      this.comments,
      this.maritalStatus,
      this.sexualActivity,
      this.smokingStatus});

  SocialHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    employed = json['employed'];
    occupation = json['occupation'];
    exercise = json['exercise'];
    exerciseType = json['exerciseType'];
    drugs = json['drugs'];
    streetDrugDesc = json['streetDrugDesc'];
    substanceAbuse = json['substanceAbuse'];
    seatBelt = json['seatBelt'];
    physicalAbuse = json['physicalAbuse'];
    coitusAge = json['coitusAge'];
    maritalStatusId = json['maritalStatusId'];
    smokingStatusId = json['smokingStatusId'];
    sexualActivityId = json['sexualActivityId'];
    hasCompliantPrescribedTreatment = json['hasCompliantPrescribedTreatment'];
    hasCompliantPrescribedTreatmentDesc =
        json['hasCompliantPrescribedTreatmentDesc'];
    drinksYesNo = json['drinksYesNo'];
    drinksPerWeek = json['drinksPerWeek'];
    sexpartnerNumber = json['sexpartnerNumber'];
    comments = json['comments'];
    maritalStatus = json['maritalStatus'] != null
        ? new MaritalStatus.fromJson(json['maritalStatus'])
        : null;
    sexualActivity = json['sexualActivity'] != null
        ? new SexualActivity.fromJson(json['sexualActivity'])
        : null;
    smokingStatus = json['smokingStatus'] != null
        ? new SexualActivity.fromJson(json['smokingStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['employed'] = this.employed;
    data['occupation'] = this.occupation;
    data['exercise'] = this.exercise;
    data['exerciseType'] = this.exerciseType;
    data['drugs'] = this.drugs;
    data['streetDrugDesc'] = this.streetDrugDesc;
    data['substanceAbuse'] = this.substanceAbuse;
    data['seatBelt'] = this.seatBelt;
    data['physicalAbuse'] = this.physicalAbuse;
    data['coitusAge'] = this.coitusAge;
    data['maritalStatusId'] = this.maritalStatusId;
    data['smokingStatusId'] = this.smokingStatusId;
    data['sexualActivityId'] = this.sexualActivityId;
    data['hasCompliantPrescribedTreatment'] =
        this.hasCompliantPrescribedTreatment;
    data['hasCompliantPrescribedTreatmentDesc'] =
        this.hasCompliantPrescribedTreatmentDesc;
    data['drinksYesNo'] = this.drinksYesNo;
    data['drinksPerWeek'] = this.drinksPerWeek;
    data['sexpartnerNumber'] = this.sexpartnerNumber;
    data['comments'] = this.comments;
    if (this.maritalStatus != null) {
      data['maritalStatus'] = this.maritalStatus.toJson();
    }
    if (this.sexualActivity != null) {
      data['sexualActivity'] = this.sexualActivity.toJson();
    }
    if (this.smokingStatus != null) {
      data['smokingStatus'] = this.smokingStatus.toJson();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['employed'] = this.employed;
    data['occupation'] = this.occupation;
    data['exercise'] = this.exercise;
    data['exerciseType'] = this.exerciseType;
    data['drugs'] = this.drugs;
    data['streetDrugDesc'] = this.streetDrugDesc;
    data['substanceAbuse'] = this.substanceAbuse;
    data['seatBelt'] = this.seatBelt;
    data['physicalAbuse'] = this.physicalAbuse;
    data['coitusAge'] = this.coitusAge;
    data['maritalStatusId'] = this.maritalStatusId;
    data['smokingStatusId'] = this.smokingStatusId;
    data['sexualActivityId'] = this.sexualActivityId;
    data['hasCompliantPrescribedTreatment'] =
        this.hasCompliantPrescribedTreatment;
    data['hasCompliantPrescribedTreatmentDesc'] =
        this.hasCompliantPrescribedTreatmentDesc;
    data['drinksYesNo'] = this.drinksYesNo;
    data['drinksPerWeek'] = this.drinksPerWeek;
    data['sexpartnerNumber'] = this.sexpartnerNumber;
    data['comments'] = this.comments;

    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['employed'] = this.employed;
    data['occupation'] = this.occupation;
    data['exercise'] = this.exercise;
    data['exerciseType'] = this.exerciseType;
    data['drugs'] = this.drugs;
    data['streetDrugDesc'] = this.streetDrugDesc;
    data['substanceAbuse'] = this.substanceAbuse;
    data['seatBelt'] = this.seatBelt;
    data['physicalAbuse'] = this.physicalAbuse;
    data['coitusAge'] = this.coitusAge;
    data['maritalStatusId'] = this.maritalStatusId;
    data['smokingStatusId'] = this.smokingStatusId;
    data['sexualActivityId'] = this.sexualActivityId;
    data['hasCompliantPrescribedTreatment'] =
        this.hasCompliantPrescribedTreatment;
    data['hasCompliantPrescribedTreatmentDesc'] =
        this.hasCompliantPrescribedTreatmentDesc;
    data['drinksYesNo'] = this.drinksYesNo;
    data['drinksPerWeek'] = this.drinksPerWeek;
    data['sexpartnerNumber'] = this.sexpartnerNumber;
    data['comments'] = this.comments;

    return data;
  }
}

class MaritalStatus {
  int id;
  String code;
  String status;

  MaritalStatus({this.id, this.code, this.status});

  MaritalStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}

class SexualActivity {
  int id;
  String status;

  SexualActivity({this.id, this.status});

  SexualActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
