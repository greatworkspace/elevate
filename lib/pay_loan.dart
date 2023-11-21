import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
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

class PayLoan extends StatefulWidget {
  @override
  _PayLoanState createState() => _PayLoanState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;

class _PayLoanState extends State<PayLoan> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final loanAmountCon = TextEditingController();
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

  Future mgetData() async {
    dynamic got = await DatabaseHelper.instance.getUser();
    dynamic loan = await DatabaseHelper.instance.getLoan();
    dynamic saving = await DatabaseHelper.instance.getSaving();

    return {
      'data': got,
      'loan': loan,
      'saving': saving,
    };
  }

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    getIncentive();
    regetdata();
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

          Widget IncentiveSwitch() {
            if (incentiveCon.text == 'true') {
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
                      await DatabaseHelper.instance.setins('true');
                      setState(() {
                        incentiveCon.text = 'true';
                      });
                    } else {
                      await DatabaseHelper.instance.setins('false');
                      setState(() {
                        incentiveCon.text = 'false';
                      });
                    }
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
                    onChanged: (value) async {
                      setState(() {
                        inivalue = value;
                      });
                      if (value == true) {
                        await DatabaseHelper.instance.setins('true');
                        setState(() {
                          incentiveCon.text = 'true';
                        });
                      } else {
                        await DatabaseHelper.instance.setins('false');
                        setState(() {
                          incentiveCon.text = 'false';
                        });
                      }
                    },
                    activeColor: const Color(0xff46A623),
                    trackColor: const Color(0xffD9D9D9),
                    thumbColor: Colors.white),
              );
            }
          }

          Widget continuebtn;

          Widget greycontinue = TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 195, 74, 74)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xffD9D9D9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
            child: const Text(
              'Insufficient Balance',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

          Widget realcontinue = TextButton(
            onPressed: () async {
              Future(() async {
                User sets = await DatabaseHelper.instance.getUser();
                String acc = sets.account;
                print(sets);
                String from = 'Savings Account / ' + acc;
                await DatabaseHelper.instance.settrans(
                    from,
                    'Loan Account / Elevate Alliance',
                    loanAmountCon.text,
                    'Loan Installment');
              }).then((value) {
                action = 'payloan';
                Navigator.of(context).pushNamed('EnterPin');
              });
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff231E54)),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

          continuebtn = greycontinue;

          //scaffold body starts here

          return FutureBuilder(
              future: mgetData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  User user = snapshot.data['data'];
                  Map savings = snapshot.data['saving'];
                  dynamic loan = snapshot.data['loan'];
                  String amount = humanizeNo(loan['next_installment']);
                  String account = user.account;
                  String name =
                      '${user.firstname} ${user.lastname} / EA Savings Wallet';
                  loanAmountCon.text = amount;
                  String savingsBal = humanizeNo(savings['balance']);
                  if ((savings['balance'] - savings['lin']) >
                      loan['next_installment']) {
                    continuebtn = realcontinue;
                  }
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                Text('Make Payment from Savings\nAccount',
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListView(
                                  children: [
                                    //first
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/savings_card.png',
                                          width: myWidth - 20,
                                          height: (myWidth - 20) / 3.978,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.low,
                                        ),
                                        SizedBox(
                                          width: myWidth - 20,
                                          height: (myWidth - 20) / 3.978,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(children: [
                                              Image.asset(
                                                'assets/images/circle_icon.png',
                                                width: 54,
                                                filterQuality:
                                                    FilterQuality.medium,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(name,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(
                                                    width: myWidth - 108,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(account,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14)),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/naira.svg',
                                                              height: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(savingsBal,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    //second
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
                                        controller: loanAmountCon,
                                        enabled: false,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            double inivalue = getNum(value);
                                            String humanVal =
                                                humanizeNo(inivalue);
                                            setState(() {
                                              loanAmountCon.value =
                                                  TextEditingValue(
                                                text: humanVal,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset:
                                                            humanVal.length),
                                              );
                                            });
                                          }
                                        },
                                        style: TextStyle(
                                            color: mode.brightText1,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                        decoration: InputDecoration(
                                          alignLabelWithHint: false,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.8,
                                                  color: mode.brightText1)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: mode.fieldBorder)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Add Elevate Plus Incentive',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: mode.brightText1,
                                          ),
                                        ),
                                        IncentiveSwitch()
                                      ],
                                    )
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
                                  child: continuebtn,
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ]),
                            )
                          ],
                        )
                      ]));
                } else {
                  return Container();
                }
              });
        })));
  }
}
