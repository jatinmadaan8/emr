class AbuseNeglect {
  int id;
  int encounterId;
  AbuseNeglectQuestionnaire abuseNeglectQuestionnaire;

  AbuseNeglect({
    this.id,
    this.encounterId,
    this.abuseNeglectQuestionnaire,
  });

  factory AbuseNeglect.fromMap(Map<String, dynamic> json) => AbuseNeglect(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        abuseNeglectQuestionnaire: json["abuseNeglectQuestionnaire"] == null
            ? null
            : AbuseNeglectQuestionnaire.fromMap(
                json["abuseNeglectQuestionnaire"]),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "abuseNeglectQuestionnaire": abuseNeglectQuestionnaire == null
            ? null
            : abuseNeglectQuestionnaire.toMap(),
      };
}

class AbuseNeglectQuestionnaire {
  int id;
  int aboNgId;
  bool feelSafeAthome;
  String safeAtHomeDesc;
  int observationId;
  String observationDesc;
  int followupActId;
  String followupActDesc;

  AbuseNeglectQuestionnaire({
    this.id,
    this.aboNgId,
    this.feelSafeAthome,
    this.safeAtHomeDesc,
    this.observationId,
    this.observationDesc,
    this.followupActId,
    this.followupActDesc,
  });

  factory AbuseNeglectQuestionnaire.fromMap(Map<String, dynamic> json) =>
      AbuseNeglectQuestionnaire(
        id: json["id"] == null ? null : json["id"],
        aboNgId: json["aboNgId"] == null ? null : json["aboNgId"],
        feelSafeAthome:
            json["feelSafeAthome"] == null ? null : json["feelSafeAthome"],
        safeAtHomeDesc:
            json["safeAtHomeDesc"] == null ? null : json["safeAtHomeDesc"],
        observationId:
            json["observationId"] == null ? null : json["observationId"],
        observationDesc:
            json["observationDesc"] == null ? null : json["observationDesc"],
        followupActId:
            json["followupActId"] == null ? null : json["followupActId"],
        followupActDesc:
            json["followupActDesc"] == null ? null : json["followupActDesc"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        if (aboNgId != null) "aboNgId": aboNgId == null ? null : aboNgId,
        "feelSafeAthome": feelSafeAthome == null ? null : feelSafeAthome,
        "safeAtHomeDesc": safeAtHomeDesc == null ? null : safeAtHomeDesc,
        "observationId": observationId == null ? null : observationId,
        "observationDesc": observationDesc == null ? null : observationDesc,
        "followupActId": followupActId == null ? null : followupActId,
        "followupActDesc": followupActDesc == null ? null : followupActDesc,
      };
}
