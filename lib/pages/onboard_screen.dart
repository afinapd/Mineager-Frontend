import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:final_project/app_bar.dart';
import 'package:final_project/models/onboard_screen_model.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  static const tag = '/onboard-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed(Bar.tag), // 1
        onSkipButtonPressed: () => // Change this
            Navigator.of(context).pushReplacementNamed(Bar.tag), // 2
      ),
    );
  }
}
