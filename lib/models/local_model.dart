import 'dart:convert';

class LocalModel {
  final int id;
  final DateTime? createdAt;
  final String name;
  final String stateAttention;
  final String image;
  final String officeHours;

  LocalModel(
      {required this.id,
      this.createdAt,
      required this.name,
      required this.stateAttention,
      required this.image,
      required this.officeHours});

  factory LocalModel.fromJson(String str) =>
      LocalModel.fromMap(json.decode(str));

  factory LocalModel.fromMap(Map<String, dynamic> json) => LocalModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        stateAttention: json["state_attention"],
        image: json["image"],
        officeHours: json["office_hours"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "name": name,
        "state_attention": stateAttention,
        "image": image,
        "office_hours": officeHours,
      };
}
