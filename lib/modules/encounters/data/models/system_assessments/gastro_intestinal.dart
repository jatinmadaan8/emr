class GastroIntestinalModel {
  int id;
  int encounterId;
  bool isMucosaDry;
  String eternalComments;
  String bowelComments;
  bool isBowelSounds;
  String lastBowelMovementDt;
  List<GastrointestinalBowels> gastrointestinalBowels;
  List<GastrointestinalEternal> gastrointestinalEternal;

  GastroIntestinalModel(
      {this.id,
      this.encounterId,
      this.isMucosaDry,
      this.eternalComments,
      this.bowelComments,
      this.isBowelSounds,
      this.lastBowelMovementDt,
      this.gastrointestinalBowels,
      this.gastrointestinalEternal});

  GastroIntestinalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    isMucosaDry = json['isMucosaDry'];
    eternalComments = json['eternalComments'];
    bowelComments = json['bowelComments'];
    isBowelSounds = json['isBowelSounds'];
    lastBowelMovementDt = json['lastBowelMovementDt'];
    if (json['gastrointestinalBowels'] != null) {
      gastrointestinalBowels = new List<GastrointestinalBowels>();
      json['gastrointestinalBowels'].forEach((v) {
        gastrointestinalBowels.add(new GastrointestinalBowels.fromJson(v));
      });
    }
    if (json['gastrointestinalEternal'] != null) {
      gastrointestinalEternal = new List<GastrointestinalEternal>();
      json['gastrointestinalEternal'].forEach((v) {
        gastrointestinalEternal.add(new GastrointestinalEternal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['isMucosaDry'] = this.isMucosaDry;
    data['eternalComments'] = this.eternalComments;
    data['bowelComments'] = this.bowelComments;
    data['isBowelSounds'] = this.isBowelSounds;
    data['lastBowelMovementDt'] = this.lastBowelMovementDt;
    if (this.gastrointestinalBowels != null) {
      data['gastrointestinalBowels'] =
          this.gastrointestinalBowels.map((v) => v.toJson()).toList();
    }
    if (this.gastrointestinalEternal != null) {
      data['gastrointestinalEternal'] =
          this.gastrointestinalEternal.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['isMucosaDry'] = this.isMucosaDry;
    data['eternalComments'] = this.eternalComments;
    data['bowelComments'] = this.bowelComments;
    data['isBowelSounds'] = this.isBowelSounds;
    data['lastBowelMovementDt'] = this.lastBowelMovementDt;
    if (this.gastrointestinalBowels != null) {
      data['gastrointestinalBowels'] =
          this.gastrointestinalBowels.map((v) => v.toUpdateJson()).toList();
    }
    if (this.gastrointestinalEternal != null) {
      data['gastrointestinalEternal'] =
          this.gastrointestinalEternal.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['isMucosaDry'] = this.isMucosaDry;
    data['eternalComments'] = this.eternalComments;
    data['bowelComments'] = this.bowelComments;
    data['isBowelSounds'] = this.isBowelSounds;
    data['lastBowelMovementDt'] = this.lastBowelMovementDt;
    if (this.gastrointestinalBowels != null) {
      data['gastrointestinalBowels'] =
          this.gastrointestinalBowels.map((v) => v.toUpdateJson()).toList();
    }
    if (this.gastrointestinalEternal != null) {
      data['gastrointestinalEternal'] =
          this.gastrointestinalEternal.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class GastrointestinalBowels {
  int id;
  int gastroId;
  int bowelId;
  GastroIntestinalDropDown bowel;

  GastrointestinalBowels({this.id, this.gastroId, this.bowelId, this.bowel});

  GastrointestinalBowels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gastroId = json['gastroId'];
    bowelId = json['bowelId'];
    bowel = json['bowel'] != null
        ? new GastroIntestinalDropDown.fromJson(json['bowel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gastroId'] = this.gastroId;
    data['bowelId'] = this.bowelId;
    if (this.bowel != null) {
      data['bowel'] = this.bowel.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bowelId'] = this.bowelId;
    return data;
  }
}

class GastroIntestinalDropDown {
  int id;
  String description;

  GastroIntestinalDropDown({this.id, this.description});

  GastroIntestinalDropDown.fromJson(Map<String, dynamic> json) {
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

class GastrointestinalEternal {
  int id;
  int gastroId;
  int eternalId;
  GastroIntestinalDropDown eternal;

  GastrointestinalEternal(
      {this.id, this.gastroId, this.eternalId, this.eternal});

  GastrointestinalEternal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gastroId = json['gastroId'];
    eternalId = json['eternalId'];
    eternal = json['eternal'] != null
        ? new GastroIntestinalDropDown.fromJson(json['eternal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gastroId'] = this.gastroId;
    data['eternalId'] = this.eternalId;
    if (this.eternal != null) {
      data['eternal'] = this.eternal.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eternalId'] = this.eternalId;
    return data;
  }
}
