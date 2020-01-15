class SubstanceUseModel {
  int id;
  int encounterId;
  int physicalHealthId;
  int numOfDaysAsleep;
  int numOfDaysDepression;
  int numOfDaysAlcoholIntake;
  int alcoholIntakeFreq;
  int numOfDaysDrugabuse;
  int cravingsid;
  int addictionControlId;
  int numOfDaysDrugEviction;
  int numOfDaysDrugRisk;
  int numOfDaysRecoveryThruSpiritualityId;
  int numOfDaysEngaged;
  bool haveEnoughIncome;
  int numOfDaysBeenBotheredId;
  int numOfDaysSocial;
  int numOfDaysProgressRecoveryId;
  SubstanceUseSelectModel addictionControl;
  SubstanceUseSelectModel cravings;
  SubstanceUseSelectModel numOfDaysBeenBothered;
  SubstanceUseSelectModel numOfDaysProgressRecovery;
  SubstanceUseSelectModel numOfDaysRecoveryThruSpirituality;
  SubstanceUseSelectModel physicalHealth;
  List<SubstanceDrugs> substanceDrugs;

  SubstanceUseModel(
      {this.id,
      this.encounterId,
      this.physicalHealthId,
      this.numOfDaysAsleep,
      this.numOfDaysDepression,
      this.numOfDaysAlcoholIntake,
      this.alcoholIntakeFreq,
      this.numOfDaysDrugabuse,
      this.cravingsid,
      this.addictionControlId,
      this.numOfDaysDrugEviction,
      this.numOfDaysDrugRisk,
      this.numOfDaysRecoveryThruSpiritualityId,
      this.numOfDaysEngaged,
      this.haveEnoughIncome,
      this.numOfDaysBeenBotheredId,
      this.numOfDaysSocial,
      this.numOfDaysProgressRecoveryId,
      this.addictionControl,
      this.cravings,
      this.numOfDaysBeenBothered,
      this.numOfDaysProgressRecovery,
      this.numOfDaysRecoveryThruSpirituality,
      this.physicalHealth,
      this.substanceDrugs});

  SubstanceUseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encounterId = json['encounterId'];
    physicalHealthId = json['physicalHealthId'];
    numOfDaysAsleep = json['numOfDaysAsleep'];
    numOfDaysDepression = json['numOfDaysDepression'];
    numOfDaysAlcoholIntake = json['numOfDaysAlcoholIntake'];
    alcoholIntakeFreq = json['alcoholIntakeFreq'];
    numOfDaysDrugabuse = json['numOfDaysDrugabuse'];
    cravingsid = json['cravingsid'];
    addictionControlId = json['addictionControlId'];
    numOfDaysDrugEviction = json['numOfDaysDrugEviction'];
    numOfDaysDrugRisk = json['numOfDaysDrugRisk'];
    numOfDaysRecoveryThruSpiritualityId =
        json['numOfDaysRecoveryThruSpiritualityId'];
    numOfDaysEngaged = json['numOfDaysEngaged'];
    haveEnoughIncome = json['haveEnoughIncome'];
    numOfDaysBeenBotheredId = json['numOfDaysBeenBotheredId'];
    numOfDaysSocial = json['numOfDaysSocial'];
    numOfDaysProgressRecoveryId = json['numOfDaysProgressRecoveryId'];
    addictionControl = json['addictionControl'] != null
        ? new SubstanceUseSelectModel.fromJson(json['addictionControl'])
        : null;
    cravings = json['cravings'] != null
        ? new SubstanceUseSelectModel.fromJson(json['cravings'])
        : null;
    numOfDaysBeenBothered = json['numOfDaysBeenBothered'] != null
        ? new SubstanceUseSelectModel.fromJson(json['numOfDaysBeenBothered'])
        : null;
    numOfDaysProgressRecovery = json['numOfDaysProgressRecovery'] != null
        ? new SubstanceUseSelectModel.fromJson(
            json['numOfDaysProgressRecovery'])
        : null;
    numOfDaysRecoveryThruSpirituality =
        json['numOfDaysRecoveryThruSpirituality'] != null
            ? new SubstanceUseSelectModel.fromJson(
                json['numOfDaysRecoveryThruSpirituality'])
            : null;
    physicalHealth = json['physicalHealth'] != null
        ? new SubstanceUseSelectModel.fromJson(json['physicalHealth'])
        : null;
    if (json['substanceDrugs'] != null) {
      substanceDrugs = new List<SubstanceDrugs>();
      json['substanceDrugs'].forEach((v) {
        substanceDrugs.add(new SubstanceDrugs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['physicalHealthId'] = this.physicalHealthId;
    data['numOfDaysAsleep'] = this.numOfDaysAsleep;
    data['numOfDaysDepression'] = this.numOfDaysDepression;
    data['numOfDaysAlcoholIntake'] = this.numOfDaysAlcoholIntake;
    data['alcoholIntakeFreq'] = this.alcoholIntakeFreq;
    data['numOfDaysDrugabuse'] = this.numOfDaysDrugabuse;
    data['cravingsid'] = this.cravingsid;
    data['addictionControlId'] = this.addictionControlId;
    data['numOfDaysDrugEviction'] = this.numOfDaysDrugEviction;
    data['numOfDaysDrugRisk'] = this.numOfDaysDrugRisk;
    data['numOfDaysRecoveryThruSpiritualityId'] =
        this.numOfDaysRecoveryThruSpiritualityId;
    data['numOfDaysEngaged'] = this.numOfDaysEngaged;
    data['haveEnoughIncome'] = this.haveEnoughIncome;
    data['numOfDaysBeenBotheredId'] = this.numOfDaysBeenBotheredId;
    data['numOfDaysSocial'] = this.numOfDaysSocial;
    data['numOfDaysProgressRecoveryId'] = this.numOfDaysProgressRecoveryId;
    if (this.addictionControl != null) {
      data['addictionControl'] = this.addictionControl.toJson();
    }
    if (this.cravings != null) {
      data['cravings'] = this.cravings.toJson();
    }
    if (this.numOfDaysBeenBothered != null) {
      data['numOfDaysBeenBothered'] = this.numOfDaysBeenBothered.toJson();
    }
    if (this.numOfDaysProgressRecovery != null) {
      data['numOfDaysProgressRecovery'] =
          this.numOfDaysProgressRecovery.toJson();
    }
    if (this.numOfDaysRecoveryThruSpirituality != null) {
      data['numOfDaysRecoveryThruSpirituality'] =
          this.numOfDaysRecoveryThruSpirituality.toJson();
    }
    if (this.physicalHealth != null) {
      data['physicalHealth'] = this.physicalHealth.toJson();
    }
    if (this.substanceDrugs != null) {
      data['substanceDrugs'] =
          this.substanceDrugs.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encounterId'] = this.encounterId;
    data['physicalHealthId'] = this.physicalHealthId;
    data['numOfDaysAsleep'] = this.numOfDaysAsleep;
    data['numOfDaysDepression'] = this.numOfDaysDepression;
    data['numOfDaysAlcoholIntake'] = this.numOfDaysAlcoholIntake;
    data['alcoholIntakeFreq'] = this.alcoholIntakeFreq;
    data['numOfDaysDrugabuse'] = this.numOfDaysDrugabuse;
    data['cravingsid'] = this.cravingsid;
    data['addictionControlId'] = this.addictionControlId;
    data['numOfDaysDrugEviction'] = this.numOfDaysDrugEviction;
    data['numOfDaysDrugRisk'] = this.numOfDaysDrugRisk;
    data['numOfDaysRecoveryThruSpiritualityId'] =
        this.numOfDaysRecoveryThruSpiritualityId;
    data['numOfDaysEngaged'] = this.numOfDaysEngaged;
    data['haveEnoughIncome'] = this.haveEnoughIncome;
    data['numOfDaysBeenBotheredId'] = this.numOfDaysBeenBotheredId;
    data['numOfDaysSocial'] = this.numOfDaysSocial;
    data['numOfDaysProgressRecoveryId'] = this.numOfDaysProgressRecoveryId;

    if (this.substanceDrugs != null) {
      data['substanceDrugs'] =
          this.substanceDrugs.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encounterId'] = this.encounterId;
    data['physicalHealthId'] = this.physicalHealthId;
    data['numOfDaysAsleep'] = this.numOfDaysAsleep;
    data['numOfDaysDepression'] = this.numOfDaysDepression;
    data['numOfDaysAlcoholIntake'] = this.numOfDaysAlcoholIntake;
    data['alcoholIntakeFreq'] = this.alcoholIntakeFreq;
    data['numOfDaysDrugabuse'] = this.numOfDaysDrugabuse;
    data['cravingsid'] = this.cravingsid;
    data['addictionControlId'] = this.addictionControlId;
    data['numOfDaysDrugEviction'] = this.numOfDaysDrugEviction;
    data['numOfDaysDrugRisk'] = this.numOfDaysDrugRisk;
    data['numOfDaysRecoveryThruSpiritualityId'] =
        this.numOfDaysRecoveryThruSpiritualityId;
    data['numOfDaysEngaged'] = this.numOfDaysEngaged;
    data['haveEnoughIncome'] = this.haveEnoughIncome;
    data['numOfDaysBeenBotheredId'] = this.numOfDaysBeenBotheredId;
    data['numOfDaysSocial'] = this.numOfDaysSocial;
    data['numOfDaysProgressRecoveryId'] = this.numOfDaysProgressRecoveryId;

    if (this.substanceDrugs != null) {
      data['substanceDrugs'] =
          this.substanceDrugs.map((v) => v.toUpdateJson()).toList();
    }
    return data;
  }
}

class SubstanceUseSelectModel {
  int id;
  String name;

  SubstanceUseSelectModel({this.id, this.name});

  SubstanceUseSelectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubstanceDrugs {
  int id;
  int subId;
  int addictedId;
  int numOfDays;
  String modifiedBy;
  String modifiedDate;
  SubstanceUseSelectModel addicted;

  SubstanceDrugs(
      {this.id,
      this.subId,
      this.addictedId,
      this.numOfDays,
      this.modifiedBy,
      this.modifiedDate,
      this.addicted});

  SubstanceDrugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['subId'];
    addictedId = json['addictedId'];
    numOfDays = json['numOfDays'];
    modifiedBy = json['modifiedBy'];
    modifiedDate = json['modifiedDate'];
    addicted = json['addicted'] != null
        ? new SubstanceUseSelectModel.fromJson(json['addicted'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subId'] = this.subId;
    data['addictedId'] = this.addictedId;
    data['numOfDays'] = this.numOfDays;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    if (this.addicted != null) {
      data['addicted'] = this.addicted.toJson();
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addictedId'] = this.addictedId;
    data['numOfDays'] = this.numOfDays;
    return data;
  }
}
