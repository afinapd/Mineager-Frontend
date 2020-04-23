import 'package:final_project/services/dump_service.dart';
import 'package:final_project/services/time_service.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbService {
  sql.Database db;

  Future<void> open() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      final myDBpath = path.join(dbPath, 'hemloworld.db');
      db = await sql.openDatabase(
        myDBpath,
        onCreate: (db, version) async {
          print("I CREATED");
          try {
            await db.execute(
                'CREATE TABLE AppState (id INT NOT NULL PRIMARY KEY, lastUpdated TEXT, userId TEXT, token TEXT);');
            await db.execute(
                'INSERT INTO AppState (id, lastUpdated, userId, token) VALUES (1, null, null, null);');
            await db.execute(
                'CREATE TABLE gender (id INT NOT NULL PRIMARY KEY, gender TEXT, createdAt TEXT, updatedAt TEXT, synced TEXT);');
            await db.execute(
                'CREATE TABLE department (id TEXT NOT NULL PRIMARY KEY, businessId TEXT, name TEXT, createdAt TEXT, updatedAt TEXT, synced TEXT);');
            await db.execute(
                'CREATE TABLE bloodType (id INT NOT NULL PRIMARY KEY, type TEXT, createdAt TEXT, updatedAt TEXT, synced TEXT);');
            await db.execute(
                '''CREATE TABLE user(id TEXT NOT NULL PRIMARY KEY, qrId TEXT, 
          nfcId TEXT, 
          name TEXT, 
          birth TEXT, 
          email TEXT, 
          livingPartner TEXT, 
          phone TEXT, 
          departmentId TEXT, 
          bloodTypeId INT, 
          genderId INT,
          createdAt TEXT, updatedAt TEXT, synced TEXT,
          FOREIGN KEY(departmentId) REFERENCES Department(id),
          FOREIGN KEY(bloodTypeId) REFERENCES BloodType(id),
          FOREIGN KEY(genderId) REFERENCES Gender(id));''');
            await db.execute(
                '''CREATE TABLE attendance (id TEXT NOT NULL PRIMARY KEY, 
          date TEXT, 
          time TEXT, 
          userId TEXT, timeOut TEXT,
          createdAt TEXT, updatedAt TEXT, synced TEXT,
          FOREIGN KEY(userId) REFERENCES User(id));''');
          } catch (e) {
            print(e);
          }
        },
        version: 1,
      );
    } catch (e) {
      throw new Exception();
    }
  }

  firstTimeCheck() async {
    await open();
    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT lastUpdated FROM AppState");
    return result[0]['lastUpdated'];
  }

  storeCurrentUser(userId, token) async {
    try {
      await open();
      final result = await db
          .update('AppState', {'userId': userId, 'token': token}, where: null);
      print(result.toString());

      return result;
    } catch (e) {
      throw new Exception();
    }
  }

  cleanDatabase() async {
    try {
      await open();
      final result = await Future.wait([
        db.delete('gender'),
        db.delete('department'),
        db.delete('bloodType'),
        db.delete('user'),
        db.delete('attendance'),
        db.update(
            'AppState', {'lastUpdated': null, 'userId': null, 'token': null}),
      ]);

      return result;
    } catch (e) {
      throw new Exception();
    }
  }

  deleteCurrentUser() async {
    try {
      await open();
      final result =
          await db.update('AppState', {"userId": null, "token": null});

      return result;
    } catch (e) {
      throw new Exception();
    }
  }

  getSavedUser() async {
    try {
      await open();

      //todo: Save user and set token
      //todo: dump our first time data
      final result =
          await db.rawQuery('SELECT userId AS id, token FROM AppState');
      return result.first;
    } catch (e) {
      throw new Exception();
    }
  }

  dumpDelta() async {
    try {
      await open();
      final lastUpdated = await db.query('AppState', columns: ['lastUpdated']);
      final rawData = await DumpService()
          .requestUpdateDump(lastUpdated.first['lastUpdated']);
      rawData.forEach((key, data) {
        data['update'].forEach((data) async {
          await db.update(key, data, where: "id = ?", whereArgs: [data['id']]);
        });
        data['create'].forEach((data) async {
          await db.insert(key, data);
          await db.update(key, {"synced": "1"},
              where: "id = ?", whereArgs: [data['id']]);
        });
      });
      await db.update("AppState", {"lastUpdated": TimeService().getDate()},
          where: "id = ?", whereArgs: [1]);
      return 'update';
    } catch (e) {
      throw new Exception(e.message);
    }
  }

  firstTimeDump() async {
    try {
      await open();
      Map<String, dynamic> rawData = await DumpService().firstTimeDump();
      rawData.forEach((key, data) async {
        data.forEach((data) async {
          await db.insert(key, data);
        });
      });
      await Future.wait([
        db.update('department', {"synced": "1"}),
        db.update('gender', {"synced": "1"}),
        db.update('bloodType', {"synced": "1"}),
        db.update('user', {"synced": "1"}),
        db.update('attendance', {"synced": "1"}),
        db.update("AppState", {"lastUpdated": TimeService().getDate()},
            where: "id = ?", whereArgs: [1]),
      ]);

      return 'firstTime';
    } catch (e) {
      throw new Exception();
    }
  }

  prepSyncData() async {
    try {
      final datas = await db.query('attendance',
          columns: ['id', 'date', 'time', 'timeOut', 'userId'],
          where: 'synced = ?',
          whereArgs: ['0']);

      return datas;
    } catch (e) {
      throw new Exception();
    }
  }

  syncUpdate(List datas) async {
    try {
      datas.forEach((data) async {
        switch (data['status']) {
          case 'ok':
            await db.update('attendance', {'synced': '1'},
                where: 'id = ?', whereArgs: [data['id']]);
            break;

          case 'dupe':
            await db.update(
                'attendance',
                {
                  'time': data['time'],
                  'timeOut': data['timeOut'],
                  'synced': '1'
                },
                where: 'id = ?',
                whereArgs: [data['id']]);
            break;

          default:
            break;
        }
      });
      return;
    } catch (e) {
      throw new Exception();
    }
  }
}

final dbService = DbService();
