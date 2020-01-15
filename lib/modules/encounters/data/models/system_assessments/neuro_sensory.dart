class NeuroSensory {
  int id;
  int encounterId;
  int orientedId;
  int consciousnessId;
  String comments;
  Consciousness consciousness;
  Consciousness oriented;
  List<NeurosensorySymptoms> neurosensorySymptoms;

  NeuroSensory(
      {this.id,
      this.encounterId,
      this.orientedId,
      this.consciousnessId,
      this.comments,
      this.consciousness,
      this.oriented,
      this.neurosensorySymptoms});

  NeuroSensory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    orientedId = json['orientedId'];
    consciousnessId = json['consciousnessId'];
    comments = json['comments'];
    consciousness = json['consciousness'] != null
        ? new Consciousness.fromJson(json['consciousness'])
        : null;
    oriented = json['oriented'] != null
        ? new Consciousness.fromJson(json['oriented'])
        : null;
    if (json['neurosensorySymptoms'] != null) {
      neurosensorySymptoms = new List<NeurosensorySymptoms>();
      json['neurosensorySymptoms'].forEach((v) {
        neurosensorySymptoms.add(new NeurosensorySymptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['orientedId'] = this.orientedId;
    data['consciousnessId'] = this.consciousnessId;
    data['comments'] = this.comments;
    if (this.consciousness != null) {
      data['consciousness'] = this.consciousness.toJson();
    }
    if (this.oriented != null) {
      data['oriented'] = this.oriented.toJson();
    }
    if (this.neurosensorySymptoms != null) {
      data['neurosensorySymptoms'] =
          this.neurosensorySymptoms.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['orientedId'] = this.orientedId;
    data['consciousnessId'] = this.consciousnessId;
    data['comments'] = this.comments;

    data['neurosensorySymptoms'] =
        this.neurosensorySymptoms.map((v) => v.toUpdateJson()).toList();

    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['orientedId'] = this.orientedId;
    data['consciousnessId'] = this.consciousnessId;
    data['comments'] = this.comments;

    data['neurosensorySymptoms'] =
        this.neurosensorySymptoms.map((v) => v.toUpdateJson()).toList();

    return data;
  }
}

class Consciousness {
  int id;
  String description;

  Consciousness({this.id, this.description});

  Consciousness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class NeurosensorySymptoms {
  int id;
  int neuroSensoryId;
  int symptomId;
  Consciousness symptom;

  NeurosensorySymptoms(
      {this.id, this.neuroSensoryId, this.symptomId, this.symptom});

  NeurosensorySymptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    neuroSensoryId = json['neuroSensoryId'];
    symptomId = json['symptomId'];
    symptom = json['symptom'] != null
        ? new Consciousness.fromJson(json['symptom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['neuroSensoryId'] = this.neuroSensoryId;
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

class NeuroDropDown {
  int id;
  String description;

  NeuroDropDown({
    this.id,
    this.description,
  });

  NeuroDropDown copyWith({
    int id,
    String description,
  }) =>
      NeuroDropDown(
          id: id ?? this.id, description: description ?? this.description);

  factory NeuroDropDown.fromMap(Map<String, dynamic> json) => NeuroDropDown(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "description": description == null ? null : description,
      };
}
