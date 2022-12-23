import 'dart:convert';
import 'package:horno/models/index.dart';

class LocalModel {
  LocalModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.stateAttention,
    required this.image,
    required this.officeHours,
    required this.address,
    required this.city,
    required this.rating,
    required this.services,
    required this.contacts,
    required this.banner,
  });

  int id;
  DateTime createdAt;
  String name;
  String stateAttention;
  String image;
  String banner;
  String officeHours;
  String address;
  String city;
  double rating;
  List<ServiceModel> services;
  List<ContactModel> contacts;

  factory LocalModel.fromJson(String str) =>
      LocalModel.fromMap(json.decode(str));

  factory LocalModel.fromMap(Map<String, dynamic> json) => LocalModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        stateAttention: json["state_attention"],
        image: json["image"],
        banner: json["banner"],
        officeHours: json["office_hours"],
        address: json["address"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        services: List<ServiceModel>.from(
            json["services"].map((x) => ServiceModel.fromJson(x))),
        contacts: List<ContactModel>.from(
            json["contacts"].map((x) => ContactModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "state_attention": stateAttention,
        "image": image,
        "banner": banner,
        "office_hours": officeHours,
        "address": address,
        "city": city,
        "rating": rating,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
      };
}
