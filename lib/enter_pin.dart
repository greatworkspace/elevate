import 'package:elevate/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'models/databaseHelper.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'savings_transfer.dart';
import 'pay_invest2.dart';
import 'humanizeAmount.dart';

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

class EnterPin extends StatefulWidget {
  @override
  _EnterPinState createState() => _EnterPinState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

class _EnterPinState extends State<EnterPin>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  late Timer _timer;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final pinCon = TextEditingController();
  final fromCon = TextEditingController();
  final toCon = TextEditingController();
  final amountCon = TextEditingController();
  final narateCon = TextEditingController();
  void getpara() async {
    Map sets = await DatabaseHelper.instance.getSettings();
    String? myfrom = sets['fromText'];
    String? myto = sets['toText'];
    String? myamount = sets['amountText'];
    ;
    String? mynarate = sets['narateText'];
    ;
    setState(() {
      fromCon.text = myfrom!;
      toCon.text = myto!;
      amountCon.text = myamount!;
      narateCon.text = mynarate!;
    });
  }

  String pinState = 'unfilled';
  Widget OverCon = Container();
  Widget Wrongpin = Container();
  Widget Correctpin = Container();
  Widget Failedtrans = Container();
  Widget Networkerror = Container();

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

  Future maketrans() async {
    if (action == 'transfer') {
      String url = apiUrl + 'make/transfer/';
      dynamic token = await DatabaseHelper.instance.getToken();
      Response res2 = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'token': token,
          'pin': pinCon.text,
          'amount': getNum(amountCon.text).toString(),
          'account': accNo,
          'note': narateCon.text,
        },
        body: (<String, String>{}),
      );
      if (res2.statusCode == 200) {
        Map data = json.decode(res2.body);
        if (data['error'] == 'incorrect pin') {
          setState(() {
            OverCon = Wrongpin;
          });
        }
        if (data['result'] == 'success') {
          regetdata();
          setState(() {
            OverCon = Correctpin;
          });
        } else {
          setState(() {
            OverCon = Failedtrans;
          });
        }
      } else {
        setState(() {
          OverCon = Container();
        });
      }
    } else if (action == 'buyplan') {
      if (pl != -1) {
        int planid = mplans[pl]['id'];
        String url = apiUrl + 'buy/plan/';
        dynamic token = await DatabaseHelper.instance.getToken();
        Response res2 = await post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'token': token,
            'pin': pinCon.text,
            'amount': getNum(amountCon.text).toString(),
            'plan': planid.toString(),
            'note': narateCon.text,
          },
          body: (<String, String>{}),
        );
        if (res2.statusCode == 200) {
          Map data = json.decode(res2.body);
          if (data['error'] == 'incorrect pin') {
            setState(() {
              OverCon = Wrongpin;
            });
          }
          if (data['result'] == 'success') {
            regetdata();
            setState(() {
              OverCon = Correctpin;
            });
          } else {
            setState(() {
              OverCon = Failedtrans;
            });
          }
        } else {
          print('error');
          setState(() {
            OverCon = Container();
          });
        }
      } else {
        setState(() {
          OverCon = Failedtrans;
        });
      }
    } else if (action == 'payloan') {
      String url = apiUrl + 'make/installment/';
      dynamic token = await DatabaseHelper.instance.getToken();
      Response res2 = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'token': token,
          'pin': pinCon.text,
        },
        body: (<String, String>{}),
      );
      if (res2.statusCode == 200) {
        Map data = json.decode(res2.body);
        if (data['error'] == 'incorrect pin') {
          setState(() {
            OverCon = Wrongpin;
          });
        }
        if (data['result'] == 'success') {
          regetdata();
          setState(() {
            OverCon = Correctpin;
          });
        } else {
          setState(() {
            OverCon = Failedtrans;
          });
        }
      } else {
        print('error');
        setState(() {
          OverCon = Container();
        });
      }
    } else if (action == 'target') {
      String url = apiUrl + 'pay/target/';
      dynamic token = await DatabaseHelper.instance.getToken();
      Response res2 = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'token': token,
          'pin': pinCon.text,
          'amount': getNum(amountCon.text).toString(),
          'id': ToWhere,
          'note': narated,
        },
        body: (<String, String>{}),
      );
      if (res2.statusCode == 200) {
        dynamic data = json.decode(res2.body);
        if (data['error'] == 'incorrect pin') {
          setState(() {
            OverCon = Wrongpin;
          });
        }
        if (data['result'] == 'success') {
          regetdata();
          setState(() {
            OverCon = Correctpin;
          });
        } else {
          setState(() {
            OverCon = Failedtrans;
          });
        }
      } else {
        print('error');
        setState(() {
          OverCon = Container();
        });
      }
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    getpara();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          // creating custom widgets

          Widget Unfilled() {
            return Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffD9D9D9)),
            );
          }

          Widget Filled() {
            return Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xff46A623)),
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffC1FFD3)),
            );
          }

          Widget Falsefilled() {
            return Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.red),
            );
          }

          Widget Filled1 = Unfilled();
          Widget Filled4 = Unfilled();
          Widget Filled3 = Unfilled();
          Widget Filled2 = Unfilled();
          //timer function

          Wrongpin = Container(
              height: myHeight,
              width: myWidth,
              color: mode.background2,
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_incorrect.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Incorrect Pin',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          child: SizedBox(
                            height: 54,
                            width: myWidth - 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff23AA59),
                                ),
                                onPressed: () {
                                  setState(() {
                                    pinCon.text = '';
                                    pinState = 'unfilled';
                                    OverCon = Container();
                                  });
                                },
                                child: const Text(
                                  'Try Again',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Failedtrans = Container(
              height: myHeight,
              width: myWidth,
              color: mode.background2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_failed.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Transaction Failed',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 54,
                                width: myWidth - 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xff23AA59),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        pinCon.text = '';
                                        pinState = 'unfilled';
                                        OverCon = Container();
                                      });
                                    },
                                    child: const Text(
                                      'Try Again',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 54,
                                width: myWidth - 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: mode.background2,
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    index: selectedindex,
                                                  )));
                                    },
                                    child: Text(
                                      'Back to HomePage',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: mode.brightText1,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Networkerror = Container(
              height: myHeight,
              width: myWidth,
              color: mode.background2,
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_network.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Network Error',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          child: SizedBox(
                            height: 54,
                            width: myWidth - 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff23AA59),
                                ),
                                onPressed: () {
                                  setState(() {
                                    pinCon.text = '';
                                    pinState = 'unfilled';
                                    OverCon = Container();
                                  });
                                },
                                child: const Text(
                                  'Try Again',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Correctpin = Container(
              height: myHeight,
              width: myWidth,
              color: mode.background2,
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_sent.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Request Sent',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          child: Container(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: mode.background2,
                                ),
                                onPressed: () {
                                  setState(() {});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                                index: selectedindex,
                                              )));
                                },
                                child: Text(
                                  'Back to HomePage',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mode.brightText1,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          void startPinTimer() {
            const twoSec = const Duration(seconds: 2);
            _timer = Timer(
              twoSec,
              () {
                Filled1 = Unfilled();
                Filled2 = Unfilled();
                Filled3 = Unfilled();
                Filled4 = Unfilled();

                if (pinCon.text == '1234') {
                  setState(() {
                    pinState = 'correct';
                  });
                } else {
                  setState(() {
                    pinState = 'incorrect';
                  });
                }
                if (pinState == 'incorrect') {
                  Widget container = Container(
                      height: myHeight,
                      width: myWidth,
                      color: mode.background2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: myHeight / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                    'assets/svg/request_incorrect.svg'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Incorrect Pin',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: mode.brightText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: myHeight / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 100),
                                  child: SizedBox(
                                    height: 54,
                                    width: myWidth - 40,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff23AA59),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            pinCon.text = '';
                                            pinState = 'unfilled';
                                            OverCon = Container();
                                          });
                                        },
                                        child: const Text(
                                          'Try Again',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                  OverCon = container;
                } else if (pinState == 'correct') {
                  Widget container = Container(
                      height: myHeight,
                      width: myWidth,
                      color: mode.background2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: myHeight / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset('assets/svg/request_sent.svg'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Request Sent',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: mode.brightText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: myHeight / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 100),
                                  child: Container(
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(20),
                                          backgroundColor: mode.background2,
                                        ),
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                        index: selectedindex,
                                                      )));
                                        },
                                        child: Text(
                                          'Back to HomePage',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: mode.brightText1,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                  OverCon = container;
                }
              },
            );
          }

          if (pinCon.text.length <= 3) {
            if (pinCon.text.length >= 1) {
              Filled1 = Filled();
            }
            if (pinCon.text.length >= 2) {
              Filled2 = Filled();
            }
            if (pinCon.text.length >= 3) {
              Filled3 = Filled();
            }
          }

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
            height: myHeight,
            width: myWidth,
            color: mode.loadingBg,
            child: Center(
              child: CustomLoader,
            ),
          );

          Future getreq() async {
            OverCon = loading;
            await maketrans();
          }

          double greenConHeight;
          greenConHeight = myHeight - 538;
          if (greenConHeight > 155) {
            greenConHeight = 155;
          }
          if (greenConHeight < 0) {
            greenConHeight = 0;
          }

          //scaffold body starts here
          return Stack(
            children: [
              Container(
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
                      width: myWidth,
                      decoration: BoxDecoration(color: mode.background3),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                            //green container
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffE5FFED),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffD9D9D9)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: SizedBox(
                                  height: greenConHeight,
                                  child: ListView(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: mode.background1,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 26,
                                              width: 70,
                                              child: Center(
                                                child: Text(
                                                  'Summary',
                                                  style: TextStyle(
                                                      color: mode.brightText1,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'From:',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                ),
                                                Text(
                                                  fromCon.text,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Container(
                                              width: myWidth,
                                              height: 0.5,
                                              color: const Color(0xff46C252),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'To:',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                ),
                                                Text(
                                                  toCon.text,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Container(
                                              width: myWidth,
                                              height: 0.5,
                                              color: const Color(0xff46C252),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Amount:',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                ),
                                                Text(
                                                  'N ${amountCon.text}',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Container(
                                              width: myWidth,
                                              height: 0.5,
                                              color: const Color(0xff46C252),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Naration:',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                ),
                                                Text(
                                                  narateCon.text,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: mode.dimText1),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Input Transaction Pin',
                              style: TextStyle(
                                fontSize: 15,
                                color: mode.brightText1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SvgPicture.asset(
                              'assets/svg/pin.svg',
                              height: 28,
                              width: 28,
                              color: mode.brightText1,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          color: mode.background3,
                          child: Container(
                            height: myHeight - greenConHeight - 245,
                            width: myWidth,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: mode.background1,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 20, 40, 20),
                              child: Column(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 20,
                                      width: 105,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mode.background3,
                                      ),
                                      child: Center(
                                          child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Filled1,
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Filled2,
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Filled3,
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Filled4
                                        ],
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //row 1 of digits
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}1';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}2';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}3';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          ))
                                    ],
                                  ), //row 2 of digits
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}4';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '4',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}5';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '5',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}6';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '6',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //row 3 of digits
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}7';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '7',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}8';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '8',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}9';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '9',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  //row 4 of digits
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: null,
                                          child: Text(
                                            ' ',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              pinCon.text = '${pinCon.text}0';
                                            });
                                            if (pinCon.text.length >= 4) {
                                              await getreq();
                                            }
                                          },
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: mode.brightText1,
                                            ),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              pinCon.text = pinCon.text
                                                  .substring(0,
                                                      pinCon.text.length - 1);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.arrow_back,
                                            size: 28,
                                            color: Color(0xff23AA59),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ])),
              OverCon,
            ],
          );
        })));
  }
}
