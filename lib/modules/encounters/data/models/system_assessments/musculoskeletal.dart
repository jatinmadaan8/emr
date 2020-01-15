class MusculoSkeletalModel {
  int id;
  int encounterId;
  int rightGripId;
  int leftGripId;
  int rightPushId;
  int leftPushId;
  String comments;
  MusculoSkeletalLookUpData leftGrip;
  MusculoSkeletalLookUpData leftPush;
  MusculoSkeletalLookUpData rightGrip;
  MusculoSkeletalLookUpData rightPush;
  List<MusculoskeletalProblemsDetails> musculoskeletalProblemsDetails;

  MusculoSkeletalModel(
      {this.id,
      this.encounterId,
      this.rightGripId,
      this.leftGripId,
      this.rightPushId,
      this.leftPushId,
      this.comments,
      this.leftGrip,
      this.leftPush,
      this.rightGrip,
      this.rightPush,
      this.musculoskeletalProblemsDetails});

  MusculoSkeletalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    rightGripId = json['rightGripId'];
    leftGripId = json['leftGripId'];
    rightPushId = json['rightPushId'];
    leftPushId = json['leftPushId'];
    comments = json['comments'];
    leftGrip = json['leftGrip'] != null
        ? new MusculoSkeletalLookUpData.fromJson(json['leftGrip'])
        : null;
    leftPush = json['leftPush'] != null
        ? new MusculoSkeletalLookUpData.fromJson(json['leftPush'])
        : null;
    rightGrip = json['rightGrip'] != null
        ? new MusculoSkeletalLookUpData.fromJson(json['rightGrip'])
        : null;
    rightPush = json['rightPush'] != null
        ? new MusculoSkeletalLookUpData.fromJson(json['rightPush'])
        : null;
    if (json['musculoskeletalProblemsDetails'] != null) {
      musculoskeletalProblemsDetails =
          new List<MusculoskeletalProblemsDetails>();
      json['musculoskeletalProblemsDetails'].forEach((v) {
        musculoskeletalProblemsDetails
            .add(new MusculoskeletalProblemsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['rightGripId'] = this.rightGripId;
    data['leftGripId'] = this.leftGripId;
    data['rightPushId'] = this.rightPushId;
    data['leftPushId'] = this.leftPushId;
    data['comments'] = this.comments;
    if (this.leftGrip != null) {
      data['leftGrip'] = this.leftGrip.toJson();
    }
    if (this.leftPush != null) {
      data['leftPush'] = this.leftPush.toJson();
    }
    if (this.rightGrip != null) {
      data['rightGrip'] = this.rightGrip.toJson();
    }
    if (this.rightPush != null) {
      data['rightPush'] = this.rightPush.toJson();
    }
    if (this.musculoskeletalProblemsDetails != null) {
      data['musculoskeletalProblemsDetails'] =
          this.musculoskeletalProblemsDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['rightGripId'] = this.rightGripId;
    data['leftGripId'] = this.leftGripId;
    data['rightPushId'] = this.rightPushId;
    data['leftPushId'] = this.leftPushId;
    data['comments'] = this.comments;

    if (this.musculoskeletalProblemsDetails != null) {
      data['musculoskeletalProblemsDetails'] = this
          .musculoskeletalProblemsDetails
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['rightGripId'] = this.rightGripId;
    data['leftGripId'] = this.leftGripId;
    data['rightPushId'] = this.rightPushId;
    data['leftPushId'] = this.leftPushId;
    data['comments'] = this.comments;

    if (this.musculoskeletalProblemsDetails != null) {
      data['musculoskeletalProblemsDetails'] = this
          .musculoskeletalProblemsDetails
          .map((v) => v.toUpdateJson())
          .toList();
    }
    return data;
  }
}

class MusculoSkeletalLookUpData {
  int id;
  String name;

  MusculoSkeletalLookUpData({this.id, this.name});

  MusculoSkeletalLookUpData.fromJson(Map<String, dynamic> json) {
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

class MusculoskeletalProblemsDetails {
  int id;
  int muscId;
  int problemId;
  MusculoSkeletalLookUpData problem;

  MusculoskeletalProblemsDetails(
      {this.id, this.muscId, this.problemId, this.problem});

  MusculoskeletalProblemsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    muscId = json['muscId'];
    problemId = json['problemId'];
    problem = json['problem'] != null
        ? new MusculoSkeletalLookUpData.fromJson(json['problem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['muscId'] = this.muscId;
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
