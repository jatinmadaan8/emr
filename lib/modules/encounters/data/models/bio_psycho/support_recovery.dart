class SupportRecovery {
  int id;
  int encounterId;
  bool isSatisfiedCircleOfFriends;
  bool isPartofSelfHelpGroup;
  String selfHelpGroupDesc;
  bool isVocationallyTrained;
  bool isFamilySupportive;
  String familyExpectations;
  bool isFriendsHelpful;
  bool isFreindsPreventing;

  SupportRecovery({
    this.id,
    this.encounterId,
    this.isSatisfiedCircleOfFriends,
    this.isPartofSelfHelpGroup,
    this.selfHelpGroupDesc,
    this.isVocationallyTrained,
    this.isFamilySupportive,
    this.familyExpectations,
    this.isFriendsHelpful,
    this.isFreindsPreventing,
  });

  factory SupportRecovery.fromMap(Map<String, dynamic> json) => SupportRecovery(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        isSatisfiedCircleOfFriends: json["isSatisfiedCircleOfFriends"] == null
            ? null
            : json["isSatisfiedCircleOfFriends"],
        isPartofSelfHelpGroup: json["isPartofSelfHelpGroup"] == null
            ? null
            : json["isPartofSelfHelpGroup"],
        selfHelpGroupDesc: json["selfHelpGroupDesc"] == null
            ? null
            : json["selfHelpGroupDesc"],
        isVocationallyTrained: json["isVocationallyTrained"] == null
            ? null
            : json["isVocationallyTrained"],
        isFamilySupportive: json["isFamilySupportive"] == null
            ? null
            : json["isFamilySupportive"],
        familyExpectations: json["familyExpectations"] == null
            ? null
            : json["familyExpectations"],
        isFriendsHelpful:
            json["isFriendsHelpful"] == null ? null : json["isFriendsHelpful"],
        isFreindsPreventing: json["isFreindsPreventing"] == null
            ? null
            : json["isFreindsPreventing"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "isSatisfiedCircleOfFriends": isSatisfiedCircleOfFriends == null
            ? null
            : isSatisfiedCircleOfFriends,
        "isPartofSelfHelpGroup":
            isPartofSelfHelpGroup == null ? null : isPartofSelfHelpGroup,
        "selfHelpGroupDesc":
            selfHelpGroupDesc == null ? null : selfHelpGroupDesc,
        "isVocationallyTrained":
            isVocationallyTrained == null ? null : isVocationallyTrained,
        "isFamilySupportive":
            isFamilySupportive == null ? null : isFamilySupportive,
        "familyExpectations":
            familyExpectations == null ? null : familyExpectations,
        "isFriendsHelpful": isFriendsHelpful == null ? null : isFriendsHelpful,
        "isFreindsPreventing":
            isFreindsPreventing == null ? null : isFreindsPreventing,
      };
}
