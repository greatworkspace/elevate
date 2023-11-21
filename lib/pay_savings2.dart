import 'dart:ui';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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



class PaySavings2 extends StatefulWidget {
  @override
  _PaySavings2State createState() => _PaySavings2State();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;

class _PaySavings2State extends State<PaySavings2> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();
  dynamic termsVal = false;

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
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      //scaffold body starts here
      return Container(
          decoration: BoxDecoration(
            color: mode.background2,
          ),
          child: Column(children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: mode.background2,
              ),
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
                  ],
                ),
              ),
            ),
            Container(
              height: myHeight - 75,
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loan',
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                        'Take a loan from EA Services to Add Money to your\nEA Wallet.',
                        style: TextStyle(
                          color: mode.dimText1,
                          fontSize: 13,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: myWidth - 20,
                        height: 74,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mode.background2),
                        child: Padding(
                          padding:const  EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Center(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        'To apply for a loan from Elevate Alliance, visit\n',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const TextSpan(
                                    text: 'www.elevate.com',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff008CC8),
                                    ))
                              ]),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]));
    })));
  }
}
