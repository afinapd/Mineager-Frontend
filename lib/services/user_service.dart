import 'package:dio/dio.dart';
import 'package:final_project/auth.dart';
import 'package:final_project/constant/constants.dart';
import 'package:final_project/local/services/db_service.dart';

var dio = Dio();
var id;

class UserService {
  Future login(email, password) async {
    try {
      Response response = await Dio()
          .post(API + "/auth", data: {"email": email, "password": password});
      id = response.data;
      this.setHeader();
      await dbService.storeCurrentUser(
          response.data['id'], response.data['token']);
      return response.data;
    } catch (e) {
      return e.response.statusCode;
    }
  }

  setHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var customHeaders = {
        'Content-Type': 'application/json',
        // 'Authorization':
        // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiUmlvIEFyc3dlbmRvIiwiZW1haWwiOiJyLmFyc3dlbmRvLnJAZ21haWwuY29tIiwiaWF0IjoxNTg2NzcyNTEzfQ.g6HdLhQUPVXby6jq0VT8I91jcKEF96_pJ77IOrWYR44'
        'Authorization': 'Bearer ${id['token']}',
      };
      options.headers.addAll(customHeaders);
      return options;
    }));
  }

  setIdAndToken() async {
    try {
      final result = await dbService.getSavedUser();

      id = result;
      this.setHeader();
      final user = await getCurrentUser();
      name = user.displayName;
      email = user.email;
      imageURL = user.photoUrl;
      return id;
    } catch (e) {
      return e.response.statusCode;
    }
  }

  fetchById(id, type, page) async {
    try {
      Response response = await dio.get("$API/u/$id/$type?page=$page");
      return response.data;
    } catch (e) {
      if (e.response.statusCode == 404) {
        return 404;
      }
      return e.response.statusCode;
    }
  }

  fetchPresenceByUserId(userId, page) async {
    try {
      Response response =
          await dio.get("$API/a/attendance/id?id=$userId&page=$page");
      return response.data;
    } catch (e) {
      return e.response.statusCode;
    }
  }

  fetchPresenceByDate(date, page) async {
    try {
      Response response =
          await dio.get("$API/a/attendance/date?date=$date&page=$page");
      return response.data;
    } catch (e) {
      return e.response.statusCode;
    }
  }

  fetchNewestPresenceById(id) async {
    try {
      Response response = await dio.get("$API/a/attendance/newest?id=$id");
      return response.data;
    } catch (e) {
      return e.response.statusCode;
    }
  }

  postAttendanceOut(userId, time) async {
    try {
      Response response = await dio
          .post("$API/a/$userId/submit?pref=out", data: {"time": time});
      return response.data;
    } catch (e) {
      if (e.response.statusCode == 404) {
        return 404;
      }
      return e.response.statusCode;
    }
  }

  postAttendance(userId, date, time) async {
    try {
      Response response = await dio.post("$API/a/$userId/submit?pref=in",
          data: {"date": date, "time": time});
      return response.data;
    } catch (e) {
      if (e.response.statusCode == 404) {
        return 404;
      }
      return e.response.statusCode;
    }
  }

  fetchPresenceByDateAndUserId(date, userId, page) async {
    try {
      Response response = await dio
          .get("$API/a/attendance/dateandId?id=$userId&date=$date&page=$page");
      return response.data;
    } catch (e) {
      return e.response.statusCode;
    }
  }
}

var userService = UserService();
