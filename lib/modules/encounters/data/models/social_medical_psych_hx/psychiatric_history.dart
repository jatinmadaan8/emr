class PsychiatricHistoryModel {
  int id;
  int encounterId;
  String comments;
  String prevConcerns;
  List<PsychiatricDiseases> psychiatricDiseases;

  PsychiatricHistoryModel(
      {this.id,
      this.encounterId,
      this.comments,
      this.prevConcerns,
      this.psychiatricDiseases});

  PsychiatricHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    comments = json['comments'];
    prevConcerns = json['prevConcerns'];
    if (json['psychiatricDiseases'] != null) {
      psychiatricDiseases = new List<PsychiatricDiseases>();
      json['psychiatricDiseases'].forEach((v) {
        psychiatricDiseases.add(new PsychiatricDiseases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    data['prevConcerns'] = this.prevConcerns;
    if (this.psychiatricDiseases != null) {
      data['psychiatricDiseases'] =
          this.psychiatricDiseases.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    data['prevConcerns'] = this.prevConcerns;
    if (this.psychiatricDiseases != null) {
      data['psychiatricDiseases'] =
          this.psychiatricDiseases.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    data['prevConcerns'] = this.prevConcerns;
    if (this.psychiatricDiseases != null) {
      data['psychiatricDiseases'] =
          this.psychiatricDiseases.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class PsychiatricDiseases {
  int id;
  int psychiatricHistoryId;
  int diseaseId;
  String otherDescription;
  Disease disease;

  PsychiatricDiseases(
      {this.id,
      this.psychiatricHistoryId,
      this.diseaseId,
      this.otherDescription,
      this.disease});

  PsychiatricDiseases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    psychiatricHistoryId = json['psychiatricHistoryId'];
    diseaseId = json['diseaseId'];
    otherDescription = json['otherDescription'];
    disease =
        json['disease'] != null ? new Disease.fromJson(json['disease']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['psychiatricHistoryId'] = this.psychiatricHistoryId;
    data['diseaseId'] = this.diseaseId;
    data['otherDescription'] = this.otherDescription;
    if (this.disease != null) {
      data['disease'] = this.disease.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diseaseId'] = this.diseaseId;
    return data;
  }
}

class Disease {
  int id;
  String name;

  Disease({this.id, this.name});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
