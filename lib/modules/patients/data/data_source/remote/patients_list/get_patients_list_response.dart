// To parse this JSON data, do
//
//     final getPatientsListResponse = getPatientsListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';

GetPatientsListResponse getPatientsListResponseFromJson(String str) => GetPatientsListResponse.fromMap(json.decode(str));

String getPatientsListResponseToJson(GetPatientsListResponse data) => json.encode(data.toMap());

class GetPatientsListResponse {
  int count;
  List<Patient> items;

  GetPatientsListResponse({
    @required this.count,
    @required this.items,
  });

  GetPatientsListResponse copyWith({
    int count,
    List<Patient> items,
  }) =>
      GetPatientsListResponse(
        count: count ?? this.count,
        items: items ?? this.items,
      );

  factory GetPatientsListResponse.fromMap(Map<String, dynamic> json) => GetPatientsListResponse(
    count: json["count"] == null ? null : json["count"],
    items: json["items"] == null ? null : List<Patient>.from(json["items"].map((x) => Patient.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count == null ? null : count,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
  };
}


