import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'humanizeAmount.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'models/databaseHelper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/user.dart';


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



class WithdrawInvest extends StatefulWidget {
  @override
  _WithdrawInvestState createState() => _WithdrawInvestState();
}

final List<Map<String, dynamic>> fromAcc = [
  {
    'value': 'EA Invesment',
    'label': 'EA Invesment Savings',
  },
];

final List<Map<String, dynamic>> toAcc = [
  {
    'value': 'EA Savings',
    'label': 'EA Savings Account',
  },
];

dynamic mode = mode;

class _WithdrawInvestState extends State<WithdrawInvest> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final fromCon = TextEditingController();
  final toCon = TextEditingController();
  final amountCon = TextEditingController();
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
    toCon.text = toAcc[0]['value'];
    fromCon.text = fromAcc[0]['value'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
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
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

      Widget realcontinue = TextButton(
        onPressed: () async {
          Future(() async {

            User sets = await DatabaseHelper.instance.getUser();
            String acc = sets.account;
            String from = 'Savings Account / ' + acc;
            await DatabaseHelper.instance.settrans(
                'Investment Account / Elevate Alliance',
                'Savings Account / Elevate Alliance',
                amountCon.text,
                'Transfer to Savings Account');

          }).then((value) {
            Navigator.of(context).pushNamed('EnterPin');
          });
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffF6B41A)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

      continuebtn = greycontinue;
      continuebtn = greycontinue;
      if (amountCon.text.length >= 3) {
        continuebtn = realcontinue;
      }

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
              height: myHeight - 75,
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text('Withdraw',
                        style: TextStyle(
                            color: mode.brightText1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //first
                  Container(
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: mode.background1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          //first
                          Text(
                            'Amount',
                            style:
                                TextStyle(color: mode.dimText1, fontSize: 11),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 60,
                            width: myWidth - 20,
                            child: TextField(
                              controller: amountCon,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  double inivalue = getNum(value);
                                  String humanVal = humanizeNo(inivalue);
                                  setState(() {
                                    amountCon.value = TextEditingValue(
                                      text: humanVal,
                                      selection: TextSelection.collapsed(
                                          offset: humanVal.length),
                                    );
                                  });
                                }
                              },
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 15, 0),
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
                                    borderSide:
                                        BorderSide(color: mode.brightText1)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff9DADEC))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //second
                          Text(
                            'From',
                            style:
                                TextStyle(color: mode.dimText1, fontSize: 11),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 60,
                            width: myWidth - 20,
                            child: SelectFormField(
                              items: fromAcc,
                              controller: fromCon,
                              type: SelectFormFieldType.dropdown,
                              decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                          const SizedBox(
                            height: 10,
                          ), //fourth
                          Text(
                            'To',
                            style:
                                TextStyle(color: mode.dimText1, fontSize: 11),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 60,
                            width: myWidth - 20,
                            child: SelectFormField(
                              items: toAcc,
                              controller: toCon,
                              type: SelectFormFieldType.dropdown,
                              decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: false,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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

                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: myWidth - 20,
                            child: continuebtn,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]));
    })));
  }
}
