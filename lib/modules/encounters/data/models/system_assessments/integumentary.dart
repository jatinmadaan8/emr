class IntegumentaryModel {
  int id;
  int encounterId;
  int colorId;
  String colorDesc;
  bool isSkinProblem;
  String skinProblemDesc;
  int tempId;
  int turgorId;
  int conditionId;
  String conditionDesc;
  bool isFootCare;
  String footCareDesc;
  IntegumentaryLookUpData color;
  IntegumentaryLookUpData condition;
  IntegumentaryLookUpData temp;
  IntegumentaryLookUpData turgor;

  IntegumentaryModel(
      {this.id,
      this.encounterId,
      this.colorId,
      this.colorDesc,
      this.isSkinProblem,
      this.skinProblemDesc,
      this.tempId,
      this.turgorId,
      this.conditionId,
      this.conditionDesc,
      this.isFootCare,
      this.footCareDesc,
      this.color,
      this.condition,
      this.temp,
      this.turgor});

  IntegumentaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    colorId = json['colorId'];
    colorDesc = json['colorDesc'];
    isSkinProblem = json['isSkinProblem'];
    skinProblemDesc = json['skinProblemDesc'];
    tempId = json['tempId'];
    turgorId = json['turgorId'];
    conditionId = json['conditionId'];
    conditionDesc = json['conditionDesc'];
    isFootCare = json['isFootCare'];
    footCareDesc = json['footCareDesc'];
    color = json['color'] != null
        ? new IntegumentaryLookUpData.fromJson(json['color'])
        : null;
    condition = json['condition'] != null
        ? new IntegumentaryLookUpData.fromJson(json['condition'])
        : null;
    temp = json['temp'] != null
        ? new IntegumentaryLookUpData.fromJson(json['temp'])
        : null;
    turgor = json['turgor'] != null
        ? new IntegumentaryLookUpData.fromJson(json['turgor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorDesc'] = this.colorDesc;
    data['isSkinProblem'] = this.isSkinProblem;
    data['skinProblemDesc'] = this.skinProblemDesc;
    data['tempId'] = this.tempId;
    data['turgorId'] = this.turgorId;
    data['conditionId'] = this.conditionId;
    data['conditionDesc'] = this.conditionDesc;
    data['isFootCare'] = this.isFootCare;
    data['footCareDesc'] = this.footCareDesc;
    if (this.color != null) {
      data['color'] = this.color.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition.toJson();
    }
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    if (this.turgor != null) {
      data['turgor'] = this.turgor.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorDesc'] = this.colorDesc;
    data['isSkinProblem'] = this.isSkinProblem;
    data['skinProblemDesc'] = this.skinProblemDesc;
    data['tempId'] = this.tempId;
    data['turgorId'] = this.turgorId;
    data['conditionId'] = this.conditionId;
    data['conditionDesc'] = this.conditionDesc;
    data['isFootCare'] = this.isFootCare;
    data['footCareDesc'] = this.footCareDesc;
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorDesc'] = this.colorDesc;
    data['isSkinProblem'] = this.isSkinProblem;
    data['skinProblemDesc'] = this.skinProblemDesc;
    data['tempId'] = this.tempId;
    data['turgorId'] = this.turgorId;
    data['conditionId'] = this.conditionId;
    data['conditionDesc'] = this.conditionDesc;
    data['isFootCare'] = this.isFootCare;
    data['footCareDesc'] = this.footCareDesc;
    return data;
  }
}

class IntegumentaryLookUpData {
  int id;
  String name;

  IntegumentaryLookUpData({this.id, this.name});

  IntegumentaryLookUpData.fromJson(Map<String, dynamic> json) {
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
