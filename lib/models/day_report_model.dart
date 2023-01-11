class DayReportModel {
  DateTime day;
  int orders;
  double revenue;
  int localId;

  DayReportModel({
    required this.day,
    required this.revenue,
    required this.orders,
    required this.localId,
  });

  factory DayReportModel.fromMap(Map<String, dynamic> json) => DayReportModel(
        day: DateTime.parse(json["day"]),
        orders: json["orders"],
        revenue: json["revenue"] ?? 0,
        localId: json["local_id"],
      );
}
