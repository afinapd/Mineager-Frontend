import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/profile_bloc.dart';
import 'package:final_project/pages/report_page.dart';
import 'package:final_project/services/time_service.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:final_project/widgets/shared/paging_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PresenceData extends StatefulWidget {
  final userId;
  final currentState;
  PresenceData({@required this.userId, @required this.currentState});

  @override
  _PresenceDataState createState() => _PresenceDataState();
}

class _PresenceDataState extends State<PresenceData> {
  int page = 0;
  DataCell _cell(String text) {
    return DataCell(Text(text,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black45,
        )));
  }

  List<DataRow> rowData(datas) {
    int index = 1;
    List<DataRow> _datas = [];
    datas.forEach((object) {
      _datas.add(DataRow(cells: [
        _cell('$index'),
        _cell(TimeService().beautifyDate(object['date'])),
        _cell(object['time']),
        _cell(object['timeOut'] != null ? object['timeOut'] : '-'),
      ]));
      index++;
    });

    return _datas;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 38),
                  child: Text(
                    '${DateFormat('MMMM').format(DateTime.now())} Report',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(208, 52, 47, 1),
                        fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
              height: displayHeight(context) * 55,
              child: SingleChildScrollView(
                child: BlocBuilder<ProfileBloc, BlocState>(
                  builder: (context, state) {
                    if (state is Waiting) {
                      BlocProvider.of<ProfileBloc>(context).add(
                          SearchPresenceByDateAndUserId(
                              DateFormat('yyyy-MM').format(DateTime.now()),
                              widget.userId,
                              page,
                              widget.currentState));
                    }
                    if (state is Error) {
                      if (state.error == 401) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacementNamed('/');
                        });
                      }
                      return ErrorHandling(
                        description: "Sorry...",
                        routeClose: ReportPage(widget.userId, widget.currentState),
                      );
                    }
                    if (state is Success) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Center(
                          child: DataTable(
                            columnSpacing: 20,
                            dataRowHeight: 60,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900),
                              )),
                              DataColumn(
                                label: Text(
                                  "Date",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              DataColumn(
                                  label: Text(
                                "In",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900),
                              )),
                              DataColumn(
                                  label: Text(
                                "Out",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900),
                              )),
                            ],
                            rows: rowData(state.result),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            PagingButton(
              increment: () {
                setState(() {
                  ++page;
                  print(page.toString());
                  BlocProvider.of<ProfileBloc>(context).add(
                      SearchPresenceByDateAndUserId(
                          DateFormat('yyyy-MM').format(DateTime.now()),
                          widget.userId,
                          page,
                          widget.currentState));
                });
              },
              page: page,
              decrement: () {
                setState(() {
                  if (page > 0) {
                    --page;
                    print(page.toString());
                  }
                  BlocProvider.of<ProfileBloc>(context).add(
                      SearchPresenceByDateAndUserId(
                          DateFormat('yyyy-MM').format(DateTime.now()),
                          widget.userId,
                          page,
                          widget.currentState));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
