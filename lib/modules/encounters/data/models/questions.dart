class GenricQuestions {
  int id;
  String code;
  String description;
  int parentQuestionId;

  GenricQuestions({
    this.id,
    this.code,
    this.description,
    this.parentQuestionId,
  });

  factory GenricQuestions.fromMap(Map<String, dynamic> json) => GenricQuestions(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
        parentQuestionId: json["parentQuestionId"] == null ? null : json["parentQuestionId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "description": description == null ? null : description,
      };
}

class GenricLookupData {
  int id;
  String name;
  bool value;

  GenricLookupData({
    this.id,
    this.name,
    this.value
  });

  factory GenricLookupData.fromMap(Map<String, dynamic> json) =>
      GenricLookupData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? false : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
