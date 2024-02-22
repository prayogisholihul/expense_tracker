import 'package:expense_tracker/model/expense_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseDB {
  static final ExpenseDB instance = ExpenseDB._internal();
  static Database? _database;

  ExpenseDB._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Expensedb.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, _) async {
    return await db.execute('''
CREATE TABLE ${ExpenseDbType.tableName}(
  ${ExpenseDbType.id} ${ExpenseDbType.idType},
  ${ExpenseDbType.title} ${ExpenseDbType.textType},
  ${ExpenseDbType.amount} ${ExpenseDbType.intType},
  ${ExpenseDbType.date} ${ExpenseDbType.textType},
  ${ExpenseDbType.category} ${ExpenseDbType.textType}
)
''');
  }

  Future<int> insert(ExpenseData expense) async {
    final db = await instance.database;
    return await db.insert(
      ExpenseDbType.tableName,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ExpenseData>> getAll() async {
    final db = await instance.database;
    final orderLatest = '${ExpenseDbType.date} ASC';
    final data = await db.query(ExpenseDbType.tableName, orderBy: orderLatest);
    return data.map((item) => ExpenseData.fromMap(item)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(ExpenseDbType.tableName,
        where: '${ExpenseDbType.id} = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    return db.close();
  }
}
