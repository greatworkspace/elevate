import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
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



class ApplySavings extends StatefulWidget {
  @override
  _ApplySavingsState createState() => _ApplySavingsState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;

class _ApplySavingsState extends State<ApplySavings> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();
  dynamic termsVal = false;

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
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      // ignore: unused_local_variable
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
        onPressed: () async {
          Navigator.pop(context);
        },
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
            color: mode.background2,
          ),
          child: Column(children: [
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
                            Navigator.pop(context);
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
              height: 100,
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Save your money with\nElevate Alliance',
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: myHeight - 260,
                  width: myWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListView(
                      children: [
                        //first
                        Text(
                          'Terms & Conditions',
                          style: TextStyle(
                              color: mode.brightText1,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Customers can withdraw funds from their savings account when needed, there may be restrictions on the number of withdrawals allowed per month, and some loan management companies may charge fees for excessive withdrawals. However, Savings account with Loan Account cannot withdraw beyond 10% of the loan in service.',
                          style: TextStyle(
                            fontSize: 13,
                            color: mode.brightText1,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'In summary, a savings account is a type of deposit product offered by loan management companies that allows customers to deposit and withdraw funds while earning interest on their deposits. Savings accounts provide ',
                                style: TextStyle(
                                  color: mode.brightText1,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontFamily: GoogleFonts.notoSans().fontFamily,
                                )),
                            TextSpan(
                                text: 'Elevate Alliance (EA)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: mode.brightText1,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontFamily: GoogleFonts.notoSans().fontFamily,
                                )),
                            TextSpan(
                                text:
                                    ' with a source of funds that they can use to lend out as loans.',
                                style: TextStyle(
                                  color: mode.brightText1,
                                  fontSize: 13,
                                  height: 1.5,
                                  fontFamily: GoogleFonts.notoSans().fontFamily,
                                ))
                          ]),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 25,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  if (termsVal == false) {
                                    setState(() {
                                      termsVal = true;
                                    });
                                  } else {
                                    setState(() {
                                      termsVal = false;
                                    });
                                  }
                                },
                                child: Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color(0xff007452)),
                                    value: termsVal,
                                    groupValue: true,
                                    onChanged: null),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'I agree with the Terms & Conditions',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff007452),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: myWidth - 20,
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SizedBox(
                        height: 50,
                        width: myWidth - 40,
                        child: realcontinue,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ]),
                )
              ],
            )
          ]));
    })));
  }
}
