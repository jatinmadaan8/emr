class SoaNote {
  int id;
  int encounterId;
  String subjective;
  String objective;
  String assessment;
  String notesForPlanning;

  SoaNote({
    this.id,
    this.encounterId,
    this.subjective,
    this.objective,
    this.assessment,
    this.notesForPlanning,
  });

  factory SoaNote.fromMap(Map<String, dynamic> json) => SoaNote(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        subjective: json["subjective"] == null ? null : json["subjective"],
        objective: json["objective"] == null ? null : json["objective"],
        assessment: json["assessment"] == null ? null : json["assessment"],
        notesForPlanning:
            json["notesForPlanning"] == null ? null : json["notesForPlanning"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "subjective": subjective == null ? null : subjective,
        "objective": objective == null ? null : objective,
        "assessment": assessment == null ? null : assessment,
        "notesForPlanning": notesForPlanning == null ? null : notesForPlanning,
      };
}
