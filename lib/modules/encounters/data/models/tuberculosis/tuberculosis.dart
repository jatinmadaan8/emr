class Tuberculosis {
  int id;
  int encounterId;
  List<TuberculosisQuestionnaire> tuberculosisQuestionnaire;

  Tuberculosis({
    this.id,
    this.encounterId,
    this.tuberculosisQuestionnaire,
  });

  factory Tuberculosis.fromMap(Map<String, dynamic> json) => Tuberculosis(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        tuberculosisQuestionnaire: json["tuberculosisQuestionnaire"] == null
            ? []
            : List<TuberculosisQuestionnaire>.from(
                json["tuberculosisQuestionnaire"]
                    .map((x) => TuberculosisQuestionnaire.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "tuberculosisQuestionnaire": tuberculosisQuestionnaire == null
            ? null
            : tuberculosisQuestionnaire.map((v) => v.toMap()).toList(),
      };
}

class TuberculosisQuestionnaire {
  int id;
  int questionId;
  int tbId;
  bool response;
  String additionalInfo;

  TuberculosisQuestionnaire({
    this.id,
    this.questionId,
    this.tbId,
    this.response,
    this.additionalInfo,
  });

  factory TuberculosisQuestionnaire.fromMap(Map<String, dynamic> json) =>
      TuberculosisQuestionnaire(
        id: json["id"] == null ? null : json["id"],
        questionId: json["questionId"] == null ? null : json["questionId"],
        tbId: json["tbId"] == null ? null : json["tbId"],
        response: json["response"] == null ? null : json["response"],
        additionalInfo:
            json["additionalInfo"] == null ? null : json["additionalInfo"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "questionId": questionId == null ? null : questionId,
        if (tbId != null) "tbId": tbId == null ? null : tbId,
        "response": response == null ? null : response,
        "additionalInfo": additionalInfo == null ? null : additionalInfo,
      };
}
