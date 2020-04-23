import 'package:final_project/app_bar.dart';
import 'package:final_project/auth.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/profile_bloc.dart';
import 'package:final_project/constant/socket_io.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/pages/profile_page.dart';
import 'package:final_project/services/user_service.dart';
import 'package:final_project/widgets/profile_page_widgets/logout_button.dart';
import 'package:final_project/widgets/profile_page_widgets/my_sliver_appbar.dart';
import 'package:final_project/widgets/report_page_widgets/ui_profile_data.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMaster extends StatelessWidget {
  final currentState;
  ProfileMaster({@required this.currentState});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, BlocState>(
      builder: (context, state) {
        if (state is Waiting) {
          BlocProvider.of<ProfileBloc>(context)
              .add(SearchUserById(id['id'], 'id', 0, currentState));
        }
        if (state is Success) {
          return SafeArea(
            child: Material(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      expandedHeight: displayHeight(context) * 20,
//                      subName: state.result['name'],
//                      department: state.result['department']['name'],
                    ),
                    pinned: false,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        UIProfileData(
                          name: state.result['name'],
                          department: state.result['department']['name'],
                          birth: state.result['birth'],
                          phone: state.result['phone'],
                          email: state.result['email'],
                          gender: state.result['gender']['gender'],
                          bloodtype: state.result['bloodType']['type'],
                          livingPartner: state.result['livingPartner'],
                        ),
                        LogOutButton()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (state is Error) {
          if (state.error == 401) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await signOutGoogle();
              await dbService.deleteCurrentUser();
              ioMain.socket.disconnect();
              Navigator.of(context).pushReplacementNamed('/');
            });
          }
          return ErrorHandling(
            description: "Sorry...",
            routeClose: Bar(
              lastIndex: ProfilePage.pageNumber,
            ),
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
