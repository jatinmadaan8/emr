class PainAssessment {
  int id;
  int encounterId;
  bool isPain;
  bool isControlled;
  int durationId;
  int locationId;
  int qualityId;
  int painType;
  int painScale;
  int goalforPainRelief;
  int painMngmtReferralId;

  String aggravatingfactor;
  String allevatingfactor;
  String goal;
  String currentregimen;
  String painlocationother;
  String paindurationother;
  String painqualityother;
  String painqualityradiationwhere;
  DateTime onsetDate;
  String impactOnFnAbility;

  PainAssessment({
    this.id,
    this.encounterId,
    this.isPain,
    this.isControlled,
    this.durationId,
    this.locationId,
    this.qualityId,
    this.painType,
    this.painScale,
    this.goalforPainRelief,
    this.painMngmtReferralId,
    this.aggravatingfactor,
    this.allevatingfactor,
    this.goal,
    this.currentregimen,
    this.painlocationother,
    this.paindurationother,
    this.painqualityother,
    this.painqualityradiationwhere,
    this.onsetDate,
    this.impactOnFnAbility,
  });

  factory PainAssessment.fromJson(Map<String, dynamic> json) => PainAssessment(
        id: json['id'],
        encounterId: json["encounterId"] == null ? null : json['encounterId'],
        isPain: json["isPain"] == null ? null : json['isPain'],
        durationId: json["durationId"] == null ? null : json['durationId'],
        locationId: json["locationId"] == null ? null : json['locationId'],
        isControlled:
            json["isControlled"] == null ? null : json['isControlled'],
        qualityId: json["qualityId"] == null ? null : json['qualityId'],
        painType: json["painType"] == null ? null : json['painType'],
        painScale: json["painScale"] == null ? null : json['painScale'],
        goalforPainRelief: json["goalforPainRelief"] == null
            ? null
            : json['goalforPainRelief'],
        painMngmtReferralId: json["painMngmtReferralId"] == null
            ? null
            : json['painMngmtReferralId'],
        aggravatingfactor: json["aggravatingfactor"] == null
            ? null
            : json['aggravatingfactor'],
        allevatingfactor:
            json["allevatingfactor"] == null ? null : json['allevatingfactor'],
        goal: json["goal"] == null ? null : json['goal'],
        currentregimen:
            json['currentregimen'] == null ? null : json['currentregimen'],
        painlocationother: json["painlocationother"] == null
            ? null
            : json['painlocationother'],
        paindurationother: json["paindurationother"] == null
            ? null
            : json['paindurationother'],
        painqualityother:
            json["painqualityother"] == null ? null : json['painqualityother'],
        painqualityradiationwhere: json["painqualityradiationwhere"] == null
            ? null
            : json['painqualityradiationwhere'],
        onsetDate: json["onsetDate"] == null
            ? null
            : DateTime.parse(json["onsetDate"]),
        impactOnFnAbility: json["impactOnFnAbility"] == null
            ? null
            : json['impactOnFnAbility'],
      );

  Map<String, dynamic> toJson() => {
        if (this.id != null) 'id': this.id,
        'encounterId': this.encounterId,
        'isPain': this.isPain,
        'isControlled': this.isControlled,
        'durationId': this.durationId,
        'locationId': this.locationId,
        'qualityId': this.qualityId,
        'painType': this.painType,
        'painScale': this.painScale,
        'goalforPainRelief': this.goalforPainRelief,
        'painMngmtReferralId': this.painMngmtReferralId,
        'aggravatingfactor': this.aggravatingfactor,
        'allevatingfactor': this.allevatingfactor,
        'goal': this.goal,
        'currentregimen': this.currentregimen,
        'painlocationother': this.painlocationother,
        'paindurationother': this.paindurationother,
        'painqualityother': this.painqualityother,
        'painqualityradiationwhere': this.painqualityradiationwhere,
        'onsetDate':
            this.onsetDate != null ? this.onsetDate.toUtc().toString() : null,
        'impactOnFnAbility': this.impactOnFnAbility,
      };
}
