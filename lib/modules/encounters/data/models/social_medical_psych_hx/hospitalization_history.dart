class HospitalizationHistoryModel {
  int id;
  int encounterId;
  bool isHospitalized;
  String hospitalizationDate;

  HospitalizationHistoryModel(
      {this.id,
      this.encounterId,
      this.isHospitalized,
      this.hospitalizationDate});

  HospitalizationHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    isHospitalized = json['isHospitalized'];
    hospitalizationDate = json['hospitalizationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.id != null) data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['isHospitalized'] = this.isHospitalized;
    data['hospitalizationDate'] = this.hospitalizationDate;
    return data;
  }
}
