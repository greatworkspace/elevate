import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';

List loanProducts = List.empty();
final myhomecardcontroller = ScrollController();
double homecardpos = 0.0;
int homecardindex = 1;
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

class MainScreen extends StatefulWidget {
  MainScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;
  @override
  _MainScreenState createState() => _MainScreenState();
}

dynamic loanpi = -1;
dynamic mode = mode;
bool _open = false;
bool loanMode = false;

class _MainScreenState extends State<MainScreen>
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

  int _index = 0;

  DateFormat dateFormat = DateFormat.yMMMMd();

  Future mgetUser() async {
    dynamic got = await DatabaseHelper.instance.getUser();
    dynamic loan = await DatabaseHelper.instance.getLoan();
    dynamic installments = await DatabaseHelper.instance.getInstallment();
    dynamic loanP = await DatabaseHelper.instance.getLoanP();

    return {
      'data': got,
      'loan': loan,
      'installments': installments,
      'loanP': loanP,
    };
  }

  void initState() {
    super.initState();
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

    Widget floatingWidget() {
      return TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('UploadDocument');
          },
          child: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: 1,
              child: SvgPicture.asset('assets/svg/floating_home.svg')));
    }

    return FutureBuilder(
        future: mgetUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data['data'];
            String imageurl = 'assets/images/default_pic.png';
            if (user.image != '' || user.image != null) {
              imageurl = user.image;
            }
            
            dynamic loan = snapshot.data['loan'];
            if (loan['id'] == null) {
              loanMode = false;
            } else {
              loanMode = true;
            }
            dynamic installs = snapshot.data['installments'];
            loanProducts = snapshot.data['loanP'];
            dynamic installments = installs.reversed.toList();
            String hello = 'Hello, ' + user.firstname;
            
            if (loanMode == false) {
              return Scaffold(
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;
                  double subfontwidth = myWidth / 37;
                  double subfontwidth2 = myWidth / 26;
                  if (subfontwidth > 11.55) {
                    subfontwidth = 11.55;
                  }
                  if (myWidth > 767) {
                    double subfontwidth = myWidth / 37;
                    double subfontwidth2 = myWidth / 26;
                    if (subfontwidth > 11.55) {
                      subfontwidth = 11.55;
                    }
                  }

                  //card index function
                  Widget cardindex() {
                    if (homecardindex == 1) {
                      return SizedBox(
                        width: myWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: const Color(0xff231E54),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (homecardindex == 2) {
                      return SizedBox(
                        width: myWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: const Color(0xff231E54),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: myWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: mode.fieldColor,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 5,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: const Color(0xff231E54),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }

                  Widget realCardIndex() {
                    if (myWidth < 768) {
                      return Column(
                        children: [
                          SizedBox(height: 10),
                          cardindex(),
                          SizedBox(height: 10)
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }

                  Widget LoanProducts() {
                    if (myWidth < 768) {
                      List<Widget> allloanp = [];
                      int myindex = 0;
                      for (var item in loanProducts) {
                        Widget btn = Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {
                              loanpi = item['id'];
                              setState(() {
                                homeI = 2;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: myWidth - 100,
                              height: (myWidth - 100) / 1.9529411,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item['Pimage'] ?? '',
                                      fit: BoxFit.cover,
                                      height: (myWidth - 100) / 1.9529411,
                                      cacheHeight:
                                          (((myWidth - 100) / 1.9529411))
                                              .toInt(),
                                      width: myWidth - 100,
                                      cacheWidth: ((myWidth - 100)).toInt(),
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(myWidth / 18,
                                        myWidth / 16, 0, myWidth / 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/loanPicon.png',
                                          height: myWidth / 7.5,
                                        ),
                                        SizedBox(
                                          height: myWidth / 34,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    153, 18, 56, 105),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    width: 1.5,
                                                    color: Color(0xff647AF0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(item['name'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: myWidth / 28,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        Widget divider = SizedBox(
                          width: 10,
                        );
                        allloanp.add(btn);
                        if (myindex != loanProducts.length - 1) {
                          allloanp.add(divider);
                          myindex += 1;
                        }
                      }
                      return SizedBox(
                        width: myWidth - 20,
                        height: (myWidth - 100) / 2.0655172,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: allloanp),
                      );
                    } //tablet view
                    else {
                      List<Widget> allloanp = [];
                      int myindex = 0;
                      for (var item in loanProducts) {
                        Widget btn = Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {
                              loanpi = item['id'];
                              setState(() {
                                homeI = 2;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: ((myWidth - 40) / 3) - 3.3334,
                              height:
                                  (((myWidth - 40) / 3) - 3.3334) / 1.9529411,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item['Pimage'] ?? '',
                                      fit: BoxFit.cover,
                                      height: (((myWidth - 40) / 3) - 3.3334) /
                                          1.9529411,
                                      cacheHeight:
                                          (((((myWidth - 40) / 3) - 3.3334) /
                                                  1.9529411))
                                              .toInt(),
                                      width: ((myWidth - 40) / 3) - 3.3334,
                                      cacheWidth:
                                          ((((myWidth - 40) / 3) - 3.3334))
                                              .toInt(),
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/loanPicon.png',
                                          height: 50,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    153, 18, 56, 105),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    width: 1.5,
                                                    color: Color(0xff647AF0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(item['name'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                  )),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        Widget divider = SizedBox(
                          width: 10,
                        );
                        allloanp.add(btn);
                        if (myindex != loanProducts.length - 1) {
                          allloanp.add(divider);
                          myindex += 1;
                        }
                      }
                      return SizedBox(
                        width: myWidth - 20,
                        height: (((myWidth - 40) / 3) - 3.3334) / 1.9529411,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: allloanp),
                      );
                    }
                  }

                  //ea services
                  Widget EaServices() {
                    if (myWidth < 768) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.597,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/lastcard1.png',
                                  height: (myWidth - 20) / 2.597,
                                  width: myWidth - 20,
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high,
                                ),
                                SizedBox(
                                  width: (myWidth - 20) * 70 / 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: ((myWidth - 20) / 2.597) *
                                              55 /
                                              100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Obtain loans that are tailored to your needs',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.56,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width:
                                                    (myWidth - 20) * 45 / 100,
                                                child: const Text(
                                                  'Our loan service provides  you with the best loans.',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8.5,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (((myWidth - 20) / 2.597) *
                                                  20 /
                                                  100) *
                                              2.294,
                                          height: ((myWidth - 20) / 2.597) *
                                              20 /
                                              100,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff231E54),
                                              borderRadius:
                                                  BorderRadius.circular(9.37)),
                                          child: const TextButton(
                                            onPressed: null,
                                            child: Center(
                                              child: Text(
                                                'Apply Now',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 6.56,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.597,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/lastcard2.png',
                                  height: (myWidth - 20) / 2.597,
                                  width: myWidth - 20,
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high,
                                ),
                                SizedBox(
                                  width: (myWidth - 20) * 75 / 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: ((myWidth - 20) / 2.597) *
                                              55 /
                                              100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Grow and monitor your wealth with our Investment account',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.56,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width:
                                                    (myWidth - 20) * 45 / 100,
                                                child: const Text(
                                                  'EA provides you with a portfolio for growing your wealth.',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8.5,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (((myWidth - 20) / 2.597) *
                                                  20 /
                                                  100) *
                                              2.959,
                                          height: ((myWidth - 20) / 2.597) *
                                              20 /
                                              100,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff231E54),
                                              borderRadius:
                                                  BorderRadius.circular(9.37)),
                                          child: const TextButton(
                                            onPressed: null,
                                            child: Center(
                                              child: Text(
                                                'Start Investing',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 6.56,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    //tablet size
                    else {
                      return Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: ((myWidth - 20) / 2) - 5,
                          height: (((myWidth - 20) / 2) - 5) / 2.597,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/lastcard1.png',
                                width: ((myWidth - 20) / 2) - 5,
                                height: (((myWidth - 20) / 2) - 5) / 2.597,
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high,
                              ),
                              SizedBox(
                                width: (((myWidth - 20) / 2) - 5) * 70 / 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: ((((myWidth - 20) / 2) - 5) /
                                                2.597) *
                                            55 /
                                            100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Obtain loans that are tailored to your needs',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.56,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width:
                                                  (((myWidth - 20) / 2) - 5) *
                                                      45 /
                                                      100,
                                              child: const Text(
                                                'Our loan service provides  you with the best loans.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8.5,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: (((((myWidth - 20) / 2) - 5) /
                                                    2.597) *
                                                20 /
                                                100) *
                                            2.959,
                                        height: ((((myWidth - 20) / 2) - 5) /
                                                2.597) *
                                            20 /
                                            100,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff231E54),
                                            borderRadius:
                                                BorderRadius.circular(9.37)),
                                        child: const TextButton(
                                          onPressed: null,
                                          child: Center(
                                            child: Text(
                                              'Apply Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 6.56,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: ((myWidth - 20) / 2) - 5,
                          height: (((myWidth - 20) / 2) - 5) / 2.597,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/lastcard2.png',
                                width: ((myWidth - 20) / 2) - 5,
                                height: (((myWidth - 20) / 2) - 5) / 2.597,
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high,
                              ),
                              SizedBox(
                                width: (((myWidth - 20) / 2) - 5) * 75 / 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: ((((myWidth - 20) / 2) - 5) /
                                                2.597) *
                                            55 /
                                            100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Grow and monitor your wealth with our Investment account',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.56,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width:
                                                  (((myWidth - 20) / 2) - 5) *
                                                      45 /
                                                      100,
                                              child: const Text(
                                                'EA provides you with a portfolio for growing your wealth.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8.5,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: (((((myWidth - 20) / 2) - 5) /
                                                    2.597) *
                                                20 /
                                                100) *
                                            2.959,
                                        height: ((((myWidth - 20) / 2) - 5) /
                                                2.597) *
                                            20 /
                                            100,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff231E54),
                                            borderRadius:
                                                BorderRadius.circular(9.37)),
                                        child: const TextButton(
                                          onPressed: null,
                                          child: Center(
                                            child: Text(
                                              'Start Investing',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 6.56,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]);
                    }
                  }

                  //top card widget
                  Widget Topcard() {
                    if (myWidth <= 767) {
                      return SizedBox(
                        width: myWidth - 20,
                        height: (myWidth - 40) / 2.33333,
                        //notifocation listener for first bounce scroll
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification) {
                            double scrollwidth =
                                ScrollNotification.metrics.maxScrollExtent;
                            double scrollInitial =
                                ScrollNotification.metrics.pixels;
                            //if scrolling to right
                            if (ScrollNotification.metrics.pixels >
                                homecardpos + 50) {
                              //scroll to 2
                              if (scrollInitial > 0 &&
                                  scrollInitial <= (myWidth - 40)) {
                                Timer(
                                    const Duration(milliseconds: 70),
                                    () => myhomecardcontroller.animateTo(
                                        (myWidth - 40),
                                        duration:
                                            const Duration(milliseconds: 70),
                                        curve: Curves.easeIn));
                                if (scrollInitial == myWidth - 40) {
                                  setState(() {
                                    homecardpos = myWidth - 40;
                                    homecardindex = 2;
                                  });
                                }
                              } //scroll to 3
                              else if (scrollInitial >= (myWidth - 40) + 20) {
                                Timer(
                                    const Duration(milliseconds: 70),
                                    () => myhomecardcontroller.animateTo(
                                        ((myWidth - 40) * 2) + 10,
                                        duration:
                                            const Duration(milliseconds: 70),
                                        curve: Curves.easeIn));
                                if (scrollInitial ==
                                    ((myWidth - 40) * 2) + 10) {
                                  setState(() {
                                    homecardpos = ((myWidth - 40) * 2) + 10;
                                    homecardindex = 3;
                                  });
                                }
                              }
                            }
                            //if scrolling to left
                            else if (ScrollNotification.metrics.pixels <
                                homecardpos) {
                              //scroll to 2
                              if (scrollInitial < (((myWidth - 40) * 2) + 10) &&
                                  scrollInitial >= (myWidth - 40) - 10) {
                                print(scrollInitial);
                                Timer(
                                    const Duration(milliseconds: 70),
                                    () => myhomecardcontroller.animateTo(
                                        (myWidth - 40),
                                        duration:
                                            const Duration(milliseconds: 70),
                                        curve: Curves.easeIn));
                                if (scrollInitial == myWidth - 40) {
                                  setState(() {
                                    homecardpos = myWidth - 40;
                                    homecardindex = 2;
                                  });
                                }
                              } //scroll to 1
                              else if (scrollInitial <= (myWidth - 40) - 20) {
                                Timer(
                                    const Duration(milliseconds: 70),
                                    () => myhomecardcontroller.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 70),
                                        curve: Curves.easeIn));
                                if (scrollInitial == 0) {
                                  setState(() {
                                    homecardpos = 0.0;
                                    homecardindex = 1;
                                  });
                                }
                              }
                            }
                            return true;
                          },
                          child: ListView(
                            controller: myhomecardcontroller,
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.down,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.6,
                                          color: const Color(0xff575A96),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff37396C),
                                            Color(0xff191C61),
                                            Color(0xff15196A)
                                          ],
                                        )),
                                    width: myWidth - 40,
                                    height: (myWidth - 40) / 2.33333,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 15, 30, 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/homeicon1.svg'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text('No Active Loans',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              'Explore through our loan products and\nstand a chance to get\napproved!!',
                                              style: TextStyle(
                                                fontSize: subfontwidth,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            )
                                          ],
                                        ))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.6,
                                          color: const Color(0xff579668),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff1A7252),
                                            Color(0xff025333),
                                            Color(0xff085E3F)
                                          ],
                                        )),
                                    width: myWidth - 40,
                                    height: (myWidth - 40) / 2.33333,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            subfontwidth2 * 2,
                                            subfontwidth2,
                                            subfontwidth2 * 2,
                                            subfontwidth2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/homeicon2.svg',
                                              height: myWidth / 13,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text('Savings Account',
                                                style: TextStyle(
                                                  fontSize: subfontwidth2,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            SizedBox(
                                              height: myWidth / 39,
                                            ),
                                            Text(
                                              'Balance',
                                              style: TextStyle(
                                                fontSize: subfontwidth - 0.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                            SizedBox(
                                              height: myWidth / 78,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/naira.svg',
                                                  height: subfontwidth2 +
                                                      (subfontwidth2 / 2),
                                                  width: subfontwidth2 +
                                                      (subfontwidth2 / 2),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  '200,000',
                                                  style: TextStyle(
                                                    fontSize: subfontwidth2 +
                                                        (subfontwidth2 / 2.5),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.6,
                                          color: const Color(0xff955796),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff65376C),
                                            Color(0xff531961),
                                            Color(0xff69156A)
                                          ],
                                        )),
                                    width: myWidth - 40,
                                    height: (myWidth - 40) / 2.33333,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 18, 30, 18),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/homeicon3.svg'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text('Investment Account',
                                                style: TextStyle(
                                                  fontSize: subfontwidth2,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            SizedBox(
                                              height: myWidth / 39,
                                            ),
                                            Text(
                                              'Total Assets',
                                              style: TextStyle(
                                                fontSize: subfontwidth - 0.5,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                            SizedBox(
                                              height: myWidth / 78,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/naira.svg',
                                                  height: subfontwidth2 +
                                                      (subfontwidth2 / 2),
                                                  width: subfontwidth2 +
                                                      (subfontwidth2 / 2),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  '200,000',
                                                  style: TextStyle(
                                                    fontSize: subfontwidth2 +
                                                        (subfontwidth2 / 2.5),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      );
                    } //for tablet size
                    else {
                      return SizedBox(
                        width: myWidth - 20,
                        height: (((myWidth - 40) / 2) / 2.33333),
                        //notifocation listener for first bounce scroll
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.6,
                                        color: const Color(0xff575A96),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff37396C),
                                          Color(0xff191C61),
                                          Color(0xff15196A)
                                        ],
                                      )),
                                  width: ((myWidth - 40) / 3) - 3.3334,
                                  height: ((myWidth - 40) / 2) / 2.33333,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 15, 12, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/homeicon1.svg'),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text('No Active Loans',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Explore through our loan products and\nstand a chance to get\napproved!!',
                                            style: TextStyle(
                                              fontSize: subfontwidth,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.6,
                                        color: const Color(0xff579668),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff1A7252),
                                          Color(0xff025333),
                                          Color(0xff085E3F)
                                        ],
                                      )),
                                  width: ((myWidth - 40) / 3) - 3.3334,
                                  height: ((myWidth - 40) / 2) / 2.33333,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 15, 12, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/homeicon2.svg',
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('Savings Account',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Balance',
                                            style: TextStyle(
                                              fontSize: subfontwidth - 0.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/naira.svg',
                                                height: 22,
                                                width: 22,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                '200,000',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.6,
                                        color: const Color(0xff955796),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff65376C),
                                          Color(0xff531961),
                                          Color(0xff69156A)
                                        ],
                                      )),
                                  width: ((myWidth - 40) / 3) - 3.3334,
                                  height: ((myWidth - 40) / 2) / 2.33333,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 15, 12, 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/homeicon3.svg'),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('Investment Account',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Total Assets',
                                            style: TextStyle(
                                              fontSize: subfontwidth - 0.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/naira.svg',
                                                height: 22,
                                                width: 22,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                '200,000',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ))),
                            ),
                          ],
                        ),
                      );
                    }
                  }

                  //card index ends
                  //scaffold body starts here
                  return Container(
                    color: mode.background3,
                    child: RefreshIndicator(
                      displacement: 50,
                      onRefresh: regetdata,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: myHeight,
                          width: myWidth,
                          decoration: BoxDecoration(
                            color: mode.background3,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hello,
                                            style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 2.5,
                                          ),
                                          //redundant greeting text
                                          Text(
                                            'Good morning',
                                            style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          child: Image.network(imageurl,
                                              alignment: Alignment.center,
                                              filterQuality:
                                                  FilterQuality.medium),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  //top card for cards
                                  Topcard(),
                                  // index of cards
                                  realCardIndex(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    child: Text(
                                      'Loan Products',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: mode.brightText1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //container for cards
                                  LoanProducts(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      'EA Services',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: mode.brightText1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  EaServices(),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
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
              //if loan
            } else {
              String outbal = humanizeNo(loan['balance']);
              String outbalance = humanizeNo(loan['balance']);
              String ins = humanizeNo(loan['total_loan'] / loan['tenure']);
    
              String installment = ins.toString();
              double paidd = 0;
              for (var ins in installments) {
                if (ins['status'] == 'approved') {
                  paidd += ins['installment_amount'];
                }
              }
              double total = loan['total_loan'];
              String paid = humanizeNo(paidd);
              String htotal = humanizeNo(loan['total_loan']);
              String interestpm = humanizeNo(
                  (loan['total_loan'] - loan['principal']) / loan['tenure']);

              return Scaffold(
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;
                  double subfontwidth = myWidth / 35;
                  double subfontwidth2 = myWidth / 24;
                  if (subfontwidth > 12.55) {
                    subfontwidth = 12.55;
                  }

                  double iniwidth;
                  if (myWidth > 600) {
                    iniwidth = 600;
                  } else {
                    iniwidth = myWidth;
                  }
                  double btnWidth = iniwidth * 55 / 100 - 41;
                  double btnWidth2 = iniwidth * 45 / 100 - 41;
                  double btnHeight = (iniwidth * 60 / 100) / 5;
                  //creating custom widgets

                  Widget overview() {
                    if (myWidth < 768) {
                      if (_index == 0) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffAFAFE3),
                              borderRadius: BorderRadius.circular(15)),
                          width: 133.3,
                          height: 35.2,
                          child: const TextButton(
                              onPressed: null,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff171A6C)),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 12, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    } //for tablets
                    else {
                      if (_index == 0) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                width: 133.3,
                                height: 42.2,
                                child: TextButton(
                                    onPressed: null,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 3, 10, 3),
                                      child: Text(
                                        'Overview',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mode.brightText1),
                                      ),
                                    )),
                              ),
                              Container(
                                height: 7,
                                width: (myWidth - 30) / 2,
                                decoration: BoxDecoration(
                                  color: Color(0xff231E54),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: (myWidth - 30) / 2,
                          height: 42.2,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _index = 0;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontSize: 16, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    }
                  }

                  Widget payment() {
                    if (myWidth < 768) {
                      if (_index == 1) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffAFAFE3),
                              borderRadius: BorderRadius.circular(15)),
                          width: 133.3,
                          height: 35.2,
                          child: const TextButton(
                              onPressed: null,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff171A6C)),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 12, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    } //for tablets
                    else {
                      if (_index == 1) {
                        return Container(
                          width: (myWidth - 30) / 2,
                          child: Column(
                            children: [
                              Container(
                                width: 133.3,
                                height: 42.2,
                                child: TextButton(
                                    onPressed: null,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 3, 10, 3),
                                      child: Text(
                                        'Payment',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mode.brightText1),
                                      ),
                                    )),
                              ),
                              Container(
                                width: (myWidth - 30) / 2,
                                height: 7,
                                color: Color(0xff231E54),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: (myWidth - 30) / 2,
                          height: 42.2,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _index = 1;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 16, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    }
                  }

                  Widget ActiveLoans() {
                    double acconwidth = 0;
                    double stext = 14;
                    double sstext = 8;
                    if (myWidth < 768) {
                      acconwidth = myWidth - 20;
                    } else {
                      acconwidth = ((myWidth - 20) / 2) - 10;
                      sstext = 10;
                    }
                    return Container(
                      width: acconwidth,
                      decoration: BoxDecoration(
                          color: mode.background1,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount Paid',
                                  style: TextStyle(
                                      fontSize: stext, color: mode.brightText1),
                                ),
                                Text(
                                  'Outstanding',
                                  style: TextStyle(
                                      fontSize: stext, color: mode.brightText1),
                                )
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'N $paid',
                                  style: TextStyle(
                                      fontSize: stext, color: mode.brightText1),
                                ),
                                Text(
                                  'N $outbal',
                                  style: TextStyle(
                                      fontSize: stext, color: mode.brightText1),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Total Loan Amount: N $htotal',
                              style: TextStyle(
                                  fontSize: sstext, color: mode.dimText1),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 5,
                              width: acconwidth - 20,
                              decoration:
                                  BoxDecoration(color: mode.barBackground),
                              child: Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: (acconwidth - 20) * paidd / total,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff23AA59),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  Widget inswid() {
                    double inswidwidth = 0;
                    if (myWidth < 768) {
                      inswidwidth = myWidth - 20;
                    } else {
                      inswidwidth = ((myWidth - 20) / 2) - 10;
                    }
                    List<Widget> wids() {
                      List<Widget> ret = [];
                      int count = 0;
                      for (var ins in installments) {
                        Widget divider;
                        count = count + 1;
                        if ((count != 1) & (count < installments.length + 1)) {
                          divider = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 2,
                                  width: inswidwidth - 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffD7D7D7),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]);
                        } else {
                          divider = Container();
                        }
                        String stat = '';
                        Color statc = Color(0xffFBB500);
                        FontStyle fontstyle = FontStyle.italic;
                        Widget status() {
                          if (ins['status'] == 'approved') {
                            stat = 'Paid';
                            statc = Color(0xff44FB00);
                            fontstyle = FontStyle.normal;
                          } else {
                            stat = 'Pending';
                          }
                          return Text(stat,
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: fontstyle,
                                color: statc,
                              ));
                        }

                        String amm = humanizeNo(ins['installment_amount']);
                        String date =
                            dateFormat.format(DateTime.parse(ins['date']));
                        Widget ichild = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              divider,
                              Row(
                                children: [
                                  SizedBox(
                                    width: (inswidwidth - 40) / 3,
                                    child: Text('$date',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: mode.brightText1)),
                                  ),
                                  SizedBox(
                                    width: (inswidwidth - 40) / 3,
                                    child: Center(
                                      child: Text('N $amm',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (inswidwidth - 40) / 3,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: status(),
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                        ret += [
                          ichild,
                        ];
                      }
                      return (ret);
                    }

                    return Container(
                      width: inswidwidth,
                      decoration: BoxDecoration(
                          color: mode.background1,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: wids()),
                      ),
                    );
                  }

                  Widget loanoffwid() {
                    double loanoffwidth = 0;
                    if (myWidth < 768) {
                      loanoffwidth = myWidth - 20;
                    } else {
                      loanoffwidth = ((myWidth - 20) / 2) - 10;
                    }
                    return Container(
                      width: loanoffwidth,
                      child: Column(children: [
                        Container(
                            decoration: BoxDecoration(
                                color: mode.background1,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Philip Isaiah',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: mode.brightText1,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ))),
                        const SizedBox(height: 1),
                        Container(
                          decoration: BoxDecoration(
                              color: mode.background1,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Text('Email:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('isaiahphil97@gmail.com',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Text('Phone Number:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('08123456789',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Text('Whatsapp Number:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (loanoffwidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('08123456789',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    );
                  }

                  Widget nextinswid() {
                    double nextinswidth = 0;
                    if (myWidth < 768) {
                      nextinswidth = myWidth - 20;
                    } else {
                      nextinswidth = ((myWidth - 20) / 2) - 10;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                          width: nextinswidth,
                          decoration: BoxDecoration(
                              color: mode.background1,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Next Installment is in',
                                      style: TextStyle(
                                          fontSize: 10.5,
                                          color: mode.brightText1),
                                    ),
                                    Text(
                                      loan['next_installment_date'] ?? '',
                                      style: TextStyle(
                                          fontSize: 10.5,
                                          color: mode.brightText1),
                                    )
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 30,
                                  width: 70,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('PayLoan');
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff231E54)),
                                      child: const Text(
                                        'Pay',
                                        style: TextStyle(
                                            fontSize: 10.5,
                                            color: Colors.white),
                                      )),
                                )
                              ],
                            ),
                          )),
                    );
                  }

                  Widget reswid() {
                    double reswidth = 0;
                    if (myWidth < 768) {
                      reswidth = myWidth - 20;
                    } else {
                      reswidth = ((myWidth - 20) / 2) - 10;
                    }
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                            width: reswidth,
                            decoration: BoxDecoration(
                                color: mode.background1,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              child: Column(
                                children: [
                                  Row(children: [
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Text('Account Number:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('0123456789',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Text('Account Name:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Isaiah Matthew',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Text('Bank:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('GT Bank',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: mode.brightText1)),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )));
                  }

                  Widget warnwid() {
                    double warnwidth = 0;
                    double warnheight = 0;
                    double warnsize = 0;
                    if (myWidth < 768) {
                      warnwidth = myWidth - 20;
                      warnheight = (myWidth / 6) + 5;
                      warnsize = iniwidth / 40;
                    } else {
                      warnwidth = ((myWidth - 20) / 2) - 10;
                      warnheight = 80;
                      warnsize = 13;
                    }
                    return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: warnheight,
                          width: warnwidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffAFAFE3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    'NOTE:  Be sure to upload the proof of payment after paying. Do so by tapping the + icon at the bottom right corner.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: const Color(0xff171A6C),
                                        fontSize: warnsize,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }

                  Widget getCon() {
                    double conheight = 0;
                    double conheight2 = 0;
                    if (myWidth < 768) {
                      conheight = myHeight - ((myWidth - 20) / 2.263) - 188;
                      conheight2 = myHeight - ((myWidth - 20) / 2.263) - 178;
                    } else {
                      conheight = myHeight - 327;
                      conheight2 = myHeight - 327;
                    }
                    if (_index == 0) {
                      if (myWidth < 768) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: SizedBox(
                            height: conheight,
                            child: ListView(children: [
                              Container(
                                child: Text(
                                  'Active Loan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mode.brightText1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ActiveLoans(),
                              //container 2
                              const SizedBox(height: 10),
                              Container(
                                child: Text(
                                  'Installments',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mode.brightText1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              inswid(),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  'Loan Officer',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mode.brightText1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              loanoffwid(),
                              const SizedBox(
                                height: 40,
                              )
                            ]),
                          ),
                        );
                      } else {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: SizedBox(
                                height: conheight,
                                child: ListView(children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Active Loan',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ActiveLoans(),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        'Loan Officer',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              mode.brightText1,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    loanoffwid(),
                                                  ])
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Installments',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: mode.brightText1,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            inswid(),
                                          ]),
                                    ],
                                  ),
                                ])));
                      }
                    } else {
                      if (myWidth < 768) {
                        return SizedBox(
                          height: conheight2,
                          child: ListView(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    nextinswid(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        child: Text(
                                          'Recipient Account Details',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: mode.brightText1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    reswid(),
                                    //warntext
                                    warnwid(),
                                  ]),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                            height: conheight2,
                            child: ListView(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Container(
                                            child: Text(
                                              'Recipient Account Details',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        reswid(),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Container(
                                            child: Text(
                                              'Next Installment',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        nextinswid(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        warnwid(),
                                      ])
                                ],
                              )
                            ]));
                      }
                    }
                  }

                  Widget TopCard() {
                    if (myWidth < 768) {
                      return (Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.263,
                            decoration: BoxDecoration(
                                color: const Color(0xff121B20),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1, color: const Color(0xff575A96))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 10),
                              child: Builder(
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Outstanding Balance',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffE7E8EE)),
                                      ),
                                      SizedBox(height: 5),
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
                                            outbal,
                                            style: TextStyle(
                                              fontSize: iniwidth / 15,
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
                                                        BorderRadius.circular(
                                                            29.87),
                                                    side: const BorderSide(
                                                      width: 0.6,
                                                      color: Color(0xff60609F),
                                                    )),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        50, 143, 143, 255),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        7, 0, 7, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Interest Per Month:',
                                                      style: TextStyle(
                                                          fontSize:
                                                              iniwidth / 42,
                                                          color: const Color(
                                                              0xffE7E8EE)),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 2, 0),
                                                        child: SvgPicture.asset(
                                                          'assets/svg/naira.svg',
                                                          height: iniwidth / 33,
                                                          width: iniwidth / 33,
                                                        ),
                                                      ),
                                                      Text(
                                                        interestpm,
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffE7E8EE)),
                                                      )
                                                    ])
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
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            29.87),
                                                    side: const BorderSide(
                                                      width: 0.6,
                                                      color: Color(0xff60609F),
                                                    )),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        50, 143, 143, 255),
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  width: btnWidth2 - 20,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Monthly Installment:',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  iniwidth / 42,
                                                              color: const Color(
                                                                  0xffE7E8EE)),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Row(children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    0, 0, 2, 0),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/svg/naira.svg',
                                                              height:
                                                                  iniwidth / 33,
                                                              width:
                                                                  iniwidth / 33,
                                                            ),
                                                          ),
                                                          Text(
                                                            installment,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    iniwidth /
                                                                        42,
                                                                color: const Color(
                                                                    0xffE7E8EE)),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
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
                          )));
                    } //for tablets
                    else {
                      return (Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xff121B20),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: const Color(0xff575A96))),
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

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: (myWidth - 62) * 35 / 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Outstanding Balance',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffE7E8EE)),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/naira.svg',
                                                height: 42,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                outbal,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: Color(0xffE7E8EE),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (myWidth - 62) * 65 / 100,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width:
                                                (((myWidth - 62) * 65 / 100) /
                                                        2) -
                                                    10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      50, 143, 143, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          29.87),
                                                  border: Border.all(
                                                      width: 0.6,
                                                      color:
                                                          Color(0xff60609F))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 7, 15, 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Interest Per Month:',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: const Color(
                                                                  0xffE7E8EE)),
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      5,
                                                                      0,
                                                                      3,
                                                                      0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/svg/naira.svg',
                                                                height: 17,
                                                                width: 17,
                                                              ),
                                                            ),
                                                            Text(
                                                              interestpm,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: const Color(
                                                                      0xffE7E8EE)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width:
                                                (((myWidth - 62) * 65 / 100) /
                                                        2) -
                                                    10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      50, 143, 143, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          29.87),
                                                  border: Border.all(
                                                      width: 0.6,
                                                      color:
                                                          Color(0xff60609F))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 7, 15, 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Monthly Installment:',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: const Color(
                                                                  0xffE0F5E9)),
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      5,
                                                                      0,
                                                                      3,
                                                                      0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/svg/naira.svg',
                                                                height: 17,
                                                                width: 17,
                                                              ),
                                                            ),
                                                            Text(
                                                              installment,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: const Color(
                                                                      0xffE0F5E9)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                    child: RefreshIndicator(
                      displacement: 50,
                      onRefresh: regetdata,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: myHeight,
                          width: myWidth,
                          decoration: BoxDecoration(
                            color: mode.background3,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hello,
                                              style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 2.5,
                                            ),
                                            //redundant greeting text
                                            Text(
                                              'Good morning',
                                              style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 37.8,
                                        width: 37.8,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(42),
                                          child: Image.network(imageurl,
                                              alignment: Alignment.center,
                                              filterQuality:
                                                  FilterQuality.medium),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //top card
                                TopCard(),
                                //end of card
                                //top card ends
                                const SizedBox(
                                  height: 10,
                                ),
                                //spend or save
                                Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        overview(),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        payment(),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //spend or save container
                                getCon(),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
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
