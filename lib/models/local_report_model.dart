class LocalReportModel {
  int id;
  int clients;
  int orders;
  double revenue;

  LocalReportModel(
      {required this.id,
      required this.clients,
      required this.orders,
      required this.revenue});

  factory LocalReportModel.fromMap(Map<String, dynamic> json) =>
      LocalReportModel(
        id: json["id"],
        clients: json["clients"],
        orders: json["orders"],
        revenue: json["revenue"] ?? 0,
      );

  String get revenueText => "S/. ${revenue.toStringAsFixed(2)}";
}
