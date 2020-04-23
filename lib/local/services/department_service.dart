import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/models/department_model.dart';

class DepartmentService{
  final db = dbService.db;

  postDepartment(Department department) async{
    await dbService.open();
    await db.insert('Department', department.toMap());
    return department;
  }

  getDepartment() async {
    await dbService.open();
    List<Map> list = await db.rawQuery('SELECT * FROM Department');
    return List.generate(list.length, (i) {
      return Department(
        id: list[i]['id'],
        businessId: list[i]['businessId'],
        name: list[i]['name'],
      );
    });
  }

  putDepartment(Department department) async {
    await dbService.open();
    await db.update('Department', department.toMap(),
      where: "id = ?",
      whereArgs: [department.id],
    );
    return department;
  }

  deleteDepartment(Department department) async {
    await dbService.open();
    await db.delete('Department', where: "id = ?",
      whereArgs: [department.id],
    );
    return department;
  }
}