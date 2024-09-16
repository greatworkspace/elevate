import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/databaseHelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

dynamic mode = mode;

class _PrivacyState extends State<Privacy> {
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

  void initState() {
    super.initState();
    getMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          //scaffold body starts here
          return Container(
              decoration: BoxDecoration(
                color: mode.background3,
              ),
              child: Column(children: [
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: mode.background2,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: mode.headerDivider,
                        ),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mode.brightText1,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                  ),
                ),
                //other items in security after header
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: myWidth,
                    child: Center(
                      child: Text(
                        'Terms of Service',
                        style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: mode.background1,
                  height: myHeight - 212,
                  width: myWidth,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Statement',
                            style: TextStyle(
                                fontSize: 15,
                                color: mode.brightText1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. ',
                            style: TextStyle(
                              fontSize: 13,
                              color: mode.brightText1,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Information we gather',
                            style: TextStyle(
                                fontSize: 15,
                                color: mode.brightText1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. ',
                            style: TextStyle(
                              fontSize: 13,
                              color: mode.brightText1,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Third Parties with access to Information',
                            style: TextStyle(
                                fontSize: 15,
                                color: mode.brightText1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. ',
                            style: TextStyle(
                              fontSize: 13,
                              color: mode.brightText1,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'How we use location data',
                            style: TextStyle(
                                fontSize: 15,
                                color: mode.brightText1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. ',
                            style: TextStyle(
                              fontSize: 13,
                              color: mode.brightText1,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Container(
                    height: 75,
                    width: myWidth,
                    color: mode.background1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'For more information, ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: GoogleFonts.notoSans().fontFamily,
                                  color: mode.brightText1,
                                ),
                              ),
                              TextSpan(
                                  text: 'www.elevatemfb.com ',
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.notoSans().fontFamily,
                                    color: const Color(0xff0080C8),
                                    fontSize: 12,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final Uri url =
                                          Uri.parse('https://elevatemfb.com');
                                      await launchUrl(url);
                                    }),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]));
        })));
  }
}
