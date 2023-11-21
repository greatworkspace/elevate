import 'package:elevate/home.dart';
import 'package:elevate/humanizeAmount.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
List targets = List.empty();

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
int targetD = 0;

class TargetSaving extends StatefulWidget {
  TargetSaving({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _TargetSavingState createState() => _TargetSavingState();
}

dynamic mode = mode;
bool hidebal = false;

class _TargetSavingState extends State<TargetSaving>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  void gethidebal() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? got = settings['hidebal'];
    if (got == 'true') {
      setState(() {
        hidebal = true;
      });
    } else {
      setState(() {
        hidebal = false;
      });
    }
  }

  void initState() {
    super.initState();
    gethidebal();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future mgetData() async {
    dynamic got = await DatabaseHelper.instance.getTarget();

    return {
      'data': got,
    };
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    String withdrawNo = '0';
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

    double interest = 0;
    for (var item in targets) {
      interest += item['balance'] * (item['interest'] / 100);
    }

    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          double iniwidth;
          if (myWidth > 600) {
            iniwidth = 600;
          } else {
            iniwidth = myWidth;
          }
          Widget AccBal() {
            double amm = 0;
            for (var item in targets) {
              amm += item['balance'];
            }
            String balance = humanizeNo(amm);
            if (myWidth < 768) {
              if (hidebal == false) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/naira.svg',
                      height: myWidth * 7.5 / 100,
                      width: myWidth * 7.5 / 100,
                    ),
                    const SizedBox(
                      width: 5.5,
                    ),
                    Text(
                      balance,
                      style: TextStyle(
                        fontSize: iniwidth / 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    Text(
                      '****',
                      style: TextStyle(
                        fontSize: iniwidth / 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              }
            } //for tablets
            else {
              if (hidebal == false) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/naira.svg',
                      height: 46,
                    ),
                    const SizedBox(
                      width: 5.5,
                    ),
                    Text(
                      balance,
                      style: TextStyle(
                        fontSize: iniwidth / 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    Text(
                      '****',
                      style: TextStyle(
                        fontSize: iniwidth / 19,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              }
            }
          }

          //building custom widgets
          //targets

          //warning widget

          Widget fakeWarn() {
            return Container();
          }

          double warnheight = 0;
          if (myWidth < 768) {
            warnheight = (myWidth / 3.2) + 5;
          } else {
            warnheight = 130;
          }

          Widget realWarn() {
            return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Container(
                  height: warnheight,
                  width: myWidth - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffC1FFD3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: myWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'What is Target Savings?',
                                style: TextStyle(
                                    color: const Color(0xff14684A),
                                    fontSize: iniwidth / 38,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 50,
                                height: 19,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        warnText = false;
                                      });
                                    },
                                    child: SizedBox(
                                      width: 50,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              FaIcon(
                                                FontAwesomeIcons.xmark,
                                                color: Color(0xff14684A),
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(
                            'This gives you the privilege of saving on a long term to aid the purpose of saving which might be a car, a piece of land or any other just cause. Interest will be accrued on savings only after 30 days of constant saving, meaning there will be no interest on the first 30 days. The interest rate shall be 1.5% on savings amount per month. Threshold is a minimum of N1,000 per day or N30,000 per month.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: const Color(0xff14684A),
                                fontSize: iniwidth / 40,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }

          Widget warnWidget() {
            return warnText == true ? realWarn() : fakeWarn();
          }

          Widget TopCard() {
            if (myWidth < 768) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: myWidth - 20,
                  height: (myWidth - 20) / 2.263,
                  decoration: BoxDecoration(
                      color: const Color(0xff14684A),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: const Color(0xff579668))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) {
                        double iniwidth;
                        if (myWidth > 600) {
                          iniwidth = 600;
                        } else {
                          iniwidth = myWidth;
                        }
                        double btnWidth = iniwidth * 58 / 100 - 41;
                        double btnWidth2 = iniwidth * 42 / 100 - 41;
                        double btnHeight = (iniwidth * 60 / 100) / 7;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: iniwidth / 30,
                            ),
                            const Text(
                              'Total Balance',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            AccBal(),
                            const SizedBox(
                              height: 8,
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
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Total Interest:',
                                            style: TextStyle(
                                              fontSize: iniwidth / 45,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          
                                          SvgPicture.asset(
                                            'assets/svg/naira.svg',
                                            height: iniwidth / 31.5,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            humanizeNo(interest),
                                            style: TextStyle(
                                                fontSize: iniwidth / 45,
                                                color: const Color(0xffEEDDEE)),
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
                ),
              );
            } //for tablets
            else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: myWidth - 20,
                  height: 140,
                  decoration: BoxDecoration(
                      color: const Color(0xff14684A),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: const Color(0xff579668))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) {
                        double iniwidth;
                        if (myWidth > 600) {
                          iniwidth = 600;
                        } else {
                          iniwidth = myWidth;
                        }
                        double btnWidth = iniwidth * 58 / 100 - 41;
                        double btnWidth2 = iniwidth * 42 / 100 - 41;
                        double btnHeight = (iniwidth * 60 / 100) / 7;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Balance',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  AccBal(),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 20,
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
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Total Interest:',
                                            style: TextStyle(
                                              fontSize: iniwidth / 45,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          
                                          SvgPicture.asset(
                                            'assets/svg/naira.svg',
                                            height: iniwidth / 31.5,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            humanizeNo(interest),
                                            style: TextStyle(
                                                fontSize: iniwidth / 45,
                                                color: const Color(0xffEEDDEE)),
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
                ),
              );
            }
          }

          double conheight = 0;
          if (myWidth < 768) {
            conheight = myHeight - 90 - (myWidth - 20) / 2.263;
          } else {
            conheight = myHeight - 225;
          }

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
                                  savingsI = 1;
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
                          'Target savings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mode.brightText1,
                              fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SizedBox(
                            height: 25,
                            width: 50,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('Notifications');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.bell,
                                    size: 20,
                                    color: mode.brightText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: mgetData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        targets = snapshot.data['data'];

                        List<Widget> AllTargets() {
                          List<Widget> targetwids = [];
                          for (var item in targets) {
                            Widget container = Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    targetD = item['id'];
                                    savingsI = 5;
                                  });
                                },
                                child: Container(
                                  height: 76,
                                  width: myWidth - 20,
                                  decoration: BoxDecoration(
                                      color: mode.background2,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/target_icon.svg',
                                          height: 56,
                                          width: 56,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: myWidth - 109,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['name'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: mode.brightText1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    humanizeNo(item['balance']),
                                                    style: const TextStyle(
                                                        fontSize: 9.5,
                                                        color:
                                                            Color(0xff23AA59)),
                                                  ),
                                                  Text(
                                                    humanizeNo(item['target']),
                                                    style: TextStyle(
                                                      fontSize: 9.5,
                                                      color: mode.brightText1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 5,
                                                width: myWidth - 109,
                                                decoration: BoxDecoration(
                                                    color: mode.barBackground),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 5,
                                                      width: (item['balance'] /
                                                              item['target']) *
                                                          (myWidth - 109),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xff23AA59),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          5))),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            targetwids.add(container);
                          }

                          return targetwids;
                        }

                        return Column(children: [
                          const SizedBox(
                            height: 15,
                          ),
                          //top card
                          TopCard(),
                          //card end
                          const SizedBox(
                            height: 5,
                          ),
                          //warn text
                          SizedBox(
                              height: conheight,
                              child: ListView(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: warnWidget(),
                                ),
                                //targets
                                Column(
                                  children: AllTargets(),
                                ),

                                //create target
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context)
                                            .pushNamed('CreateTarget1');
                                      });
                                    },
                                    child: Container(
                                      height: 78,
                                      width: myWidth - 20,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff23AA59),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/create_target.svg',
                                              height: 38,
                                              width: 38,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: myWidth - 89.2,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Create a new target',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Generate a personal saving goal e.g Rent, Gadgets.',
                                                        style: TextStyle(
                                                            fontSize: 9.5,
                                                            letterSpacing: 0.2,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //create target end
                                const SizedBox(
                                  height: 20,
                                )
                              ]))
                        ]);
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
                          height: myHeight - 65,
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
            ),
          );
        })));
  }
}
