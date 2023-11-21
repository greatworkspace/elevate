import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'humanizeAmount.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/user.dart';

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

class WithdrawSavings extends StatefulWidget {
  @override
  _WithdrawSavingsState createState() => _WithdrawSavingsState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;

class _WithdrawSavingsState extends State<WithdrawSavings> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();
  final amountCon = TextEditingController();
  final narateCon = TextEditingController();
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

  void getbank() async {
    dynamic bank = await DatabaseHelper.instance.getBank();
    if (bank['id'] == null || bank['status'] == 'pending') {
      setState(() {
        selectedindex = 3;
        accountI = 3;
      });
      Navigator.pop(context);
    }
  }

  void initState() {
    super.initState();
    getMode();
    getbank();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          // creating custom widgets

          Widget continuebtn;

          Widget greycontinue = TextButton(
            onPressed: null,
            child: const Text(
              'Send',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff777777)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          );

          Widget realcontinue = TextButton(
            onPressed: () async {
              String narated = narateCon.text;
              String totext = 'Damian Marley / Guarantee Trust Bank';
              if (narated == '' || narated == null) {
                narated = ' ';
              }
              Future(() async {
                User sets = await DatabaseHelper.instance.getUser();
                String acc = sets.account;
                String from = 'Savings Account / ' + acc;
                await DatabaseHelper.instance.settrans(
                    'Investment Account / Elevate Alliance',
                    totext,
                    amountCon.text,
                    narated);
              }).then((value) {
                Navigator.of(context).pushNamed('EnterPin');
              });
            },
            child: const Text(
              'Send',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
          );

          continuebtn = greycontinue;
          if (amountCon.text.length >= 3) {
            continuebtn = realcontinue;
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
                  height: myHeight - 75,
                  width: myWidth,
                  decoration: BoxDecoration(color: mode.background3),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text('Withdraw',
                              style: TextStyle(
                                  color: mode.brightText1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                              'Send  a request to withdraw funds from\nyour Funding Wallet',
                              style: TextStyle(
                                color: mode.dimText1,
                                fontSize: 13,
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
                                Text('Amount',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 56,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: amountCon,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        double inivalue = getNum(value);
                                        String humanVal = humanizeNo(inivalue);
                                        setState(() {
                                          amountCon.value = TextEditingValue(
                                            text: humanVal,
                                            selection: TextSelection.collapsed(
                                                offset: humanVal.length),
                                          );
                                        });
                                      }
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(" "))
                                    ],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: false,
                                      hintStyle: TextStyle(
                                        color: mode.dimText1,
                                        fontSize: 15,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.fieldBorder)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mode.fieldBorder,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: mode.brightText1,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('To (Bank)',
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
                                    color: mode.selectfieldColor,
                                    borderRadius: BorderRadius.circular(5),
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
                                        Text('Guarantee Trust Bank',
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
                                Text('To (Account Number)',
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
                                    color: mode.selectfieldColor,
                                    borderRadius: BorderRadius.circular(5),
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
                                        Text('0123456789',
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
                                Text('Purpose of Withdrawal',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: mode.brightText1,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 56,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: narateCon,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(" "))
                                    ],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: false,
                                      hintStyle: TextStyle(
                                        color: mode.dimText1,
                                        fontSize: 15,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.fieldBorder)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mode.fieldBorder,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: mode.brightText1,
                                      fontSize: 15,
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
                                      child: continuebtn,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]));
        })));
  }
}
