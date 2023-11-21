import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

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



class UploadDocument extends StatefulWidget {
  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

final List<Map<String, dynamic>> sourcetypes = [
  {
    'value': 'Monthly',
    'label': 'EA Flexible Wallet',
  },
];

dynamic mode = mode;
String loanAmount = '20,000';

class _UploadDocumentState extends State<UploadDocument> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

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



  FilePickerResult? result;

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    bool inivalue;
    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      // creating custom widgets

      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Send',
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
        onPressed: () {
          Navigator.of(context).pushNamed('EnterPin');
        },
        child: const Text(
          'Send',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff231E54)),
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
                    SizedBox(
                      width: myWidth - 80,
                      child: Center(
                        child: Text(
                          'Upload Document',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mode.brightText1,
                              fontSize: 15),
                        ),
                      ),
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
                    Text(
                        'Browse through your files and import the proof \nof payment.',
                        style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 15,
                        )),
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
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        //first
                        SizedBox(
                          width: myWidth - 20,
                          height: 95,
                          child: TextButton(
                            onPressed: () async {
                              result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg', 'pdf']);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: DottedBorder(
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                dashPattern: const [8, 9, 8, 9],
                                radius: const Radius.circular(10),
                                padding: const EdgeInsets.all(6),
                                color: const Color(0xff231E54),
                                child: SizedBox(
                                  height: 95,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            'Click here to upload',
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
                        const SizedBox(
                          height: 20,
                        ),
                        //first
                        Text(
                          'Purpose of payment',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: Container(
                                child: Text(
                                  'add a note',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    color: mode.dimText1,
                                  ),
                                ),
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
                          'Amount paid',
                          style: TextStyle(color: mode.dimText1, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: myWidth - 20,
                          child: TextField(
                            keyboardType: TextInputType.number,
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
                        //third
                        Text(
                          'Account number paid from',
                          style: TextStyle(color: mode.dimText1, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: myWidth - 20,
                          child: TextField(
                            keyboardType: TextInputType.number,
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
                        const SizedBox(
                          height: 10,
                        ),
                        //fourth
                        Text(
                          'Bank paid from',
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
                        const SizedBox(
                          height: 10,
                        ),
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
                    SizedBox(
                      height: 50,
                      width: myWidth - 20,
                      child: realcontinue,
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
