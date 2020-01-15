class GenricDropDown {
  int id;
  String name;
  String desc;
  GenricDropDown({
    this.id,
    this.name,
    this.desc,
  });

  GenricDropDown copyWith({
    int id,
    String name,
    String desc,
  }) =>
      GenricDropDown(
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.name,
      );

  factory GenricDropDown.fromMap(Map<String, dynamic> json) => GenricDropDown(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        desc: json["desc"] == null ? null : json["desc"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "desc": desc == null ? null : desc,
      };
}
