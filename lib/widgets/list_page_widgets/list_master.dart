import 'package:final_project/app_bar.dart';
import 'package:final_project/auth.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/list_page_bloc.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/pages/list_page.dart';
import 'package:final_project/services/scan_service.dart';
import 'package:final_project/widgets/list_page_widgets/search_field.dart';
import 'package:final_project/widgets/list_page_widgets/user_list.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:final_project/widgets/shared/nfcscan.dart';
import 'package:final_project/widgets/shared/paging_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMaster extends StatefulWidget {
  final currentState;
  ListMaster({@required this.currentState});
  @override
  _ListMasterState createState() => _ListMasterState();
}

class _ListMasterState extends State<ListMaster> {
  final TextEditingController controller = TextEditingController();
  int page = 0;
  Map<String, dynamic> searchHistory = {'default': null};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SearchField(
            controller: controller,
            onSubmitted: (input) {
              if (controller.text.isNotEmpty) {
                setState(() {
                  searchHistory = {'name': input};
                });
                BlocProvider.of<ListPageBloc>(context)
                    .add(SearchUserById(input, 'name', 0, widget.currentState));
              }
            },
            qrOnPressed: () async {
              String result = await ScanService().qr();
              setState(() {
                searchHistory = {'qr': null};
              });
              BlocProvider.of<ListPageBloc>(context)
                  .add(SearchUserById(result, 'qr', 0, widget.currentState));
            },
            nfcOnPressed: () async {
              // String result = await ScanService().nfc();
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return NFCScan(
                    callback: (result) async {
                      // await Future.delayed(const Duration(seconds: 5));
                      BlocProvider.of<ListPageBloc>(context).add(SearchUserById(
                          result, 'nfc', 0, widget.currentState));
                      return;
                    },
                  );
                }),
              );
              setState(() {
                searchHistory = {'nfc': null};
              });
            },
          ),
          BlocBuilder<ListPageBloc, BlocState>(
            builder: (context, state) {
              if (state is Waiting) {
                return Container(
                  height: displayHeight(context) * 62,
                  child: Image.asset(
                    'assets/employeeReport.png',
                    fit: BoxFit.fitWidth,
                    width: displayWidth(context) * 80,
                  ),
                );
              }
              if (state is Loading) {
                return Container(
                  height: displayHeight(context) * 62,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is Success) {
                return Container(
                  height: displayHeight(context) * 62,
                  child: UserList(state.result, widget.currentState),
                );
              }
              if (state is Error) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (state.error == 401) {
                    await signOutGoogle();
                    await dbService.deleteCurrentUser();
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                });
                return ErrorHandling(
                  description: "Sorry...",
                  routeClose: Bar(
                    lastIndex: ListPage.pageNumber,
                  ),
                );
              }
              return Container();
            },
          ),
          searchHistory.values.first != null
              ? PagingButton(
                  increment: () {
                    setState(() {
                      ++page;
                      print(page.toString());
                      BlocProvider.of<ListPageBloc>(context).add(SearchUserById(
                          searchHistory.values.first,
                          searchHistory.keys.first,
                          page,
                          widget.currentState));
                    });
                  },
                  page: page,
                  decrement: () {
                    setState(
                      () {
                        if (page > 0) {
                          --page;
                          print(page.toString());
                        }
                        BlocProvider.of<ListPageBloc>(context).add(
                            SearchUserById(
                                searchHistory.values.first,
                                searchHistory.keys.first,
                                page,
                                widget.currentState));
                      },
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
