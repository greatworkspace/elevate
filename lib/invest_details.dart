// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';

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

bool loaded = false;
bool warnText = true;

dynamic shakey = KeyClass.shakeKey1;



class InvestDetails extends StatefulWidget {
  InvestDetails({
    super.key,
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _InvestDetailsState createState() => _InvestDetailsState();
}

dynamic mode = mode;
bool investMode = false;

class _InvestDetailsState extends State<InvestDetails> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();





  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    String interestNo = '50,000';
    String percentNo = '2.0';
    String withdrawNo = '4';

    Widget floatingWidget() {
      return TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('UploadDocument');
          },
          child: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: 1,
              child: SvgPicture.asset('assets/svg/floating_invest.svg')));
    }

    if (investMode == true) {
      return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          double iniwidth;
          if (myWidth > 600) {
            iniwidth = 600;
          } else {
            iniwidth = myWidth;
          }
          double btnWidth = iniwidth * 55 / 100 - 41;
          double btnWidth2 = iniwidth * 45 / 100 - 41;
          double btnHeight = (iniwidth * 60 / 100) / 6;

          //building custom widgets

          //scaffold body starts here
          return Container(
            color: mode.background3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 65,
                decoration: BoxDecoration(
                  color: mode.background3,
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
                              setState(() {
                                investI = 1;
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
                      Container(
                        child: Text("EA Investment Savings",
                            style: TextStyle(
                              fontSize: 15,
                              color: mode.brightText1,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //top card
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    width: myWidth - 20,
                    height: (myWidth - 20) / 2.263,
                    decoration: BoxDecoration(
                      color: const Color(0xffF6B41A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Builder(
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Portfolio',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/pie.svg',
                                    height: myWidth * 7.5 / 100,
                                    width: myWidth * 7.5 / 100,
                                  )
                                ],
                              ),
                              const Text(
                                '(ends in 9 months)',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/naira.svg',
                                    height: myWidth * 8.5 / 100,
                                    width: myWidth * 8.5 / 100,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    '50,000',
                                    style: TextStyle(
                                      fontSize: iniwidth / 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //row for buttons
                              Row(
                                children: [
                                  SizedBox(
                                    height: btnHeight,
                                    width: btnWidth,
                                    child: TextButton(
                                      onPressed: null,
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.87),
                                            side: const BorderSide(
                                              width: 0.6,
                                              color: Colors.white,
                                            )),
                                        backgroundColor:
                                            const Color(0xff9A7214),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Interest:',
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '+',
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            Text(
                                              interestNo,
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'at',
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              percentNo,
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            const SizedBox(
                                              width: 1,
                                            ),
                                            Text(
                                              '%',
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: btnHeight,
                                    width: btnWidth2,
                                    child: TextButton(
                                      onPressed: null,
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.87),
                                            side: const BorderSide(
                                              width: 0.6,
                                              color: Colors.white,
                                            )),
                                        backgroundColor:
                                            const Color(0xff9A7214),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Withdrawals:',
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              withdrawNo,
                                              style: TextStyle(
                                                  fontSize: iniwidth / 42,
                                                  color:
                                                      const Color(0xffEEDDEE)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //end of buttons
                            ],
                          );
                        },
                      ),
                    ),
                  )),
              //end of card
              const SizedBox(
                height: 15,
              ),

              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    //quick operations
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        'Quick Operations',
                        style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SizedBox(
                        width: 296,
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 92,
                              decoration: BoxDecoration(
                                  color: mode.background1,
                                  borderRadius: BorderRadius.circular(4.77)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('PayInvest');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/invest_plus.svg'),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'Add money',
                                        style: TextStyle(
                                            fontSize: 11.45,
                                            color: mode.brightText1),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 80,
                              width: 92,
                              decoration: BoxDecoration(
                                  color: mode.background1,
                                  borderRadius: BorderRadius.circular(4.77)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('WithdrawInvest');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/savings_withdraw.svg'),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'Withdraw',
                                        style: TextStyle(
                                            fontSize: 11.45,
                                            color: mode.brightText1),
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
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Activities",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        height: myHeight - ((myWidth - 20) / 2.263) - 280.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: mode.background2,
                        ),
                        child: ListView(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(children: [
                                  SvgPicture.asset(
                                    'assets/svg/deposit_arrow.svg',
                                    width: 47,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: myWidth - 107,
                                    child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  'You’ve successfully added ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1)),
                                          TextSpan(
                                              text: 'N 50,000',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color:
                                                      const Color(0xff10B420))),
                                          TextSpan(
                                              text: ' to your deposit.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1))
                                        ])),
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: myWidth - 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: myWidth - 80,
                                    color: const Color(0xffF0F0F0),
                                  )
                                ],
                              ),
                            ),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(children: [
                                  SvgPicture.asset(
                                    'assets/svg/deposit_arrow.svg',
                                    width: 47,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: myWidth - 107,
                                    child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  'You’ve successfully added ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1)),
                                          TextSpan(
                                              text: 'N 50,000',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color:
                                                      const Color(0xff10B420))),
                                          TextSpan(
                                              text: ' to your deposit.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1))
                                        ])),
                                  )
                                ]),
                              ),
                            ),
                            SizedBox(
                              width: myWidth - 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: myWidth - 80,
                                    color: const Color(0xffF0F0F0),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(children: [
                                  SvgPicture.asset(
                                    'assets/svg/deposit_arrow.svg',
                                    width: 47,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: myWidth - 107,
                                    child: RichText(
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  'You’ve successfully added ',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1)),
                                          TextSpan(
                                              text: 'N 50,000',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color:
                                                      const Color(0xff10B420))),
                                          TextSpan(
                                              text: ' to your deposit.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      GoogleFonts.notoSans()
                                                          .fontFamily,
                                                  color: mode.brightText1))
                                        ])),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ])),
            ]),
          );
        })),
        floatingActionButton: floatingWidget(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    } else {
      return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myWidth = constraints.maxWidth;
          if (myWidth > 600) {
          } else {
          }

          //building custom widgets

          //scaffold body starts here
          return Container(
            color: mode.background3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Investment Account',
                      style:
                          TextStyle(fontSize: 15.31, color: mode.brightText1),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('Notifications');
                          },
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('Notifications');
                              },
                              child: FaIcon(
                                FontAwesomeIcons.bell,
                                size: 20,
                                color: mode.brightText1,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //top card
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: myWidth - 20,
                  height: (myWidth - 20) / 3.032,
                  decoration: BoxDecoration(
                      color: const Color(0xff8F6400),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: const Color(0xff955796))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) {
                        if (myWidth > 600) {
                        } else {
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You don’t have an Investment',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xffE0F5E9)),
                            ),
                            const Text(
                              'Account with Elevate Alliance',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xffE0F5E9)),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              //top card ends
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: mode.background1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 95,
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.zero,
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          margin: EdgeInsets.fromLTRB(
                              myWidth / 4, 0, myWidth / 4, 30),
                          backgroundColor: mode.background1,
                          duration: const Duration(seconds: 3),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          content: Container(
                            width: myWidth / 2,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: mode.floatBg,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Request Sent!',
                                      style: TextStyle(
                                          color: mode.darkText1,
                                          fontWeight: FontWeight.bold),
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
                        ));
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(children: [
                            SvgPicture.asset('assets/svg/naira_plant.svg'),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: myWidth - 109,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Send an Application for Elevate ',
                                        style: TextStyle(
                                            color: mode.brightText1,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'Alliance Investment Account',
                                        style: TextStyle(
                                            color: mode.brightText1,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    ),
                  ),
                ),
              ),
            ]),
          );
        })),
        floatingActionButton: floatingWidget(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }
}
