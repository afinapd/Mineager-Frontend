import 'package:final_project/auth.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
//  final String subName;
//  final String department;

  MySliverAppBar(
      {@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          child: Image.asset('assets/building.png',
              fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: <Color>[
                    Colors.grey,
                    Colors.white,
                  ]
              )
          ),
        ),
        Positioned(
            top: expandedHeight / 40 - shrinkOffset,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: (1 - shrinkOffset / expandedHeight),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: displayWidth(context)*2,
                    ),
                    Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageURL),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, color: Colors.grey)
                            ])),
//                    SizedBox(height: 20.0),
//                    Text(
//                      subName,
//                      style: TextStyle(
//                          fontSize: 30.0,
//                          fontWeight: FontWeight.bold,
//                          color: Colors.white),
//                    ),
//                    SizedBox(height: 15.0),
//                    Text(
//                      department,
//                      style: TextStyle(
//                          fontSize: 17.0,
//                          fontStyle: FontStyle.italic,
//                          color: Colors.white),
//                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
