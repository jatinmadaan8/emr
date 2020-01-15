class FurtherEvaluation {
  int id;
  int encounterId;
  int evalId;
  bool isReferrealOffered;

  FurtherEvaluation({
    this.id,
    this.encounterId,
    this.evalId,
    this.isReferrealOffered,
  });

  factory FurtherEvaluation.fromMap(Map<String, dynamic> json) =>
      FurtherEvaluation(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        evalId: json["evalId"] == null ? null : json["evalId"],
        isReferrealOffered: json["isReferrealOffered"] == null
            ? null
            : json["isReferrealOffered"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "evalId": evalId == null ? null : evalId,
        "isReferrealOffered":
            isReferrealOffered == null ? null : isReferrealOffered,
      };
}
