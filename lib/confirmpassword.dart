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

final storage = const FlutterSecureStorage();
bool obscure = true;
String loaded = 'no';

final conpass = TextEditingController();
final conconpass = TextEditingController();

class KeyClass {
  static final shakeKey1 = const Key('__RIKEY1__');
  static final shakeKey2 = const Key('__RIKEY2__');
}

class ConfirmPasswordScreen extends StatefulWidget {
  @override
  _ConfirmPasswordScreenState createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  @override
  bool samepass = false;
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      Widget bodywidget = Container();
      Widget btnwidget = Container();

      Widget HideWid() {
        return SizedBox(
          width: 40,
          height: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                child: Icon(
                  FontAwesomeIcons.solidEyeSlash,
                  size: 15,
                )),
          ),
        );
      }

      Widget ShowWid() {
        return SizedBox(
          width: 40,
          height: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                child: Icon(
                  FontAwesomeIcons.solidEye,
                  size: 15,
                )),
          ),
        );
      }

      Widget HideButton() {
        if (obscure == true) {
          return ShowWid();
        } else {
          return HideWid();
        }
      }

      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
        child: Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffD9D9D9)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xffD9D9D9),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      Widget realcontinue = TextButton(
        onPressed: () => Navigator.of(context).pushNamed('Home'),
        child: Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff122774)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xff122774),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
      );

      continuebtn = greycontinue;

      Widget Confirmpassword;
      bool changed = false;

      Widget normalfield = TextField(
        controller: conpass,
        onChanged: (value) async {
          String inivalue = value;
          setState(() {
            changed = true;
          });
          await storage.read(key: 'password').then((value) {
            if (inivalue == value) {
              setState(() {
                samepass = true;
              });
            }
          });
        },
        obscureText: obscure,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          filled: true,
          suffixIcon: HideButton(),
          fillColor: Color(0xffD9D9D9),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xffD9D9D9))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xffD9D9D9))),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      );

      Widget greenfield = TextField(
        controller: conpass,
        obscureText: obscure,
        onChanged: (value) async {
          String inivalue = value;
          setState(() {
            changed = true;
          });
          await storage.read(key: 'password').then((value) {
            if (inivalue == value) {
              setState(() {
                samepass = true;
              });
            }
          });
        },
        decoration: InputDecoration(
          alignLabelWithHint: false,
          filled: true,
          suffixIcon: HideButton(),
          fillColor: Color(0xffD9D9D9),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xff44FC00))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xff44FC00))),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      );

      Widget redfield = TextField(
        controller: conpass,
        obscureText: obscure,
        onChanged: (value) async {
          String inivalue = value;
          setState(() {
            changed = true;
          });
          await storage.read(key: 'password').then((value) {
            if (inivalue == value) {
              Confirmpassword = greenfield;
              continuebtn = realcontinue;
              Future.delayed(Duration(seconds: 2));
              setState(() {
                samepass = true;
              });
            }
          });
        },
        decoration: InputDecoration(
          alignLabelWithHint: false,
          filled: true,
          suffixIcon: HideButton(),
          fillColor: Color(0xffD9D9D9),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xffF23C3D))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Color(0xffF23C3D))),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      );

      loaded = 'yes';

      Confirmpassword = normalfield;
      if (conpass.text.length > 0) {
        if (samepass == true) {
          Confirmpassword = greenfield;
          continuebtn = realcontinue;
        } else {
          Confirmpassword = redfield;
          continuebtn = greycontinue;
        }
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
                        'Almost Done!',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: myWidth - 60,
                        child: Confirmpassword,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: SizedBox(
                  height: 56,
                  width: myWidth - 60,
                  child: continuebtn,
                ),
              ),
            ],
          ));
    }));
  }
}
