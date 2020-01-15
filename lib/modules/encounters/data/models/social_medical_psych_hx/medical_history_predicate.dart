import 'package:flutter/material.dart';

class MedicalHistoryPredicate {
  int id;
  String code;
  String description;

  MedicalHistoryPredicate({@required this.id, this.code, this.description});

  MedicalHistoryPredicate copyWith({
    int id,
    String code,
    String description,
  }) =>
      MedicalHistoryPredicate(
          id: id ?? this.id,
          code: code ?? this.code,
          description: description ?? this.description);

  factory MedicalHistoryPredicate.fromMap(Map<String, dynamic> json) =>
      MedicalHistoryPredicate(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "description": description == null ? null : description,
      };
}
