class ChiefComplaint {
  int id;
  int encounterId;
  String complaint;
  String accompaniedBy;
  int informantId;
  int methodOfArrivalId;
  int reasonId;

  ChiefComplaint({
    this.id,
    this.encounterId,
    this.complaint,
    this.accompaniedBy,
    this.informantId,
    this.methodOfArrivalId,
    this.reasonId,
  });

  ChiefComplaint copyWith({
    int id,
    int encounterId,
    String complaint,
    String accompaniedBy,
    int informantId,
    int methodOfArrivalId,
    int reasonId,
  }) =>
      ChiefComplaint(
        id: id ?? this.id,
        encounterId: encounterId ?? this.encounterId,
        complaint: complaint ?? this.complaint,
        accompaniedBy: accompaniedBy ?? this.accompaniedBy,
        informantId: informantId ?? this.informantId,
        methodOfArrivalId: methodOfArrivalId ?? this.methodOfArrivalId,
        reasonId: reasonId ?? this.reasonId,
      );

  factory ChiefComplaint.fromMap(Map<String, dynamic> json) => ChiefComplaint(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        complaint: json["complaint"] == null ? null : json["complaint"],
        accompaniedBy:
            json["accompaniedBy"] == null ? null : json["accompaniedBy"],
        informantId: json["informantId"] == null ? null : json["informantId"],
        methodOfArrivalId: json["methodOfArrivalId"] == null
            ? null
            : json["methodOfArrivalId"],
        reasonId: json["reasonId"] == null ? null : json["reasonId"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "complaint": complaint == null ? null : complaint,
        "accompaniedBy": accompaniedBy == null ? null : accompaniedBy,
        "informantId": informantId == null ? null : informantId,
        "methodOfArrivalId":
            methodOfArrivalId == null ? null : methodOfArrivalId,
        "reasonId": reasonId == null ? null : reasonId,
      };
}
