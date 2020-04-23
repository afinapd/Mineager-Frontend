import 'package:final_project/app_bar.dart';
import 'package:final_project/auth.dart';
import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/filter_date_page_bloc.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/widgets/list_page_widgets/search_by.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/shared/card_view.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:final_project/widgets/shared/paging_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterDatePage extends StatefulWidget {
  @override
  _FilterDatePageState createState() => _FilterDatePageState();
}

class _FilterDatePageState extends State<FilterDatePage> {
  static int pageNumber = 1;
  DateTime _selectedDate;
  int page = 0;

  _presentDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    setState(() {
      _selectedDate = pickedDate;
    });
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, mainState) {
        // since we need to fetch from API when online and to the local when offline
        // this variable is needed to store the currentState
        String currentState;
        if (mainState is Online) {
          currentState = mainState.stateVal;
        } else if (mainState is Offline) {
          currentState = mainState.stateVal;
        }
        print(currentState);
        return Scaffold(
          body: Container(
            child: BlocProvider<FilterDatePageBloc>(
              create: (_) => FilterDatePageBloc(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: displayHeight(context) * 1,
                  ),
                  BlocBuilder<FilterDatePageBloc, BlocState>(
                    builder: (ctx, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFFEBEEF1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            height: 40.0,
                            width: displayWidth(context) * 80,
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black45,
                                fontFamily: 'OpenSans',
                              ),
                              onTap: () async {
                                await _presentDatePicker();
                                BlocProvider.of<FilterDatePageBloc>(ctx).add(
                                    SearchPresenceByDate(
                                        DateFormat("yyyy-MM-dd")
                                            .format(_selectedDate),
                                        page,
                                        currentState));
                              },
                              onChanged: (_selectedDate) {
                                // BlocProvider.of<FilterDatePageBloc>(context).add(
                                //     SearchPresenceByDate(DateFormat("yyyy-MM-dd")
                                //         .format(_selectedDate)));
                              },
                              readOnly: true,
                              onSubmitted: (input) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 6.0),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                  size: 20,
                                ),
                                hintText: _selectedDate == null
                                    ? "Filter report attendance by date"
                                    : DateFormat("yyyy-MM-dd")
                                        .format(_selectedDate)
                                        .toString(),
                                hintStyle: TextStyle(
                                    color: Colors.black45, fontSize: 14),
                              ),
                            ),
                          ),
                          SearchBy(
                            icon: Icons.calendar_today,
                            onPressed: () async {
                              await _presentDatePicker();
                              BlocProvider.of<FilterDatePageBloc>(ctx).add(
                                  SearchPresenceByDate(
                                      DateFormat("yyyy-MM-dd")
                                          .format(_selectedDate),
                                      page,
                                      currentState));
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: displayWidth(context) * 3),
                    child: Text(
                      '${_selectedDate == null ? ' ' : '${DateFormat.yMMMMEEEEd().format(_selectedDate)}'}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(208, 52, 47, 1),
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 2,
                  ),
                  BlocBuilder<FilterDatePageBloc, BlocState>(
                    builder: (context, state) {
                      if (state is Waiting) {
                        return Container(
                            height: displayHeight(context) * 55,
                            child: Center(
                              child: Image.asset(
                                'assets/filterDate.png',
                                fit: BoxFit.fitWidth,
                                width: displayWidth(context) * 80,
                              ),
                            ));
                      }
                      if (state is Success) {
                        return Container(
                          height: displayHeight(context) * 55,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 0),
                            itemCount: state.result.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return CardView(
                                id: state.result[index]['userId'],
                                time: state.result[index]['time'],
                                timeOut: state.result[index]['timeOut'] != null
                                    ? state.result[index]['timeOut']
                                    : '           ',
                                currentState: currentState,
                              );
                            },
                          ),
                        );
                      }
                      if (state is Loading) {
                        return Container(
                          height: displayHeight(context) * 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is Error) {
                        if (state.error == 401) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            await signOutGoogle();
                            await dbService.deleteCurrentUser();
                            Navigator.of(context).pushReplacementNamed('/');
                          });
                        }
                        return ErrorHandling(
                          description: state.error,
                          routeClose: Bar(
                            lastIndex: pageNumber,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  _selectedDate != null
                      ? BlocBuilder<FilterDatePageBloc, BlocState>(
                          builder: (ctx, state) {
                            return PagingButton(
                              increment: () {
                                setState(() {
                                  ++page;
                                  print(page.toString());
                                  BlocProvider.of<FilterDatePageBloc>(ctx).add(
                                      SearchPresenceByDate(
                                          DateFormat("yyyy-MM-dd")
                                              .format(_selectedDate),
                                          page,
                                          currentState));
                                });
                              },
                              page: page,
                              decrement: () {
                                setState(() {
                                  if (page > 0) {
                                    --page;
                                    print(page.toString());
                                  }
                                  BlocProvider.of<FilterDatePageBloc>(ctx).add(
                                      SearchPresenceByDate(
                                          DateFormat("yyyy-MM-dd")
                                              .format(_selectedDate),
                                          page,
                                          currentState));
                                });
                              },
                            );
                          },
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
