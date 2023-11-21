import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'models/user.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';

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

class InvestmentScreen extends StatefulWidget {
  InvestmentScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

dynamic mode = mode;
int _index = 0;
bool _open = false;
bool investMode = false;
bool hidebal = false;

class _InvestmentScreenState extends State<InvestmentScreen>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

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

  Future mgetUser() async {
    dynamic got = await DatabaseHelper.instance.getUser();

    dynamic investment = await DatabaseHelper.instance.getInvestment();
    dynamic activity = await DatabaseHelper.instance.getActivity();

    return {
      'data': got,
      'investment': investment,
      'activity': activity,
    };
  }

  DateFormat dateFormat = DateFormat.yMMMMd();

  void initState() {
    super.initState();
    gethidebal();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('en');
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    String interestNo = '50,000';
    String percentNo = '2.0';
    String withdrawNo = '';

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

    return FutureBuilder(
        future: mgetUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data['data'];
            dynamic investments = snapshot.data['investment'];
            dynamic activities = snapshot.data['activity'];
            if (investments.length < 1) {
              investMode = false;
            } else {
              investMode = true;
            }
            if (investMode == true) {
              double mainport = 0;
              for (var invest in investments) {
                mainport += invest['balance'];
              }
              return Scaffold(
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;
                  double iniwidth;
                  if (myWidth > 600) {
                    iniwidth = 600;
                  } else {
                    iniwidth = myWidth;
                  }
                  interestNo = '';
                  double interes = 0;
                  for (var plan in investments) {
                    interes =
                        interes + (plan['invest_return'] - plan['balance']);
                  }
                  interestNo = humanizeNo(interes);
                  int withdrawNum = 0;
                  for (var act in activities) {
                    if (act['activity_type'] == 'withdraw') {
                      withdrawNum += 1;
                    }
                  }
                  withdrawNo = withdrawNum.toString();

                  Widget AccBal() {
                    if (myWidth < 768) {
                      if (hidebal == false) {
                        return Row(
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
                              humanizeNo(mainport),
                              style: TextStyle(
                                fontSize: iniwidth / 15,
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
                                fontSize: iniwidth / 15,
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
                              width: 7,
                            ),
                            Text(
                              humanizeNo(mainport),
                              style: TextStyle(
                                fontSize: 36,
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
                                fontSize: iniwidth / 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        );
                      }
                    }
                  }

                  double btnWidth = iniwidth * 55 / 100 - 41;
                  double btnWidth2 = iniwidth * 45 / 100 - 41;
                  double btnHeight = (iniwidth * 60 / 100) / 6;

                  //building custom widgets

                  //warning widget

                  Widget portfolio() {
                    if (_index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFFEFC9),
                            borderRadius: BorderRadius.circular(15)),
                        width: 133.3,
                        height: 35.2,
                        child: const TextButton(
                            onPressed: null,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                              child: Text(
                                'Portfolio',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffF6B41A)),
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
                                'Portfolio',
                                style: TextStyle(
                                    fontSize: 12, color: mode.dimText1),
                              ),
                            )),
                      );
                    }
                  }

                  Widget Topcard() {
                    if (myWidth < 768) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.263,
                            decoration: BoxDecoration(
                              color: const Color(0xff8F6400),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Builder(
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total Portfolio',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                investI = 5;
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: SvgPicture.asset(
                                                'assets/svg/pie.svg',
                                                height: myWidth * 7 / 100,
                                                width: myWidth * 7 / 100,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      AccBal(),
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
                                                        BorderRadius.circular(
                                                            29.87),
                                                    side: const BorderSide(
                                                      width: 0.6,
                                                      color: Color(0xffFFEFC9),
                                                    )),
                                                backgroundColor:
                                                    const Color(0xff9A7214),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(7,0,7,0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Interest:',
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffEEDDEE)),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '+',
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffEEDDEE)),
                                                    ),
                                                    Text(
                                                      interestNo,
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffEEDDEE)),
                                                    ),
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
                                                        BorderRadius.circular(
                                                            29.87),
                                                    side: const BorderSide(
                                                      width: 0.6,
                                                      color: Color(0xffFFEFC9),
                                                    )),
                                                backgroundColor:
                                                    const Color(0xff9A7214),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(7,0,7,0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Withdrawals:',
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffEEDDEE)),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      withdrawNo,
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffEEDDEE)),
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
                          ));
                    } //for tablets
                    else {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: myWidth - 20,
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xff8F6400),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Builder(
                                builder: (context) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 240,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Portfolio',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 10),
                                            AccBal(),
                                          ],
                                        ),
                                      ),
                                      //row for buttons
                                      Container(
                                        width: myWidth - 300,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              width:
                                                  ((myWidth - 300) * 50 / 100) -
                                                      10,
                                              child: TextButton(
                                                onPressed: null,
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              29.87),
                                                      side: const BorderSide(
                                                        width: 0.6,
                                                        color:
                                                            Color(0xffFFEFC9),
                                                      )),
                                                  backgroundColor:
                                                      const Color(0xff9A7214),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Interest:',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      Text(
                                                        interestNo,
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'at',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        percentNo,
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      const SizedBox(
                                                        width: 1,
                                                      ),
                                                      Text(
                                                        '%',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
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
                                              height: 50,
                                              width:
                                                  ((myWidth - 300) * 30 / 100) -
                                                      10,
                                              child: TextButton(
                                                onPressed: null,
                                                style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              29.87),
                                                      side: const BorderSide(
                                                        width: 0.6,
                                                        color:
                                                            Color(0xffFFEFC9),
                                                      )),
                                                  backgroundColor:
                                                      const Color(0xff9A7214),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Withdrawals:',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        withdrawNo,
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffEEDDEE)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  ((myWidth - 300) * 20 / 100),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 42,
                                                    height: 42,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          investI = 5;
                                                        });
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.zero,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: SvgPicture.asset(
                                                          'assets/svg/pie.svg',
                                                          height: 42,
                                                          width: 42,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      //end of buttons
                                    ],
                                  );
                                },
                              ),
                            ),
                          ));
                    }
                  }

                  Widget stocks() {
                    if (_index == 1) {
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFFEFC9),
                            borderRadius: BorderRadius.circular(15)),
                        width: 133.3,
                        height: 35.2,
                        child: const TextButton(
                            onPressed: null,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                              child: Text(
                                'Stocks',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffF6B41A)),
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
                                'Stocks',
                                style: TextStyle(
                                    fontSize: 12, color: mode.dimText1),
                              ),
                            )),
                      );
                    }
                  }

                  Widget Portwid() {
                    double portheight = 0;
                    if (myWidth < 768) {
                      portheight = myHeight - ((myWidth - 20) / 2.263) - 274.2;

                    } else {
                      portheight = myHeight - 414.2;
                    }
                    return SizedBox(
                      height: portheight,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          //only item
                          //active plans
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              'Active Plan(s)',
                              style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: SizedBox(
                                width: myWidth - 20,
                                height: investments.length.toDouble() * 64,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: investments.length,
                                    itemBuilder: (context, index) {
                                      int tenure = investments[index]["tenure"];
                                      double interes =
                                          investments[index]["interest"];
                                      String nametext =
                                          'Investment -  ${tenure}months @ ${interes}%';
                                      String realdate = dateFormat.format(
                                          DateTime.parse(
                                              investments[index]['date']));
                                      String datetxt = 'Due: ${realdate}';
                                      String amtstr = humanizeNo(
                                          investments[index]['balance']);
                                      return Container(
                                          height: 64,
                                          width: myWidth - 20,
                                          color: mode.background1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 20, 0),
                                                  child: SvgPicture.asset(
                                                    'assets/svg/naira_plant.svg',
                                                    height: 38,
                                                    width: 38,
                                                  ),
                                                ),
                                                Container(
                                                  width: (myWidth - 20) - 78,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              nametext,
                                                              style: TextStyle(
                                                                color: mode
                                                                    .brightText1,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Text(
                                                              datetxt,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffF6B41A),
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          ]),
                                                      Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  01, 0, 2, 0),
                                                          child: SvgPicture.asset(
                                                              'assets/svg/naira.svg',
                                                              color: mode
                                                                  .brightText1,
                                                              height: 16),
                                                        ),
                                                        Text(
                                                          amtstr,
                                                          style: TextStyle(
                                                            color: mode
                                                                .brightText1,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        )
                                                      ])
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    })),
                          ),
                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Text("Activities",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: mode.brightText1,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                                height: activities.length.toDouble() * 70,
                                decoration: BoxDecoration(
                                  color: mode.background2,
                                ),
                                child: ListView.builder(
                                    itemCount: activities.length,
                                    itemBuilder: (context, index) {
                                      String rename = activities[index]['name'];
                                      String amount = humanizeNo(
                                          activities[index]['amount']);
                                      Widget acticon() {
                                        if (activities[index]['activity_type']
                                                .toLowerCase() ==
                                            'invest') {
                                          return SvgPicture.asset(
                                            'assets/svg/deposit_arrow.svg',
                                            width: 47,
                                            height: 47,
                                          );
                                        } else {
                                          return Transform.rotate(
                                            angle: 20.3,
                                            child: SvgPicture.asset(
                                              'assets/svg/deposit_arrow.svg',
                                              width: 47,
                                              height: 47,
                                            ),
                                          );
                                        }
                                      }

                                      Widget textbdy() {
                                        if (activities[index]['activity_type']
                                                .toLowerCase() ==
                                            'invest') {
                                          return RichText(
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        'You’ve successfully activated ${rename}: ',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                                .notoSans()
                                                            .fontFamily,
                                                        color:
                                                            mode.brightText1)),
                                                TextSpan(
                                                    text: 'N ${amount}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                                .notoSans()
                                                            .fontFamily,
                                                        color: const Color(
                                                            0xff10B420))),
                                              ]));
                                        } else {
                                          return RichText(
                                              overflow: TextOverflow.clip,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        'You’ve successfully withdrawn ${rename}: ',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                                .notoSans()
                                                            .fontFamily,
                                                        color:
                                                            mode.brightText1)),
                                                TextSpan(
                                                    text: 'N ${amount}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: GoogleFonts
                                                                .notoSans()
                                                            .fontFamily,
                                                        color: const Color(
                                                            0xffB41020))),
                                              ]));
                                        }
                                      }

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(children: [
                                              acticon(),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: myWidth - 107,
                                                child: textbdy(),
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            width: myWidth - 20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 1,
                                                  width: myWidth - 40,
                                                  color:
                                                      const Color(0xffF0F0F0),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                          )
                        ],
                      ),
                    );
                  }

                  Widget getCon() {
                    //if portfolio
                    if (_index == 0) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //quick operations
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                'Quick Operations',
                                style: TextStyle(
                                  color: mode.brightText1,
                                  fontSize: 15,
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
                                          borderRadius:
                                              BorderRadius.circular(4.77)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('PayInvest');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/invest_plus.svg'),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Add plan',
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
                                          borderRadius:
                                              BorderRadius.circular(4.77)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('WithdrawInvest');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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

                            Portwid(),
                          ]);
                    } //if stocks
                    else {
                      double stockconheight = 0;
                      if (myWidth < 768) {
                        stockconheight =
                            myHeight - ((myWidth - 20) / 2.263) - 168.2;
                      } else {
                        stockconheight = myHeight - 305.2;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: stockconheight,
                          child: ListView(
                            children: [
                              //item 1
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                onPressed: () {
                                  setState(() {
                                    investI = 2;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: mode.background1,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Row(children: [
                                      Image.asset(
                                        'assets/images/icon.png',
                                        height: 90,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ELEVATE ALLIANCE INVESTMENT SAVINGS',
                                            style: TextStyle(
                                                fontSize: iniwidth / 35,
                                                color: mode.brightText1),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Up to ',
                                                style: TextStyle(
                                                    fontSize: iniwidth / 45,
                                                    color: mode.dimText1),
                                              ),
                                              Text(
                                                '13%',
                                                style: TextStyle(
                                                    fontSize: iniwidth / 45,
                                                    color: mode.brightText1),
                                              ),
                                              Text(
                                                ' returns in 12 months',
                                                style: TextStyle(
                                                    fontSize: iniwidth / 45,
                                                    color: mode.dimText1),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  height: 26,
                                                  width: 78,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffB0EDAB),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: const TextButton(
                                                    onPressed: null,
                                                    child: Center(
                                                      child: Text(
                                                        'Invest Now',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                '(with 50+ investors)',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                    color: Color(0xffF6B41A)),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }

                  //scaffold body starts here
                  return Container(
                    color: mode.background3,
                    child: RefreshIndicator(
                       displacement: 50,
                      onRefresh: regetdata,
                      child: SingleChildScrollView(
                         physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          color: mode.background3,
                          height: myHeight,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Investment Account',
                                        style: TextStyle(
                                            fontSize: 15.31, color: mode.brightText1),
                                      ),
                                      SizedBox(
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
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //top card
                                Topcard(),
                                //end of card
                                const SizedBox(
                                  height: 15,
                                ),
                                //spend or save
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      portfolio(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      stocks(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //spend or save container
                                getCon(),
                              ]),
                        ),
                      ),
                    ),
                  );
                })),
                floatingActionButton: floatingWidget(),
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
              );
            } else {
              return Scaffold(
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
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

                  //warning widget

                  Widget fakeWarn() {
                    return Container();
                  }

                  Widget TopCard() {
                    if (myWidth < 768) {
                      return (Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: (myWidth - 20) / 3.032,
                          decoration: BoxDecoration(
                            color: const Color(0xff8F6400),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                                double btnWidth = iniwidth * 65 / 100 - 40;
                                double btnHeight = (iniwidth * 60 / 100) / 6;
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You don’t have an Investment',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    ),
                                    Text(
                                      'Account with Elevate Alliance',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ));
                    } //for tablets
                    else {
                      return (Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xff8F6400),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                                double btnWidth = iniwidth * 65 / 100 - 40;
                                double btnHeight = (iniwidth * 60 / 100) / 6;
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You don’t have an Investment',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    ),
                                    Text(
                                      'Account with Elevate Alliance',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ));
                    }
                  }

                  //scaffold body starts here
                  return Container(
                    color: mode.background3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Investment Account',
                                  style: TextStyle(
                                      fontSize: 15.31, color: mode.brightText1),
                                ),
                                SizedBox(
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
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //top card
                          TopCard(),
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      padding: EdgeInsets.zero,
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 0,
                                      margin: EdgeInsets.fromLTRB(
                                          myWidth / 4, 0, myWidth / 4, 30),
                                      backgroundColor: mode.background1,
                                      duration: const Duration(seconds: 3),
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
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Request Sent!',
                                                  style: TextStyle(
                                                      color: mode.darkText1,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          'assets/svg/naira_plant.svg',
                                          width: 38,
                                        ),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffF6B41A),
                              ),
                              height: 105,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(children: [
                                    SvgPicture.asset(
                                        'assets/svg/circle_percent_invest.svg'),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: myWidth - 136,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Your best Investment Opportunities',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            textAlign: TextAlign.justify,
                                            'Elevate Alliance allows you to deposit & withdraw funds while earning interests on your deposits.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])),
                            ),
                          ),
                        ]),
                  );
                })),
                floatingActionButton: floatingWidget(),
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
              );
            }
          } else {
            return Scaffold(body:
                SafeArea(child: LayoutBuilder(builder: (context, constraints) {
              final myHeight = constraints.maxHeight;
              final myWidth = constraints.maxWidth;
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
                color: mode.background1,
                child: Center(
                  child: CustomLoader,
                ),
              );
              return loading;
            })));
          }
        });
  }
}
