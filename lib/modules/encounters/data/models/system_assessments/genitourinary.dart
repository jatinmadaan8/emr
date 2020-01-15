class GenitourinaryModel {
  int id;
  int encounterId;
  int colorId;
  String colorComments;
  String cathetersComments;
  String bladderComments;
  GenitourinaryLookUpModel color;
  List<GenitourinaryBaldderSymptoms> genitourinaryBaldderSymptoms;
  List<GenitourinaryCatheters> genitourinaryCatheters;

  GenitourinaryModel(
      {this.id,
      this.encounterId,
      this.colorId,
      this.colorComments,
      this.cathetersComments,
      this.bladderComments,
      this.color,
      this.genitourinaryBaldderSymptoms,
      this.genitourinaryCatheters});

  GenitourinaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    colorId = json['colorId'];
    colorComments = json['colorComments'];
    cathetersComments = json['cathetersComments'];
    bladderComments = json['bladderComments'];
    color = json['color'] != null
        ? new GenitourinaryLookUpModel.fromJson(json['color'])
        : null;
    if (json['genitourinaryBaldderSymptoms'] != null) {
      genitourinaryBaldderSymptoms = new List<GenitourinaryBaldderSymptoms>();
      json['genitourinaryBaldderSymptoms'].forEach((v) {
        genitourinaryBaldderSymptoms
            .add(new GenitourinaryBaldderSymptoms.fromJson(v));
      });
    }
    if (json['genitourinaryCatheters'] != null) {
      genitourinaryCatheters = new List<GenitourinaryCatheters>();
      json['genitourinaryCatheters'].forEach((v) {
        genitourinaryCatheters.add(new GenitourinaryCatheters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorComments'] = this.colorComments;
    data['cathetersComments'] = this.cathetersComments;
    data['bladderComments'] = this.bladderComments;
    if (this.color != null) {
      data['color'] = this.color.toJson();
    }
    if (this.genitourinaryBaldderSymptoms != null) {
      data['genitourinaryBaldderSymptoms'] =
          this.genitourinaryBaldderSymptoms.map((v) => v.toJson()).toList();
    }
    if (this.genitourinaryCatheters != null) {
      data['genitourinaryCatheters'] =
          this.genitourinaryCatheters.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorComments'] = this.colorComments;
    data['cathetersComments'] = this.cathetersComments;
    data['bladderComments'] = this.bladderComments;

    if (this.genitourinaryBaldderSymptoms != null) {
      data['genitourinaryBaldderSymptoms'] = this
          .genitourinaryBaldderSymptoms
          .map((v) => v.toUpdateJson())
          .toList();
    }
    if (this.genitourinaryCatheters != null) {
      data['genitourinaryCatheters'] =
          this.genitourinaryCatheters.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['colorId'] = this.colorId;
    data['colorComments'] = this.colorComments;
    data['cathetersComments'] = this.cathetersComments;
    data['bladderComments'] = this.bladderComments;

    if (this.genitourinaryBaldderSymptoms != null) {
      data['genitourinaryBaldderSymptoms'] = this
          .genitourinaryBaldderSymptoms
          .map((v) => v.toUpdateJson())
          .toList();
    }
    if (this.genitourinaryCatheters != null) {
      data['genitourinaryCatheters'] =
          this.genitourinaryCatheters.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class GenitourinaryLookUpModel {
  int id;
  String description;

  GenitourinaryLookUpModel({this.id, this.description});

  GenitourinaryLookUpModel.fromJson(Map<String, dynamic> json) {
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

class GenitourinaryBaldderSymptoms {
  int id;
  int urinaryId;
  int symptomId;
  GenitourinaryLookUpModel symptom;

  GenitourinaryBaldderSymptoms(
      {this.id, this.urinaryId, this.symptomId, this.symptom});

  GenitourinaryBaldderSymptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urinaryId = json['urinaryId'];
    symptomId = json['symptomId'];
    symptom = json['symptom'] != null
        ? new GenitourinaryLookUpModel.fromJson(json['symptom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urinaryId'] = this.urinaryId;
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

class GenitourinaryCatheters {
  int id;
  int urinaryId;
  int catheterId;
  GenitourinaryLookUpModel catheter;

  GenitourinaryCatheters(
      {this.id, this.urinaryId, this.catheterId, this.catheter});

  GenitourinaryCatheters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urinaryId = json['urinaryId'];
    catheterId = json['catheterId'];
    catheter = json['catheter'] != null
        ? new GenitourinaryLookUpModel.fromJson(json['catheter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urinaryId'] = this.urinaryId;
    data['catheterId'] = this.catheterId;
    if (this.catheter != null) {
      data['catheter'] = this.catheter.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catheterId'] = this.catheterId;
    return data;
  }
}
