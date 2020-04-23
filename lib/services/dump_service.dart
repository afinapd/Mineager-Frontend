import 'package:dio/dio.dart';
import 'package:final_project/constant/constants.dart';
import 'package:final_project/services/user_service.dart';

class DumpService {
  firstTimeDump() async {
    try {
      Response response = await dio.get("$API/d/all");
      return response.data;
    } catch (e) {
      if (e.response.statusCode == 404) {
        return 404;
      }
      throw new Exception();
    }
  }

  requestUpdateDump(lastUpdated) async {
    try {
      Response response =
          await dio.put("$API/d/update", data: {"lastUpdated": lastUpdated});
      return response.data;
    } catch (e) {
      if (e.response.statusCode == 401) {
        throw new Exception(401);
      }
      throw new Exception();
    }
  }

  synch(datas) async {
    try {
      Response response = await dio.post('$API/d/sync', data: datas);

      return response.data;
    } catch (e) {
      throw new Exception();
    }
  }
}
