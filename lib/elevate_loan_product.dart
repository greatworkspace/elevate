import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/color.dart';
import 'mainscreen.dart';
import 'models/databaseHelper.dart';

dynamic getKey(key) {
  if (key == KeyClass.shakeKey2) {
    return KeyClass.shakeKey1;
  } else {
    return KeyClass.shakeKey2;
  }
}

dynamic shakey = KeyClass.shakeKey1;

class LoanProduct extends StatefulWidget {
  LoanProduct({
    required this.amode,
    required this.index,
  });
  ColorClass amode;
  int index;
  @override
  _LoanProductState createState() => _LoanProductState();
}

final List<Map<String, dynamic>> savetypes = [
  {
    'value': 'Monthly',
    'label': 'Monthly',
  },
  {
    'value': 'Weekly',
    'label': 'Weekly',
  },
  {
    'value': 'Daily',
    'label': 'Daily',
  },
];

dynamic mode = mode;

class _LoanProductState extends State<LoanProduct> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

  Map item = loanProducts.where((element) => element['id'] == loanpi).toList()[0];

  void getMode() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? mymode = settings['mode'];
    if (mymode == null) {
      setState(() {
        mode = lightmode;
        modeCon.text = 'Light';
      });
    } else if (mymode == 'Dark') {
      setState(() {
        mode = darkmode;
        modeCon.text = 'Dark';
      });
    } else {
      setState(() {
        mode = lightmode;
        modeCon.text = 'Light';
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffD9D9D9)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xffD9D9D9),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      Widget realcontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff23AA59)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xff23AA59),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      continuebtn = greycontinue;

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
                color: mode.background1,
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
                              homeI = 1;
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
              child: Stack(
                children: [
                  Image.network(
                    item['Pimage'],
                    width: myWidth,
                    height: myWidth / 2.70588,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                      width: myWidth,
                      height: myWidth / 2.70588,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icon_shadow.png',
                            width: 71.51,
                            height: 75.59,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              color: mode.background1,
              width: myWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        item['name'].toUpperCase(),
                        style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: mode.background1,
              height: myHeight - 105 - (myWidth / 2.70588),
              child: ListView(
                children: [
                  //first container
                  Container(
                    color: mode.background1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff697CC3),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            item['description'] ?? '',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 20,),
                          RichText(text: TextSpan(children: [
                             TextSpan(
                              text: 'To apply for ',
                               style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 12,
                              height: 1.5,
                            ),
                            ),
                            TextSpan(
                              text: item['name'],
                               style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 12,
                              height: 1.5,
                            ),
                            ),
                           TextSpan(
                              text: ', visit ',
                               style: TextStyle(
                              color: mode.brightText1,
                              fontSize: 12,
                              height: 1.5,
                            ),
                            ),
                            const TextSpan(
                              text: 'www.elevate.com',
                               style: TextStyle(
                              color: Color(0xff8194DD),
                              fontSize: 12,
                              height: 1.5,
                            ),
                            )
                          ]))
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      );
    })));
  }
}
