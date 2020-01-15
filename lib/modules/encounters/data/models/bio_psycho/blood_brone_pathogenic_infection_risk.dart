class BloodBronePathogenicInfectionRisk {
  int id;
  int encounterId;
  bool isStdVulnerable;

  BloodBronePathogenicInfectionRisk({
    this.id,
    this.encounterId,
    this.isStdVulnerable,
  });

  factory BloodBronePathogenicInfectionRisk.fromMap(
          Map<String, dynamic> json) =>
      BloodBronePathogenicInfectionRisk(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        isStdVulnerable:
            json["isStdVulnerable"] == null ? null : json["isStdVulnerable"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "isStdVulnerable": isStdVulnerable == null ? null : isStdVulnerable,
      };
}
