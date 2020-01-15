class EducationVocation {
  int id;
  int encounterId;
  int gradeId;
  int attendanceId;
  bool isExpelledSuspended;
  String expelledSuspendedDesc;
  bool isLearningDifficulties;
  String learningDifficultiesDesc;
  bool isVocationallyTrained;
  bool isSatisfiedCurrentJob;
  String past5yrJobs;
  bool isJobRelatedProblems;
  String jobRelatedProblemsDesc;
  bool isAbilityEffetced;
  bool isInterestedBenefitsEmployment;
  List<EdunvocHelpneedfor> edunvocHelpneedfor;

  EducationVocation({
    this.id,
    this.encounterId,
    this.gradeId,
    this.attendanceId,
    this.isExpelledSuspended,
    this.expelledSuspendedDesc,
    this.isLearningDifficulties,
    this.learningDifficultiesDesc,
    this.isVocationallyTrained,
    this.isSatisfiedCurrentJob,
    this.past5yrJobs,
    this.isJobRelatedProblems,
    this.jobRelatedProblemsDesc,
    this.isAbilityEffetced,
    this.isInterestedBenefitsEmployment,
    this.edunvocHelpneedfor,
  });

  factory EducationVocation.fromMap(Map<String, dynamic> json) =>
      EducationVocation(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        gradeId: json["gradeId"] == null ? null : json["gradeId"],
        attendanceId:
            json["attendanceId"] == null ? null : json["attendanceId"],
        isExpelledSuspended: json["isExpelledSuspended"] == null
            ? null
            : json["isExpelledSuspended"],
        expelledSuspendedDesc: json["expelledSuspendedDesc"] == null
            ? null
            : json["expelledSuspendedDesc"],
        isLearningDifficulties: json["isLearningDifficulties"] == null
            ? null
            : json["isLearningDifficulties"],
        learningDifficultiesDesc: json["learningDifficultiesDesc"] == null
            ? null
            : json["learningDifficultiesDesc"],
        isVocationallyTrained: json["isVocationallyTrained"] == null
            ? null
            : json["isVocationallyTrained"],
        isSatisfiedCurrentJob: json["isSatisfiedCurrentJob"] == null
            ? null
            : json["isSatisfiedCurrentJob"],
        past5yrJobs: json["past5yrJobs"] == null ? null : json["past5yrJobs"],
        isJobRelatedProblems: json["isJobRelatedProblems"] == null
            ? null
            : json["isJobRelatedProblems"],
        jobRelatedProblemsDesc: json["jobRelatedProblemsDesc"] == null
            ? null
            : json["jobRelatedProblemsDesc"],
        isAbilityEffetced: json["isAbilityEffetced"] == null
            ? null
            : json["isAbilityEffetced"],
        isInterestedBenefitsEmployment:
            json["isInterestedBenefitsEmployment"] == null
                ? null
                : json["isInterestedBenefitsEmployment"],
        edunvocHelpneedfor: json["edunvocHelpneedfor"] == null
            ? []
            : List<EdunvocHelpneedfor>.from(json["edunvocHelpneedfor"]
                .map((x) => EdunvocHelpneedfor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "gradeId": gradeId == null ? null : gradeId,
        "attendanceId": attendanceId == null ? null : attendanceId,
        "isExpelledSuspended":
            isExpelledSuspended == null ? null : isExpelledSuspended,
        "expelledSuspendedDesc":
            expelledSuspendedDesc == null ? null : expelledSuspendedDesc,
        "isLearningDifficulties":
            isLearningDifficulties == null ? null : isLearningDifficulties,
        "learningDifficultiesDesc":
            learningDifficultiesDesc == null ? null : learningDifficultiesDesc,
        "isVocationallyTrained":
            isVocationallyTrained == null ? null : isVocationallyTrained,
        "isSatisfiedCurrentJob":
            isSatisfiedCurrentJob == null ? null : isSatisfiedCurrentJob,
        "past5yrJobs": past5yrJobs == null ? null : past5yrJobs,
        "isJobRelatedProblems":
            isJobRelatedProblems == null ? null : isJobRelatedProblems,
        "jobRelatedProblemsDesc":
            jobRelatedProblemsDesc == null ? null : jobRelatedProblemsDesc,
        "isAbilityEffetced":
            isAbilityEffetced == null ? null : isAbilityEffetced,
        "isInterestedBenefitsEmployment": isInterestedBenefitsEmployment == null
            ? null
            : isInterestedBenefitsEmployment,
        "edunvocHelpneedfor": edunvocHelpneedfor == null
            ? null
            : edunvocHelpneedfor.map((v) => v.toMap()).toList(),
      };
}

class EdunvocHelpneedfor {
  int encounterId;
  int needId;

  EdunvocHelpneedfor({
    this.encounterId,
    this.needId,
  });

  factory EdunvocHelpneedfor.fromMap(Map<String, dynamic> json) =>
      EdunvocHelpneedfor(
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        needId: json["needId"] == null ? null : json["needId"],
      );

  Map<String, dynamic> toMap() => {
        "encounterId": encounterId == null ? null : encounterId,
        "needId": needId == null ? null : needId,
      };
}
