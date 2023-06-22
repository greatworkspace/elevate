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

final newpass = TextEditingController();
final connewpass = TextEditingController();

class KeyClass {
  static final shakeKey1 = const Key('__RIKEY1__');
  static final shakeKey2 = const Key('__RIKEY2__');
}

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
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
        onPressed: () async {
          await storage.write(key: 'password', value: newpass.text);
          Navigator.of(context).pushNamed('ConfirmPassword');
        },
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

      Widget createpassword;
      bool changed = false;

      Widget normalfield = TextField(
        controller: newpass,
        onChanged: (value) {
          setState(() {
            changed = true;
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

      Widget redfield = TextField(
        controller: newpass,
        obscureText: obscure,
        onChanged: (value) {
          setState(() {
            changed = true;
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

      Widget greenfield = TextField(
        controller: newpass,
        obscureText: obscure,
        onChanged: (value) {
          setState(() {
            changed = true;
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

      loaded = 'yes';
      bool checkuppercase(String value) {
        bool ret = false;
        List<String> valueList = value.split('');
        for (var item in valueList) {
          if (double.tryParse(item) == null) {
            if (item == item.toUpperCase()) {
              ret = true;
            }
          }
        }
        return ret;
      }

      bool checklowercase(String value) {
        bool ret = false;
        List<String> valueList = value.split('');
        for (var item in valueList) {
          if (double.tryParse(item) == null) {
            if (item == item.toLowerCase()) {
              ret = true;
            }
          }
        }
        return ret;
      }

      bool checknumber(String value) {
        bool ret = false;
        List<String> valueList = value.split('');
        for (var item in valueList) {
          if (double.tryParse(item) != null) {
            ret = true;
          }
        }

        return ret;
      }

      bool checksymbol(String value) {
        bool ret = false;
        List symbols = [
          '/',
          '#',
          '@',
          '*',
          '+',
          '&',
          '%',
          ')',
          '(',
          '-',
          ';',
          ':',
          '.',
          ',',
          '!',
        ];
        List<String> valueList = value.split('');
        for (var item in valueList) {
          if (symbols.indexOf(item) != -1) {
            ret = true;
          }
        }
        return ret;
      }

      createpassword = normalfield;
      if (newpass.text.length > 0) {
        if (newpass.text.length < 8) {
          createpassword = redfield;
          continuebtn = greycontinue;
        } else if (checkuppercase(newpass.text) &&
            checklowercase(newpass.text) &&
            checknumber(newpass.text) &&
            checksymbol(newpass.text)) {
          createpassword = greenfield;
          continuebtn = realcontinue;
        } else {
          createpassword = redfield;
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
                          'Create a Password',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: myWidth - 60,
                        child: createpassword,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password must have:',
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xff723A3A)),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: Color(0xff723A3A),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'At least eight in length',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff723A3A)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: Color(0xff723A3A),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Upper case and lower case letters',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff723A3A)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: Color(0xff723A3A),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'At least one number',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff723A3A)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: Color(0xff723A3A),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'At least one symbol(/#@&%)',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff723A3A)),
                                ),
                              ],
                            )
                          ],
                        ),
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
