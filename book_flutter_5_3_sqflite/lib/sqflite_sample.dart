import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';

class User {
  final int id;
  final String name;

  const User(this.id, this.name);
}

// (1) DDL操作の責務を持たせたクラス
class DatabaseFactory {
  Future<Database> create() async {
    var databasesPath = await getDatabasesPath();
    // (2) joinメソッドはpathパッケージのもの
    final path = join(databasesPath, 'sample.db');
    // (3) データベースが作成されていない場合にonCreate関数が呼ばれる
    return await openDatabase(path, version: 1, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute('''
create table ${UserDaoHelper._tableName} ( 
  ${UserDaoHelper._columnId} int primary key, 
  ${UserDaoHelper._columnName} text
  )
''');
    });
  }
}

// (4) データの取得・追加・更新・削除の責務を持たせたクラス
class UserDaoHelper {
  static const _tableName = 'user';
  static const _columnId = 'id';
  static const _columnName = 'name';

  final DatabaseFactory _factory;
  Database _db;

  UserDaoHelper(this._factory);

  Future<void> open() async {
    _db = await _factory.create();
  }

  Future<User> fetch(int id) async {
    // (5) 取得操作、必ずListで返却される
    List<Map> maps = await _db.query(_tableName,
        columns: [
          _columnId,
          _columnName,
        ],
        where: '$_columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User(
        maps.first[_columnId],
        maps.first[_columnName],
      );
    }
    return null;
  }

  Future<void> insert(int id, String name) async {
    // (6) 挿入処理
    await _db.insert(_tableName, {
      _columnId: id,
      _columnName: name,
    });
  }

  Future<void> delete(int id) async {
    // (7) 削除処理
    await _db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> update(int id, String name) async {
    // (8) 更新処理
    await _db.update(
        _tableName,
        {
          _columnId: id,
          _columnName: name,
        },
        where: '$_columnId = ?',
        whereArgs: [id]);
  }

  Future<void> close() async => _db?.close();
}

// (9) Facade的な責務
class UserDao {
  final DatabaseFactory factory;

  const UserDao(this.factory);

  Future<void> save(int id, String name) async {
    var helper = UserDaoHelper(factory);
    try {
      // (10) 必ず最初にopenする
      await helper.open();
      final result = await helper.fetch(id);
      if (result == null) {
        await helper.insert(id, name);
      } else {
        await helper.update(id, name);
      }
    } on SqfliteDatabaseException catch (e) {
      print(e.message);
    } finally {
      // (11) 必ず最後にcloseする
      await helper.close();
    }
  }

  Future<User> fetch(int id) async {
    var helper = UserDaoHelper(factory);
    try {
      await helper.open();
      return await helper.fetch(id);
    } on SqfliteDatabaseException catch (e) {
      print(e.message);
      return null;
    } finally {
      await helper.close();
    }
  }

  Future<void> delete(int id) async {
    var helper = UserDaoHelper(factory);
    try {
      await helper.open();
      await helper.delete(id);
    } on SqfliteDatabaseException catch (e) {
      print(e.message);
    } finally {
      await helper.close();
    }
  }
}
