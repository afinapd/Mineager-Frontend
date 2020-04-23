import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

class SlideBar extends StatefulWidget {
  @override
  _SlideBarState createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  int currentIndex = 0;
  List imageList = [
    'assets/six_values_1.jpeg',
    'assets/six_values_2.jpeg',
    'assets/six_values_3.jpeg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(imageList, (index, url) {
            return Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? Color.fromRGBO(208, 52, 47, 1)
                      : Colors.grey),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.only(top: displayHeight(context) * 32),
          child: Center(
            child: Container(
              height: displayHeight(context) * 40,
              width: displayWidth(context) * 90,
              child: CarouselSlider(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayInterval: Duration(seconds: 5),
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                scrollDirection: Axis.horizontal,
                height: 400,
                initialPage: 0,
                enlargeCenterPage: true,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: imageList.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.asset(imgUrl, fit: BoxFit.fill),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

