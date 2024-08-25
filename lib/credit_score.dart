import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

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



Map<String, double> creditMap = {
  "Early": 2.5,
  "Ontime": 5,
  "Late": 2.5,
};

final List loans = ['Elevate Market Money', 'Elevate Acquire'];



// ignore: must_be_immutable
class CreditScore extends StatefulWidget {
  CreditScore({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _CreditScoreState createState() => _CreditScoreState();
}

dynamic mode = mode;

class _CreditScoreState extends State<CreditScore> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

 
 
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      //building custom widget

      Widget CreditLoans() {
        Widget column;
        List<Widget> babies = [];
        for (var item in loans) {
          Widget container = Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/credit_loan_icon.svg',
                  height: 35.66,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  item,
                  style: TextStyle(
                    color: mode.brightText1,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
          babies.add(container);
        }
        column = Column(
          children: babies,
        );
        return column;
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
                                accountI = 8;
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
                        'Credit Score',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mode.brightText1,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              //other items in security after header
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: myHeight - 85,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: myWidth - 20,
                        decoration: BoxDecoration(
                          color: mode.background2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Repayment history',
                                  style: TextStyle(
                                    color: mode.brightText1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: myWidth - 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          PieChart(
                                            dataMap: creditMap,
                                            animationDuration: const Duration(
                                                milliseconds: 800),
                                            chartLegendSpacing: 32,
                                            chartRadius: myWidth / 3,
                                            colorList: const [
                                              Color(0xff575A96),
                                              Color(0xff23AA59),
                                              Color(0xffFF5F00),
                                            ],
                                            initialAngleInDegree: 90,
                                            chartType: ChartType.disc,
                                            legendOptions: LegendOptions(
                                              showLegendsInRow: false,
                                              legendPosition:
                                                  LegendPosition.right,
                                              showLegends: true,
                                              legendShape: BoxShape.circle,
                                              legendTextStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: mode.brightText1),
                                            ),
                                            chartValuesOptions:
                                                const ChartValuesOptions(
                                              showChartValueBackground: false,
                                              showChartValues: true,
                                              showChartValuesInPercentage: true,
                                              showChartValuesOutside: false,
                                              decimalPlaces: 0,
                                              chartValueStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            // gradientList: ---To add gradient colors---
                                            // emptyColorGradient: ---Empty Color gradient---
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: myWidth - 60,
                                  height: 1,
                                  color: mode.kunleStroke,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: myWidth - 60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Last Paid Early:',
                                              style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Container(
                                                height: 24,
                                                width: 102,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff575A96),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  '21-Jan-2023',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Last Paid On-time:',
                                              style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Container(
                                                height: 24,
                                                width: 102,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff23AA59),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  '21-Jan-2023',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Last Paid Late:',
                                              style: TextStyle(
                                                color: mode.brightText1,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Container(
                                                height: 24,
                                                width: 102,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffFF5F00),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  '21-Jan-2023',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: myWidth - 20,
                        decoration: BoxDecoration(
                          color: mode.background2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type of Loan',
                                  style: TextStyle(
                                    color: mode.brightText1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CreditLoans(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: myWidth - 20,
                        decoration: BoxDecoration(
                          color: mode.background2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Credit History Length',
                                  style: TextStyle(
                                    color: mode.brightText1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'First loan approved on ',
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 12,
                                          fontFamily:
                                              GoogleFonts.notoSans().fontFamily,
                                        )),
                                    TextSpan(
                                        text: '1st March 2020',
                                        style: TextStyle(
                                          color: const Color(0xff231E54),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          fontFamily:
                                              GoogleFonts.notoSans().fontFamily,
                                        )),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ));
    })));
  }
}
