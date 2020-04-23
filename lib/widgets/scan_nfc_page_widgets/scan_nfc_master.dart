import 'package:final_project/app_bar.dart';
import 'package:final_project/auth.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/scan_nfc_page_bloc.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/pages/scan_nfc_page.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/attendance_button.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/custom_dialog.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanNFCMaster extends StatelessWidget {
  final currentState;
  ScanNFCMaster({@required this.currentState});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScanNFCMasterStf(currentState: currentState),
    );
  }
}

class ScanNFCMasterStf extends StatefulWidget {
  final currentState;
  ScanNFCMasterStf({@required this.currentState});
  @override
  _ScanNFCMasterStfState createState() => _ScanNFCMasterStfState();
}

class _ScanNFCMasterStfState extends State<ScanNFCMasterStf> {
  String checkType = 'In';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<ScanNfcPageBloc>(
        create: (_) => ScanNfcPageBloc(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<ScanNfcPageBloc, BlocState>(
              builder: (context, state) {
                if (state is Error) {
                  if (state.error == 401) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      await signOutGoogle();
                      await dbService.deleteCurrentUser();
                      Navigator.of(context).pushReplacementNamed('/');
                    });
                  }
                  return ErrorHandling(
                    description: state.error,
                    routeClose: Bar(
                      lastIndex: ScanNFCPage.pageNumber,
                    ),
                  );
                }
                if (state is Waiting) {
                  return AttendanceButton(
                    currentState: widget.currentState,
                    callback: (val) {
                      setState(() {
                        checkType = val;
                      });
                    },
                    checkType: checkType,
                  );
                }
                if (state is Success) {
                  return CustomDialog(
                      state.result, checkType, widget.currentState);
                }
                // if (state is Loading) {
                //   return Container(
                //     height: displayHeight(context) * 80,
                //     child: Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //   );
                // }
                return Container(
                  height: displayHeight(context) * 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
