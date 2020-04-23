// import 'package:final_project/auth.dart';
// import 'package:final_project/local/services/attendance_service.dart';
// import 'package:final_project/models/attendance_model.dart';
// import 'package:final_project/widgets/profile_page_widgets/logout_button.dart';
// import 'package:flutter/material.dart';

// class TestingSqflite extends StatefulWidget {
//   @override
//   _TestingSqfliteState createState() => _TestingSqfliteState();
// }

// class _TestingSqfliteState extends State<TestingSqflite> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             FloatingActionButton(
//                 onPressed: () async {
//                   Attendance result = await AttendanceService().postAttendance(
//                       Attendance(
//                           id: '444433333321321341',
//                           time: 'a2333313bc',
//                           date: 'HA321LLO',
//                           userId: '144321421'));
//                   print(result);
//                 },
//                 heroTag: "btn1",
//                 tooltip: 'Create',
//                 child: Icon(Icons.add)),
//             FlatButton(
//               onPressed: () async {
//                 List<Attendance> result =
//                     await AttendanceService().getAttendance();
//                 result.forEach((att) {
//                   print(att.toMap().toString());
//                 });
//                 // print(result[0].time.toString());
//               },
//               child: Text("Show Notes"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3),
//             ),
//             FlatButton(
//               onPressed: () async {
//                 // List<Attendance> result = await AttendanceService()
//                 //     .putAttendance(Attendance(
//                 //         id: '1', time: '123', date: '123', userId: '123'));
//                 // print(result);
//                 final result = await getCurrentUser();
//                 print(result);
//               },
//               child: Text("Update Notes"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3),
//             ),
//             FlatButton(
//               onPressed: () async {
//                 Attendance result = await AttendanceService()
//                     // .deleteAttendance(Attendance(id: '44443333332132134'));
//                 print(result);
//               },
//               child: Text("Delete Notes"),
//             ),
//             LogOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }
