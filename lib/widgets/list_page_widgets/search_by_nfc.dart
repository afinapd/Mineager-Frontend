import 'package:final_project/widgets/list_page_widgets/search_by.dart';
import 'package:flutter/material.dart';

class SearchByNFC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchBy(
      icon: Icons.nfc,
      onPressed: () async {
        // String result = await ScanService().nfc();
        // BlocProvider.of<ListPageBloc>(context)
        //     .add(SearchUserById(result, 'nfc', 0));
      },
    );
  }
}
