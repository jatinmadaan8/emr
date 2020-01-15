// To parse this JSON data, do
//
//     final getPatientsListRequest = getPatientsListRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPatientsListRequest getPatientsListRequestFromJson(String str) =>
    GetPatientsListRequest.fromMap(json.decode(str));

String getPatientsListRequestToJson(GetPatientsListRequest data) =>
    json.encode(data.toMap());

class GetPatientsListRequest {
  int page;
  int pageSize;
  String sortBy;
  bool sortOrderAsc;
  bool showMyPateints;
  Filter filter;

  GetPatientsListRequest({
    @required this.page,
    @required this.pageSize,
    @required this.sortBy,
    @required this.sortOrderAsc,
    @required this.showMyPateints,
    @required this.filter,
  });

  GetPatientsListRequest copyWith({
    int page,
    int pageSize,
    String sortBy,
    bool sortOrderAsc,
    bool showMyPateints,
    Filter filter,
  }) =>
      GetPatientsListRequest(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        sortBy: sortBy ?? this.sortBy,
        sortOrderAsc: sortOrderAsc ?? this.sortOrderAsc,
        showMyPateints: showMyPateints ?? this.showMyPateints,
        filter: filter ?? this.filter,
      );

  factory GetPatientsListRequest.fromMap(Map<String, dynamic> json) =>
      GetPatientsListRequest(
        page: json["page"] == null ? null : json["page"],
        pageSize: json["pageSize"] == null ? null : json["pageSize"],
        sortBy: json["sortBy"] == null ? null : json["sortBy"],
        sortOrderAsc:
            json["sortOrderAsc"] == null ? null : json["sortOrderAsc"],
        showMyPateints:
            json["showMyPateints"] == null ? null : json["showMyPateints"],
        filter: json["filter"] == null ? null : Filter.fromMap(json["filter"]),
      );

  Map<String, dynamic> toMap() => {
        "page": page == null ? null : page,
        "pageSize": pageSize == null ? null : pageSize,
        "sortBy": sortBy == null ? null : sortBy,
        "sortOrderAsc": sortOrderAsc == null ? null : sortOrderAsc,
        "showMyPateints": showMyPateints == null ? null : showMyPateints,
        "filter": filter == null ? null : filter.toMap(),
      };
}

class Filter {
  String any;

  Filter({
    @required this.any,
  });

  Filter copyWith({
    String any,
  }) =>
      Filter(
        any: any ?? this.any,
      );

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        any: json["any"] == null ? null : json["any"],
      );

  Map<String, dynamic> toMap() => {
        "any": any == null ? null : any,
      };
}
