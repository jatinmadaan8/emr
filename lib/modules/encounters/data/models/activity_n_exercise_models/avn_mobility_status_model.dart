
class ActivityNExerciseMobilityStatusModel {
  int id;
  String name;

  ActivityNExerciseMobilityStatusModel({
    this.id,
    this.name,
  });

  ActivityNExerciseMobilityStatusModel copyWith({
    int id,
    String name,
  }) =>
      ActivityNExerciseMobilityStatusModel(id: id ?? this.id, name: name ?? this.name);

  factory ActivityNExerciseMobilityStatusModel.fromMap(Map<String, dynamic> json) => ActivityNExerciseMobilityStatusModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}


class ActivityNExerciseAssistiveDevicesModel {
  int id;
  String name;

  ActivityNExerciseAssistiveDevicesModel({
    this.id,
    this.name,
  });

  ActivityNExerciseAssistiveDevicesModel copyWith({
    int id,
    String name,
  }) =>
      ActivityNExerciseAssistiveDevicesModel(id: id ?? this.id, name: name ?? this.name);

  factory ActivityNExerciseAssistiveDevicesModel.fromMap(Map<String, dynamic> json) => ActivityNExerciseAssistiveDevicesModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}


class ActivityNExerciseLimitationsModel {
  int id;
  String name;

  ActivityNExerciseLimitationsModel({
    this.id,
    this.name,
  });

  ActivityNExerciseLimitationsModel copyWith({
    int id,
    String name,
  }) =>
      ActivityNExerciseLimitationsModel(id: id ?? this.id, name: name ?? this.name);

  factory ActivityNExerciseLimitationsModel.fromJSON(Map<String, dynamic> json) => ActivityNExerciseLimitationsModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}




class ActivityNExerciseADLsModel {
  int id;
  String name;

  ActivityNExerciseADLsModel({
    this.id,
    this.name,
  });


  factory ActivityNExerciseADLsModel.fromMap(Map<String, dynamic> json) => ActivityNExerciseADLsModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

///Getting the activities & Exercises against encounter id


class ActivitiesNExercise{
   int id;
   int encounterId;
   String hobbiesInterestOccupation;
   ActivityExerciseQuestionnaire activityExerciseQuestionnaire;
  ActivitiesNExercise({this.id,this.encounterId,this.hobbiesInterestOccupation,this.activityExerciseQuestionnaire});


  factory ActivitiesNExercise.fromJson(Map<String, dynamic> json) {

    return ActivitiesNExercise(
        id: json['id'],
        encounterId: json['encounterId'],
        hobbiesInterestOccupation: json['hobbiesInterestOccupation'],
        activityExerciseQuestionnaire: ActivityExerciseQuestionnaire.fromJson(json['activityExerciseQuestionnaire']),
     // activityExerciseQuestionnaire: list

    );
  }

   Map<String, dynamic> toMap() => {
     if (id != null) "id": id == null ? null : id,
     "encounterId": encounterId == null ? null : encounterId,
     "hobbiesInterestOccupation": hobbiesInterestOccupation == null ? null : hobbiesInterestOccupation,
     "activityExerciseQuestionnaire": activityExerciseQuestionnaire == null
         ? null
         : activityExerciseQuestionnaire.toMap(),
   };

}

class ActivityExerciseQuestionnaire{

   int id;
   int acnExId;
   int mobilityId;
   int assistDeviceId;
   String assistDeviceList;
   int limitationsId;
   String limitationsDesc;
   int adlsId;
   bool exerciseRegularly;
   String exerciseDesc;

  ActivityExerciseQuestionnaire({this.id,this.acnExId,this.mobilityId,this.assistDeviceId,this.assistDeviceList,this
  .limitationsId,this.exerciseDesc,this.adlsId,this.exerciseRegularly,this.limitationsDesc});

  factory ActivityExerciseQuestionnaire.fromJson(Map<String, dynamic> json) {
    return ActivityExerciseQuestionnaire(
        id: json['id'],
        acnExId: json['acnExId'],
        mobilityId: json['mobilityId'],
        assistDeviceId: json['assistDeviceId'],
      assistDeviceList: json['assistDeviceList'] == null ? null : json['assistDeviceList'] ,
      limitationsId: json['limitationsId'],
      limitationsDesc: json['limitationsDesc'] == null ? null : json['limitationsDesc'],
      adlsId: json['adlsId'],
      exerciseRegularly: json['exerciseRegularly'],
      exerciseDesc: json['exerciseDesc'] == null ? null : json['exerciseDesc']
    );
  }

   Map<String, dynamic> toMap() => {
     if (id != null) "id": id == null ? null : id,
     "acnExId": acnExId == null ? null : acnExId,
     "mobilityId": mobilityId == null ? null : mobilityId,
     "assistDeviceId": assistDeviceId == null ? null : assistDeviceId,
     "limitationsId": limitationsId == null ? null : limitationsId,
     "limitationsDesc": limitationsDesc == null ? null : limitationsDesc,
     "adlsId": adlsId == null ? null : adlsId,
     "exerciseRegularly": exerciseRegularly == null ? null : exerciseRegularly,
     "exerciseDesc": exerciseDesc == null ? null : exerciseDesc,
   };
}
