import 'dart:ui';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'overlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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



class PayInvest extends StatefulWidget {
  @override
  _PayInvestState createState() => _PayInvestState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;

class _PayInvestState extends State<PayInvest> {
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
    regetdata();
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
              height: myHeight - 65,
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add Money',
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    Text('Choose how to add money to  your EA Wallet',
                        style: TextStyle(
                          color: mode.dimText1,
                          fontSize: 13,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    //first
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('AccountOfficer');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        height: 90,
                        width: myWidth - 20,
                        decoration: BoxDecoration(
                          color: mode.background1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/account_icon.svg',
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: myWidth - 131,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Account Details',
                                            style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text('Transfer to the Account Provided',
                                            style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: mode.brightText1,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //second
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('PayInvest2');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        height: 90,
                        width: myWidth - 20,
                        decoration: BoxDecoration(
                          color: mode.background1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/deposit.svg',
                                width: 48,
                                height: 48,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: myWidth - 131,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Savings Wallet',
                                            style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            'Buy Plan from your Savings Wallet',
                                            style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: mode.brightText1,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]));
    })));
  }
}
