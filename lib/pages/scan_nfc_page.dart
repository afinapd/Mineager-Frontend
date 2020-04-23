import 'package:final_project/blocs/scan_nfc_page_bloc.dart';
import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/scan_nfc_master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanNFCPage extends StatelessWidget {
  static String tag = 'scan-nfc-page';
  static int pageNumber = 4;

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
        return BlocProvider<ScanNfcPageBloc>(
          create: (_) => ScanNfcPageBloc(),
          child: ScanNFCMaster(
            currentState: currentState,
          ),
        );
      },
    );
  }
}
