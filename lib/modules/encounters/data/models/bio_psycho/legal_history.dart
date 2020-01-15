import 'package:flutter/cupertino.dart';

class LegalHistory {
  int id;
  int encounterId;
  bool haveCriminalCharges;
  bool haveAttorney;
  String attorneyName;
  String attorneyPhone;
  bool haveProbationOfficer;
  String probationOfficerName;
  bool haveYouBeenJuvenile;
  bool isJuvenileAbuse;
  bool haveYouBeenChildService;
  bool haveDependentChild;
  String nameCsCaseworker;
  bool haveCourtOrderChild;
  int childSupportAmt;
  List<CriminalCharges> criminalCharges;
  List<LegalProceeding> legalProceeding;

  LegalHistory({
    this.id,
    this.encounterId,
    this.haveCriminalCharges,
    this.haveAttorney,
    this.attorneyName,
    this.attorneyPhone,
    this.haveProbationOfficer,
    this.probationOfficerName,
    this.haveYouBeenJuvenile,
    this.isJuvenileAbuse,
    this.haveYouBeenChildService,
    this.haveDependentChild,
    this.nameCsCaseworker,
    this.haveCourtOrderChild,
    this.childSupportAmt,
    this.criminalCharges,
    this.legalProceeding,
  });

  factory LegalHistory.fromMap(Map<String, dynamic> json) => LegalHistory(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        haveCriminalCharges: json["haveCriminalCharges"] == null
            ? null
            : json["haveCriminalCharges"],
        haveAttorney:
            json["haveAttorney"] == null ? null : json["haveAttorney"],
        attorneyName:
            json["attorneyName"] == null ? null : json["attorneyName"],
        attorneyPhone:
            json["attorneyPhone"] == null ? null : json["attorneyPhone"],
        haveProbationOfficer: json["haveProbationOfficer"] == null
            ? null
            : json["haveProbationOfficer"],
        probationOfficerName: json["probationOfficerName"] == null
            ? null
            : json["probationOfficerName"],
        haveYouBeenJuvenile: json["haveYouBeenJuvenile"] == null
            ? null
            : json["haveYouBeenJuvenile"],
        isJuvenileAbuse:
            json["isJuvenileAbuse"] == null ? null : json["isJuvenileAbuse"],
        haveYouBeenChildService: json["haveYouBeenChildService"] == null
            ? null
            : json["haveYouBeenChildService"],
        haveDependentChild: json["haveDependentChild"] == null
            ? null
            : json["haveDependentChild"],
        nameCsCaseworker:
            json["nameCsCaseworker"] == null ? null : json["nameCsCaseworker"],
        haveCourtOrderChild: json["haveCourtOrderChild"] == null
            ? null
            : json["haveCourtOrderChild"],
        childSupportAmt:
            json["childSupportAmt"] == null ? null : json["childSupportAmt"],
        criminalCharges: json["criminalCharges"] == null
            ? []
            : List<CriminalCharges>.from(
                json["criminalCharges"].map((x) => CriminalCharges.fromMap(x))),
        legalProceeding: json["legalProceeding"] == null
            ? []
            : List<LegalProceeding>.from(
                json["legalProceeding"].map((x) => LegalProceeding.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "haveCriminalCharges":
            haveCriminalCharges == null ? null : haveCriminalCharges,
        "haveAttorney": haveAttorney == null ? null : haveAttorney,
        "attorneyName": attorneyName == null ? null : attorneyName,
        "attorneyPhone": attorneyPhone == null ? null : attorneyPhone,
        "haveYouBeenJuvenile":
            haveYouBeenJuvenile == null ? null : haveYouBeenJuvenile,
        "isJuvenileAbuse": isJuvenileAbuse == null ? null : isJuvenileAbuse,
        "haveYouBeenChildService":
            haveYouBeenChildService == null ? null : haveYouBeenChildService,
        "haveDependentChild":
            haveDependentChild == null ? null : haveDependentChild,
        "nameCsCaseworker": nameCsCaseworker == null ? null : nameCsCaseworker,
        "haveCourtOrderChild":
            haveCourtOrderChild == null ? null : haveCourtOrderChild,
        "childSupportAmt": childSupportAmt == null ? null : childSupportAmt,
        "criminalCharges": criminalCharges == null
            ? null
            : criminalCharges.map((v) => v.toMap()).toList(),
        "legalProceeding": legalProceeding == null
            ? null
            : legalProceeding.map((v) => v.toMap()).toList(),
      };
}

class CriminalCharges {
  int id;
  String charge;
  DateTime date;
  int statusId;

  CriminalCharges({
    this.id,
    this.charge,
    this.date,
    this.statusId,
  });

  factory CriminalCharges.fromMap(Map<String, dynamic> json) => CriminalCharges(
        id: json["id"] == null ? null : json["id"],
        charge: json["charge"] == null ? null : json["charge"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        statusId: json["statusId"] == null ? null : json["statusId"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "charge": charge == null ? null : charge,
        "date": date == null ? null : this.date.toUtc().toString(),
        "statusId": statusId == null ? null : statusId
      };
}

class LegalProceeding {
  int proceedingId;

  LegalProceeding({
    this.proceedingId,
  });

  factory LegalProceeding.fromMap(Map<String, dynamic> json) => LegalProceeding(
      proceedingId: json["proceedingId"] == null ? null : json["proceedingId"]);

  Map<String, dynamic> toMap() => {
        "proceedingId": proceedingId == null ? null : proceedingId,
      };
}
