// ignore_for_file: sized_box_for_whitespace

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';

import 'models/databaseHelper.dart';

class KeyClass {
  static const shakeKey1 = Key('__RIKEY1__');
  static const shakeKey2 = Key('__RIKEY2__');
}

dynamic getKey(key) {
  if (key == KeyClass.shakeKey2) {
    return KeyClass.shakeKey1;
  } else {
    return KeyClass.shakeKey2;
  }
}

dynamic shakey = KeyClass.shakeKey1;

final List<Map<String, dynamic>> _languages = [
  {
    'value': 'English',
    'label': 'English',
  },
  {
    'value': 'French',
    'label': 'French',
  }
];

final List<Map<String, dynamic>> _modes = [
  {
    'value': 'Dark',
    'label': 'Dark Mode',
  },
  {
    'value': 'Light',
    'label': 'Light Mode',
  }
];



class ChangePin extends StatefulWidget {
  @override
  _ChangePinState createState() => _ChangePinState();
}

dynamic mode = mode;

class _ChangePinState extends State<ChangePin> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

  void getMode() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? mymode = settings['mode'];
    if (mymode == null) {
      setState(() {
        mode = lightmode;
        modeCon.text = 'Light';
      });
    } else if (mymode == 'Dark') {
      setState(() {
        mode = darkmode;
        modeCon.text = 'Dark';
      });
    } else {
      setState(() {
        mode = lightmode;
        modeCon.text = 'Light';
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myWidth = constraints.maxWidth;
      //custom widget

      // ignore: unused_local_variable
      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Reset',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffD9D9D9)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xffD9D9D9),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      Widget realcontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Reset',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff122774)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xff122774),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      continuebtn = greycontinue;

      //scaffold body starts here
      return Container(
          decoration: BoxDecoration(
            color: mode.background3,
          ),
          child: Column(children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                  color: mode.background2,
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: mode.headerDivider,
                    ),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: mode.brightText1,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Transaction Pin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mode.brightText1,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ),
            ),
            //other items in statement after header
            Container(
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4-Digit Pin',
                        style: TextStyle(
                          fontSize: 20,
                          color: mode.brightText1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: myWidth - 20,
                        child: Text(
                          'This pin secures your transactions. Do not share this pin to anyone.',
                          style: TextStyle(
                            color: mode.dimText1,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              width: myWidth,
              decoration: BoxDecoration(
                  color: mode.background1,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Pin',
                      style: TextStyle(color: mode.brightText1, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: myWidth - 20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.8, color: mode.brightText1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mode.fieldBorder)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'New Pin',
                      style: TextStyle(color: mode.brightText1, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: myWidth - 20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.8, color: mode.brightText1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mode.fieldBorder)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Confirm Pin',
                      style: TextStyle(color: mode.brightText1, fontSize: 13),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      height: 60,
                      width: myWidth - 20,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.8, color: mode.brightText1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mode.fieldBorder)),
                        ),
                      ),
                    ),
                    Container(
                      width: myWidth - 20,
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: myWidth - 20,
                          child: realcontinue,
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ]),
                    )
                  ],
                ),
              ),
            )
          ]));
    })));
  }
}
