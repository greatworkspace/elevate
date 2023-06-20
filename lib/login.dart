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

class KeyClass {
  static final shakeKey1 = const Key('__RIKEY1__');
  static final shakeKey2 = const Key('__RIKEY2__');
}

dynamic getKey(key) {
  if (key == KeyClass.shakeKey2) {
    return KeyClass.shakeKey1;
  } else {
    return KeyClass.shakeKey2;
  }
}

dynamic shakey = KeyClass.shakeKey1;

String resp = 'Not Loaded';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailed = TextEditingController();
  final passworded = TextEditingController();
  String err = '';

  //login function
  Future<String> login(String user, String pass) async {
    if (user == 'admin' && pass == 'Password') {
      return ('logged');
    } else {
      return ('incorrect');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget HideWid() {
      return SizedBox(
        width: 40,
        height: 10,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
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
              child: Icon(FontAwesomeIcons.solidEyeSlash)),
        ),
      );
    }

    Widget ShowWid() {
      return SizedBox(
        width: 40,
        height: 10,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
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
              child: Icon(FontAwesomeIcons.solidEye)),
        ),
      );
    }

    Widget HideButton;
    if (obscure == true) {
      HideButton = ShowWid();
    } else {
      HideButton = HideWid();
    }

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final myHeight = constraints.maxHeight;
        final myWidth = constraints.maxWidth;

        //gettiing field sizes
        double fieldWidth = 0;
        if ((MediaQuery.of(context).size.width - 100) > 500) {
          fieldWidth = 450;
        } else {
          fieldWidth = myWidth - 60;
        }
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Image.asset(
                  'assets/images/icon.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              //login fields
              SizedBox(
                width: fieldWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    //error
                    Center(
                      child: ShakeWidget(
                        key: shakey,
                        child: Text(
                          err,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 230, 56, 56),
                              fontSize: 14,
                              fontFamily: 'StickNoBills'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Username Field
                    Container(
                      child: Text(
                        'Email Address',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    TextField(
                      controller: emailed,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(" "))
                      ],
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
                    Container(
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    //Password Field
                    TextField(
                      controller: passworded,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        alignLabelWithHint: false,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        suffixIcon: HideButton,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff898989))),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    //Forgot password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style:
                              TextStyle(color: Color(0xff122774), fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Login Button
                    SizedBox(
                      width: myWidth - 60,
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color(0xff122774),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //Fake checking Username and Password
                        onPressed: () async {
                          if (emailed.text == '' || passworded.text == '') {
                            setState(() {
                              err = 'please enter your username and password';
                            });
                          } else {
                            Loader.appLoader.showLoader();
                            String usernamedText = emailed.text.toLowerCase();
                            await login(usernamedText, passworded.text)
                                .then((value) {
                              Loader.appLoader.hideLoader();
                              setState(() {
                                resp = value;
                              });
                            });
                            if (resp == 'logged') {
                              Navigator.of(context).pushNamed('Home');
                              setState(() {
                                resp = 'Not Loaded';
                              });
                            } else {
                              if (resp == 'inactive') {
                                setState(() {
                                  err = 'User Inactive';
                                });
                              } else if (resp == 'incorrect') {
                                setState(() {
                                  err = 'Incorrect Username or Password';
                                });
                              }
                            }
                          }
                          setState(() {
                            shakey = getKey(shakey);
                          });
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'StickNoBills',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Don't have an account
                    Container(
                      child: Row(
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.black),
                            onPressed: () {
                              Navigator.of(context).pushNamed('Signup');
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff122774),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
