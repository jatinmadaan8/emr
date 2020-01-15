import 'package:flutter/material.dart';

class Encounter {
  int id;
  int patientId;
  String date;
  int providerId;

  Encounter({
    @required this.id,
    @required this.patientId,
    @required this.date,
    @required this.providerId,
  });

  Encounter copyWith({
    int id,
    String patientId,
    String date,
    String providerId,
  }) =>
      Encounter(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        date: date ?? this.date,
        providerId: date ?? this.providerId,
      );

  factory Encounter.fromMap(Map<String, dynamic> json) => Encounter(
        id: json["id"] == null ? null : json["id"],
        patientId: json["patientId"] == null ? null : json["patientId"],
        date: json["date"] == null ? null : json["date"],
        providerId: json["providerId"] == null ? null : json["providerId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "patientId": patientId == null ? null : patientId,
        "date": date == null ? null : date,
        "providerId": providerId == null ? null : providerId,
      };
}
