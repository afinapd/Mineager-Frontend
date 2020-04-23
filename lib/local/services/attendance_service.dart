import 'package:final_project/services/time_service.dart';
import 'package:uuid/uuid.dart';
import 'db_service.dart';

class AttendanceService {
  final db = dbService.db;

  getAttendanceByDate(date, page) async {
    try {
      await dbService.open();
      final result = await db.query('attendance',
          columns: ['id', 'date', 'time', 'timeOut', 'userId'],
          limit: 10,
          offset: 10 * page,
          orderBy: 'date DESC, time DESC',
          where: "date LIKE ?",
          whereArgs: ['%$date%']);
      List<Map<String, dynamic>> map = [];
      for (var i = 0; i < result.length; i++) {
        final user = await db.query('user',
            where: "id = ?",
            columns: ['name'],
            whereArgs: [result[i]['userId']]);
        final temp = Map<String, dynamic>.from(result[i]);
        temp['user'] = user.first;
        temp['image'] = null;
        map.add(temp);
      }
      print(map[0].toString());
      return map;
    } catch (e) {
      throw new Exception(e);
    }
  }

  getAttendanceByUserIdAndDate(id, date, page) async {
    try {
      await dbService.open();
      final result = await db.query('attendance',
          columns: ['id', 'date', 'time', 'timeOut'],
          limit: 10,
          offset: 10 * page,
          orderBy: 'date DESC, time DESC',
          where: "date LIKE ? AND userId = ?",
          whereArgs: ['%$date%', id]);

      return result;
    } catch (e) {
      throw new Exception(e);
    }
  }

  getNewestAttendanceById(id) async {
    try {
      await dbService.open();
      final result = await db.query(
        'attendance',
        limit: 1,
        columns: ['id', 'date', 'time', 'timeOut'],
        orderBy: "date DESC, time DESC",
        where: "userId = ?",
        whereArgs: [id],
      );

      if (result.length <= 0) {
        return 404;
      } else {
        return result.first;
      }
    } catch (e) {
      throw new Exception(e);
    }
  }

  postAttendanceIn(userId, date, time, state) async {
    try {
      await dbService.open();
      final uuid = Uuid();
      final id = uuid.v1();
      Map<String, dynamic> body = {
        'id': id,
        'date': date,
        'time': time,
        'userId': userId,
        "timeOut": null,
        'createdAt': '${date}T$time',
        'updatedAt': '${date}T$time',
        'synced': "0"
      };
      if (state == 'online') body['synced'] = '1';
      final result = await db.insert('attendance', body);
      return result;
    } catch (e) {
      throw new Exception(e);
    }
  }

  postAttendanceOut(userId, time, state) async {
    try {
      await dbService.open();
      var body = {
        'timeOut': time,
        'synced': "0",
      };
      if (state == 'online') body['synced'] = '1';
      final newest = await getNewestAttendanceById(userId);
      if (newest != 404) {
        if (newest['date'] == TimeService().getDate()) {
          if (newest['timeOut'] == null) {
            final result = await db.update('attendance', body,
                where: 'id = ?', whereArgs: [newest['id']]);
            return result;
          }
          return 404;
        } else {
          return 404;
        }
      }
      return 404;
    } catch (e) {
      throw new Exception(e);
    }
  }
}
