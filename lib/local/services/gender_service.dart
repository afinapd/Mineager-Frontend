import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/models/gender_model.dart';

class GenderService {
  final db = dbService.db;

  postGender(Gender gender) async {
    await dbService.open();
    await db.insert('Gender', gender.toMap());
    return gender;
  }

  getGender() async {
    await dbService.open();
    List<Map> list = await db.rawQuery('SELECT * FROM Gender');
    return List.generate(list.length, (i) {
      return Gender(
        id: list[i]['id'],
        gender: list[i]['gender'],
      );
    });
  }

  putGender(Gender gender) async {
    await dbService.open();
    await db.update(
      'Gender',
      gender.toMap(),
      where: "id = ?",
      whereArgs: [gender.id],
    );
    return gender;
  }

  deleteGender(Gender gender) async {
    await dbService.open();
    await db.delete(
      'Gender',
      where: "id = ?",
      whereArgs: [gender.id],
    );
    return gender;
  }
}
