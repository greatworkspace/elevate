import 'dart:convert';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
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

class AccountOfficer extends StatefulWidget {
  @override
  _AccountOfficerState createState() => _AccountOfficerState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

String accountOfficerNo = '0123456789';
dynamic mode = mode;

List<dynamic> inielevatebank = [
  '',
  '',
  '',
  '',
];

List<dynamic> elevatebank = List.empty();

class _AccountOfficerState extends State<AccountOfficer> {
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

  Future getelevatebank() async {
    String url = apiUrl + 'get/elevate/bank/';
    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      dynamic data = json.decode(res2.body);
     setState(() {
        elevatebank[0] = data['account_number'];
      elevatebank[1] = data['name'];
      elevatebank[2] = data['bank_name'];
      elevatebank[3] = data['reference'];
     });
    }
  }

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    elevatebank = inielevatebank;
    getelevatebank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
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
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                              'Copy the details below to add money through your account officer',
                              style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 20,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: myWidth,
                          decoration: BoxDecoration(
                            color: mode.background2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Name',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
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
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(elevatebank[1] ?? '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: mode.brightText1,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Account Number',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: mode.selectfieldColor,
                                  ),
                                  onPressed: () async {
                                    Clipboard.setData(ClipboardData(
                                            text: elevatebank[0] ?? ''))
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              padding: EdgeInsets.zero,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              elevation: 0,
                                              margin: EdgeInsets.fromLTRB(
                                                  myWidth / 4,
                                                  0,
                                                  myWidth / 4,
                                                  30),
                                              backgroundColor: mode.background1,
                                              duration:
                                                  const Duration(seconds: 3),
                                              shape: BeveledRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              content: Container(
                                                width: myWidth / 2,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mode.floatBg,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Copied!',
                                                          style: TextStyle(
                                                              color: mode
                                                                  .darkText1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/svg/mark.svg',
                                                          color: mode.darkText1,
                                                          height: 12,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    height: 56,
                                    width: myWidth - 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(elevatebank[0] ?? '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Bank Name',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
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
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(elevatebank[2] ?? '',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: mode.brightText1,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Reference',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: mode.selectfieldColor,
                                  ),
                                  onPressed: () async {
                                    Clipboard.setData(ClipboardData(
                                            text: elevatebank[3] ?? ''))
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              padding: EdgeInsets.zero,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              elevation: 0,
                                              margin: EdgeInsets.fromLTRB(
                                                  myWidth / 4,
                                                  0,
                                                  myWidth / 4,
                                                  30),
                                              backgroundColor: mode.background1,
                                              duration:
                                                  const Duration(seconds: 3),
                                              shape: BeveledRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              content: Container(
                                                width: myWidth / 2,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mode.floatBg,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Copied!',
                                                          style: TextStyle(
                                                              color: mode
                                                                  .darkText1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/svg/mark.svg',
                                                          color: mode.darkText1,
                                                          height: 12,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    height: 56,
                                    width: myWidth - 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(elevatebank[3] ?? '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]));
        })));
  }
}
