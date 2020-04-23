import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/shared/offline_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class NFCScan extends StatelessWidget {
  final Function callback;
  NFCScan({@required this.callback});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NfcScan(
        callback: callback,
      ),
    );
  }
}

class NfcScan extends StatefulWidget {
  final Function callback;
  NfcScan({@required this.callback});
  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> {
  static const platform = const MethodChannel('info.mylabstudio.dev/smm');
  var hasPressed = false;
  String _deviceInfo = '';
  TextEditingController _controller = TextEditingController();
  AudioCache _audioCache;

  @override
  void initState() {
    Wakelock.enable();
    _audioCache = AudioCache(
        prefix: 'audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    _initDevice();
    super.initState();
  }

  Future _getIdCardInfo() async {
    String idCard;
    try {
      final String result = await platform.invokeMethod('scanIDCard');
      // await Future.delayed(const Duration(seconds: 1));
      // String result = "A0353400E200001965170049";
      idCard = result;
      _controller.text = idCard;

      return result;
      //Lanjutkan dengan hit http
    } on PlatformException catch (e) {
      idCard = "'${e.message}'.";
    } finally {
      // await _disposeDevice();
    }
  }

//   Future _getIdCardInfo() async {
//     String idCard;
//     try {
//       final String result = await platform.invokeMethod('scanIDCard');
//       idCard = result;
//       _controller.text = idCard;
//       print(result.toString());
//       //Lanjutkan dengan hit http
//     } on PlatformException catch (e) {
//       idCard = "'${e.message}'.";
//     } finally {
// //      await _disposeDevice();
//     }
//   }

  Future _initDevice() async {
    String deviceInfo = '';
    try {
      final bool result = await platform.invokeMethod('initUhfReader');
      if (result) {
        deviceInfo = 'Init device success';
      }
    } on PlatformException catch (e) {
      if (e.code == '001') {
        deviceInfo = 'device ready';
      } else {
        deviceInfo = e.message;
      }
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future _disposeDevice() async {
    try {
      await platform.invokeMethod('disposeUhfReader');
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayHeight(context) * 7),
        child: AppBar(
          backgroundColor: Colors.grey,
          title: Text('NFC Scan'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('How To Use'),
                          content: Text(
                              'Point the scanner gun to Employee card and pull the trigger'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }),
            OfflineIndicator(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/building.png'),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Device Status : $_deviceInfo'),
              FlatButton(
                child: Text("Pull the trigger to scan"),
                onPressed: () async {
                  final result = await _getIdCardInfo();
                  await widget.callback(result);
                  Navigator.of(context).pop();
                },
              ),
              RawKeyboardListener(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(focusColor: Colors.black),
                  autofocus: true,
                  readOnly: true,
                  textAlign: TextAlign.center,
                ),
                focusNode: _focusNode,
                onKey: (RawKeyEvent event) async {
                  if ((event.runtimeType.toString() == 'RawKeyDownEvent' &&
                      event.logicalKey.keyId == 1108101562648 &&
                      !hasPressed)) //Enter Key ID from keyboard
                  {
                    setState(() {
                      hasPressed = !hasPressed;
                    });
                    final result = await _getIdCardInfo();
                    await widget.callback(result);
                    Navigator.of(context).pop();
                  }
                  // if ((event.logicalKey.keyId ==
                  //     1108101562648)) //Enter Key ID from keyboard
                  // {
                  //   final result = await _getIdCardInfo();
                  //   await widget.callback(result);
                  //   Navigator.of(context).pop();
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
