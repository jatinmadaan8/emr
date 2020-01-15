class CulturalReligiousBackground {
  int id;
  int encounterId;
  bool isFluentInOtherLang;
  String langDesc;
  bool isMemberOfReligiouCulture;
  String religiouCultureDesc;
  String holidaysTraditionsObserve;
  String whoWhatStrengthHope;
  bool isSatisfiedSpiritually;
  bool isCopeEverydayStressors;
  int outlookId;
  String otherOutlook;

  CulturalReligiousBackground({
    this.id,
    this.encounterId,
    this.isFluentInOtherLang,
    this.langDesc,
    this.isMemberOfReligiouCulture,
    this.religiouCultureDesc,
    this.holidaysTraditionsObserve,
    this.whoWhatStrengthHope,
    this.isSatisfiedSpiritually,
    this.isCopeEverydayStressors,
    this.outlookId,
    this.otherOutlook,
  });

  factory CulturalReligiousBackground.fromMap(Map<String, dynamic> json) =>
      CulturalReligiousBackground(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        isFluentInOtherLang: json["isFluentInOtherLang"] == null
            ? null
            : json["isFluentInOtherLang"],
        langDesc: json["langDesc"] == null ? null : json["langDesc"],
        isMemberOfReligiouCulture: json["isMemberOfReligiouCulture"] == null
            ? null
            : json["isMemberOfReligiouCulture"],
        religiouCultureDesc: json["religiouCultureDesc"] == null
            ? null
            : json["religiouCultureDesc"],
        holidaysTraditionsObserve: json["holidaysTraditionsObserve"] == null
            ? null
            : json["holidaysTraditionsObserve"],
        whoWhatStrengthHope: json["whoWhatStrengthHope"] == null
            ? null
            : json["whoWhatStrengthHope"],
        isSatisfiedSpiritually: json["isSatisfiedSpiritually"] == null
            ? null
            : json["isSatisfiedSpiritually"],
        isCopeEverydayStressors: json["isCopeEverydayStressors"] == null
            ? null
            : json["isCopeEverydayStressors"],
        outlookId: json["outlookId"] == null ? null : json["outlookId"],
        otherOutlook:
            json["otherOutlook"] == null ? null : json["otherOutlook"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "isFluentInOtherLang":
            isFluentInOtherLang == null ? null : isFluentInOtherLang,
        "langDesc": langDesc == null ? null : langDesc,
        "religiouCultureDesc":
            religiouCultureDesc == null ? null : religiouCultureDesc,
        "isMemberOfReligiouCulture": isMemberOfReligiouCulture == null
            ? null
            : isMemberOfReligiouCulture,
        "holidaysTraditionsObserve": holidaysTraditionsObserve == null
            ? null
            : holidaysTraditionsObserve,
        "whoWhatStrengthHope":
            whoWhatStrengthHope == null ? null : whoWhatStrengthHope,
        "isSatisfiedSpiritually":
            isSatisfiedSpiritually == null ? null : isSatisfiedSpiritually,
        "isCopeEverydayStressors":
            isCopeEverydayStressors == null ? null : isCopeEverydayStressors,
        "outlookId": outlookId == null ? null : outlookId,
        "otherOutlook": otherOutlook == null ? null : otherOutlook,
      };
}

class Language {
  String value;

  Language({
    this.value,
  });
  factory Language.fromMap(Map<String, dynamic> json) =>
      Language(value: json["value"] == null ? null : json["value"]);
}
