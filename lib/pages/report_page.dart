import 'package:final_project/blocs/profile_bloc.dart';
import 'package:final_project/constant/constants.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/report_page_widgets/presence_data.dart';
import 'package:final_project/widgets/report_page_widgets/profile_data.dart';
import 'package:final_project/widgets/shared/offline_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPage extends StatefulWidget {
  static String tag = 'report-page';
  final Map<String, dynamic> user;
  final currentState;

  ReportPage(this.user, this.currentState);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: displayHeight(context)*20,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[
                        Colors.grey,
                        Colors.white,
                      ]
                  ),
                image: DecorationImage(
                  image: AssetImage("assets/building.png",),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              right: displayWidth(context) * 0,
              top: displayHeight(context) * 5,
              child: OfflineIndicator(),
            ),
            Positioned(
              top: displayHeight(context) * 4,
              left: displayWidth(context) * 1,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black45,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130),
              child: Container(
                //replace this Container with your Card
                color: Colors.white,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelColor: Color.fromRGBO(208, 52, 47, 1),
                        unselectedLabelColor: Colors.black45,
                        tabs: [
                          Tab(icon: Icon(Icons.person), text: "ABOUT ME"),
                          Tab(
                              icon: Icon(Icons.format_list_bulleted),
                              text: "MONTHLY REPORT"),
                        ],
                      ),
                      Container(
                        child: Flexible(
                          child: TabBarView(
                            children: [
                              ProfileData(
                                user: widget.user,
                              ),
                              PresenceData(
                                currentState: widget.currentState,
                                userId: widget.user['id'],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: displayHeight(context)*10,
              child: Container(
                width: 100,
                height: 100,
                decoration:
                ShapeDecoration(shape: CircleBorder(), color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.user['image'] != null ? NetworkImage(
                          // 'aa'
                          '$API/${widget.user['image']['path']}'
                        ) : AssetImage('assets/no_avatar.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
