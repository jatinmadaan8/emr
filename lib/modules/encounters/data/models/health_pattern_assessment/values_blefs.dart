class ValuesBeliefs {
  int id;
  int encounterId;
  List<VobQuestions> valuesBeliefsQuestionnaire;

  ValuesBeliefs({
    this.id,
    this.encounterId,
    this.valuesBeliefsQuestionnaire,
  });

  factory ValuesBeliefs.fromMap(Map<String, dynamic> json) => ValuesBeliefs(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        valuesBeliefsQuestionnaire: json["valuesBeliefsQuestionnaire"] == null
            ? []
            : List<VobQuestions>.from(json["valuesBeliefsQuestionnaire"]
                .map((x) => VobQuestions.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "valuesBeliefsQuestionnaire": valuesBeliefsQuestionnaire == null
            ? null
            : valuesBeliefsQuestionnaire.map((v) => v.toMap()).toList(),
      };
}

class VobQuestions {
  int id;
  int questionId;
  int vlnBfId;
  bool response;
  String additionalInfo;

  VobQuestions({
    this.id,
    this.questionId,
    this.vlnBfId,
    this.response,
    this.additionalInfo,
  });

  factory VobQuestions.fromMap(Map<String, dynamic> json) => VobQuestions(
        id: json["id"] == null ? null : json["id"],
        questionId: json["questionId"] == null ? null : json["questionId"],
        vlnBfId: json["vlnBfId"] == null ? null : json["vlnBfId"],
        response: json["response"] == null ? null : json["response"],
        additionalInfo:
            json["additionalInfo"] == null ? null : json["additionalInfo"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "questionId": questionId == null ? null : questionId,
        if (vlnBfId != null) "vlnBfId": vlnBfId == null ? null : vlnBfId,
        "response": response == null ? null : response,
        "additionalInfo": additionalInfo == null ? null : additionalInfo,
      };
}
