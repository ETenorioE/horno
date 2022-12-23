import 'package:horno/database/db.dart';
import 'package:horno/database/models/orderDbModel.dart';
import 'package:sqflite/sqflite.dart';

class DBOrders {
  static const table = 'orders';

  static const columnId = 'id';
  static const columnClientId = 'clientId';
  static const columnLocalId = 'localId';

  static String createTable() {
    return '''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnClientId TEXT NOT NULL,
        $columnLocalId INTEGER NOT NULL
      )
    ''';
  }

  static Future<int> save(OrderDbModel order) async {
    Database? db = await DbApp.instance.database;

    return await db!.insert(table, {
      columnClientId: order.clientId,
      columnLocalId: order.localId,
    });
  }

  static Future<OrderDbModel?> findByLocal(int localId) async {
    // DbApp.instance.deleteDatabase();

    Database? db = await DbApp.instance.database;

    final results = await db!
        .query(table, where: '$columnLocalId = ?', whereArgs: [localId]);

    if (results.isEmpty) return null;

    final first = results[0];

    final order = OrderDbModel.fromMap(first);

    return order;
  }
}
