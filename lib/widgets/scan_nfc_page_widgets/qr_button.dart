import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/scan_nfc_page_bloc.dart';
import 'package:final_project/services/scan_service.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/scan_or_nfc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QRButton extends StatelessWidget {
  final currentState;
  QRButton({@required this.currentState});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        String result = await ScanService().qr();
        BlocProvider.of<ScanNfcPageBloc>(context)
            .add(SearchUserById(result, 'qr', 0, currentState));
      },
      child: Column(
        children: <Widget>[ScanOrNFC(FontAwesomeIcons.qrcode, 'SCAN QR')],
      ),
    );
  }
}
