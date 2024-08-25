// ignore_for_file: unnecessary_null_comparison, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';

dynamic loan = {};
dynamic installs = [];
Map saving = {};
dynamic invests = {};
dynamic investA = {};
dynamic installments = List.empty();
String hello = '';
dynamic officer = {};
User? user = null;
List loanProducts = List.empty();
final myhomecardcontroller = ItemScrollController();
ItemPositionsListener myhomecardcontrollerlis = ItemPositionsListener.create();
double homecardpos = 0.0;
int homecardindex = 1;
double cardheight = 0;
bool gotdata = false;

dynamic getKey(key) {
  if (key == KeyClass.shakeKey2) {
    return KeyClass.shakeKey1;
  } else {
    return KeyClass.shakeKey2;
  }
}

dynamic shakey = KeyClass.shakeKey1;

List<dynamic> inielevatebank = [
  '',
  '',
  '',
  '',
];

List<dynamic> elevatebank = List.empty();

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
bool loanMode = false;
String mystate = 'got';

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
  String loanurl = 'https://elevatemfb.com/loan/services/';
  String investurl = 'https:/elevatemfb.com/investment/services/';

  DateFormat dateFormat = DateFormat.yMMMMd();

  Future mgetUser() async {
    dynamic got = await DatabaseHelper.instance.getUser();
    dynamic loana = await DatabaseHelper.instance.getLoan();
    dynamic installmentsa = await DatabaseHelper.instance.getInstallment();
    dynamic loanP = await DatabaseHelper.instance.getLoanP();
    dynamic savinga = await DatabaseHelper.instance.getSaving();
    dynamic invest = await DatabaseHelper.instance.getInvestment();
    dynamic investa = await DatabaseHelper.instance.getInvestA();
    dynamic officera = await DatabaseHelper.instance.getOfficer();
    if (mystate == 'got') {
      setState(() {
        user = got;
        loan = loana;
        installs = installmentsa;
        loanProducts = loanP;
        saving = savinga;
        invests = invest;
        investA = investa;
        hello = 'Hello, ' + got.firstname;
        officer = officera;
        gotdata = true;
      });
    }

    return (true);
  }

  Future getelevatebank() async {
    String url = apiUrl + 'get/elevate/bank/';
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
      dynamic data = json.decode(res2.body);
      elevatebank[0] = data['account_number'];
      elevatebank[1] = data['name'];
      elevatebank[2] = data['bank_name'];
      elevatebank[3] = data['reference'];
    }
  }

  _launchURL() async {
    final Uri url = Uri.parse(loanurl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ${url}');
    }
  }

  _launchURL2() async {
    final Uri url = Uri.parse(investurl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ${url}');
    }
  }

  Future regetdata3() async {
    setState(() {
      mystate = 'getting';
    });
    await regetdata2();
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        mystate = 'got';
      });
    });

    if (gotstate == 'network') {
      double myWidth2 = MediaQuery.of(context).size.width;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: EdgeInsets.fromLTRB(myWidth2 / 4, 0, myWidth2 / 4, 30),
        backgroundColor: Color.fromARGB(150, 128, 128, 128),
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Container(
          width: myWidth2 / 2,
          height: 30,
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
                    'Network Error',
                    style: TextStyle(
                        color: mode.darkText1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
      await Future.delayed(Duration(seconds: 5));
      regetdata(context, mode);
    }
    if (gotstate == 'timeout') {
      double myWidth2 = MediaQuery.of(context).size.width;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: EdgeInsets.fromLTRB(myWidth2 / 4, 0, myWidth2 / 4, 30),
        backgroundColor: Color.fromARGB(150, 128, 128, 128),
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Container(
          width: myWidth2 / 2,
          height: 30,
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
                    'Request Timeout',
                    style: TextStyle(
                        color: mode.darkText1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
      regetdata(context, mode);
    }
  }

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('en');
    elevatebank = inielevatebank;
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
          if (snapshot.hasData || gotdata) {
            installments = installs.reversed.toList();
            Widget imagecon2() {
              if (user!.image == '' || user!.image == null) {
                return Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.asset(
                      'assets/images/default_pic.png',
                      width: 40,
                      cacheHeight: 80,
                      cacheWidth: 80,
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.network(
                      user!.image,
                      width: 40,
                      cacheHeight: 80,
                      cacheWidth: 80,
                    ),
                  ),
                );
              }
            }

            Widget imagecon3() {
              if (user!.image == '' || user!.image == null) {
                return Container(
                  height: 37.8,
                  width: 37.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.asset(
                      'assets/images/default_pic.png',
                      width: 37.8,
                      cacheHeight: 80,
                      cacheWidth: 80,
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 37.8,
                  width: 37.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.network(
                      user!.image,
                      width: 37.8,
                      cacheHeight: 80,
                      cacheWidth: 80,
                    ),
                  ),
                );
              }
            }

            if (loan['id'] == null) {
              loanMode = false;
            } else {
              loanMode = true;
            }

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
                                      width: myWidth - 100,
                                      cacheHeight:
                                          ((myWidth - 100) ~/ 1.9529411)
                                              .floor(),
                                      cacheWidth: ((myWidth - 100)).floor(),
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
                                          (((myWidth - 40) / 3) - 3.3334) ~/
                                              1.9529411,
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
                          SizedBox(
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.597,
                            child: TextButton(
                              onPressed: _launchURL,
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Container(
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
                                      cacheHeight:
                                          (((myWidth - 20) / 2.597) * 2)
                                              .floor(),
                                      cacheWidth: ((myWidth - 20) * 2).floor(),
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
                                                    width: (myWidth - 20) *
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
                                              width: (((myWidth - 20) / 2.597) *
                                                      20 /
                                                      100) *
                                                  2.294,
                                              height: ((myWidth - 20) / 2.597) *
                                                  20 /
                                                  100,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff231E54),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.37)),
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
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: myWidth - 20,
                            height: (myWidth - 20) / 2.597,
                            child: TextButton(
                              onPressed: _launchURL2,
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Container(
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
                                      cacheHeight:
                                          (((myWidth - 20) / 2.597) * 2)
                                              .floor(),
                                      cacheWidth: ((myWidth - 20) * 2).floor(),
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
                                                    width: (myWidth - 20) *
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
                                              width: (((myWidth - 20) / 2.597) *
                                                      20 /
                                                      100) *
                                                  2.959,
                                              height: ((myWidth - 20) / 2.597) *
                                                  20 /
                                                  100,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff231E54),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.37)),
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
                            ),
                          ),
                        ],
                      );
                    }
                    //tablet size
                    else {
                      return Row(children: [
                        SizedBox(
                          width: ((myWidth - 20) / 2) - 5,
                          height: (((myWidth - 20) / 2) - 5) / 2.597,
                          child: TextButton(
                            onPressed: _launchURL,
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Container(
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
                                    width:
                                        (((myWidth - 20) / 2) - 5) * 70 / 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:
                                                ((((myWidth - 20) / 2) - 5) /
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                SizedBox(
                                                  width: (((myWidth - 20) / 2) -
                                                          5) *
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
                                            width:
                                                (((((myWidth - 20) / 2) - 5) /
                                                            2.597) *
                                                        20 /
                                                        100) *
                                                    2.959,
                                            height:
                                                ((((myWidth - 20) / 2) - 5) /
                                                        2.597) *
                                                    20 /
                                                    100,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff231E54),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9.37)),
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
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: ((myWidth - 20) / 2) - 5,
                          height: (((myWidth - 20) / 2) - 5) / 2.597,
                          child: TextButton(
                            onPressed: _launchURL2,
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Container(
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
                                    width:
                                        (((myWidth - 20) / 2) - 5) * 75 / 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:
                                                ((((myWidth - 20) / 2) - 5) /
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                SizedBox(
                                                  width: (((myWidth - 20) / 2) -
                                                          5) *
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
                                            width:
                                                (((((myWidth - 20) / 2) - 5) /
                                                            2.597) *
                                                        20 /
                                                        100) *
                                                    2.959,
                                            height:
                                                ((((myWidth - 20) / 2) - 5) /
                                                        2.597) *
                                                    20 /
                                                    100,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff231E54),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9.37)),
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
                          ),
                        ),
                      ]);
                    }
                  }

                  //top card widget
                  Widget Topcard() {
                    if (myWidth <= 767) {
                      cardheight = ((myWidth - 40) / 2.33333) + 154;
                      List<Widget> savingschild() {
                        if (saving['id'] != null) {
                          List<Widget> ret = [
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
                                  height: subfontwidth2 + (subfontwidth2 / 2),
                                  width: subfontwidth2 + (subfontwidth2 / 2),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  humanizeNo(saving['balance']),
                                  style: TextStyle(
                                    fontSize:
                                        subfontwidth2 + (subfontwidth2 / 2.5),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ];
                          return (ret);
                        } else {
                          List<Widget> ret = [
                            SvgPicture.asset(
                              'assets/svg/homeicon2.svg',
                              height: myWidth / 13,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'You do not have a savings account with Elevate Alliance',
                              style: TextStyle(
                                fontSize: subfontwidth2,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ];
                          return (ret);
                        }
                      }

                      List<Widget> investchild() {
                        if (investA == 'true') {
                          double mainport = 0;
                          for (var invest in invests) {
                            mainport += invest['balance'];
                          }
                          List<Widget> ret = [
                            SvgPicture.asset('assets/svg/homeicon3.svg'),
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
                                  height: subfontwidth2 + (subfontwidth2 / 2),
                                  width: subfontwidth2 + (subfontwidth2 / 2),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  humanizeNo(mainport),
                                  style: TextStyle(
                                    fontSize:
                                        subfontwidth2 + (subfontwidth2 / 2.5),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ];
                          return (ret);
                        } else {
                          List<Widget> ret = [
                            SvgPicture.asset(
                              'assets/svg/homeicon3.svg',
                              height: myWidth / 13,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'You do not have an invesment account with Elevate Alliance',
                              style: TextStyle(
                                fontSize: subfontwidth2,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ];
                          return (ret);
                        }
                      }

                      Widget noloancard(int idx) {
                        if (idx == 0) {
                          return (Padding(
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
                          ));
                        } else if (idx == 1) {
                          return (Padding(
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
                                      children: savingschild(),
                                    ))),
                          ));
                        } else {
                          return (Padding(
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
                                      children: investchild(),
                                    ))),
                          ));
                        }
                      }

                      return SizedBox(
                        width: myWidth - 20,
                        height: ((myWidth - 40) / 2.33333),
                        //notifocation listener for first bounce scroll
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification) {
                            if ((ScrollNotification.metrics.extentBefore) +
                                    (myWidth / 2) <=
                                ScrollNotification.metrics.extentTotal / 3) {
                              setState(() {
                                homecardindex = 1;
                              });
                            } else if (ScrollNotification.metrics.extentBefore >
                                    (ScrollNotification.metrics.extentTotal /
                                            3) +
                                        (myWidth / 2) &&
                                ScrollNotification.metrics.extentAfter <
                                    (ScrollNotification.metrics.extentTotal /
                                            3) -
                                        (myWidth / 2)) {
                              setState(() {
                                homecardindex = 3;
                              });
                            } else {
                              setState(() {
                                homecardindex = 2;
                              });
                            }
                            return true;
                          },
                          child: ScrollablePositionedList.builder(
                            itemCount: 3,
                            itemScrollController: myhomecardcontroller,
                            itemPositionsListener: myhomecardcontrollerlis,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return noloancard(index);
                            },
                          ),
                        ),
                      );
                    } //for tablet size
                    else {
                      cardheight = ((((myWidth - 40) / 2) / 2.33333)) + 125;
                      List<Widget> savingschild() {
                        if (saving['id'] != null) {
                          List<Widget> ret = [
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
                                  humanizeNo(saving['balance']),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ];
                          return (ret);
                        } else {
                          List<Widget> ret = [
                            SvgPicture.asset(
                              'assets/svg/homeicon2.svg',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'You do not have a savings account with Elevate Alliance',
                              style: TextStyle(
                                fontSize: subfontwidth + 4,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ];
                          return (ret);
                        }
                      }

                      List<Widget> investchild() {
                        if (investA == 'true') {
                          double mainport = 0;
                          for (var invest in invests) {
                            mainport += invest['balance'];
                          }
                          List<Widget> ret = [
                            SvgPicture.asset('assets/svg/homeicon3.svg'),
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
                                  humanizeNo(mainport),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ];
                          return (ret);
                        } else {
                          List<Widget> ret = [
                            SvgPicture.asset(
                              'assets/svg/homeicon3.svg',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'You do not have an invesment account with Elevate Alliance',
                              style: TextStyle(
                                fontSize: subfontwidth + 4,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ];
                          return (ret);
                        }
                      }

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
                                        children: savingschild(),
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
                                        children: investchild(),
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
                    child: RefreshIndicator(
                      displacement: 50,
                      onRefresh: regetdata3,
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
                                    imagecon2()
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
                                    height: myHeight - cardheight,
                                    child: ListView(
                                      children: [
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
                                    )),
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
                              onPressed: () async {
                                setState(() {
                                  _index = 1;
                                });
                                await getelevatebank();
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
                              onPressed: () async {
                                setState(() {
                                  _index = 1;
                                });
                                await getelevatebank();
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

                  Widget loantitle() {
                    if (officer['email'] == null) {
                      return Container();
                    }
                    return Container(
                      child: Text(
                        'Loan Officer',
                        style: TextStyle(
                          fontSize: 15,
                          color: mode.brightText1,
                        ),
                      ),
                    );
                  }

                  Widget loanoffwid() {
                    if (officer['email'] == null) {
                      return Container();
                    }
                    double loanoffwidth = 0;
                    if (myWidth < 768) {
                      loanoffwidth = myWidth - 20;
                    } else {
                      loanoffwidth = ((myWidth - 20) / 2) - 10;
                    }

                    Widget imagecon() {
                      if (officer['image'] == '' || officer['image'] == null) {
                        return Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/default_pic.png',
                              width: 50,
                              cacheHeight: 100,
                              cacheWidth: 100,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(42),
                            child: Image.network(
                              officer['image'],
                              width: 50,
                              cacheHeight: 100,
                              cacheWidth: 100,
                            ),
                          ),
                        );
                      }
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
                                        imagecon(),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          officer['name'] ?? '',
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
                                        child: Text(officer['email'] ?? '',
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
                                        child: Text(
                                            officer['phone_number'] ?? '',
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
                                        child: Text(
                                            officer['whatsapp_number'] ?? '',
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
                    if (elevatebank[0] == '') {
                      return Container();
                    }
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
                                        child: Text(elevatebank[0] ?? '',
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
                                        child: Text(elevatebank[1] ?? '',
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
                                        child: Text(elevatebank[2] ?? '',
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
                                      child: Text('Reference:',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mode.brightText1)),
                                    ),
                                    SizedBox(
                                      width: (reswidth - 40) / 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(elevatebank[3] ?? '',
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
                      conheight = myHeight - ((myWidth - 20) / 2.263) - 173;
                      conheight2 = myHeight - ((myWidth - 20) / 2.263) - 173;
                      if (myHeight < 580) {
                        conheight = myHeight - (100) - 173;
                        conheight2 = myHeight - (100) - 173;
                      }
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
                              loantitle(),
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
                                                    loantitle(),
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
                    if (myWidth < 768 && myHeight > 580) {
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
                      double cardheight = 140;
                      double height42 = 42;
                      double font20 = 20;
                      double font30 = 30;
                      double height50 = 50;
                      double height20 = 20;
                      double height17 = 17;
                      double font13 = 13;
                      double btnwidth = (((myWidth - 62) * 65 / 100) / 2) - 10;
                      double btnrowwidth = (myWidth - 62) * 65 / 100;
                      double outwidth = (myWidth - 62) * 35 / 100;
                      if (myWidth < 767) {
                        cardheight = 100;
                        height42 = 21;
                        font20 = 10;
                        font30 = 15;
                        height50 = 25;
                        height20 = 10;
                        height17 = 8.5;
                        font13 = 7.5;
                        btnrowwidth = 151.6;
                        btnwidth = 151.6;
                        outwidth = myWidth - 62 - 151.6;
                      }
                      Widget btnrow(List<Widget> children) {
                        if (myWidth > 767) {
                          return Row(
                            children: children,
                          );
                        } else {
                          return Column(
                            children: children,
                          );
                        }
                      }

                      return (Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: cardheight,
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
                                      width: outwidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Outstanding Balance',
                                            style: TextStyle(
                                                fontSize: font20,
                                                color: Color(0xffE7E8EE)),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/naira.svg',
                                                height: height42,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Text(
                                                outbal,
                                                style: TextStyle(
                                                  fontSize: font30,
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
                                      width: btnrowwidth,
                                      child: btnrow(
                                        [
                                          SizedBox(
                                            height: height50,
                                            width: btnwidth,
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
                                                              fontSize: font13,
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
                                                                height:
                                                                    height17,
                                                                width: height17,
                                                              ),
                                                            ),
                                                            Text(
                                                              interestpm,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      font13,
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
                                            width: height20,
                                            height: 5,
                                          ),
                                          SizedBox(
                                            height: height50,
                                            width: btnwidth,
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
                                                              fontSize: font13,
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
                                                                height:
                                                                    height17,
                                                                width: height17,
                                                              ),
                                                            ),
                                                            Text(
                                                              installment,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      font13,
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
                      onRefresh: regetdata3,
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
                                      imagecon3(),
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
