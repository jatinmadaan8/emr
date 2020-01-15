class StandardsAndScales {
  int id;
  String formName;
  int formId;

  StandardsAndScales({
    this.id,
    this.formName,
    this.formId,
  });

  factory StandardsAndScales.fromMap(Map<String, dynamic> json) =>
      StandardsAndScales(
        id: json["id"] == null ? null : json["id"],
        formName: json["formName"] == null ? null : json["formName"],
        formId: json["formId"] == null ? null : json["formId"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "formName": formName == null ? null : formName,
        "formId": formId == null ? null : formId,
      };
}

class StandardsAndScalesForm {
  int id;
  int encounterId;
  int screenerId;
  bool isEditable;
  String formName;
  String date;
  String lastName;
  String firstName;

  StandardsAndScalesForm({
    this.id,
    this.encounterId,
    this.screenerId,
    this.isEditable,
    this.formName,
    this.date,
    this.lastName,
    this.firstName,
  });

  factory StandardsAndScalesForm.fromMap(Map<String, dynamic> json) =>
      StandardsAndScalesForm(
        id: json["id"] == null ? null : json["id"],
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        screenerId: json["screenerId"] == null ? null : json["screenerId"],
        isEditable: json["isEditable"] == null ? null : json["isEditable"],
        formName: json["formName"] == null ? null : json["formName"],
        date: json["date"] == null ? null : json["date"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        firstName: json["firstName"] == null ? null : json["firstName"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "id": id == null ? null : id,
        "encounterId": encounterId == null ? null : encounterId,
        "screenerId": screenerId == null ? null : screenerId,
        "isEditable": isEditable == null ? null : isEditable,
        "formName": formName == null ? null : formName,
        "date": date == null ? null : date,
        "lastName": lastName == null ? null : lastName,
        "firstName": firstName == null ? null : firstName,
      };
}

class AddStandardsAndScale {
  int encounterId;
  int screenerId;

  AddStandardsAndScale({
    this.encounterId,
    this.screenerId,
  });

  factory AddStandardsAndScale.fromMap(Map<String, dynamic> json) =>
      AddStandardsAndScale(
        encounterId: json["encounterId"] == null ? null : json["encounterId"],
        screenerId: json["screenerId"] == null ? null : json["screenerId"],
      );

  Map<String, dynamic> toMap() => {
        "encounterId": encounterId == null ? null : encounterId,
        "screenerId": screenerId == null ? null : screenerId,
      };
}
