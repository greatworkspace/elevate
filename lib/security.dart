// ignore_for_file: must_be_immutable

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

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

class SecurityScreen extends StatefulWidget {
  SecurityScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

dynamic mode = mode;

class _SecurityScreenState extends State<SecurityScreen> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

  void gethidebal() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? got = settings['hidebal'];
    if (got == 'true') {
      setState(() {
        hiddenbalCon.text = 'true';
      });
    } else {
      setState(() {
        hiddenbalCon.text = 'false';
      });
    }
  }

  void initState() {
    super.initState();
    regetdata(context, mode);
    gethidebal();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    bool inivalue;
    Widget HideBalSwitch() {
      if (hiddenbalCon.text == 'true') {
        inivalue = true;
      } else {
        inivalue = false;
      }
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
                await DatabaseHelper.instance.sethide('true');
                setState(() {
                  hiddenbalCon.text = 'true';
                });
              } else {
                await DatabaseHelper.instance.sethide('false');
                setState(() {
                  hiddenbalCon.text = 'false';
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
                  await DatabaseHelper.instance.sethide('true');
                  setState(() {
                    hiddenbalCon.text = 'true';
                  });
                } else {
                  await DatabaseHelper.instance.sethide('false');
                  setState(() {
                    hiddenbalCon.text = 'false';
                  });
                }
              },
              activeColor: Color(0xff46A623),
              trackColor: Color(0xffD9D9D9),
              thumbColor: Colors.white),
        );
      }
    }

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myWidth = constraints.maxWidth;
      //scaffold body starts here
      return Container(
          decoration: BoxDecoration(
            color: mode.background3,
          ),
          child: Column(
            children: [
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
                              setState(() {
                                accountI = 1;
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
                      Text(
                        'Security',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mode.brightText1,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              //other items in security after header
              //change password
              Container(
                decoration: BoxDecoration(
                  color: mode.background1,
                ),
                height: 70,
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('ChangePassword');
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(children: [
                          SvgPicture.asset('assets/svg/changepass.svg'),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: myWidth - 97,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                      color: mode.brightText1, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ),
                ),
              ),
              //Transaction pin
              Container(
                decoration: BoxDecoration(
                  color: mode.background1,
                ),
                height: 70,
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('ChangePin');
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(children: [
                          SvgPicture.asset('assets/svg/transpin.svg'),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: myWidth - 97,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Transaction Pin',
                                  style: TextStyle(
                                      color: mode.brightText1, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ),
                ),
              ),
              //Hidden Balance
              Container(
                decoration: BoxDecoration(
                  color: mode.background1,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                height: 70,
                child: SizedBox(
                  child: TextButton(
                    onPressed: null,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(children: [
                          SvgPicture.asset('assets/svg/hiddenbal.svg'),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: myWidth - 97,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hidden Balance',
                                  style: TextStyle(
                                      color: mode.brightText1, fontSize: 15),
                                ),
                                HideBalSwitch()
                              ],
                            ),
                          ),
                        ])),
                  ),
                ),
              ),
            ],
          ));
    })));
  }
}
