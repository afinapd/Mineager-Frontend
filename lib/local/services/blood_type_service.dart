import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/models/blood_type_model.dart';

class BloodTypeService {
  final db = dbService.db;
  postBloodType(BloodType bloodType) async {
    await dbService.open();
    await db.insert('BloodType', bloodType.toMap());
    return bloodType;
  }

  getBloodType() async {
    await dbService.open();
    List<Map> list = await db.rawQuery('SELECT * FROM BloodType');
    return List.generate(list.length, (i) {
      return BloodType(
        id: list[i]['id'],
        type: list[i]['type'],
      );
    });
  }

  putBloodType(BloodType bloodType) async {
    await dbService.open();
    await db.update(
      'BloodType',
      bloodType.toMap(),
      where: "id = ?",
      whereArgs: [bloodType.id],
    );
    return bloodType;
  }

  deleteBloodType(BloodType bloodType) async {
    await dbService.open();
    await db.delete(
      'BloodType',
      where: "id = ?",
      whereArgs: [bloodType.id],
    );
    return bloodType;
  }
}
