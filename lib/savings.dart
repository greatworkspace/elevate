import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'humanizeAmount.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

class SavingsScreen extends StatefulWidget {
  SavingsScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

dynamic mode = mode;

int _index = 0;
bool _open = false;
bool savings = false;
bool saveMode = false;

int transIndex = 0;
bool hidebal = false;

class _SavingsScreenState extends State<SavingsScreen>
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

  DateFormat dateFormat = DateFormat.yMMMMd();
  DateFormat timeFormat = DateFormat.jm();

  void initState() {
    super.initState();
    gethidebal();
    dateFormat = new DateFormat.yMMMMd('en');
    timeFormat = new DateFormat.jm('en');
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    Future mgetUser() async {
      dynamic got = await DatabaseHelper.instance.getUser();
      dynamic saving = await DatabaseHelper.instance.getSaving();
      dynamic trans = await DatabaseHelper.instance.getTrans();

      return {
        'data': got,
        'savings': saving,
        'trans': trans,
      };
    }

    Widget floatingWidget() {
      return TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('UploadDocument');
          },
          child: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: 1,
              child: SvgPicture.asset('assets/svg/floating_savings.svg')));
    }

    return FutureBuilder(
        future: mgetUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data['data'];
            dynamic saving = snapshot.data['savings'];
            dynamic transactions = snapshot.data['trans'];
            String accountNo = user.account;
            if (saving['id'] == null) {
              saveMode = false;
            } else {
              saveMode = true;
            }
            if (saveMode == true) {
              return Scaffold(
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;

                  //building custom widgets
                  Widget noSavings() {
                    return Container();
                  }

                  Widget Topcard() {
                    if (myWidth < 768) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: (myWidth - 20) / 2.263,
                          decoration: BoxDecoration(
                              color: const Color(0xff12201B),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: const Color(0xff579668))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (context) {
                                    double iniwidth;
                                    if (myWidth > 600) {
                                      iniwidth = 600;
                                    } else {
                                      iniwidth = myWidth;
                                    }

                                    Widget AccBal() {
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
                                              humanizeNo(saving['balance']),
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
                                    }

                                    double btnWidth = iniwidth * 65 / 100 - 40;
                                    double btnHeight =
                                        (iniwidth * 60 / 100) / 6;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Available Balance',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  savingsI = 6;
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
                                        SizedBox(
                                          height: btnHeight,
                                          width: btnWidth,
                                          child: TextButton(
                                            onPressed: () async {
                                              Clipboard.setData(ClipboardData(
                                                      text: accountNo))
                                                  .then((value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        elevation: 0,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                myWidth / 4,
                                                                0,
                                                                myWidth / 4,
                                                                30),
                                                        backgroundColor:
                                                            mode.background1,
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        shape:
                                                            BeveledRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        content: Container(
                                                          width: myWidth / 2,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: mode.floatBg,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    'Copied!',
                                                                    style: TextStyle(
                                                                        color: mode
                                                                            .darkText1,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/mark.svg',
                                                                    color: mode
                                                                        .darkText1,
                                                                    height: 12,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )));
                                            },
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          29.87),
                                                  side: const BorderSide(
                                                    width: 0.6,
                                                    color: Color(0xffE0F5E9),
                                                  )),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      25, 154, 238, 162),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      7, 0, 7, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Account Number:',
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffE0F5E9)),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        accountNo,
                                                        style: TextStyle(
                                                            fontSize:
                                                                iniwidth / 42,
                                                            color: const Color(
                                                                0xffE0F5E9)),
                                                      )
                                                    ],
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/svg/copy.svg',
                                                    height: 15,
                                                    width: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    //for tablet
                    else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xff12201B),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: const Color(0xff579668))),
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

                                Widget AccBal() {
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
                                          humanizeNo(saving['balance']),
                                          style: TextStyle(
                                            fontSize: 35,
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

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 260,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Available Balance',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          AccBal(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (myWidth - 62) - 340,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 280,
                                            child: TextButton(
                                              onPressed: () async {
                                                Clipboard.setData(ClipboardData(
                                                        text: accountNo))
                                                    .then((value) =>
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          elevation: 0,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  myWidth / 4,
                                                                  0,
                                                                  myWidth / 4,
                                                                  30),
                                                          backgroundColor:
                                                              mode.background1,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 3),
                                                          shape: BeveledRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          content: Container(
                                                            width: myWidth / 2,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  mode.floatBg,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      'Copied!',
                                                                      style: TextStyle(
                                                                          color: mode
                                                                              .darkText1,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    SvgPicture
                                                                        .asset(
                                                                      'assets/svg/mark.svg',
                                                                      color: mode
                                                                          .darkText1,
                                                                      height:
                                                                          12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )));
                                              },
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            29.87),
                                                    side: const BorderSide(
                                                      width: 0.6,
                                                      color: Color(0xffE0F5E9),
                                                    )),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        25, 154, 238, 162),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Account Number:',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: const Color(
                                                                  0xffE0F5E9)),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          accountNo,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: const Color(
                                                                  0xffE0F5E9)),
                                                        )
                                                      ],
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/svg/copy.svg',
                                                      height: 15,
                                                      width: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  ((myWidth - 62) - 340) - 280)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                savingsI = 6;
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
                                                height: 42,
                                                width: 42,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  }

                  Widget TransList() {
                    double transconheight = 0;
                    if (myWidth < 768) {
                      transconheight =
                          (myHeight - (myWidth - 20) / 2.263) - 334.2;
                    } else {
                      transconheight = myHeight - 488.2;
                    }

                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Container(
                        height: transconheight,
                        color: mode.background1,

                        //listview for transactions
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              Widget divider = Row(
                                children: [
                                  const SizedBox(
                                    width: 62,
                                  ),
                                  Container(
                                    width: myWidth - 62,
                                    height: 1,
                                    color: mode.kunleStroke,
                                  )
                                ],
                              );
                              if (index == 4) {
                                divider = Container();
                              }
                              Widget amountWid = Container();
                              String date = dateFormat.format(DateTime.parse(
                                      transactions[index]['date'])) +
                                  ' ' +
                                  timeFormat.format(DateTime.parse(
                                      transactions[index]['date']));
                              if (transactions[index]['trans_type'] ==
                                      'Deposit' ||
                                  transactions[index]['name'] ==
                                      'Interest Gain') {
                                amountWid = Text(
                                  '+' +
                                      humanizeNo(transactions[index]['amount']),
                                  style: const TextStyle(
                                      color: Color(0xff05F200), fontSize: 13),
                                );
                              } else {
                                amountWid = Text(
                                  '-' +
                                      humanizeNo(transactions[index]['amount']),
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 13),
                                );
                              }
                              Widget container = Container();

                              if (transactions[index]['trans_type'] !=
                                      'investment' &&
                                  transactions[index]['trans_type'] != 'loan') {
                                String nametext = transactions[index]
                                        ['transaction_name'] ??
                                    '';
                                if (transactions[index]['trans_type'] ==
                                    'target') {
                                  nametext = transactions[index]['note'];
                                }
                                container = TextButton(
                                  onPressed: () {
                                    setState(() {
                                      transIndex = index;
                                      Navigator.of(context)
                                          .pushNamed('TransactionDetails');
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Column(
                                    children: [
                                      //transaction 1
                                      Container(
                                        height: 63,
                                        width: myWidth,
                                        color: mode.background1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  //placeholder for picture
                                                  Image.asset(
                                                    'assets/images/default_pic.png',
                                                    width: 42,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: myWidth - 72,
                                                    child: Row(
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
                                                              nametext,
                                                              style: TextStyle(
                                                                  color: mode
                                                                      .brightText1,
                                                                  fontSize: 13),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              date,
                                                              style: TextStyle(
                                                                  color: mode
                                                                      .dimText1,
                                                                  fontSize: 13),
                                                            )
                                                          ],
                                                        ),
                                                        amountWid,
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            divider,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Widget transpic = Container();
                                if (transactions[index]['trans_type'] ==
                                    'loan') {
                                  transpic = SvgPicture.asset(
                                    'assets/svg/trans_loan.svg',
                                    width: 42,
                                  );
                                } else {
                                  transpic = SvgPicture.asset(
                                    'assets/svg/trans_invest.svg',
                                    width: 42,
                                  );
                                }
                                container = TextButton(
                                  onPressed: () {
                                    setState(() {
                                      transIndex = index;
                                      Navigator.of(context)
                                          .pushNamed('TransactionDetails');
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Column(
                                    children: [
                                      //transaction 1
                                      Container(
                                        height: 63,
                                        width: myWidth,
                                        color: mode.background1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  //placeholder for picture
                                                  transpic,
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: myWidth - 72,
                                                    child: Row(
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
                                                              transactions[
                                                                          index]
                                                                      [
                                                                      'note'] ??
                                                                  '',
                                                              style: TextStyle(
                                                                  color: mode
                                                                      .brightText1,
                                                                  fontSize: 13),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              date,
                                                              style: TextStyle(
                                                                  color: mode
                                                                      .dimText1,
                                                                  fontSize: 13),
                                                            )
                                                          ],
                                                        ),
                                                        amountWid,
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 62,
                                                ),
                                                Container(
                                                  width: myWidth - 62,
                                                  height: 1,
                                                  color: mode.kunleStroke,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return container;
                            },
                          ),
                          //end of listbuilder
                        ),
                      ),
                    );
                  }

                  Widget FundingBal() {
                    if (hidebal == false) {
                      return Text(
                        'N ${humanizeNo(saving['balance'])}',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xff127422)),
                      );
                    } else {
                      return Text(
                        '****',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xff127422)),
                      );
                    }
                  }

                  Widget spend() {
                    if (myWidth < 768) {
                      if (_index == 0) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffC1FFD3),
                              borderRadius: BorderRadius.circular(15)),
                          width: 133.3,
                          height: 35.2,
                          child: const TextButton(
                              onPressed: null,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Spend',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff127422)),
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
                                  'Spend',
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
                                        'Spend',
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
                                  color: Color(0xff23AA59),
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
                                  'Spend',
                                  style: TextStyle(
                                      fontSize: 16, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    }
                  }

                  Widget save() {
                    if (myWidth < 768) {
                      if (_index == 1) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffC1FFD3),
                              borderRadius: BorderRadius.circular(15)),
                          width: 133.3,
                          height: 35.2,
                          child: const TextButton(
                              onPressed: null,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff127422)),
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
                                  'Save',
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
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mode.brightText1),
                                      ),
                                    )),
                              ),
                              Container(
                                width: (myWidth - 30) / 2,
                                height: 7,
                                color: Color(0xff23AA59),
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
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 16, color: mode.dimText1),
                                ),
                              )),
                        );
                      }
                    }
                  }

                  Widget getCon() {
                    if (_index == 0) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed('SavingsTransfer'),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/savings_transfer.svg'),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Transfer',
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
                                              .pushNamed('AccountOfficer');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/invest_plus.svg',
                                                color: const Color(0xff23AA59),
                                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(4.77)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('WithdrawSavings');
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recent Transactions',
                                    style: TextStyle(
                                      color: mode.brightText1,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Container(
                                    width: 65,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0xff78e58f)),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('Transactions');
                                      },
                                      child: const Text(
                                        'View All',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TransList(),
                          ],
                        ),
                      );
                    } //for save
                    else {
                      double saveheight = 0;
                      if (myWidth < 768) {
                        saveheight =
                            (myHeight - (myWidth - 20) / 2.263) - 168.2;
                      } else {
                        saveheight = myHeight - 319.2;
                      }

                      Widget saveList() {
                        if (myWidth < 768) {
                          return ListView(
                            children: [
                              //funding wallet
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: mode.background1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 70,
                                  child: SizedBox(
                                    child: TextButton(
                                      onPressed: null,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                'assets/svg/flex_wallet.svg'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: myWidth - 118,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Funding Wallet',
                                                    style: TextStyle(
                                                        color: mode.brightText1,
                                                        fontSize: 11),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffC1FFD3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 0),
                                                      child: Center(
                                                        child: FundingBal(),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                ),
                              ),
                              //Target Savings
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: mode.background1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 70,
                                  child: SizedBox(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          savingsI = 3;
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                'assets/svg/target_savings.svg'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: myWidth - 118,
                                              child: Row(
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
                                                        'Target Savings',
                                                        style: TextStyle(
                                                            color: mode
                                                                .brightText1,
                                                            fontSize: 11),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        'Accomplish your savings goals faster and easier',
                                                        style: TextStyle(
                                                            color: mode
                                                                .brightText1,
                                                            fontSize: 7),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: mode.brightText1,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } //for tablets
                        else {
                          return ListView(
                            children: [
                              //schedule deductions
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Row(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: mode.background1,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 110,
                                      width: (myWidth - 30) / 2,
                                      child: SizedBox(
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              savingsI = 4;
                                            });
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Row(children: [
                                                SvgPicture.asset(
                                                  'assets/svg/schedule.svg',
                                                  width: 86,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                SizedBox(
                                                  width: (myWidth / 2) - 152,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Schedule Deductions',
                                                        style: TextStyle(
                                                            color: mode
                                                                .brightText1,
                                                            fontSize: 20),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 18,
                                                        color: mode.brightText1,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //funding wallet
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: mode.background1,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 110,
                                      width: (myWidth - 30) / 2,
                                      child: SizedBox(
                                        child: TextButton(
                                          onPressed: null,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Row(children: [
                                                SvgPicture.asset(
                                                    'assets/svg/flex_wallet.svg',
                                                    width: 86),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                SizedBox(
                                                  width: (myWidth / 2) - 152,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Funding Wallet',
                                                        style: TextStyle(
                                                            color: mode
                                                                .brightText1,
                                                            fontSize: 20),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffC1FFD3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 10, 0),
                                                          child: Center(
                                                            child: FundingBal(),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Row(children: [
                                //Target Savings
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 110,
                                    width: (myWidth - 30) / 2,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            savingsI = 3;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/target_savings.svg',
                                                  width: 86),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SizedBox(
                                                width: (myWidth / 2) - 152,
                                                child: Row(
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
                                                          'Target Savings',
                                                          style: TextStyle(
                                                              color: mode
                                                                  .brightText1,
                                                              fontSize: 20),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Container(
                                                          width: (myWidth / 2) -
                                                              180,
                                                          child: Text(
                                                            'Accomplish your savings goals faster and easier',
                                                            style: TextStyle(
                                                                color: mode
                                                                    .brightText1,
                                                                fontSize: 13),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: mode.brightText1,
                                                      size: 18,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                ),
                                //elevate plus
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 110,
                                    width: (myWidth - 30) / 2,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            savingsI = 2;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/elevate_plus.svg',
                                                  width: 86),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SizedBox(
                                                width: (myWidth / 2) - 152,
                                                child: Row(
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
                                                          'Elevate Plus',
                                                          style: TextStyle(
                                                              color: mode
                                                                  .brightText1,
                                                              fontSize: 20),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Text(
                                                          'Save up charges from loan repayments',
                                                          style: TextStyle(
                                                              color: mode
                                                                  .brightText1,
                                                              fontSize: 13),
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
                            ],
                          );
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: saveheight,
                          child: saveList(),
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 45, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Savings Account',
                                      style: TextStyle(
                                          fontSize: 15.31,
                                          color: mode.brightText1),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                              //card end
                              const SizedBox(
                                height: 15,
                              ),
                              //spend or save
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    spend(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    save(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //spend or save container
                              getCon(),
                            ]),
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

                  //building custom widgets
                  Widget noSavings() {
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
                              color: const Color(0xff12201B),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: const Color(0xff579668))),
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'You don’t have a Savings',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    ),
                                    const Text(
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
                    } //for tablet
                    else {
                      return (Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: myWidth - 20,
                          height: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xff12201B),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1, color: const Color(0xff579668))),
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'You don’t have a Savings',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffE0F5E9)),
                                    ),
                                    const Text(
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
                                  'Savings Account',
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
                          //card end
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
                                    Navigator.of(context)
                                        .pushNamed('ApplySavings');
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                            'assets/svg/naira_jar.svg'),
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
                                                    'Send an Application for Elevate',
                                                    style: TextStyle(
                                                        color: mode.brightText1,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    'Alliance Savings Account',
                                                    style: TextStyle(
                                                        color: mode.brightText1,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                                color: mode.brightText1,
                                              )
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
                                color: Color(0xff23AA59),
                              ),
                              height: 105,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(children: [
                                    SvgPicture.asset(
                                        'assets/svg/circle_percent.svg'),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: myWidth - 136,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Earn Interests on your Deposits',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
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
