class ReproductionFemaleModel {
  int id;
  int encounterId;
  String lmpDate;
  int para;
  int gravida;
  bool isPregnant;
  String pregnantEdc;
  bool isContraception;
  int contraceptionTypeId;
  String otherContraceptionType;
  String lastPapSmearDt;
  String comments;
  ContraceptionType contraceptionType;
  List<ReproducationfemaleProblems> reproducationfemaleProblems;

  ReproductionFemaleModel(
      {this.id,
      this.encounterId,
      this.lmpDate,
      this.para,
      this.gravida,
      this.isPregnant,
      this.pregnantEdc,
      this.isContraception,
      this.contraceptionTypeId,
      this.otherContraceptionType,
      this.lastPapSmearDt,
      this.comments,
      this.contraceptionType,
      this.reproducationfemaleProblems});

  ReproductionFemaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    lmpDate = json['lmpDate'];
    para = json['para'];
    gravida = json['gravida'];
    isPregnant = json['isPregnant'];
    pregnantEdc = json['pregnantEdc'];
    isContraception = json['isContraception'];
    contraceptionTypeId = json['contraceptionTypeId'];
    otherContraceptionType = json['otherContraceptionType'];
    lastPapSmearDt = json['lastPapSmearDt'];
    comments = json['comments'];
    contraceptionType = json['contraceptionType'] != null
        ? new ContraceptionType.fromJson(json['contraceptionType'])
        : null;
    if (json['reproducationfemaleProblems'] != null) {
      reproducationfemaleProblems = new List<ReproducationfemaleProblems>();
      json['reproducationfemaleProblems'].forEach((v) {
        reproducationfemaleProblems
            .add(new ReproducationfemaleProblems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['lmpDate'] = this.lmpDate;
    data['para'] = this.para;
    data['gravida'] = this.gravida;
    data['isPregnant'] = this.isPregnant;
    data['pregnantEdc'] = this.pregnantEdc;
    data['isContraception'] = this.isContraception;
    data['contraceptionTypeId'] = this.contraceptionTypeId;
    data['otherContraceptionType'] = this.otherContraceptionType;
    data['lastPapSmearDt'] = this.lastPapSmearDt;
    data['comments'] = this.comments;
    if (this.contraceptionType != null) {
      data['contraceptionType'] = this.contraceptionType.toJson();
    }
    if (this.reproducationfemaleProblems != null) {
      data['reproducationfemaleProblems'] =
          this.reproducationfemaleProblems.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['lmpDate'] = this.lmpDate;
    data['para'] = this.para;
    data['gravida'] = this.gravida;
    data['isPregnant'] = this.isPregnant;
    data['pregnantEdc'] = this.pregnantEdc;
    data['isContraception'] = this.isContraception;
    data['contraceptionTypeId'] = this.contraceptionTypeId;
    data['otherContraceptionType'] = this.otherContraceptionType;
    data['lastPapSmearDt'] = this.lastPapSmearDt;
    data['comments'] = this.comments;

    if (this.reproducationfemaleProblems != null) {
      data['reproducationfemaleProblems'] = this
          .reproducationfemaleProblems
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['lmpDate'] = this.lmpDate;
    data['para'] = this.para;
    data['gravida'] = this.gravida;
    data['isPregnant'] = this.isPregnant;
    data['pregnantEdc'] = this.pregnantEdc;
    data['isContraception'] = this.isContraception;
    data['contraceptionTypeId'] = this.contraceptionTypeId;
    data['otherContraceptionType'] = this.otherContraceptionType;
    data['lastPapSmearDt'] = this.lastPapSmearDt;
    data['comments'] = this.comments;

    if (this.reproducationfemaleProblems != null) {
      data['reproducationfemaleProblems'] = this
          .reproducationfemaleProblems
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }
}

class ContraceptionType {
  int id;
  String description;

  ContraceptionType({this.id, this.description});

  ContraceptionType.fromJson(Map<String, dynamic> json) {
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

class ReproducationfemaleProblems {
  int id;
  int reproFemaleId;
  int problemId;
  ReproductionFemaleLookUpData problem;

  ReproducationfemaleProblems(
      {this.id, this.reproFemaleId, this.problemId, this.problem});

  ReproducationfemaleProblems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reproFemaleId = json['reproFemaleId'];
    problemId = json['problemId'];
    problem = json['problem'] != null
        ? new ReproductionFemaleLookUpData.fromJson(json['problem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reproFemaleId'] = this.reproFemaleId;
    data['problemId'] = this.problemId;
    if (this.problem != null) {
      data['problem'] = this.problem.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['problemId'] = this.problemId;
    return data;
  }
}

class ReproductionFemaleLookUpData {
  int id;
  String name;

  ReproductionFemaleLookUpData({this.id, this.name});

  ReproductionFemaleLookUpData.fromJson(Map<String, dynamic> json) {
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

class ReproductionFemaleLookUpDataDescription {
  int id;
  String description;

  ReproductionFemaleLookUpDataDescription({this.id, this.description});

  ReproductionFemaleLookUpDataDescription.fromJson(Map<String, dynamic> json) {
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
