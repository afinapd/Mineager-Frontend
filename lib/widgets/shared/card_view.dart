import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/profile_bloc.dart';
import 'package:final_project/constant/constants.dart';
import 'package:final_project/widgets/shared/circular_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardView extends StatelessWidget {
  final String time;
  final String id;
  final String timeOut;
  final currentState;
  CardView(
      {@required this.id,
      @required this.time,
      @required this.timeOut,
      @required this.currentState});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) => ProfileBloc(),
      child: Card(
        color: Color.fromRGBO(250, 250, 250, 1),
        shape: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
        elevation: 0.3,
        child: BlocBuilder<ProfileBloc, BlocState>(
          builder: (context, state) {
            if (state is Waiting) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(SearchUserById(id, 'id', 0, currentState));
            }
            if (state is Success) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.result['image'] != null
                      ? NetworkImage('$API/${state.result['image']['path']}')
                      : AssetImage('assets/no_avatar.jpg'),
                ),
                title: Text(
                  state.result['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: 14),
                ),
                trailing: Container(
                    width: 95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('IN',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14)),
                            Text('$time',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('OUT',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14)),
                            Text('$timeOut',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 14)),
                          ],
                        ),
                      ],
                    )),
              );
            }
            if (state is Error) {
              return Center(
                child: Text("An error has occured.. Sorry..."),
              );
            }
            return CircularLoading();
          },
        ),
      ),
    );
  }
}
