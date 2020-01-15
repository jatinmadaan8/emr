class CogitivePeceptualCommonModel {
  int id;
  String name;

  CogitivePeceptualCommonModel({
    this.id,
    this.name,
  });

  CogitivePeceptualCommonModel copyWith({
    int id,
    String name,
  }) =>
      CogitivePeceptualCommonModel(id: id ?? this.id, name: name ?? this.name);

  factory CogitivePeceptualCommonModel.fromMap(Map<String, dynamic> json) => CogitivePeceptualCommonModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}



class CognitivePerceptual{
  int id;
  int encounterId;
 // String hobbiesInterestOccupation;
  CognitivePerceptualQuestionnaire cognitivePerceptualQuestionnaire;
  CognitivePerceptual({this.id,this.encounterId,this.cognitivePerceptualQuestionnaire});


  factory CognitivePerceptual.fromJson(Map<String, dynamic> json) {

    return CognitivePerceptual(
      id: json['id'],
      encounterId: json['encounterId'],
   //   hobbiesInterestOccupation: json['hobbiesInterestOccupation'],
      cognitivePerceptualQuestionnaire: CognitivePerceptualQuestionnaire.fromJson(json['cognitivePerceptualQuestionnaire']),
      // activityExerciseQuestionnaire: list

    );
  }

  Map<String, dynamic> toMap() => {
    if (id != null) "id": id == null ? null : id,
    "encounterId": encounterId == null ? null : encounterId,
   // "hobbiesInterestOccupation": hobbiesInterestOccupation == null ? null : hobbiesInterestOccupation,
    "cognitivePerceptualQuestionnaire": cognitivePerceptualQuestionnaire == null
        ? null
        : cognitivePerceptualQuestionnaire.toMap(),
  };

}

class CognitivePerceptualQuestionnaire{

  int id;
  int cgoPcId;
  int communicationId;
  int languageId;
  String languageList;
  int hearingId;
  String hearingList;
  int visionId;
  String visionList;
  bool isParaesthesiaNumbness;
  String paraesthesiaNumbnessDesc;

  CognitivePerceptualQuestionnaire({this.id,this.cgoPcId,this.communicationId,this.languageId,this.languageList,this
      .hearingId,this.hearingList,this.visionId,this.visionList,this.isParaesthesiaNumbness,this.paraesthesiaNumbnessDesc});

  factory CognitivePerceptualQuestionnaire.fromJson(Map<String, dynamic> json) {
    return CognitivePerceptualQuestionnaire(
        id: json['id'],
        cgoPcId: json['cgoPcId'],
        communicationId: json['communicationId'],
        languageId: json['languageId'],
        languageList: json['languageList'] == null ? null : json['languageList'] ,
        hearingId: json['hearingId'],
        hearingList: json['hearingList'],
        visionId: json['visionId'] == null ? null : json['visionId'],
        visionList: json['visionList'] == null ? null : json['visionList'],
        isParaesthesiaNumbness: json['isParaesthesiaNumbness'],
        paraesthesiaNumbnessDesc: json['paraesthesiaNumbnessDesc'] == null ? null : json['paraesthesiaNumbnessDesc']
    );
  }

  Map<String, dynamic> toMap() => {
    if (id != null) "id": id == null ? null : id,
    "cgoPcId": cgoPcId == null ? null : cgoPcId,
    "communicationId": communicationId == null ? null : communicationId,
    "languageId": languageId == null ? null : languageId,
    "languageList": languageList == null ? null : languageList,
    "hearingId": hearingId == null ? null : hearingId,
    "hearingList": hearingList == null ? null : hearingList,
    "visionId": visionId == null ? null : visionId,
    "visionList": visionList == null ? null : visionList,
    "isParaesthesiaNumbness": isParaesthesiaNumbness == null ? null : isParaesthesiaNumbness,
    "paraesthesiaNumbnessDesc": paraesthesiaNumbnessDesc == null ? null : paraesthesiaNumbnessDesc,
  };
}