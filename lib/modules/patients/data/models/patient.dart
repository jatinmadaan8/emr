import 'package:meta/meta.dart';

class Patient {
  int id;
  String billingId;
  String dob;
  String email;
  String phone;
  int genderId;
  String ssn;
  String fullName;
  int billType;
  Gender gender;

  Patient({
    @required this.id,
    @required this.billingId,
    @required this.dob,
    @required this.email,
    @required this.phone,
    @required this.genderId,
    @required this.ssn,
    @required this.fullName,
    @required this.billType,
    @required this.gender,
  });

  Patient copyWith({
    int id,
    String billingId,
    String dob,
    String email,
    String phone,
    int genderId,
    String ssn,
    String fullName,
    int billType,
    Gender gender,
  }) =>
      Patient(
        id: id ?? this.id,
        billingId: billingId ?? this.billingId,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        genderId: genderId ?? this.genderId,
        ssn: ssn ?? this.ssn,
        fullName: fullName ?? this.fullName,
        billType: billType ?? this.billType,
        gender: gender ?? this.gender,
      );

  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
        id: json["id"] == null ? null : json["id"],
        billingId: json["billingId"] == null ? null : json["billingId"],
        dob: json["dob"] == null ? null : json["dob"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        genderId: json["genderId"] == null ? null : json["genderId"],
        ssn: json["ssn"] == null ? null : json["ssn"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        billType: json["billType"] == null ? null : json["billType"],
        gender: json["gender"] == null ? null : Gender.fromMap(json["gender"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "billingId": billingId == null ? null : billingId,
        "dob": dob == null ? null : dob,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "genderId": genderId == null ? null : genderId,
        "ssn": ssn == null ? null : ssn,
        "fullName": fullName == null ? null : fullName,
        "billType": billType == null ? null : billType,
        "gender": gender == null ? null : gender.toMap(),
      };
}

class Gender {
  int id;
  String name;
  String code;

  Gender({
    @required this.id,
    @required this.name,
    @required this.code,
  });

  Gender copyWith({
    int id,
    String name,
    String code,
  }) =>
      Gender(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory Gender.fromMap(Map<String, dynamic> json) => Gender(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
      };
}
