class SelfPerception {
  int id;
  int encounterId;
  String concernsAbtIllness;
  bool isBehaviorAppropriate;
  String behaviorAppropriateDesc;

  SelfPerception({
    this.id,
    this.encounterId,
    this.concernsAbtIllness,
    this.isBehaviorAppropriate,
    this.behaviorAppropriateDesc,
  });

  factory SelfPerception.fromMap(Map<String, dynamic> json) => SelfPerception(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        concernsAbtIllness: json["concernsAbtIllness"] == null
            ? null
            : json["concernsAbtIllness"],
        isBehaviorAppropriate: json["isBehaviorAppropriate"] == null
            ? null
            : json["isBehaviorAppropriate"],
        behaviorAppropriateDesc: json["behaviorAppropriateDesc"] == null
            ? null
            : json["behaviorAppropriateDesc"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "concernsAbtIllness":
            concernsAbtIllness == null ? null : concernsAbtIllness,
        "isBehaviorAppropriate":
            isBehaviorAppropriate == null ? null : isBehaviorAppropriate,
        "behaviorAppropriateDesc":
            behaviorAppropriateDesc == null ? null : behaviorAppropriateDesc,
      };
}
