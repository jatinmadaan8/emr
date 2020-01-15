class RespiratoryModel {
  int id;
  int encounterId;
  int chestAppId;
  int breathPattId;
  int breathSoundId;
  String comments;
  RespiratoryDropDown breathpatt;
  RespiratoryDropDown breathsound;
  RespiratoryDropDown chestapp;
  List<RespiratorySymptoms> respiratorySymptoms;

  RespiratoryModel(
      {this.id,
      this.encounterId,
      this.chestAppId,
      this.breathPattId,
      this.breathSoundId,
      this.comments,
      this.breathpatt,
      this.breathsound,
      this.chestapp,
      this.respiratorySymptoms});

  RespiratoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    chestAppId = json['chestAppId'];
    breathPattId = json['breathPattId'];
    breathSoundId = json['breathSoundId'];
    comments = json['comments'];
    breathpatt = json['breathpatt'] != null
        ? new RespiratoryDropDown.fromJson(json['breathpatt'])
        : null;
    breathsound = json['breathsound'] != null
        ? new RespiratoryDropDown.fromJson(json['breathsound'])
        : null;
    chestapp = json['chestapp'] != null
        ? new RespiratoryDropDown.fromJson(json['chestapp'])
        : null;
    if (json['respiratorySymptoms'] != null) {
      respiratorySymptoms = new List<RespiratorySymptoms>();
      json['respiratorySymptoms'].forEach((v) {
        respiratorySymptoms.add(new RespiratorySymptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['chestAppId'] = this.chestAppId;
    data['breathPattId'] = this.breathPattId;
    data['breathSoundId'] = this.breathSoundId;
    data['comments'] = this.comments;
    if (this.breathpatt != null) {
      data['breathpatt'] = this.breathpatt.toJson();
    }
    if (this.breathsound != null) {
      data['breathsound'] = this.breathsound.toJson();
    }
    if (this.chestapp != null) {
      data['chestapp'] = this.chestapp.toJson();
    }
    if (this.respiratorySymptoms != null) {
      data['respiratorySymptoms'] =
          this.respiratorySymptoms.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['chestAppId'] = this.chestAppId;
    data['breathPattId'] = this.breathPattId;
    data['breathSoundId'] = this.breathSoundId;
    data['comments'] = this.comments;

    if (this.respiratorySymptoms != null) {
      data['respiratorySymptoms'] =
          this.respiratorySymptoms.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['chestAppId'] = this.chestAppId;
    data['breathPattId'] = this.breathPattId;
    data['breathSoundId'] = this.breathSoundId;
    data['comments'] = this.comments;

    if (this.respiratorySymptoms != null) {
      data['respiratorySymptoms'] =
          this.respiratorySymptoms.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class RespiratoryDropDown {
  int id;
  String description;

  RespiratoryDropDown({this.id, this.description});

  RespiratoryDropDown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}

class RespiratorySymptoms {
  int id;
  int respiratoryId;
  int symptomId;
  RespiratoryDropDown symptom;

  RespiratorySymptoms(
      {this.id, this.respiratoryId, this.symptomId, this.symptom});

  RespiratorySymptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    respiratoryId = json['respiratoryId'];
    symptomId = json['symptomId'];
    symptom = json['symptom'] != null
        ? new RespiratoryDropDown.fromJson(json['symptom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['respiratoryId'] = this.respiratoryId;
    data['symptomId'] = this.symptomId;
    if (this.symptom != null) {
      data['symptom'] = this.symptom.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptomId'] = this.symptomId;
    return data;
  }
}
