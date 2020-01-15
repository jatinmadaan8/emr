class NutritionMetabolic {
  int id;
  int encounterId;
  int dieticianReferralId;
  List<NutritionMetabolicQuestionnaire> nutritionalMetabolicQuestionnaire;

  NutritionMetabolic({
    this.id,
    this.encounterId,
    this.dieticianReferralId,
    this.nutritionalMetabolicQuestionnaire,
  });

  factory NutritionMetabolic.fromMap(Map<String, dynamic> json) => NutritionMetabolic(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        dieticianReferralId: json["dieticianReferralId"] == null ? null : json["dieticianReferralId"],
        nutritionalMetabolicQuestionnaire: json["nutritionalMetabolicQuestionnaire"] == null
            ? []
            : List<NutritionMetabolicQuestionnaire>.from(
                json["nutritionalMetabolicQuestionnaire"]
                    .map((x) => NutritionMetabolicQuestionnaire.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "dieticianReferralId": dieticianReferralId == null ? null : dieticianReferralId,
        "nutritionalMetabolicQuestionnaire": nutritionalMetabolicQuestionnaire == null
            ? null
            : nutritionalMetabolicQuestionnaire.map((v) => v.toMap()).toList(),
      };
}

class NutritionMetabolicQuestionnaire {
  int id;
  int questionid;
  int nomId;
  bool response;
  String additionalInfo;

  NutritionMetabolicQuestionnaire({
    this.id,
    this.questionid,
    this.nomId,
    this.response,
    this.additionalInfo,
  });

  factory NutritionMetabolicQuestionnaire.fromMap(Map<String, dynamic> json) =>
      NutritionMetabolicQuestionnaire(
        id: json["id"] == null ? null : json["id"],
        questionid: json["questionid"] == null ? null : json["questionid"],
        nomId: json["nomId"] == null ? null : json["nomId"],
        response: json["response"] == null ? null : json["response"],
        additionalInfo:
            json["additionalInfo"] == null ? null : json["additionalInfo"],
      );

  Map<String, dynamic> toMap() => {
        // if (id != null) "id": id == null ? null : id,
        "questionid": questionid == null ? null : questionid,
        "response": response == null ? null : response,
        "additionalInfo": additionalInfo == null ? "" : additionalInfo,
      };
}
