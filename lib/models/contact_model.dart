class ContactModel {
  ContactModel({
    required this.id,
    required this.createdAt,
    required this.contactId,
    required this.url,
    required this.localId,
  });

  int id;
  DateTime createdAt;
  int contactId;
  String url;
  int localId;

  static List<String> names = ['whatsapp', 'facebook', 'instagram', 'tiktok'];

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        contactId: json["contact_id"],
        url: json["url"],
        localId: json["local_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "contact_id": contactId,
        "url": url,
        "local_id": localId,
      };

  String get contactName {
    return ContactModel.names[contactId];
  }
}
