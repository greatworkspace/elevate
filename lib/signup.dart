import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'shaker.dart';
import 'overlay.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:country_flags/country_flags.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

Widget nglabel = Row(children: [
  CountryFlags.flag(
    'ng',
    width: 24,
    height: 20,
    borderRadius: 5,
  ),
  Text('+234')
]);
final List<Map<String, dynamic>> _locations = [
  {
    'value': '+234',
    'label': '+234',
    'icon': Container(
        child: CountryFlags.flag(
      'ng',
      width: 24,
      height: 20,
      borderRadius: 5,
    ))
  },
];
final storage = const FlutterSecureStorage();

final emailed = TextEditingController();
final fullnamed = TextEditingController();

final phonenumber = TextEditingController();
final code1 = TextEditingController();
final code2 = TextEditingController();
final code3 = TextEditingController();
final code4 = TextEditingController();
final country = TextEditingController(text: '+234');
final FocusNode code1focus = FocusNode();
final FocusNode code2focus = FocusNode();
final FocusNode code3focus = FocusNode();
final FocusNode code4focus = FocusNode();

class _SignupScreenState extends State<SignupScreen> {
  late Timer _timer;
  int _start = 30;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget btnwidget = Container();
  Widget bodywidget = Container();
  String loaded = 'no';
  String titleText = 'Get Started';
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      //bodywidget 1

      Widget bodywidget1 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Full Name',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          TextField(
            controller: fullnamed,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(" "))],
            obscureText: false,
            decoration: const InputDecoration(
              alignLabelWithHint: false,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff898989))),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          const SizedBox(
            height: 30,
          ),

          //email field
          Container(
            child: Text(
              'Email Address',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          TextField(
            controller: emailed,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(" "))],
            obscureText: false,
            decoration: const InputDecoration(
              alignLabelWithHint: false,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff898989))),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      );

      //bodywidget 2

      Widget bodywidget2 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Verify Your Phone Number',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 90,
                child: SelectFormField(
                  items: _locations,
                  controller: country,
                  type: SelectFormFieldType.dropdown,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffD9D9D9),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      size: 10,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xffD9D9D9))),
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              SizedBox(
                width: myWidth - 154,
                child: TextField(
                  controller: phonenumber,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  obscureText: false,
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    counterText: '',
                    filled: true,
                    fillColor: Color(0xffD9D9D9),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xffD9D9D9))),
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
      Widget mytimer() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Resend Code: '),
            Container(child: Text(_start.toString())),
          ],
        );
      }

      ;

      Widget greyresend = SizedBox(
        height: 30,
        width: 100,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            backgroundColor: Color(0xffD9D9D9),
          ),
          child: Text(
            'resend',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      Widget realresend = SizedBox(
        height: 30,
        width: 100,
        child: TextButton(
          onPressed: () {
            setState(() {
              _start = 60;
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff122774),
          ),
          child: Text(
            'resend',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      getresend() {
        if (_start > 0) {
          return greyresend;
        } else {
          return realresend;
        }
      }

      //bodywidget 3
      Widget bodywidget3() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Enter Code',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: (myWidth - 90) / 4,
                  child: TextField(
                    focusNode: code1focus,
                    autofocus: true,
                    controller: code1,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => code2focus.requestFocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" "))
                    ],
                    obscureText: false,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: (myWidth - 90) / 4,
                  child: TextField(
                    controller: code2,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: code2focus,
                    onChanged: (value) => code3focus.requestFocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" "))
                    ],
                    obscureText: false,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: (myWidth - 90) / 4,
                  child: TextField(
                    controller: code3,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: code3focus,
                    onChanged: (value) => code4focus.requestFocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" "))
                    ],
                    obscureText: false,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: (myWidth - 90) / 4,
                  child: TextField(
                    controller: code4,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: code4focus,
                    onChanged: (value) => code4focus.unfocus(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(" "))
                    ],
                    obscureText: false,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: Color(0xffD9D9D9),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xffD9D9D9))),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            //end of top row
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getresend(),
                  mytimer(),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        );
      }

      //timer function

      void startTimer() {
        const oneSec = const Duration(seconds: 1);
        _timer = new Timer.periodic(
          oneSec,
          (Timer timer) {
            if (_start == 0) {
              setState(() {
                timer.cancel();
              });
            } else {
              setState(() {
                _start--;
                bodywidget = bodywidget3();
              });
            }
          },
        );
      }

      //btnwidget 3

      Widget btnwidget3 = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: SizedBox(
          height: 56,
          width: myWidth - 60,
          child: TextButton(
            onPressed: () {
              _timer.cancel();
              Navigator.of(context).pushNamed('CreatePassword');
            },
            child: Text(
              'Verify',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff122774)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff122774),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
        ),
      );

      //btnwidget 2

      Widget btnwidget2 = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: SizedBox(
          height: 56,
          width: myWidth - 60,
          child: TextButton(
            onPressed: () {
              setState(() {
                bodywidget = bodywidget3();
                btnwidget = btnwidget3;
              });
              startTimer();
            },
            child: Text(
              'Send SMS',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff122774)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff122774),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
        ),
      );

      //btnwidget 1

      Widget btnwidget1 = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: SizedBox(
          height: 56,
          width: myWidth - 60,
          child: TextButton(
            onPressed: () {
              setState(() {
                bodywidget = bodywidget2;
                btnwidget = btnwidget2;
              });
            },
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff122774)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff122774),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
        ),
      );

      //load only once
      if (loaded == 'no') {
        btnwidget = btnwidget1;
        bodywidget = bodywidget1;
      }
      loaded = 'yes';
      if (_start == 60) {
        startTimer();
      }
      return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                      child: Text(
                        titleText,
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff717171),
                        ),
                      )),
                  //Already have an account
                  Container(
                    child: Row(
                      children: [
                        const Text(
                          'Already have an Account?',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pushNamed('Login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff122774),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //full name Field
                  SizedBox(
                    height: 40,
                  ),
                  bodywidget,
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              btnwidget,
            ],
          ));
    }));
  }
}
