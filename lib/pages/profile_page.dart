import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/blocs/profile_bloc.dart';
import 'package:final_project/pages/offline_page.dart';
import 'package:final_project/widgets/profile_page_widgets/profile_master.dart';
import 'package:final_project/widgets/shared/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfilePage extends StatelessWidget {
  static String tag = 'profile-page';
  static int pageNumber = 3;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, mainState) {
        if (mainState is Online) {
          return BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(),
            child: ProfileMaster(
              currentState: mainState.stateVal,
            ),
          );
        } else if (mainState is Offline) {
          return OfflinePage();
        }
        return CircularLoading();
      },
    );
  }
}
