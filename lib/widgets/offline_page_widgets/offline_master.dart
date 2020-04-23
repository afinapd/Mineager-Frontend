import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/offline_page_widgets/notification_text.dart';
import 'package:flutter/material.dart';

class OfflineMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: displayWidth(context) * 80,
          child: NotificationText(),
        ),
      ),
    );
  }
}
