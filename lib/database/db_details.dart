import 'package:horno/database/index.dart';
import 'package:horno/database/models/detailDbModel.dart';
import 'package:sqflite/sqflite.dart';

class DBDetails {
  static const table = 'details';

  static const columnId = 'id';
  static const columnOrderId = 'orderId';
  static const columnServiceId = 'serviceId';
  static const columnServiceName = 'serviceName';
  static const columnServiceImage = 'serviceImage';
  static const columnServicePrice = 'servicePrice';
  static const columnWeight = 'weight';
  static const columnTotal = 'total';

  static String createTable() {
    return '''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnOrderId INTEGER NOT NULL,
        $columnServiceId INTEGER NOT NULL,
        $columnServiceName TEXT NOT NULL,
        $columnServiceImage TEXT NOT NULL,
        $columnServicePrice REAL NOT NULL,
        $columnWeight INTEGER NOT NULL,
        $columnTotal REAL NOT NULL
      )
    ''';
  }

  static Future<int> save(DetailDbModel detail) async {
    Database? db = await DbApp.instance.database;

    return await db!.insert(table, detail.toMap());
  }

  static Future<List<DetailDbModel>> getAllByOrder(int order) async {
    Database? db = await DbApp.instance.database;

    List<DetailDbModel> list = [];

    final results =
        await db!.query(table, where: '$columnOrderId = ?', whereArgs: [order]);

    for (var item in results) {
      list.add(DetailDbModel.fromMap(item));
    }

    return list;
  }

  static Future<int?> update(DetailDbModel detail) async {
    Database? db = await DbApp.instance.database;

    int id = detail.id!;

    return await db!
        .update(table, detail.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<DetailDbModel?> findById(int id) async {
    Database? db = await DbApp.instance.database;

    final results =
        await db!.query(table, where: '$columnId = ?', whereArgs: [id]);

    if (results.isEmpty) return null;

    final first = results[0];

    final detail = DetailDbModel.fromMap(first);

    return detail;
  }

  static Future<int?> deleteById(int id) async {
    Database? db = await DbApp.instance.database;

    return await db!.delete(table, where: '$columnId=?', whereArgs: [id]);
  }

  static Future<int?> deleteByOrderId(int id) async {
    Database? db = await DbApp.instance.database;

    return await db!.delete(table, where: '$columnOrderId=?', whereArgs: [id]);
  }
}
