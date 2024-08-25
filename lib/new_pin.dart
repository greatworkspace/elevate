// ignore_for_file: sized_box_for_whitespace, unused_catch_clause

import 'dart:async';
import 'dart:io';

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'models/databaseHelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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



class NewPin extends StatefulWidget {
  @override
  _NewPinState createState() => _NewPinState();
}

dynamic mode = mode;
Widget OverCon = Container();
Widget Wrongpin = Container();
Widget Failedtrans = Container();
Widget Correctpin = Container();
Widget loading = Container();
bool obscure = true;

class _NewPinState extends State<NewPin>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final newpinCon = TextEditingController();
  final newpinconCon = TextEditingController();

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

  Future changepin() async {
    setState(() {
      OverCon = loading;
    });
    try {
      String url = apiUrl + 'new/pin/';
      dynamic token = await DatabaseHelper.instance.getToken();
      Response res2 = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'token': token,
          'newpin': newpinCon.text,
        },
        body: (<String, String>{}),
      ).timeout(const Duration(seconds: 5));
      if (res2.statusCode == 200) {
        dynamic data = json.decode(res2.body);
        if (data == 'incorrect pin') {
          setState(() {
            OverCon = Wrongpin;
          });
        } else if (data == 'success') {
          setState(() {
            OverCon = Correctpin;
          });
        } else {
          setState(() {
            OverCon = Failedtrans;
          });
        }
      } else {
        setState(() {
          OverCon = Failedtrans;
        });
      }
    } on SocketException catch (e) {
      setState(() {
        OverCon = Container();
      });
      return ('network');
    } on TimeoutException catch (e) {
      setState(() {
        OverCon = Container();
      });
      return ('timeout');
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  void initState() {
    super.initState();
    getMode();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myWidth = constraints.maxWidth;
          final myHeight = MediaQuery.of(context).size.height;
          //custom widget


          Widget CustomLoader = RotationTransition(
              turns: _animation,
              child: Container(
                child: SvgPicture.asset(
                  'assets/svg/loader_icon.svg',
                  height: 30,
                  width: 40,
                  color: const Color(0xffF6B41A),
                ),
              ));
          loading = Container(
            height: myHeight - 65,
            width: myWidth,
            color: mode.loadingBg,
            child: Center(
              child: CustomLoader,
            ),
          );

          Failedtrans = Container(
              height: myHeight - 65,
              width: myWidth,
              color: mode.background2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: (myHeight / 2) - 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_failed.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Request Failed',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 54,
                                width: myWidth - 40,
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xff122774)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Color(0xff122774),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        OverCon = Container();
                                      });
                                    },
                                    child: const Text(
                                      'Try Again',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 54,
                                width: myWidth - 40,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: mode.background2,
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    index: selectedindex,
                                                  )));
                                    },
                                    child: Text(
                                      'Back to HomePage',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: mode.brightText1,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Correctpin = Container(
              height: myHeight - 65,
              width: myWidth,
              color: mode.background2,
              child: Column(
                children: [
                  SizedBox(
                    height: (myHeight / 2) - 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_sent.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Pin Changed',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          child: Container(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: mode.background2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    OverCon = Container();
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                                index: selectedindex,
                                              )));
                                },
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mode.brightText1,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Wrongpin = Container(
              height: myHeight - 65,
              width: myWidth,
              color: mode.background2,
              child: Column(
                children: [
                  SizedBox(
                    height: (myHeight / 2) - 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/svg/request_incorrect.svg'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Incorrect Pin',
                          style: TextStyle(
                            fontSize: 20,
                            color: mode.brightText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                          child: SizedBox(
                            height: 54,
                            width: myWidth - 40,
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xff122774)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Color(0xff122774),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                ),
                                onPressed: () {
                                  setState(() {
                                    OverCon = Container();
                                  });
                                },
                                child: const Text(
                                  'Try Again',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));

          Widget greycontinue = TextButton(
            onPressed: null,
            child: const Text(
              'Change Pin',
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
            },
            child: const Text(
              'Change Pin',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff122774)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xff122774),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          );

          Widget continuebtn() {
            if (
                newpinCon.text != '' &&
                newpinconCon.text != '' &&
                newpinCon.text == newpinconCon.text) {
              return realcontinue;
            } else {
              return greycontinue;
            }
          }

          Widget HideWid() {
            return Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        obscure = true;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.solidEyeSlash,
                      size: 20,
                      color: Color(0xffB7B7B7),
                    )),
              ),
            );
          }

          Widget ShowWid() {
            return Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        obscure = false;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.solidEye,
                      size: 20,
                      color: Color(0xffB7B7B7),
                    )),
              ),
            );
          }

          Widget HideButton;
          if (obscure == true) {
            HideButton = ShowWid();
          } else {
            HideButton = HideWid();
          }

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
                                OverCon = Container();
                                Navigator.of(context).pushNamed("Home");
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
                          'Transaction Pin',
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
                //other items in statement after header
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: myWidth,
                          decoration: BoxDecoration(color: mode.background3),
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '4-Digit Pin',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: mode.brightText1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: myWidth - 20,
                                    child: Text(
                                      'This pin secures your transactions. Do not share this pin to anyone.',
                                      style: TextStyle(
                                        color: mode.dimText1,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          width: myWidth,
                          decoration: BoxDecoration(
                              color: mode.background1,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  'New Pin',
                                  style: TextStyle(
                                      color: mode.brightText1, fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: newpinCon,
                                    obscureText: obscure,
                                    onChanged: (value) {
                                      setState(() {
                                        newpinCon.text = value;
                                      });
                                    },
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      suffixIcon: HideButton,
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.8,
                                              color: mode.brightText1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.fieldBorder)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Confirm Pin',
                                  style: TextStyle(
                                      color: mode.brightText1, fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  height: 60,
                                  width: myWidth - 20,
                                  child: TextField(
                                    controller: newpinconCon,
                                    obscureText: obscure,
                                    onChanged: (value) {
                                      setState(() {
                                        newpinconCon.text = value;
                                      });
                                    },
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      counterText: '',
                                      suffixIcon: HideButton,
                                      alignLabelWithHint: false,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.8,
                                              color: mode.brightText1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.fieldBorder)),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: myWidth - 20,
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 50,
                                      width: myWidth - 20,
                                      child: continuebtn(),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ]),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    OverCon
                  ],
                )
              ]));
        })));
  }
}
