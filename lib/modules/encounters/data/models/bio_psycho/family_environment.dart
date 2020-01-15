class FamilyEnvironment {
  int id;
  int encounterId;
  int movedInLifetimeId;
  String movedInLifetimeDesc;
  bool hadComplicationsPregnancy;
  String complicationsPregnancyDesc;
  bool isHaveSiblings;
  int numOfBrothers;
  int numOfSisters;
  int numOfHalfSiblings;
  int numOfStepSiblings;
  int relWithSiblingsId;
  String relWithSiblingsOther;
  int childhoodLifeId;
  int disciplineId;
  bool isHaveChildren;
  int numOfChildren;
  bool haveChildCustody;
  bool seekingReunification;
  bool havePets;
  String petsKind;
  bool haveConcernsStabilityLiving;
  String haveConcernsStabilityLivingDesc;
  bool haveDomesticStress;
  String haveDomesticStressDesc;

  FamilyEnvironment({
    this.id,
    this.encounterId,
    this.movedInLifetimeId,
    this.movedInLifetimeDesc,
    this.hadComplicationsPregnancy,
    this.complicationsPregnancyDesc,
    this.isHaveSiblings,
    this.numOfBrothers,
    this.numOfSisters,
    this.numOfHalfSiblings,
    this.numOfStepSiblings,
    this.relWithSiblingsId,
    this.relWithSiblingsOther,
    this.childhoodLifeId,
    this.disciplineId,
    this.isHaveChildren,
    this.numOfChildren,
    this.haveChildCustody,
    this.seekingReunification,
    this.havePets,
    this.petsKind,
    this.haveConcernsStabilityLiving,
    this.haveConcernsStabilityLivingDesc,
    this.haveDomesticStress,
    this.haveDomesticStressDesc,
  });

  factory FamilyEnvironment.fromMap(Map<String, dynamic> json) =>
      FamilyEnvironment(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        movedInLifetimeId: json["movedInLifetimeId"] == null
            ? null
            : json["movedInLifetimeId"],
        movedInLifetimeDesc: json["movedInLifetimeDesc"] == null
            ? null
            : json["movedInLifetimeDesc"],
        hadComplicationsPregnancy: json["hadComplicationsPregnancy"] == null
            ? null
            : json["hadComplicationsPregnancy"],
        complicationsPregnancyDesc: json["complicationsPregnancyDesc"] == null
            ? null
            : json["complicationsPregnancyDesc"],
        isHaveSiblings:
            json["isHaveSiblings"] == null ? null : json["isHaveSiblings"],
        numOfBrothers:
            json["numOfBrothers"] == null ? null : json["numOfBrothers"],
        numOfSisters:
            json["numOfSisters"] == null ? null : json["numOfSisters"],
        numOfHalfSiblings: json["numOfHalfSiblings"] == null
            ? null
            : json["numOfHalfSiblings"],
        numOfStepSiblings: json["numOfStepSiblings"] == null
            ? null
            : json["numOfStepSiblings"],
        relWithSiblingsId: json["relWithSiblingsId"] == null
            ? null
            : json["relWithSiblingsId"],
        relWithSiblingsOther: json["relWithSiblingsOther"] == null
            ? null
            : json["relWithSiblingsOther"],
        childhoodLifeId:
            json["childhoodLifeId"] == null ? null : json["childhoodLifeId"],
        disciplineId:
            json["disciplineId"] == null ? null : json["disciplineId"],
        isHaveChildren:
            json["isHaveChildren"] == null ? null : json["isHaveChildren"],
        numOfChildren:
            json["numOfChildren"] == null ? null : json["numOfChildren"],
        haveChildCustody:
            json["haveChildCustody"] == null ? null : json["haveChildCustody"],
        seekingReunification: json["seekingReunification"] == null
            ? null
            : json["seekingReunification"],
        havePets: json["havePets"] == null ? null : json["havePets"],
        petsKind: json["petsKind"] == null ? null : json["petsKind"],
        haveConcernsStabilityLiving: json["haveConcernsStabilityLiving"] == null
            ? null
            : json["haveConcernsStabilityLiving"],
        haveConcernsStabilityLivingDesc:
            json["haveConcernsStabilityLivingDesc"] == null
                ? null
                : json["haveConcernsStabilityLivingDesc"],
        haveDomesticStress: json["haveDomesticStress"] == null
            ? null
            : json["haveDomesticStress"],
        haveDomesticStressDesc: json["haveDomesticStressDesc"] == null
            ? null
            : json["haveDomesticStressDesc"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "movedInLifetimeId":
            movedInLifetimeId == null ? null : movedInLifetimeId,
        "movedInLifetimeDesc":
            movedInLifetimeDesc == null ? null : movedInLifetimeDesc,
        "hadComplicationsPregnancy": hadComplicationsPregnancy == null
            ? null
            : hadComplicationsPregnancy,
        "complicationsPregnancyDesc": complicationsPregnancyDesc == null
            ? null
            : complicationsPregnancyDesc,
        "isHaveSiblings": isHaveSiblings == null ? null : isHaveSiblings,
        "numOfBrothers": numOfBrothers == null ? null : numOfBrothers,
        "numOfSisters": numOfSisters == null ? null : numOfSisters,
        "numOfHalfSiblings":
            numOfHalfSiblings == null ? null : numOfHalfSiblings,
        "numOfStepSiblings":
            numOfStepSiblings == null ? null : numOfStepSiblings,
        "relWithSiblingsId":
            relWithSiblingsId == null ? null : relWithSiblingsId,
        "relWithSiblingsOther":
            relWithSiblingsOther == null ? null : relWithSiblingsOther,
        "childhoodLifeId": childhoodLifeId == null ? null : childhoodLifeId,
        "disciplineId": disciplineId == null ? null : disciplineId,
        "isHaveChildren": isHaveChildren == null ? null : isHaveChildren,
        "numOfChildren": numOfChildren == null ? null : numOfChildren,
        "haveChildCustody": haveChildCustody == null ? null : haveChildCustody,
        "seekingReunification":
            seekingReunification == null ? null : seekingReunification,
        "havePets": havePets == null ? null : havePets,
        "petsKind": petsKind == null ? null : petsKind,
        "haveConcernsStabilityLiving": haveConcernsStabilityLiving == null
            ? null
            : haveConcernsStabilityLiving,
        "haveConcernsStabilityLivingDesc":
            haveConcernsStabilityLivingDesc == null
                ? null
                : haveConcernsStabilityLivingDesc,
        "haveDomesticStress":
            haveDomesticStress == null ? null : haveDomesticStress,
        "haveDomesticStressDesc":
            haveDomesticStressDesc == null ? null : haveDomesticStressDesc,
      };
}
