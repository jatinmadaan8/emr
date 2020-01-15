class CardioVascularModel {
  int id;
  int encounterId;
  bool palpablePulse;
  bool leftNonPalpable;
  int apicalPulseMin;
  int apicalPulseMax;
  int rhythmId;
  int qualityId;
  int edemaId;
  String comments;
  CardioVascularDropDown edema;
  CardioVascularDropDown quality;
  CardioVascularDropDown rhythm;
  List<CardiovascularProblemsDetails> cardiovascularProblemsDetails;

  CardioVascularModel(
      {this.id,
      this.encounterId,
      this.palpablePulse,
      this.leftNonPalpable,
      this.apicalPulseMin,
      this.apicalPulseMax,
      this.rhythmId,
      this.qualityId,
      this.edemaId,
      this.comments,
      this.edema,
      this.quality,
      this.rhythm,
      this.cardiovascularProblemsDetails});

  CardioVascularModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    palpablePulse = json['palpablePulse'];
    leftNonPalpable = json['leftNonPalpable'];
    apicalPulseMin = json['apicalPulseMin'];
    apicalPulseMax = json['apicalPulseMax'];
    rhythmId = json['rhythmId'];
    qualityId = json['qualityId'];
    edemaId = json['edemaId'];
    comments = json['comments'];
    edema = json['edema'] != null
        ? new CardioVascularDropDown.fromJson(json['edema'])
        : null;
    quality = json['quality'] != null
        ? new CardioVascularDropDown.fromJson(json['quality'])
        : null;
    rhythm = json['rhythm'] != null
        ? new CardioVascularDropDown.fromJson(json['rhythm'])
        : null;
    if (json['cardiovascularProblemsDetails'] != null) {
      cardiovascularProblemsDetails = new List<CardiovascularProblemsDetails>();
      json['cardiovascularProblemsDetails'].forEach((v) {
        cardiovascularProblemsDetails
            .add(new CardiovascularProblemsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['palpablePulse'] = this.palpablePulse;
    data['leftNonPalpable'] = this.leftNonPalpable;
    data['apicalPulseMin'] = this.apicalPulseMin;
    data['apicalPulseMax'] = this.apicalPulseMax;
    data['rhythmId'] = this.rhythmId;
    data['qualityId'] = this.qualityId;
    data['edemaId'] = this.edemaId;
    data['comments'] = this.comments;
    if (this.edema != null) {
      data['edema'] = this.edema.toJson();
    }
    if (this.quality != null) {
      data['quality'] = this.quality.toJson();
    }
    if (this.rhythm != null) {
      data['rhythm'] = this.rhythm.toJson();
    }
    if (this.cardiovascularProblemsDetails != null) {
      data['cardiovascularProblemsDetails'] =
          this.cardiovascularProblemsDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['palpablePulse'] = this.palpablePulse;
    data['leftNonPalpable'] = this.leftNonPalpable;
    data['apicalPulseMin'] = this.apicalPulseMin;
    data['apicalPulseMax'] = this.apicalPulseMax;
    data['rhythmId'] = this.rhythmId;
    data['qualityId'] = this.qualityId;
    data['edemaId'] = this.edemaId;
    data['comments'] = this.comments;

    if (this.cardiovascularProblemsDetails != null) {
      data['cardiovascularProblemsDetails'] = this
          .cardiovascularProblemsDetails
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['palpablePulse'] = this.palpablePulse;
    data['leftNonPalpable'] = this.leftNonPalpable;
    data['apicalPulseMin'] = this.apicalPulseMin;
    data['apicalPulseMax'] = this.apicalPulseMax;
    data['rhythmId'] = this.rhythmId;
    data['qualityId'] = this.qualityId;
    data['edemaId'] = this.edemaId;
    data['comments'] = this.comments;

    if (this.cardiovascularProblemsDetails != null) {
      data['cardiovascularProblemsDetails'] = this
          .cardiovascularProblemsDetails
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }
}

class CardioVascularDropDown {
  int id;
  String name;

  CardioVascularDropDown({this.id, this.name});

  CardioVascularDropDown.fromJson(Map<String, dynamic> json) {
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

class CardiovascularProblemsDetails {
  int id;
  int cvId;
  int problemId;
  CardioVascularDropDown problem;

  CardiovascularProblemsDetails(
      {this.id, this.cvId, this.problemId, this.problem});

  CardiovascularProblemsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cvId = json['cvId'];
    problemId = json['problemId'];
    problem = json['problem'] != null
        ? new CardioVascularDropDown.fromJson(json['problem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cvId'] = this.cvId;
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
