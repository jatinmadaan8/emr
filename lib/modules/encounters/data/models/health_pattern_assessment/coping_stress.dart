class CopingStress {
  int id;
  int encounterId;
  String actionUnderStress;
  List<CosQuestions> copingStressQuestionnaire;

  CopingStress({
    this.id,
    this.encounterId,
    this.actionUnderStress,
    this.copingStressQuestionnaire,
  });

  factory CopingStress.fromMap(Map<String, dynamic> json) => CopingStress(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        actionUnderStress: json["actionUnderStress"] == null
            ? null
            : json["actionUnderStress"],
        copingStressQuestionnaire: json["copingStressQuestionnaire"] == null
            ? []
            : List<CosQuestions>.from(json["copingStressQuestionnaire"]
                .map((x) => CosQuestions.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "actionUnderStress":
            actionUnderStress == null ? null : actionUnderStress,
        "copingStressQuestionnaire": copingStressQuestionnaire == null
            ? null
            : copingStressQuestionnaire.map((v) => v.toMap()).toList(),
      };
}

class CosQuestions {
  int id;
  int questionId;
  bool response;
  String additionalInfo;

  CosQuestions({
    this.id,
    this.questionId,
    this.response,
    this.additionalInfo,
  });

  factory CosQuestions.fromMap(Map<String, dynamic> json) => CosQuestions(
        id: json["id"] == null ? null : json["id"],
        questionId: json["questionId"] == null ? null : json["questionId"],
        response: json["response"] == null ? null : json["response"],
        additionalInfo:
            json["additionalInfo"] == null ? null : json["additionalInfo"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "questionId": questionId == null ? null : questionId,
        "response": response == null ? null : response,
        "additionalInfo": additionalInfo == null ? null : additionalInfo,
      };
}
