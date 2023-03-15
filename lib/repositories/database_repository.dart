import 'package:tbrtesttask/models/country.dart';

import '../database/database.dart';

class DatabaseRepo {
  DatabaseRepo(this.database);

  final DatabaseProvider database;

  Future<List<Country>> getCountries() async {
    final db = await database.database;
    return db.transaction((txn) async {
      return await txn.rawQuery('''
      SELECT * FROM ${DatabaseProvider.cTable}
      ''').then((data) {
        final converted = List<Map<dynamic, dynamic>>.from(data);
        return converted.map((e) {
          return Country(
            name: e['name'],
            flagUrl: e['image'],
            dialCode: e['dial'],
          );
        }).toList();
      });
    });
  }

  Future<List<Country>> getSearchedCountry(String searchValue) async {
    final db = await database.database;

    return await db.transaction((txn) async {
      return await txn.query(
        DatabaseProvider.cTable,
        where: 'name LIKE ?',
        whereArgs: ['$searchValue%'],
      ).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        return converted.map((e) {
          return Country(
            name: e['name'],
            flagUrl: e['image'],
            dialCode: e['dial'],
          );
        }).toList();
      });
    });
  }
}
