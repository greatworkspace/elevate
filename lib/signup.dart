import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'shaker.dart';
import 'overlay.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

final emailed = TextEditingController();
final fullnamed = TextEditingController();

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget btnwidget = Container();
  Widget bodywidget = Container();
  String loaded = 'no';
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
                width: 70,
                child: TextField(
                  controller: fullnamed,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" "))
                  ],
                  obscureText: false,
                  decoration: InputDecoration(
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
                width: 4,
              ),
              SizedBox(
                width: myWidth - 134,
                child: TextField(
                  controller: fullnamed,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" "))
                  ],
                  obscureText: false,
                  decoration: InputDecoration(
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
          const SizedBox(
            height: 30,
          ),
        ],
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
                bodywidget = bodywidget2;
              });
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
                        'Get Started',
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
