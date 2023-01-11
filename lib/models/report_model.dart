import 'package:horno/models/day_report_model.dart';
import 'package:horno/models/local_report_model.dart';

class ReportModel {
  LocalReportModel local;
  List<DayReportModel> days;

  ReportModel({
    required this.local,
    required this.days,
  });
}
