import 'package:final_project/constant/constants.dart';
import 'package:final_project/pages/report_page.dart';
import 'package:final_project/services/time_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserList extends StatelessWidget {
  final List datas;
  final currentState;
  UserList(this.datas, this.currentState);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (context, index) {
        var data;
        data = datas[index];
        bool isPresent;
        bool isTimeOut;
        if (data['attendances'].toString() == '[]') {
          isPresent = false;
        } else {
          isPresent = data['attendances'][0]['date'] == TimeService().getDate();
        }

        data['timeOut'].toString() == '[]'
            ? isTimeOut = false
            : isTimeOut = true;

        return Card(
          color: Color.fromRGBO(250, 250, 250, 1),
          shape: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
          margin: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          elevation: 0.3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: data['image'] != null
                  ? NetworkImage('$API/${data['image']['path']}')
                  : AssetImage(
                      'assets/no_avatar.jpg'), // no matter how big it is, it won't overflow
            ),
            title: Text(
              data['name'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 14),
            ),
            subtitle: Text(
              data['department']['name'],
              style: TextStyle(color: Colors.black45, fontSize: 13),
            ),
            trailing: FaIcon(
              isPresent
                  ? FontAwesomeIcons.checkCircle
                  : FontAwesomeIcons.circle,
              color: isPresent ? Colors.green : Colors.red,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(data, currentState),
                ),
              );
            },
          ),
        );
      },
      itemCount: datas.length,
    ));
  }
}
