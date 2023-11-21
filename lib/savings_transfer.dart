import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'package:file_picker/file_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';

@Timeout(Duration(seconds: 1))
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
String accNo = '';
String ToWhere = '';
String narated = '';

class SavingsTransfer extends StatefulWidget {
  @override
  _SavingsTransferState createState() => _SavingsTransferState();
}

final List<Map<String, dynamic>> accountTypes = [
  {
    'value': 'Elevate Account',
    'label': 'Elevate Account',
  },
];

dynamic mode = mode;

final List<Map<String, dynamic>> people = [
  {
    'id': 1,
    'name': 'Franklin, O.',
    'pic': Colors.blue,
    'accountNumber': '0123456789',
  },
  {
    'id': 2,
    'name': 'Sandra, A.',
    'pic': Colors.amber,
    'accountNumber': '0123456788',
  },
  {
    'id': 3,
    'name': 'Cathryn, S.',
    'pic': Colors.teal,
    'accountNumber': '0123456787',
  },
  {
    'id': 4,
    'name': 'Philip, B.',
    'pic': Colors.blueGrey,
    'accountNumber': '0123456786',
  },
  {
    'id': 5,
    'name': 'Onome, B.',
    'pic': Colors.greenAccent,
    'accountNumber': '0123456785',
  },
  {
    'id': 6,
    'name': 'Daniel, V.',
    'pic': Colors.indigo,
    'accountNumber': '0123456784',
  },
  {
    'id': 7,
    'name': 'Kunle, A.',
    'pic': Colors.pinkAccent,
    'accountNumber': '0123456783',
  },
  {
    'id': 8,
    'name': 'Johnson, D.',
    'pic': Colors.limeAccent,
    'accountNumber': '0123456782',
  },
  {
    'id': 9,
    'name': 'Kate, G.',
    'pic': Colors.lightBlueAccent,
    'accountNumber': '0123456781',
  },
  {
    'id': 10,
    'name': 'George, W.',
    'pic': Colors.purple,
    'accountNumber': '0123456780',
  },
  {
    'id': 11,
    'name': 'Barack, O.',
    'pic': Colors.cyanAccent,
    'accountNumber': '0123456779',
  },
];

class _SavingsTransferState extends State<SavingsTransfer> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final beneCon = TextEditingController();
  final accountTCon = TextEditingController();
  final accCon = TextEditingController();
  final amountCon = TextEditingController();
  final narateCon = TextEditingController();

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

  Future gettags() async {
    List targets = await DatabaseHelper.instance.getTarget();
    for (var item in targets) {
      accountTypes.add(
        {
          'value': item['id'],
          'label': 'Target - ${item['name']}',
        },
      );
    }
  }

  String accName = '';

  Widget loader = Container();

  Future getAcc(str) async {
    String url = apiUrl + 'get/user/account/';
    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
        'account': str,
        'note': narateCon.text,
        'bene': beneCon.text,
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      String account = json.decode(res2.body)['data']['user'];
      if (account == 'not found') {
        setState(() {
          err = true;
          AccountText = const Text(
            'Not Found',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          );
        });
      } else if (account == 'own account') {
        setState(() {
          err = true;
          AccountText = const Text(
            'Cannot transfer to self',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          );
        });
      } else {
        setState(() {
          err = false;
          accName = account;
          AccountText = Text(
            account,
            style: const TextStyle(
              color: Color(0xff30B800),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          );
        });
      }
      loader = Container();
    } else {
      setState(() {
        err = true;
        AccountText = const Text(
          'Network Error',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        );
      });
      loader = Container();
    }
  }

  List<Map<String, dynamic>> accountTypes = List.empty();
  FilePickerResult? result;
  Widget AccountW = Container();
  String accountN = '';
  bool isEnabled = true;
  Widget AccountText = Container();
  bool err = true;

  void initState() {
    super.initState();
    regetdata();
    getMode();
    accountTypes = [
      {
        'value': 'Elevate Account',
        'label': 'Elevate Account',
      },
    ];
    gettags();
    accountTCon.text = 'Elevate Account';
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    bool inivalue;

    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          // creating custom widgets

          Widget continuebtn;

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
            onPressed: () async {
              accNo = accCon.text;
              ToWhere = accountTCon.text;
              narated = narateCon.text;
              String totext = '';
              if (narated == '' || narated == null) {
                narated = ' ';
              }
              if (ToWhere == 'Elevate Account') {
                totext = '${accName} / Elevate Alliance';
              } else if (ToWhere == 'EA Loan Account') {
                totext = 'Loan Account / Elevate Alliance';
              } else if ((ToWhere == 'EA Investment Account')) {
                totext = 'Investment Account / Elevate Alliance';
              } else {
                Map tag = accountTypes
                    .where((element) => element['value'] == int.parse(ToWhere))
                    .toList()[0];
                totext = tag['label'];
                narated = 'Target Deposit';

                target_id = ToWhere;
              }
              Future(() async {
                User sets = await DatabaseHelper.instance.getUser();
                String acc = sets.account;
                String from = 'Savings Account / ' + acc;
                await DatabaseHelper.instance
                    .settrans(from, totext, amountCon.text, narated);
              }).then((value) {
                if (ToWhere == 'Elevate Account') {
                  action = 'transfer';
                } else {
                  action = 'target';
                }

                Navigator.of(context).pushNamed('EnterPin');
              });
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff23AA59)),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

          continuebtn = greycontinue;

          Widget getbtn() {
            if ((accountTCon.text == 'EA Loan Account' ||
                    accountTCon.text == 'EA Investment Account') &&
                amountCon.text.length > 2) {
              return realcontinue;
            } else if ((accountTCon.text == 'Elevate Account' &&
                    amountCon.text.length > 2) &&
                err == false &&
                accCon.text.length == 10) {
              return realcontinue;
            } else {
              if ((accountTCon.text != 'EA Loan Account' &&
                  accountTCon.text != 'EA Investment Account' &&
                  accountTCon.text != 'Elevate Account' &&
                  amountCon.text != '')) {
                if (getNum(amountCon.text) >= 1000) {
                  return realcontinue;
                }
              }
              return greycontinue;
            }
          }

          Widget realLoader = const GFLoader(
            type: GFLoaderType.ios,
            size: 18,
            loaderColorOne: Color(0xff96DBB2),
            loaderColorTwo: Color(0xff6CC992),
            loaderColorThree: Color(0xff23AA59),
            loaderstrokeWidth: 5,
          );

          Widget realAccountW = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Number',
                style: TextStyle(color: mode.dimText1, fontSize: 11),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: myWidth - 20,
                child: TextField(
                  controller: accCon,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onTap: () {
                    setState(() {
                      amountCon.text = humanizeNo(getNum(amountCon.text));
                    });
                  },
                  onChanged: (value) async {
                    if (value.length == 10) {
                      setState(() {
                        loader = realLoader;
                      });
                      err = true;
                      await getAcc(value);
                    } else {
                      AccountText = Container();
                      setState(() {
                        loader = Container();
                      });
                    }
                  },
                  style: TextStyle(
                      color: mode.brightText1,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: SizedBox(
                        width: 38.6,
                        child: loader,
                      ),
                    ),
                    counterText: '',
                    counterStyle: null,
                    alignLabelWithHint: false,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.8, color: mode.brightText1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mode.fieldBorder)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: AccountText,
              )
            ],
          );

          void changewidget() {
            if (accountTCon.text == 'Elevate Account') {
              setState(() {
                AccountW = realAccountW;
              });
            } else {
              setState(() {
                AccountW = Container();
              });
            }
          }

          if (accountTCon.text == 'Elevate Account') {
            AccountW = realAccountW;
          } else {
            AccountW = Container();
          }

          Widget BeneSwitch() {
            if (beneCon.text == 'true') {
              inivalue = true;
            } else {
              inivalue = false;
            }

            if (mode.name == 'Light') {
              return Transform.scale(
                scale: 0.9,
                child: CupertinoSwitch(
                  value: inivalue,
                  onChanged: (value) {
                    setState(() {
                      inivalue = value;
                      if (inivalue == true) {
                        beneCon.text = 'true';
                      } else {
                        beneCon.text = 'false';
                      }
                    });
                  },
                  activeColor: const Color(0xff46A623),
                  trackColor: const Color(0xffD9D9D9),
                  thumbColor: mode.thumbColor,
                ),
              );
            } else {
              return Transform.scale(
                scale: 0.9,
                child: CupertinoSwitch(
                    value: inivalue,
                    onChanged: (value) {
                      setState(() {
                        inivalue = value;
                        if (inivalue == true) {
                          beneCon.text = 'true';
                        } else {
                          beneCon.text = 'false';
                        }
                      });
                    },
                    activeColor: const Color(0xff46A623),
                    trackColor: const Color(0xffD9D9D9),
                    thumbColor: Colors.white),
              );
            }
          }

          List<Widget> People() {
            List<Widget> allpeople = [];
            for (var item in people) {
              Widget container = Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: item['pic'],
                          borderRadius: BorderRadius.circular(55)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 8,
                        color: mode.brightText1,
                      ),
                    )
                  ],
                ),
              );
              allpeople.add(container);
            }
            return allpeople;
          }

          Widget note() {
            if (accountTCon.text != 'Elevate Account') {
              return Container();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note',
                    style: TextStyle(color: mode.dimText1, fontSize: 11),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: myWidth - 20,
                    child: TextField(
                      maxLength: 50,
                      maxLines: 1,
                      controller: narateCon,
                      onTap: () {
                        setState(() {
                          amountCon.text = humanizeNo(getNum(amountCon.text));
                        });
                      },
                      style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        counterText: '',
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
                  //sixth
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add to Beneficiaries',
                        style: TextStyle(
                          fontSize: 14,
                          color: mode.brightText1,
                        ),
                      ),
                      BeneSwitch()
                    ],
                  ),
                ],
              );
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
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                        SizedBox(
                          width: myWidth - 80,
                          child: Center(
                            child: Text(
                              'Transfer',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mode.brightText1,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: myWidth,
                  height: myHeight - 65,
                  decoration: BoxDecoration(color: mode.background3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Beneficiaries.',
                                style: TextStyle(
                                  color: mode.brightText1,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 105,
                        width: myWidth,
                        decoration: BoxDecoration(
                          color: mode.background2,
                          border: Border(
                              bottom: BorderSide(
                            width: 1,
                            color: mode.kunleStroke,
                          )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: myWidth - 10,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: People()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: myWidth,
                        height: myHeight - 215,
                        color: mode.background2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //first
                                  Text(
                                    'From',
                                    style: TextStyle(
                                        color: mode.dimText1, fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height: 46,
                                      width: myWidth - 20,
                                      decoration: BoxDecoration(
                                          color: mode.selectfieldColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1,
                                              color: mode.fieldBorder)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                              'Elevate Alliance Savings Account',
                                              style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //second
                                  Text(
                                    'To',
                                    style: TextStyle(
                                        color: mode.dimText1, fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: myWidth - 20,
                                    child: SelectFormField(
                                      items: accountTypes,
                                      controller: accountTCon,
                                      onChanged: (value) {
                                        changewidget();
                                      },
                                      type: SelectFormFieldType.dropdown,
                                      decoration: InputDecoration(
                                        filled: true,
                                        alignLabelWithHint: false,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        label: Container(
                                          child: Text(
                                            'Select Account',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: mode.dimText1,
                                            ),
                                          ),
                                        ),
                                        fillColor: mode.selectfieldColor,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: mode.fieldBorder)),
                                        suffixIcon: const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 17, 0, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.solidCircle,
                                            size: 7,
                                            color: Color(0xff231E54),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: mode.fieldBorder)),
                                      ),
                                      style: TextStyle(
                                        color: mode.dimText1,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //third
                                  AccountW,
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //fourth
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                        color: mode.dimText1, fontSize: 11),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: myWidth - 20,
                                    child: TextField(
                                      controller: amountCon,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [],
                                      onTapOutside: (event) {
                                        if (amountCon.text != '') {
                                          setState(() {
                                            amountCon.text = humanizeNo(
                                                getNum(amountCon.text));
                                          });
                                        }
                                      },
                                      onTap: () {
                                        setState(() {
                                          amountCon.value = TextEditingValue(
                                            text: amountCon.text,
                                            selection: TextSelection.collapsed(
                                                offset: amountCon.text.length),
                                          );
                                        });
                                      },
                                      cursorColor: mode.background1,
                                      onChanged: (value) {
                                        if (value.isNotEmpty &&
                                            !value.contains('.')) {
                                          dynamic inivalue = getNum(value);
                                          String humanVal =
                                              humanizeNo2(inivalue);
                                          setState(() {
                                            amountCon.value = TextEditingValue(
                                              text: humanVal,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: humanVal.length),
                                            );
                                          });
                                        } else if (value.contains('.')) {
                                          String newval = '';
                                          List strs = value.split('.');
                                          if (strs[1].length > 2) {
                                            String restred =
                                                strs[1].substring(0, 2);
                                            newval = strs[0] + '.' + restred;
                                          } else {
                                            newval = value;
                                          }

                                          setState(() {
                                            amountCon.value = TextEditingValue(
                                              text: newval,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: newval.length),
                                            );
                                          });
                                        }
                                      },
                                      style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 15, 0),
                                              child: Text(
                                                'NGN',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: mode.dimText1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        alignLabelWithHint: false,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0.8,
                                                color: mode.brightText1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: mode.fieldBorder)),
                                      ),
                                    ),
                                  ),
                                  //fifth
                                  note(),

                                  SizedBox(
                                    width: myWidth - 20,
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: myWidth - 20,
                                        child: getbtn(),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ]),
                                  )
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]));
        })));
  }
}
