// ignore_for_file: must_be_immutable

import 'package:elevate/home.dart';
import 'package:elevate/humanizeAmount.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'target_saving.dart';

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

bool warnText = true;

class TargetSavingDetails extends StatefulWidget {
  TargetSavingDetails({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _TargetSavingDetailsState createState() => _TargetSavingDetailsState();
}

dynamic mode = mode;

class _TargetSavingDetailsState extends State<TargetSavingDetails> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

  Map item = targets.where((element) => element['id'] == targetD).toList()[0];
  DateTime itemenddate = DateTime.now();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          double iniwidth;
          if (myWidth > 400) {
            iniwidth = 400;
          } else {
            iniwidth = myWidth;
          }

          //building custom widgets
          //targets

          Widget MyTargetActivities() {
            List<Widget> targetwids = [];
            Map item = targets
                .where((element) => element['id'] == targetD)
                .toList()[0];
            String transstr = item['trans'];
            if (transstr != '') {
              // ignore: unused_local_variable
              List trans_id = item['trans'].split(',').map(int.parse).toList();
            }
            List<Map> trans = List.empty();
            double myConHeight =
                ((trans.length * 64) + trans.length - 1).ceilToDouble();
            if (myConHeight > myHeight - 90 - ((myWidth - 20) / 2.263) - 220) {
              myConHeight = myHeight - 90 - ((myWidth - 20) / 2.263) - 220;
              if (myConHeight < 0) {
                myConHeight = 0;
              }
            }
            if (trans.length == 0) {
              myConHeight = 0;
            }
            for (var item in trans) {
              Widget mybar = Container();
              if (item['id'] !=
                  targets.elementAt(targetD - 1)['transactions'].length) {
                mybar = Container(
                  width: myWidth,
                  height: 1,
                  color: mode.kunleStroke,
                );
              }
              Widget container = Container(
                decoration: BoxDecoration(
                  color: mode.background2,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: SizedBox(
                        height: 54,
                        width: myWidth - 20,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/success_tick.svg',
                                height: 39,
                                width: 39,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: myWidth - 151.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['status'] + ': ' + item['name'],
                                      style: TextStyle(
                                          fontSize: iniwidth / 31,
                                          color: mode.brightText1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item['date'],
                                      style: TextStyle(
                                          fontSize: 9.5, color: mode.dimText1),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                humanizeNo(item['amount']),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: mode.brightText1,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    mybar,
                  ],
                ),
              );
              targetwids.add(container);
            }

            return SizedBox(
              height: myConHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: targetwids,
                ),
              ),
            );
          }

          Map item =
              targets.where((element) => element['id'] == targetD).toList()[0];
          Widget TopCard() {
            if (myWidth < 767 && myHeight >= 580) {
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
                    padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                    child: Builder(
                      builder: (context) {
                        double iniwidth;
                        if (myWidth > 600) {
                          iniwidth = 600;
                        } else {
                          iniwidth = myWidth;
                        }
                        double btnWidth = iniwidth * 50 / 100 - 36;
                        double btnWidth2 = iniwidth * 50 / 100 - 36;
                        double btnHeight = (iniwidth * 60 / 100) / 7;
                        double target_ratio =
                            (item['balance'] / item['target']);
                        if (target_ratio > 1) {
                          target_ratio = 1;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: iniwidth / 30,
                            ),
                            Text(
                              item['name'],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
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
                                  humanizeNo(item['balance']),
                                  style: TextStyle(
                                    fontSize: iniwidth / 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: myWidth,
                              height: 21,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        humanizeNo(item['balance']),
                                        style: const TextStyle(
                                            fontSize: 9.5, color: Colors.white),
                                      ),
                                      Text(
                                        humanizeNo(item['target']),
                                        style: const TextStyle(
                                          fontSize: 9.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 4,
                                    width: myWidth - 62,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff5D8C7B)),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 5,
                                          width: target_ratio * (myWidth - 62),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Interest for 30 days',
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
                                            humanizeNo(item['balance'] *
                                                (item['interest'] / 100)),
                                            style: TextStyle(
                                                fontSize: iniwidth / 45,
                                                color: const Color(0xffEEDDEE)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
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
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'End Date:',
                                            style: TextStyle(
                                                fontSize: iniwidth / 45,
                                                color: const Color(0xffEEDDEE)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${DateFormat('MMMM d, yyyy').format(itemenddate.toLocal())}',
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
              double cardheight = 140;
              double btnWidth = 230;
              double btnWidth2 = 230;
              double btnHeight = 50;
              double balwidth = (myWidth - 72) - 460;
              double height37 = 37;
              double font25 = 25;
              double height15 = 15;
              double font13 = 13;
              if (myHeight < 580) {
                cardheight = 100;
                btnWidth = (myWidth - 72) / 2;
                btnWidth2 = (myWidth - 72) / 2;
                btnHeight = 25;
                balwidth = 0;
                height37 = 19;
                font25 = 12.5;
                height15 = 5;
                font13 = 6.5;
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: myWidth - 20,
                  height: cardheight,
                  decoration: BoxDecoration(
                      color: const Color(0xff14684A),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: const Color(0xff579668))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                    child: Builder(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height15,
                            ),
                            Text(
                              item['name'],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: balwidth,
                                  child: Row(children: [
                                    SvgPicture.asset(
                                      'assets/svg/naira.svg',
                                      height: height37,
                                      width: height37,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      humanizeNo(item['balance']),
                                      style: TextStyle(
                                        fontSize: font25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              7, 2, 7, 2),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Interest for 30 days',
                                                style: TextStyle(
                                                  fontSize: font13,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SvgPicture.asset(
                                                'assets/svg/naira.svg',
                                                height: height15,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                humanizeNo(item['balance'] *
                                                    (item['interest'] / 100)),
                                                style: TextStyle(
                                                    fontSize: iniwidth / 45,
                                                    color: const Color(
                                                        0xffEEDDEE)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
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
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              7, 2, 7, 2),
                                          child: Row(
                                            children: [
                                              Text(
                                                'End Date:',
                                                style: TextStyle(
                                                    fontSize: font13,
                                                    color: const Color(
                                                        0xffEEDDEE)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${DateFormat('MMMM d, yyyy').format(itemenddate.toLocal())}',
                                                style: TextStyle(
                                                    fontSize: font13,
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
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: myWidth,
                              height: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        humanizeNo(item['balance']),
                                        style: const TextStyle(
                                            fontSize: 9.5, color: Colors.white),
                                      ),
                                      Text(
                                        humanizeNo(item['target']),
                                        style: const TextStyle(
                                          fontSize: 9.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 4,
                                    width: myWidth - 62,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff5D8C7B)),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 5,
                                          width: (item['balance'] /
                                                  item['target']) *
                                              (myWidth - 62),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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

          double height78 = 78;
          double height38 = 38;
          double pad10 = 10;
          if (myHeight <= 580) {
            height78 = 58;
            pad10 = 5;
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
                                    savingsI = 3;
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
                  const SizedBox(
                    height: 15,
                  ),
                  //top card
                  TopCard(),
                  //card end
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: myHeight - 85 - (myWidth - 20) / 2.263,
                    child: Column(
                      children: [
                        //create target
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: SizedBox(
                            height: height78,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('EditTarget');
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Container(
                                height: height78,
                                width: myWidth - 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xff23AA59),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(pad10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/create_target.svg',
                                        height: height38,
                                        width: height38,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: myWidth - 89.2,
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
                                                  'Edit Target - ' +
                                                      item['name'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Text(
                                                  'You can adjust targets however you please.',
                                                  style: TextStyle(
                                                      fontSize: 9.5,
                                                      letterSpacing: 0.2,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            const Icon(
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
                        ),
                        //edit target end
                        //create target
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: SizedBox(
                            height: height78,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  savingsI = 3;
                                });
                                Navigator.of(context)
                                    .pushNamed('WithdrawTarget');
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: Container(
                                height: height78,
                                width: myWidth - 20,
                                decoration: BoxDecoration(
                                    color: mode.background2,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(pad10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/withdraw_arrow.svg',
                                        height: height38,
                                        width: height38,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: myWidth - 89.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Withdraw',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff23AA59),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color(0xff23AA59),
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
                        ),
                        //create target end
                        const SizedBox(
                          height: 10,
                        ),
                        //my activities
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Container(
                                  child: Text('Activities',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: mode.brightText1,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                              MyTargetActivities(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        })));
  }
}
