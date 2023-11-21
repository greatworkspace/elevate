import 'dart:ui';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'overlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

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



class ScheduleDeduction extends StatefulWidget {
  ScheduleDeduction({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _ScheduleDeductionState createState() => _ScheduleDeductionState();
}

final List<Map<String, dynamic>> deductions = [
  {
    'id': 1,
    'name': 'Rent',
    'deduct': false,
    'amount': 200000,
    'paid': 10000,
  },
  {
    'id': 2,
    'name': 'Lexus ES 350',
    'deduct': false,
    'amount': 1000000,
    'paid': 500000,
  },
  {
    'id': 3,
    'name': 'ASUS Alienware Laptop',
    'deduct': false,
    'amount': 1000000,
    'paid': 50000,
  }
];

dynamic mode = mode;

class _ScheduleDeductionState extends State<ScheduleDeduction> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final incentiveCon = TextEditingController();

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

 
  void getIncentive() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? incentivemode = settings['isincentive'];
    if (incentivemode == 'true') {
      setState(() {
        incentiveCon.text = 'true';
      });
    } else {
      setState(() {
        incentiveCon.text = 'false';
      });
    }
  }

  FilePickerResult? result;

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    getIncentive();
  }

  @override
  Widget build(BuildContext context) {
    bool inivalue;
    return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      Widget IncentiveSwitch(int id) {
        Map<String, dynamic> wid = deductions.elementAt(id - 1);
        dynamic inivalue = wid['deduct'];

        if (mode.name == 'Light') {
          return Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              value: inivalue,
              onChanged: (value) async {
                setState(() {
                  inivalue = value;
                });
                if (value == true) {
                  deductions.elementAt(id - 1)['deduct'] = true;
                  setState(() {
                    incentiveCon.text = 'true';
                  });
                } else {
                  deductions.elementAt(id - 1)['deduct'] = false;
                  setState(() {
                    incentiveCon.text = 'false';
                  });
                }
              },
              activeColor: Color(0xff46A623),
              trackColor: Color(0xffD9D9D9),
              thumbColor: mode.thumbColor,
            ),
          );
        } else {
          return Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
                value: inivalue,
                onChanged: (value) async {
                  setState(() {
                    inivalue = value;
                  });
                  if (value == true) {
                    deductions.elementAt(id - 1)['deduct'] = true;
                    setState(() {
                      incentiveCon.text = 'true';
                    });
                  } else {
                    deductions.elementAt(id - 1)['deduct'] = false;
                    setState(() {
                      incentiveCon.text = 'false';
                    });
                  }
                },
                activeColor: Color(0xff46A623),
                trackColor: Color(0xffD9D9D9),
                thumbColor: Colors.white),
          );
        }
      }

      List<Widget> deducts() {
        List<Widget> deductsL = [];
        for (var item in deductions) {
          String dec;
          if (item['deduct'] == true) {
            dec = 'Enabled';
          } else {
            dec = 'Disabled';
          }
          Widget container = Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              height: 91,
              width: myWidth - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: mode.background2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/target_icon.svg',
                            height: 44.4,
                            width: 46.38,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: mode.brightText1,
                                ),
                              ),
                              Text(
                                dec,
                                style: TextStyle(
                                  fontSize: 11.84,
                                  color: mode.dimText1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      IncentiveSwitch(item['id']),
                    ]),
              ),
            ),
          );
          deductsL.add(container);
        }
        return deductsL;
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
                    Container(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              savingsI = 1;
                            });
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
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text('Deductions',
                          style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 18,
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: deducts(),
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
