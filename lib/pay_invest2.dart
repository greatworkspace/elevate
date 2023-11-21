import 'dart:ui';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'models/user.dart';
import 'models/databaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class PayInvest2 extends StatefulWidget {
  @override
  _PayInvest2State createState() => _PayInvest2State();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;
String loanAmount = '20,000';
bool gotten = false;
List mplans = List.empty();
int pl = -1;

String errText = 'Continue';

class _PayInvest2State extends State<PayInvest2>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final amountCon2 = TextEditingController();
  final incentiveCon = TextEditingController();
  final retCon = TextEditingController();
  final planCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

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

  List plans = List.empty();

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

  Future getplans() async {
    String url = apiUrl + 'get/plans/';
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
      setState(() {
        gotten = true;
      });
      Map<String, dynamic> data = json.decode(res2.body);

      if (data['plans'] != null) {
        setState(() {
          plans = data['plans'];
        });
      }
    } else {
      print('error');
    }
  }

  Future getdata() async {
    if (gotten == false) {
      await getplans();
    }
    dynamic got = await DatabaseHelper.instance.getSaving();
    User data = await DatabaseHelper.instance.getUser();

    return {
      'savings': got,
      'user': data,
      'plans': plans,
    };
  }

  void initState() {
    super.initState();
    getMode();
    getplans();
    initializeDateFormatting();
    getIncentive();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
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
                      await DatabaseHelper.instance.setins('true');
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
                    activeColor: Color(0xff46A623),
                    trackColor: Color(0xffD9D9D9),
                    thumbColor: Colors.white),
              );
            }
          }

          Widget continuebtn;

          Widget greycontinue = TextButton(
            onPressed: null,
            child: Text(
              errText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffD9D9D9)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xffD9D9D9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          );

          Widget realcontinue = TextButton(
            onPressed: () {
              Future(() async {
                User sets = await DatabaseHelper.instance.getUser();
                String acc = sets.account;
                String from = 'Savings Account / ' + acc;
                pl = int.parse(planCon.text);
                String month = 'month';
                if (mplans[pl]['duration'] > 1) {
                  month = 'months';
                }
                String narat =
                    '${mplans[pl]['name']} - ${mplans[pl]['duration']} ${month} @ ${mplans[pl]['interest']}%';
                await DatabaseHelper.instance.settrans(
                    from,
                    'Investment Account / Elevate Alliance',
                    amountCon2.text,
                    narat);
              }).then((value) {
                action = 'buyplan';
                Navigator.of(context).pushNamed('EnterPin');
              });
            },
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff231E54)),
            ),
          );

          Widget ReturnCon() {
                        Widget con = Container();
                        if (planCon.text == '') {
                              errText = 'Select Plan';
                            } else if (amountCon2.text == '') {
                              errText = 'Enter Amount';
                            }
                        else if (amountCon2.text != '' && planCon.text != '') {
                          double amm = getNum(amountCon2.text);
                          if (amm >=
                              mplans[int.parse(planCon.text)]
                                  ['interest_threshold']) {
                            continuebtn = realcontinue;
                            double inter =
                                mplans[int.parse(planCon.text)]['interest'];

                            int tenure =
                                mplans[int.parse(planCon.text)]['duration'];
                            double retvalue =
                                amm + ((amm * (inter / 100)) * tenure);
                            String retv = humanizeNo(retvalue);
                            con = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Return',
                                  style: TextStyle(
                                      color: mode.dimText1, fontSize: 11),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: myWidth - 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: mode.selectfieldColor,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 15, 0),
                                                      child: Text(
                                                        'NGN',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: mode.dimText1,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(retv,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: mode.brightText1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                              errText = 'Below Threshold';
                          }
                        } else {
                          con = Container();
                        }
                        return con;
                      }

          continuebtn = greycontinue;

          //scaffold body starts here
          return Column(
            children: [
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
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: getdata(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      Map data = snapshot.data;
                      mplans = data['plans'];
                      String balance = humanizeNo(data['savings']['balance']);
                      String account = data['user'].account ?? '';
                      String name = (data['user'].firstname ?? '') +
                          ' ' +
                          (data['user'].lastname ?? '');
                      List<Map<String, dynamic>> myplans = [];
                      int mindex = -1;
                      for (var plan in mplans) {
                        mindex += 1;
                        String month = 'month';
                        if (plan['duration'] > 1) {
                          month = 'months';
                        }
                        Map<String, dynamic> newval = {
                          'value': mindex,
                          'label':
                              '${plan['name']} - ${plan['duration']} ${month} at ${plan['interest']}%',
                        };
                        myplans.add(newval);
                      }

                      

                      return Container(
                          decoration: BoxDecoration(
                            color: mode.background2,
                          ),
                          child: Column(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: myHeight - 260,
                                  width: myWidth,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Container(
                                      height: myHeight - 260,
                                      child: ListView(
                                        children: [
                                          //first
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Stack(
                                            children: [
                                              Image.asset(
                                                'assets/images/savings_card.png',
                                                width: myWidth - 20,
                                                height: (myWidth - 20) / 3.978,
                                                fit: BoxFit.contain,
                                                filterQuality:
                                                    FilterQuality.low,
                                              ),
                                              Container(
                                                width: myWidth - 20,
                                                height: (myWidth - 20) / 3.978,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      'assets/images/circle_icon.png',
                                                      width: 54,
                                                      filterQuality:
                                                          FilterQuality.medium,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${name} / EA Savings Wallet',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14)),
                                                        Container(
                                                          width: myWidth - 108,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(account,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14)),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/naira.svg',
                                                                    height: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Text(balance,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
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

                                          SizedBox(
                                            height: 15,
                                          ),

                                          Text(
                                            'Select Plan',
                                            style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          SizedBox(
                                            height: 60,
                                            width: myWidth - 20,
                                            child: SelectFormField(
                                              items: myplans,
                                              controller: planCon,
                                              dialogTitle: 'Select Plan',
                                              enableSearch: true,
                                              type: SelectFormFieldType.dialog,
                                              onChanged: ((value) {
                                                setState(() {
                                                  planCon.text = value;
                                                });
                                              }),
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
                                                fillColor:
                                                    mode.selectfieldColor,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: mode
                                                                .fieldBorder)),
                                                suffixIcon: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 17, 0, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidCircle,
                                                    size: 7,
                                                    color: Color(0xff231E54),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: mode
                                                                .fieldBorder)),
                                              ),
                                              style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //second
                                          Text(
                                            'Amount',
                                            style: TextStyle(
                                                color: mode.dimText1,
                                                fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 60,
                                            width: myWidth - 20,
                                            child: TextField(
                                              controller: amountCon2,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [],
                                              onTapOutside: (event) {
                                                if (amountCon2.text != '') {
                                                  setState(() {
                                                    amountCon2.text =
                                                        humanizeNo(getNum(
                                                            amountCon2.text));
                                                  });
                                                }
                                              },
                                              onTap: () {
                                                setState(() {
                                                  amountCon2.value =
                                                      TextEditingValue(
                                                    text: amountCon2.text,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: amountCon2
                                                                .text.length),
                                                  );
                                                });
                                              },
                                              cursorColor: mode.background1,
                                              onChanged: (value) {
                                                if (value.isNotEmpty &&
                                                    !value.contains('.')) {
                                                  dynamic inivalue =
                                                      getNum(value);
                                                  String humanVal =
                                                      humanizeNo2(inivalue);
                                                  setState(() {
                                                    amountCon2.value =
                                                        TextEditingValue(
                                                      text: humanVal,
                                                      selection: TextSelection
                                                          .collapsed(
                                                              offset: humanVal
                                                                  .length),
                                                    );
                                                  });
                                                } else if (value
                                                    .contains('.')) {
                                                  String newval = '';
                                                  List strs = value.split('.');
                                                  if (strs[1].length > 2) {
                                                    String restred =
                                                        strs[1].substring(0, 2);
                                                    newval =
                                                        strs[0] + '.' + restred;
                                                  } else {
                                                    newval = value;
                                                  }

                                                  setState(() {
                                                    amountCon2.value =
                                                        TextEditingValue(
                                                      text: newval,
                                                      selection: TextSelection
                                                          .collapsed(
                                                              offset: newval
                                                                  .length),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 15, 0),
                                                      child: Text(
                                                        'NGN',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: mode.dimText1,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                alignLabelWithHint: false,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.8,
                                                            color: mode
                                                                .brightText1)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mode
                                                                .fieldBorder)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ReturnCon(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: myWidth - 20,
                                  child: Column(children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 50,
                                      width: myWidth - 20,
                                      child: continuebtn,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ]),
                                )
                              ],
                            )
                          ]));
                    } else {
                      Widget CustomLoader = RotationTransition(
                          turns: _animation,
                          child: Container(
                            child: SvgPicture.asset(
                              'assets/svg/loader_icon.svg',
                              height: 30,
                              width: 40,
                              color: const Color(0xffF6B41A),
                            ),
                          ));
                      Widget loading = Container(
                        height: myHeight - 175,
                        width: myWidth,
                        color: mode.background1,
                        child: Center(
                          child: CustomLoader,
                        ),
                      );
                      return loading;
                    }
                  }),
            ],
          );
        })));
  }
}
