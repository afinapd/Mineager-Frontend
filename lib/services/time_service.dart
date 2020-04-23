import 'package:intl/intl.dart';

// buat ngeget waktu saat ini
class TimeService {
  // ngeget tanggal sekarang, kalau mau pake timestamps pas manggil kasih param true di withTime
  // format udah sama persis buat mysql, jangan di utak atik
  getDate({bool withTime = false}) {
    if(withTime) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    }
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  getTime(){
    return DateFormat("HH:mm:ss").format(DateTime.now());
  }

  beautifyDate(date) {
    return DateFormat("yMMMMd").format(DateTime.parse(date));
  }
}