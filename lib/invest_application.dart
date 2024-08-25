import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';

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



class InvestApplication extends StatefulWidget {
  @override
  _InvestApplicationState createState() => _InvestApplicationState();
}

final List<Map<String, dynamic>> tenures = [
  {
    'value': '1',
    'label': '1 Month',
  },
  {
    'value': '2',
    'label': '2 Months',
  },
  {
    'value': '3',
    'label': '3 Months',
  },
  {
    'value': '4',
    'label': '4 Months',
  },
  {
    'value': '5',
    'label': '5 Months',
  },
  {
    'value': '6',
    'label': '6 Months',
  },
  {
    'value': '7',
    'label': '7 Months',
  },
  {
    'value': '8',
    'label': '8 Months',
  },
  {
    'value': '9',
    'label': '9 Months',
  },
  {
    'value': '10',
    'label': '10 Months',
  },
  {
    'value': '11',
    'label': '11 Months',
  },
  {
    'value': '12',
    'label': '12 Months',
  },
];

dynamic mode = mode;
bool inivalue = false;

class _InvestApplicationState extends State<InvestApplication> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final tenureCon = TextEditingController();
  final autoCon = TextEditingController();
  String autotxt = 'Disabled';

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



      Widget realcontinue = TextButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffF6B41A)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        child: const Text(
          'Send Application',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );


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
                            setState(() {
                              savingsI = 3;
                            });
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
                    Container(
                      child: Text("Investment Application",
                          style: TextStyle(
                            fontSize: 15,
                            color: mode.brightText1,
                          )),
                    ),
                    const SizedBox(
                      width: 40,
                    )
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
                    const Text('Secure an Investment with \nElevate Alliance',
                        style: TextStyle(
                            color: Color(0xffF6B41A),
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(
                        'Enter amount in which you want to deposit. The threshold for \ngaining interest is stated.',
                        style: TextStyle(
                          color: mode.dimText2,
                          fontSize: 10,
                        ))
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
                  height: myHeight - 195,
                  width: myWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView(
                      children: [
                        //first
                        Text(
                          'Amount',
                          style: TextStyle(color: mode.dimText1, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: myWidth - 20,
                          child: TextField(
                            style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              alignLabelWithHint: false,
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 15, 0),
                                    child: Text(
                                      'NGN',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: mode.dimText1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.8, color: mode.brightText1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mode.fieldBorder)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //second
                        Text(
                          'Interest Threshold',
                          style: TextStyle(color: mode.dimText1, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: myWidth - 20,
                          child: TextField(
                            style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              alignLabelWithHint: false,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.8, color: mode.brightText1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mode.fieldBorder)),
                            ),
                          ),
                        ),
                        Text(
                          ' Deposits must be up to the stated amount to qualify for interests',
                          style: TextStyle(
                            fontSize: 10,
                            color: mode.dimText1,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //third
                        Text(
                          'Tenure of Investment',
                          style: TextStyle(color: mode.dimText1, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: myWidth - 20,
                          child: SelectFormField(
                            items: tenures,
                            controller: tenureCon,
                            type: SelectFormFieldType.dropdown,
                            decoration: InputDecoration(
                              filled: true,
                              alignLabelWithHint: false,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: Container(
                                child: Text(
                                  'Tenure of Investment',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: mode.dimText1,
                                  ),
                                ),
                              ),
                              fillColor: mode.selectfieldColor,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: 1, color: mode.fieldBorder)),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(10, 17, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  size: 7,
                                  color: Color(0xff231E54),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      width: 1, color: mode.fieldBorder)),
                            ),
                            style: TextStyle(
                                color: mode.dimText1,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //fourth

                        const SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: myWidth - 20,
                          height: 53,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffFFEFC9)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "NOTE: After your application has been approved, go to Account > Documents to upload proof of payment.",
                                    style: TextStyle(
                                      fontSize: 9.5,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: myWidth - 20,
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: myWidth - 20,
                              child: realcontinue,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]));
    })));
  }
}
