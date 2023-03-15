import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tbrtesttask/initial_values/initial_values.dart';

class DatabaseProvider {
  Database? _database;
  Future<Database> get database async {
    final dbDirectory = await getDatabasesPath();
    const dbName = 'expense.db';
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return _database!;
  }

  static const cTable = 'countryTable';
  Future<void> _createDb(Database db, int version) async {
    await db.transaction(
      (txn) async {
        await txn.execute('''CREATE TABLE $cTable(
        name TEXT,
        dial TEXT,
        image TEXT
      )''');

        for (int i = 0; i < countries.keys.length; i++) {
          await txn.insert(
            cTable,
            {
              'name': countries.keys.toList()[i],
              'dial': countries.values.toList()[i],
              'image': countryImages.values.toList()[i],
            },
          );
        }
      },
    );
  }
}
