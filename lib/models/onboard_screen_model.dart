import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

final pageList = [
  PageModel(
      color: Colors.red,
      heroAssetPath: 'assets/scannfcpage.png',
      title: Text('Scan',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text("Choose to scan between NFC or QR, Convenient isn't it?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/scan.png'),
  PageModel(
      color: Colors.red,
      heroAssetPath: 'assets/AttendanceReport.png',
      title: Text('Date',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body:
          Text('Now, you can search the report day-by-day using search-by-date',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
      iconAssetPath: 'assets/scan.png'),
  PageModel(
    color: Colors.red,
    heroAssetPath: 'assets/listpage.png',
    title: Text('Name',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        )),
    body: Text(
        'Do you want to check if someone has already been checked? Keep calm and search his/her name, or you can use the nfc/qr to scan him/her.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
    iconAssetPath: 'assets/scan.png',
  ),
];
