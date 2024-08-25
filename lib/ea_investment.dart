// ignore_for_file: unused_element, unused_local_variable, must_be_immutable

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
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

final List<Map<String, dynamic>> _languages = [
  {
    'value': 'English',
    'label': 'English',
  },
  {
    'value': 'French',
    'label': 'French',
  }
];

final List<Map<String, dynamic>> _modes = [
  {
    'value': 'Dark',
    'label': 'Dark Mode',
  },
  {
    'value': 'Light',
    'label': 'Light Mode',
  }
];

bool warnText = true;
int _index = 0;

class EaInvestment extends StatefulWidget {
  EaInvestment({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _EaInvestmentState createState() => _EaInvestmentState();
}

dynamic mode = mode;

class _EaInvestmentState extends State<EaInvestment> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

  void gethidebal() async {
    Map sets = await DatabaseHelper.instance.getSettings();
    String? got = sets['hidebal'];
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
    gethidebal();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    String interestNo = '9,000';
    String percentNo = '1.5';

    bool inivalue;

    Widget HideBalSwitch() {
      if (hiddenbalCon.text == 'true') {
        inivalue = true;
      } else {
        inivalue = false;
      }

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
          activeColor: const Color(0xffD9D9D9),
          trackColor: const Color(0xffD9D9D9),
          thumbColor: mode.thumbColor,
        ),
      );
    }

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

      //building custom widgets

      Widget realcontinue = TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('InvestApplication');
        },
        child: const Text(
          'Invest',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffF6B41A)),
        ),
      );

      Widget summary() {
        if (_index == 0) {
          return Container(
            decoration: BoxDecoration(
                color: const Color(0xffF6B41A),
                borderRadius: BorderRadius.circular(15)),
            width: 133.3,
            height: 35.2,
            child: const TextButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    'Summary',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )),
          );
        } else {
          return SizedBox(
            width: 133.3,
            height: 35.2,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    'Summary',
                    style: TextStyle(fontSize: 12, color: mode.dimText1),
                  ),
                )),
          );
        }
      }

      Widget detail() {
        if (_index == 1) {
          return Container(
            decoration: BoxDecoration(
                color: const Color(0xffF6B41A),
                borderRadius: BorderRadius.circular(15)),
            width: 133.3,
            height: 35.2,
            child: const TextButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )),
          );
        } else {
          return SizedBox(
            width: 133.3,
            height: 35.2,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 12, color: mode.dimText1),
                  ),
                )),
          );
        }
      }

      List<Widget> getCon() {
        //if portfolio
        if (_index == 0) {
          return [
            //item 1
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: 80,
                width: myWidth - 20,
                decoration: BoxDecoration(
                  color: const Color(0xffFFEFC9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/exp_returns.svg'),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Expected Returns',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF6B41A),
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Maximum of 12.5% in 12 months',
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //item 2
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: 80,
                width: myWidth - 20,
                decoration: BoxDecoration(
                  color: const Color(0xffFFEFC9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/investment_type.svg'),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Investment Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF6B41A),
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Fixed',
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //item 3
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: 80,
                width: myWidth - 20,
                decoration: BoxDecoration(
                  color: const Color(0xffFFEFC9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/maturity_date.svg'),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Maturity Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF6B41A),
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Between 1 to 12 months',
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            //item 4
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: 80,
                width: myWidth - 20,
                decoration: BoxDecoration(
                  color: const Color(0xffFFEFC9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/payout_type.svg'),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Payout Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF6B41A),
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Interest + Capital',
                            style: TextStyle(
                              color: Color(0xff616161),
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ];
        } else {
          return [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xffF6B41A),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The investment savings service shall allow for big and small investors alike have a fixed deposit plan with ELEVATE ALLIANCE NIG. LTD. The interest rate on each depositor’s deposit shall be a function of the number of months the deposit shall be termed fixed. Also, there shall be a particular threshold (of #50,000) that the deposit is expected to reach before it can qualify for an interest incentive.',
                    style: TextStyle(
                      fontSize: 13,
                      color: mode.brightText1,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xffFFEFC9),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interest Rate',
                      style: TextStyle(
                        color: Color(0xffF6B41A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Below is the interest rate on deposit chart',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'One(1) month',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/long_arrow.svg',
                              )
                            ],
                          ),
                        ),
                        Text(
                          '1.5%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Two(2) month',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/long_arrow.svg',
                              )
                            ],
                          ),
                        ),
                        Text(
                          '2.0%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Three(3) month',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/long_arrow.svg',
                              )
                            ],
                          ),
                        ),
                        Text(
                          '5.0%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Text(
                                'Six(6) months',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/svg/long_arrow.svg',
                            )
                          ],
                        ),
                        Text(
                          '8.5%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Nine(9) months',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/long_arrow.svg',
                              )
                            ],
                          ),
                        ),
                        Text(
                          '10.0%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  'Twelve(12) months',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/long_arrow.svg',
                              )
                            ],
                          ),
                        ),
                        Text(
                          '12.5%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.justify,
                      'NOTE: This interest rate is subject to the prevailing and current market interest rate as benchmarked by the Central Bank of Nigeria.',
                      style: TextStyle(
                        fontSize: 11,
                        color: mode.dimText1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ];
        }
      }

      //scaffold body starts here
      return Container(
          decoration: BoxDecoration(
            color: mode.background3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                ),
              ),
              Container(
                  height: 171,
                  width: myWidth,
                  color: const Color(0xffF6B41A),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon.png',
                        height: 90,
                        width: 90,
                      )
                    ],
                  )),
              Container(
                color: mode.background1,
                width: myWidth,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EA INVESTMENT SAVINGS',
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Interest on ',
                            style: TextStyle(
                              color: mode.dimText2,
                              fontSize: 13,
                              fontFamily: GoogleFonts.notoSans().fontFamily,
                            )),
                        TextSpan(
                            text: 'N 50,000',
                            style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 13,
                              fontFamily: GoogleFonts.notoSans().fontFamily,
                            )),
                        TextSpan(
                            text: ' above',
                            style: TextStyle(
                              color: mode.dimText2,
                              fontSize: 13,
                              fontFamily: GoogleFonts.notoSans().fontFamily,
                            ))
                      ])),
                    ],
                  ),
                ),
              ),
              //summary or details
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    summary(),
                    const SizedBox(
                      width: 10,
                    ),
                    detail(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //spend or save container

              Container(
                height: myHeight - 374.2,
                color: mode.background1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListView(
                    children: getCon(),
                  ),
                ),
              ),
            ],
          ));
    })));
  }
}
