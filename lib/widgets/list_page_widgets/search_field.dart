import 'package:final_project/widgets/list_page_widgets/field_search_name.dart';
import 'package:final_project/widgets/list_page_widgets/search_by.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchField extends StatelessWidget {
  final Function onSubmitted;
  final Function qrOnPressed;
  final Function nfcOnPressed;
  final TextEditingController controller;
  SearchField(
      {@required this.onSubmitted,
      @required this.qrOnPressed,
      @required this.nfcOnPressed,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: displayHeight(context) * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FieldSearchName(
              controller: controller,
              onSubmitted: onSubmitted,
            ),
            SearchBy(
              icon: FontAwesomeIcons.qrcode,
              onPressed: qrOnPressed,
            ),
            SearchBy(
              icon: Icons.nfc,
              onPressed: nfcOnPressed,
            ),
            // SearchByQR(),
            // SearchByNFC(),
          ],
        ),
      ],
    );
  }
}
