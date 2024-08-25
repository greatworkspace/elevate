// ignore_for_file: must_be_immutable

import 'package:elevate/home.dart';
import 'package:elevate/humanizeAmount.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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




List<Map<String, dynamic>> chartdatas = [
  {
    'id': 1,
    'month': DateFormat('MMM').format(DateTime(0, DateTime.now().month - 3)),
    'inflow': 40000,
    'outflow': 30000
  },
  {
    'id': 2,
    'month': DateFormat('MMM').format(DateTime(0, DateTime.now().month - 2)),
    'inflow': 30000,
    'outflow': 25000
  },
  {
    'id': 3,
    'month': DateFormat('MMM').format(DateTime(0, DateTime.now().month - 1)),
    'inflow': 20000,
    'outflow': 15000
  },
  {
    'id': 4,
    'month': DateFormat('MMM').format(DateTime(0, DateTime.now().month)),
    'inflow': 35000,
    'outflow': 28000
  },
];

bool warnText = true;
int targetD = 0;

class SavingsStats extends StatefulWidget {
  SavingsStats({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _SavingsStatsState createState() => _SavingsStatsState();
}

dynamic mode = mode;

class _SavingsStatsState extends State<SavingsStats> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final timesCon = TextEditingController();



  void initState() {
    super.initState();
    timesCon.text = 'Monthly';
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myWidth = constraints.maxWidth;
      if (myWidth > 600) {
      } else {
      }

      //building custom widgets
      List<BarChartGroupData> MyBarData() {
        List<BarChartGroupData> datas = [];
        for (var item in chartdatas) {
          BarChartGroupData contain = BarChartGroupData(
            barRods: [
              BarChartRodData(
                color: Color(0xff554537),
                width: 26,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
                toY: item['outflow'].toDouble(),
              ),
              BarChartRodData(
                color: Color(0xffA5F2CD),
                width: 26,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
                toY: item['inflow'].toDouble(),
              ),
            ],
            x: item['id'],
            barsSpace: -10,
          );
          datas.add(contain);
        }
        return datas;
      }

      List<Widget> titles() {
        List<Widget> titless = [];
        for (var item in chartdatas) {
          Widget contain = Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              width: 42,
              child: Center(
                child: Text(
                  item['month'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
          titless.add(contain);
        }
        return titless;
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
                        'Statistics',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mode.brightText1,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: myWidth,
                decoration: BoxDecoration(
                    color: Color(0xff23AA59),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Analytics',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Monthly',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: myWidth - 40,
                        decoration: BoxDecoration(
                          color: Color(0xff57C490),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Inflow',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          color: Color(0xffA5F2CD),
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Outflow',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          color: Color(0xff554537),
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 210,
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.center,
                                    groupsSpace: 20,
                                    borderData: FlBorderData(show: false),
                                    minY: 0,
                                    maxY: 40000,
                                    titlesData: FlTitlesData(
                                      rightTitles: AxisTitles(),
                                      topTitles: AxisTitles(),
                                      bottomTitles: AxisTitles(),
                                    ),
                                    gridData: FlGridData(
                                      show: false,
                                    ),
                                    barGroups: MyBarData(),
                                  ),
                                  swapAnimationDuration:
                                      Duration(milliseconds: 150), // Optional
                                  swapAnimationCurve: Curves.linear, // Optional
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: myWidth - 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: titles(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 146,
                            width: (myWidth - 50) / 2,
                            decoration: BoxDecoration(
                                color: Color(0xff57C490),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Savings',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/arrow_uptrend.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '10%',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/naira.svg',
                                        height: 32,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        humanizeNo(150000),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 146,
                            width: (myWidth - 50) / 2,
                            decoration: BoxDecoration(
                                color: Color(0xff57C490),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Spending',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/arrow_downtrend.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '34%',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/naira.svg',
                                        height: 32,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        humanizeNo((150000 / 100) * 34),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
    })));
  }
}
