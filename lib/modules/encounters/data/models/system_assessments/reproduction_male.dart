class ReproductionMaleModel {
  int id;
  int encounterId;
  String comments;
  List<ReproducationmaleProblems> reproducationmaleProblems;

  ReproductionMaleModel(
      {this.id,
      this.encounterId,
      this.comments,
      this.reproducationmaleProblems});

  ReproductionMaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    comments = json['comments'];
    if (json['reproducationmaleProblems'] != null) {
      reproducationmaleProblems = new List<ReproducationmaleProblems>();
      json['reproducationmaleProblems'].forEach((v) {
        reproducationmaleProblems
            .add(new ReproducationmaleProblems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.reproducationmaleProblems != null) {
      data['reproducationmaleProblems'] =
          this.reproducationmaleProblems.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.reproducationmaleProblems != null) {
      data['reproducationmaleProblems'] =
          this.reproducationmaleProblems.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['comments'] = this.comments;
    if (this.reproducationmaleProblems != null) {
      data['reproducationmaleProblems'] =
          this.reproducationmaleProblems.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class ReproducationmaleProblems {
  int id;
  int reproMaleId;
  int problemId;
  ReproductionMaleLookUpData problem;

  ReproducationmaleProblems(
      {this.id, this.reproMaleId, this.problemId, this.problem});

  ReproducationmaleProblems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reproMaleId = json['reproMaleId'];
    problemId = json['problemId'];
    problem = json['problem'] != null
        ? new ReproductionMaleLookUpData.fromJson(json['problem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reproMaleId'] = this.reproMaleId;
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

class ReproductionMaleLookUpData {
  int id;
  String name;

  ReproductionMaleLookUpData({this.id, this.name});

  ReproductionMaleLookUpData.fromJson(Map<String, dynamic> json) {
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
