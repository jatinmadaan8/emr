import 'package:flutter/material.dart';

class ProblemChecklist {
  int id;
  int encounterId;
  bool havePainConcerns;
  bool haveCurrentHealthIssues;
  List<ProblemsPsychoStress> problemsPsychoStress;

  ProblemChecklist({
    @required this.id,
    @required this.encounterId,
    @required this.havePainConcerns,
    @required this.haveCurrentHealthIssues,
    @required this.problemsPsychoStress,
  });

  ProblemChecklist copyWith({
    int id,
    String encounterId,
    String code,
  }) =>
      ProblemChecklist(
        id: id ?? this.id,
        encounterId: encounterId ?? this.encounterId,
        havePainConcerns: havePainConcerns ?? this.havePainConcerns,
        haveCurrentHealthIssues:
            haveCurrentHealthIssues ?? this.haveCurrentHealthIssues,
        problemsPsychoStress: problemsPsychoStress ?? this.problemsPsychoStress,
      );

  factory ProblemChecklist.fromMap(Map<String, dynamic> json) =>
      ProblemChecklist(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        havePainConcerns:
            json["havePainConcerns"] == null ? null : json["havePainConcerns"],
        haveCurrentHealthIssues: json["haveCurrentHealthIssues"] == null
            ? null
            : json["haveCurrentHealthIssues"],
        problemsPsychoStress: json["problemsPsychoStress"] == null
            ? []
            : List<ProblemsPsychoStress>.from(json["problemsPsychoStress"]
                .map((x) => ProblemsPsychoStress.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "havePainConcerns": havePainConcerns == null ? null : havePainConcerns,
        "haveCurrentHealthIssues":
            haveCurrentHealthIssues == null ? null : haveCurrentHealthIssues,
        "problemsPsychoStress":
            problemsPsychoStress == null || problemsPsychoStress == [] ? [] : 
            (problemsPsychoStress.map((f) => f.toMap())).toList(),
      };
}

class ProblemsPsychoStress {
  int id;
  int pcId;
  int psychoStressId;
  String psychoStressDesc;
  Psychostress psychostress;

  ProblemsPsychoStress({
    this.id,
    this.pcId,
    @required this.psychoStressId,
    @required this.psychoStressDesc,
    this.psychostress,
  });

  ProblemsPsychoStress copyWith({
    int id,
    int pcId,
    int psychoStressId,
    String psychoStressDesc,
    Psychostress psychostress,
  }) =>
      ProblemsPsychoStress(
        id: id ?? this.id,
        pcId: pcId ?? this.pcId,
        psychoStressId: psychoStressId ?? this.psychoStressId,
        psychoStressDesc: psychoStressDesc ?? this.psychoStressDesc,
        psychostress: psychostress ?? this.psychostress,
      );

  factory ProblemsPsychoStress.fromMap(Map<String, dynamic> json) =>
      ProblemsPsychoStress(
        id: json["id"] == null ? null : json["id"],
        pcId: json["pcId"] == null ? null : json["pcId"],
        psychoStressId:
            json["psychoStressId"] == null ? null : json["psychoStressId"],
        psychoStressDesc:
            json["psychoStressDesc"] == null ? null : json["psychoStressDesc"],
        psychostress: json["psychostress"] == null
            ? []
            : Psychostress.fromMap(json["psychostress"]),
      );

  Map<String, dynamic> toMap() => {
        
        "psychoStressId": psychoStressId == null ? null : psychoStressId,
        "psychoStressDesc": psychoStressDesc == null ? null : psychoStressDesc,
      };
}

class Psychostress {
  int id;
  String name;

  Psychostress({
    @required this.id,
    @required this.name,
  });

  Psychostress copyWith({
    int id,
    String name,
  }) =>
      Psychostress(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Psychostress.fromMap(Map<String, dynamic> json) => Psychostress(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class PsychostressDisplay {
  int id;
  String name;
  bool reported;
  String description;

  PsychostressDisplay({
    this.id,
    this.name,
    this.reported,
    this.description,
  });
}