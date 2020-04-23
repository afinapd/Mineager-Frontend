import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/scan_nfc_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/widgets/shared/nfcscan.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/scan_or_nfc.dart';

class NFCButton extends StatelessWidget {
  final currentState;
  NFCButton({@required this.currentState});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) {
            return NFCScan(
              callback: (result) async {
                BlocProvider.of<ScanNfcPageBloc>(context)
                    .add(SearchUserById(result, 'nfc', 0, currentState));
                return;
              },
            );
          }),
        );
      },
      child: Column(
        children: <Widget>[ScanOrNFC(Icons.nfc, "NFC")],
      ),
    );
  }
}
