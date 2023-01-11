// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:horno/models/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/provider/base_provider.dart';

class ReportProvider extends BaseProvider {
  LocalReportModel? local;
  LocalReportModel? prevLocal;
  List<DayReportModel> days = [];
  DateTime _time = DateTime.now();

  ReportProvider() {
    findReportByLocalId();
  }

  Future findReportByLocalId({bool? activePrev = false}) async {
    isLoading = true;

    await _findReportLocal(activePrev);

    final starWeek =
        _getDate(_time.subtract(Duration(days: _time.weekday - 1)));
    final endWeek = _getDate(
        _time.add(Duration(days: DateTime.daysPerWeek - _time.weekday)));

    final List<dynamic> res = await supabase
        .from('report_days_local_view')
        .select()
        .eq('local_id', Preferences.localId)
        .lte('day', endWeek.toString())
        .gte('day', starWeek.toString());

    days.clear();

    for (var item in res) {
      final dayReport = DayReportModel.fromMap(item);
      days.add(dayReport);
    }

    isLoading = false;
  }

  DateTime _getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> _findReportLocal(bool? activePrev) async {
    final resLocal = await supabase
        .from('report_local_view')
        .select()
        .eq('id', Preferences.localId)
        .limit(1)
        .single();

    if (activePrev!) {
      prevLocal = local;
    }

    local = LocalReportModel.fromMap(resLocal);

    _time = DateTime.now();
  }

  String get hour {
    String suffix = 'PM';
    int hourFormat12h = _time.hour;

    if (_time.hour <= 12) {
      suffix = 'AM';
    }

    if (hourFormat12h > 12) {
      hourFormat12h = _time.hour - 12;
    }

    return "${hourFormat12h}${suffix}";
  }

  int get ordersDay {
    final day = DateTime.now();
    DayReportModel? orders;

    try {
      orders = days.firstWhere((element) => element.day.day == day.day);
    } catch (e) {
      orders = null;
    }

    return orders == null ? 0 : orders.orders;
  }
}
