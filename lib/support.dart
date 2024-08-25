import 'package:dotted_border/dotted_border.dart';
import 'package:elevate/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
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



class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
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

class _SupportState extends State<Support> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final emailCon = TextEditingController();
  final nameCon = TextEditingController();
  final messageCon = TextEditingController();
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



  FilePickerResult? attachment;

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets



      Widget realcontinue = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Submit Ticket',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff231E54)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
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
                    child: Text('Support Ticket',
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
                        children: [
                          SizedBox(
                            height: myHeight - 222,
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                //first
                                Text(
                                  'Full Name',
                                  style: TextStyle(
                                      color: mode.dimText1, fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: nameCon,
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.brightText1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9DADEC))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                //second
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                      color: mode.dimText1, fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: emailCon,
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.brightText1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9DADEC))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ), //fourth
                                Text(
                                  'Message',
                                  style: TextStyle(
                                      color: mode.dimText1, fontSize: 11),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: messageCon,
                                    maxLines: 8,
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.brightText1)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9DADEC))),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: myWidth - 20,
                                  height: 95,
                                  child: TextButton(
                                    onPressed: () async {
                                      attachment = await FilePicker.platform
                                          .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                            'png',
                                            'jpg',
                                            'pdf'
                                          ]);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: DottedBorder(
                                        strokeWidth: 1,
                                        borderType: BorderType.RRect,
                                        dashPattern: [8, 9, 8, 9],
                                        radius: const Radius.circular(10),
                                        padding: const EdgeInsets.all(6),
                                        color: const Color(0xff9DADEC),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/svg/floating_home_document.svg',
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  const Text(
                                                    'Click here to upload  attachment',
                                                    style: TextStyle(
                                                      color: Color(0xff231E54),
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: myWidth - 20,
                            child: realcontinue,
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
