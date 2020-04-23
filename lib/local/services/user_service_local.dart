import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/models/user_model.dart';

class UserServiceLocal {
  final db = dbService.db;

  postUser(User user) async {
    await dbService.open();
    await db.insert('User', user.toMap());
    return user;
  }

  getUserById(id, type, page) async {
    await dbService.open();
    List<Map> result;
    switch (type) {
      case 'qr':
        result = await db.query('user',
            columns: [
              'id',
              'qrId',
              'nfcId',
              'name',
              'birth',
              'email',
              'phone',
              'livingPartner',
              'genderId',
              'departmentId',
              'bloodTypeId',
            ],
            where: 'qrId = ?',
            whereArgs: [id]);
        break;

      case 'nfc':
        result = await db.query('user',
            columns: [
              'id',
              'qrId',
              'nfcId',
              'name',
              'birth',
              'email',
              'phone',
              'livingPartner',
              'genderId',
              'departmentId',
              'bloodTypeId',
            ],
            where: 'nfcId = ?',
            whereArgs: [id]);
        break;

      case 'name':
        final resp = await getUserByName(id, page);
        return resp;
        break;

      default:
        result = await db.query('user',
            columns: [
              'id',
              'qrId',
              'nfcId',
              'name',
              'birth',
              'email',
              'phone',
              'livingPartner',
              'genderId',
              'departmentId',
              'bloodTypeId',
            ],
            where: 'id = ?',
            whereArgs: [id]);
        break;
    }
    if (result.toString() == '[]') {
      return 404;
    }
    Map<String, dynamic> map;
    for (var i = 0; i < result.length; i++) {
      final gender = db.query('gender',
          where: "id = ?",
          columns: ['id', 'gender'],
          whereArgs: [result[i]['genderId']]);
      final department = db.query('department',
          columns: ['id', 'name', 'businessId'],
          where: 'id = ?',
          whereArgs: [result[i]['departmentId']]);
      final bloodType = db.query('bloodType',
          where: 'id = ?',
          columns: ['id', 'type'],
          whereArgs: [result[i]['bloodTypeId']]);
      final attendance = db.query('attendance',
          limit: 1,
          columns: ['id', 'date', 'time', 'timeOut'],
          where: 'userId = ?',
          orderBy: 'date DESC, time DESC',
          whereArgs: [result[i]['id']]);
      final fetchs =
          await Future.wait([gender, department, bloodType, attendance]);
      final temp = Map<String, dynamic>.from(result[i]);
      temp['gender'] = fetchs[0].first;
      temp['department'] = fetchs[1].first;
      temp['bloodType'] = fetchs[2].first;
      temp['attendances'] = fetchs[3];
      map = temp;
    }

    return map;
  }

  getUserByName(name, page) async {
    try {
      final result = await db.query(
        'user',
        columns: [
          'id',
          'qrId',
          'nfcId',
          'name',
          'birth',
          'email',
          'phone',
          'livingPartner',
          'genderId',
          'departmentId',
          'bloodTypeId',
        ],
        where: 'name LIKE ?',
        whereArgs: ['%$name%'],
        limit: 10,
        offset: 10 * page,
      );
      List maps = [];
      for (var i = 0; i < result.length; i++) {
        final gender = db.query('gender',
            where: "id = ?",
            columns: ['id', 'gender'],
            whereArgs: [result[i]['genderId']]);
        final department = db.query('department',
            columns: ['id', 'name', 'businessId'],
            where: 'id = ?',
            whereArgs: [result[i]['departmentId']]);
        final bloodType = db.query('bloodType',
            where: 'id = ?',
            columns: ['id', 'type'],
            whereArgs: [result[i]['bloodTypeId']]);
        final attendance = db.query('attendance',
            limit: 1,
            columns: ['id', 'date', 'time', 'timeOut'],
            where: 'userId = ?',
            orderBy: 'date DESC, time DESC',
            whereArgs: [result[i]['id']]);
        final fetchs =
            await Future.wait([gender, department, bloodType, attendance]);
        final temp = Map<String, dynamic>.from(result[i]);
        temp['gender'] = fetchs[0].first;
        temp['department'] = fetchs[1].first;
        temp['bloodType'] = fetchs[2].first;
        temp['attendances'] = fetchs[3];
        maps.add(temp);
      }
      return maps;
    } catch (e) {
      throw new Exception(e);
    }
  }

  putUser(User user) async {
    await dbService.open();
    await db.update(
      'User',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
    return user;
  }

  deleteUser(User user) async {
    await dbService.open();
    await db.delete(
      'User',
      where: "id = ?",
      whereArgs: [user.id],
    );
    return user;
  }
}
