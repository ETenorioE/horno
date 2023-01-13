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
        stateAttention: json["state_attention"] ?? '',
        image: json["image"],
        banner: json["banner"],
        officeHours: json["office_hours"],
        address: json["address"],
        city: json["city"] ?? '',
        rating: json["rating"] == null ? 0 : json["rating"].toDouble(),
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

  String get stateAttentionText {
    try {
      final now = DateTime.now();

      final hourStarIndex = officeHours.indexOf(':');
      final hourStar = officeHours.substring(0, hourStarIndex + 3).trim();

      final hourEndIndex = officeHours.indexOf(':', hourStarIndex + 1);
      final hourEnd =
          officeHours.substring(hourEndIndex - 2, hourEndIndex + 3).trim();

      bool isGreater = isGreaterThenAttention(hourStar, now);
      bool isLess = isLessThenAttention(hourEnd, now);

      return isGreater == isLess ? 'Abierto' : 'Cerrado';
    } catch (_) {
      return '';
    }
  }

  bool isGreaterThenAttention(String time, DateTime now) {
    List<String> values = time.split(':');
    final hour = int.parse(values[0]);
    final minute = int.parse(values[1]);

    DateTime date = DateTime(now.year, now.month, now.day, hour, minute);

    return now.compareTo(date) > 0;
  }

  bool isLessThenAttention(String time, DateTime now) {
    List<String> values = time.split(':');
    int hour = int.parse(values[0]);
    final minute = int.parse(values[1]);

    if (hour < 12) {
      hour += 12;
    }

    DateTime date = DateTime(now.year, now.month, now.day, hour, minute);

    return now.compareTo(date) < 0;
  }
}
