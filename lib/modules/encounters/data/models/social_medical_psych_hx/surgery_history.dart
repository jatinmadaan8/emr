class SurgeryHistoryModel {
  int id;
  int encounterId;
  String comments;
  List<SurgeryTypes> surgerytypes;

  SurgeryHistoryModel(
      {this.id, this.encounterId, this.comments, this.surgerytypes});

  SurgeryHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    comments = json['comments'];
    if (json['surgerytypes'] != null) {
      surgerytypes = new List<SurgeryTypes>();
      json['surgerytypes'].forEach((v) {
        surgerytypes.add(new SurgeryTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.surgerytypes != null) {
      data['surgerytypes'] = this.surgerytypes.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.surgerytypes != null) {
      data['surgerytypes'] =
          this.surgerytypes.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.surgerytypes != null) {
      data['surgerytypes'] =
          this.surgerytypes.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class SurgeryTypes {
  int id;
  int surgeryHistoryId;
  int surgeryId;
  String surgeryDate;
  String surgeryNotes;
  Surgery surgery;

  SurgeryTypes(
      {this.id,
      this.surgeryHistoryId,
      this.surgeryId,
      this.surgeryDate,
      this.surgeryNotes,
      this.surgery});

  SurgeryTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surgeryHistoryId = json['surgeryHistoryId'];
    surgeryId = json['surgeryId'];
    surgeryDate = json['surgeryDate'];
    surgeryNotes = json['surgeryNotes'];
    surgery =
        json['surgery'] != null ? new Surgery.fromJson(json['surgery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['surgeryHistoryId'] = this.surgeryHistoryId;
    data['surgeryId'] = this.surgeryId;
    data['surgeryDate'] = this.surgeryDate;
    data['surgeryNotes'] = this.surgeryNotes;
    if (this.surgery != null) {
      data['surgery'] = this.surgery.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;

    if (this.surgeryHistoryId != null)
      data['surgeryHistoryId'] = this.surgeryHistoryId;

    if (this.surgeryId != null) data['surgeryId'] = this.surgeryId;

    if (this.surgeryDate != null) data['surgeryDate'] = this.surgeryDate;

    if (this.surgeryNotes != null) data['surgeryNotes'] = this.surgeryNotes;

    return data;
  }
}

class Surgery {
  int id;
  String name;
  int displaySection;
  int speciality;
  Gender gender;

  Surgery(
      {this.id, this.name, this.displaySection, this.speciality, this.gender});

  Surgery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displaySection = json['displaySection'];
    speciality = json['speciality'];
    gender =
        json['gender'] != null ? new Gender.fromJson(json['gender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displaySection'] = this.displaySection;
    data['speciality'] = this.speciality;
    if (this.gender != null) {
      data['gender'] = this.gender.toJson();
    }
    return data;
  }
}

class Gender {
  int id;
  String name;
  String code;

  Gender({this.id, this.name, this.code});

  Gender.fromJson(Map<String, dynamic> json) {
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

class SurgeryTypesLookupModel {
  int id;
  String name;
  int displayGenderId;
  int displaySection;
  int speciality;
  DisplayGender displayGender;

  SurgeryTypesLookupModel(
      {this.id,
      this.name,
      this.displayGenderId,
      this.displaySection,
      this.speciality,
      this.displayGender});

  SurgeryTypesLookupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayGenderId = json['displayGenderId'];
    displaySection = json['displaySection'];
    speciality = json['speciality'];
    displayGender = json['displayGender'] != null
        ? new DisplayGender.fromJson(json['displayGender'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displayGenderId'] = this.displayGenderId;
    data['displaySection'] = this.displaySection;
    data['speciality'] = this.speciality;
    if (this.displayGender != null) {
      data['displayGender'] = this.displayGender.toJson();
    }
    return data;
  }
}

class DisplayGender {
  int id;
  String name;
  String code;

  DisplayGender({this.id, this.name, this.code});

  DisplayGender.fromJson(Map<String, dynamic> json) {
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
