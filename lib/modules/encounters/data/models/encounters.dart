import 'package:flutter/material.dart';

class Encounters {
  int id;
  String sectionName;

  Encounters({
    @required this.id,
    @required this.sectionName,
  });

  Encounters copyWith({
    int id,
    String sectionName,
  }) =>
      Encounters(
        id: id ?? this.id,
        sectionName: sectionName ?? this.sectionName,
      );

  factory Encounters.fromMap(Map<String, dynamic> json) => Encounters(
        id: json["id"] == null ? null : json["id"],
        sectionName: json["sectionName"] == null ? null : json["sectionName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "sectionName": sectionName == null ? null : sectionName
      };
}
