class SleepRest {
  int id;
  int encounterId;
  String bedTime;
  double hrsofNightSleep;
  int noofpillows;
  String helpsToSleep;

  List<SleepRestQuestionnaire> sleepRestQuestionnaire;

  SleepRest({
    this.id,
    this.encounterId,
    this.bedTime,
    this.hrsofNightSleep,
    this.noofpillows,
    this.helpsToSleep,
    this.sleepRestQuestionnaire,
  });

  factory SleepRest.fromMap(Map<String, dynamic> json) => SleepRest(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        bedTime: json["bedTime"] == null ? null : json["bedTime"],
        hrsofNightSleep:
            json["hrsofNightSleep"] == null ? null : json["hrsofNightSleep"],
        noofpillows: json["noofpillows"] == null ? null : json["noofpillows"],
        helpsToSleep:
            json["helpsToSleep"] == null ? null : json["helpsToSleep"],
        sleepRestQuestionnaire: json["sleepRestQuestionnaire"] == null
            ? []
            : List<SleepRestQuestionnaire>.from(json["sleepRestQuestionnaire"]
                .map((x) => SleepRestQuestionnaire.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "bedTime": bedTime == null ? null : bedTime,
        "hrsofNightSleep": hrsofNightSleep == null ? null : hrsofNightSleep,
        "noofpillows": noofpillows == null ? null : noofpillows,
        "helpsToSleep": helpsToSleep == null ? null : helpsToSleep,
        "sleepRestQuestionnaire": sleepRestQuestionnaire == null
            ? null
            :  sleepRestQuestionnaire.map((v) => v.toMap()).toList(),
      };
}

class SleepRestQuestionnaire {
  int id;
  int spoRtId;
  int problemsId;
  String problemDesc;

  SleepRestQuestionnaire({
    this.id,
    this.spoRtId,
    this.problemsId,
    this.problemDesc,
  });

  factory SleepRestQuestionnaire.fromMap(Map<String, dynamic> json) =>
      SleepRestQuestionnaire(
        id: json["id"] == null ? null : json["id"],
        spoRtId: json["spoRtId"] == null ? null : json["spoRtId"],
        problemsId: json["problemsId"] == null ? null : json["problemsId"],
        problemDesc: json["problemDesc"] == null ? null : json["problemDesc"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        if (spoRtId != null) "spoRtId": spoRtId == null ? null : spoRtId,
        "problemsId": problemsId == null ? null : problemsId,
        "problemDesc": problemDesc == null ? null : problemDesc,
      };
}
