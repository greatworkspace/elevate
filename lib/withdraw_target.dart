// ignore_for_file: unused_local_variable

import 'package:elevate/home.dart';
import 'package:elevate/humanizeAmount.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'target_saving.dart';

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

class WithdrawTarget extends StatefulWidget {
  @override
  _WithdrawTargetState createState() => _WithdrawTargetState();
}

final List<Map<String, dynamic>> savetypes = [
  {
    'value': 'Monthly',
    'label': 'Monthly',
  },
  {
    'value': 'Weekly',
    'label': 'Weekly',
  },
  {
    'value': 'Daily',
    'label': 'Daily',
  },
];

dynamic mode = mode;

class _WithdrawTargetState extends State<WithdrawTarget> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();
  final tNameCon = TextEditingController();
  final tAmountCon = TextEditingController();

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

  Map item = targets.elementAt(targetD - 1);

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    tNameCon.text = item['name'];
    tAmountCon.text = humanizeNo(item['balance']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          // creating custom widgets

          Widget greycontinue = TextButton(
            onPressed: null,
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
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

          Widget realcontinue = TextButton(
            onPressed: () {
              Future(() async {
                await DatabaseHelper.instance.settrans(
                    'Savings Account / Target Savings',
                    'Savings Account / Elevate Alliance',
                    humanizeNo(item['balance']),
                    'Withdraw from Target (' + item['name'] + ')');
              }).then((value) {
                Navigator.of(context).pushNamed('EnterPin');
              });
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff23AA59)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xff23AA59),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

          Widget continuebtn() {
            if (item['balance'] >= 1000) {
              return realcontinue;
            } else {
              return greycontinue;
            }
          }

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
                        SizedBox(
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
                  height: 100,
                  width: myWidth,
                  decoration: BoxDecoration(color: mode.background3),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Withdraw Target',
                            style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('Withdraw your Target - ' + item['name'],
                            style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: myHeight - 260,
                      width: myWidth,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView(
                          children: [
                            //second
                            Text(
                              'Amount',
                              style:
                                  TextStyle(color: mode.dimText1, fontSize: 11),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 56,
                              width: myWidth - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: mode.selectfieldColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(humanizeNo(item['balance']),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: mode.dimText1,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //third
                            Text(
                              'To',
                              style:
                                  TextStyle(color: mode.dimText1, fontSize: 11),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 56,
                              width: myWidth - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: mode.selectfieldColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('EA Savings Account',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: mode.dimText1,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: myWidth - 20,
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: myWidth - 20,
                          child: continuebtn(),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ]),
                    )
                  ],
                )
              ]));
        })));
  }
}
