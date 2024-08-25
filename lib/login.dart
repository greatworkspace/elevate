// ignore_for_file: unused_catch_clause, unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shaker.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'home.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';
const forgoturl = 'https://finx.ginnsltd.com/password/mail/send/';

bool obscure = true;

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

String makeToken(String Token) {
  Token = 'Token ' + Token;
  return Token;
}

dynamic shakey = KeyClass.shakeKey1;

String resp = 'Not Loaded';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailed = TextEditingController();
  final passworded = TextEditingController();
  String err = '';

  Future makeUser(Map user) async {
    User usered = User(
      id: user['id'] ?? '',
      image: user['image'] ?? '',
      firstname: user['firstname'] ?? '',
      lastname: user['lastname'] ?? '',
      address: user['address'] ?? '',
      gender: user['gender'] ?? '',
      nationality: user['nationality'] ?? '',
      phone: user['phone'] ?? '',
      email: user['email'] ?? '',
      identification: user['identification'] ?? '',
      kin: user['kin'] ?? '',
      marital: user['marital'] ?? '',
      account: user['account'] ?? '',
      token: user['token'] ?? '',
      deduction: user['auto_deduction'] ?? 'false',
    );
    String inv = user['inv'].toString();
    await DatabaseHelper.instance.insertUser(usered);
    await DatabaseHelper.instance.insertLoan(user['loan']);
    await DatabaseHelper.instance.insertLoanP(user['loan_products']);
    await DatabaseHelper.instance.insertBank(user['bank']);
    await DatabaseHelper.instance.insertInvestA(inv);
    await DatabaseHelper.instance.insertBeneficiary(user['beneficiary']);
    await DatabaseHelper.instance.insertNoti(user['notifications']);
    await DatabaseHelper.instance
        .insertSaving(user['savings'], user['transactions']);
    await DatabaseHelper.instance.insertInvest(
        user['investmentaccount']['investment'],
        user['investmentaccount']['activity']);
    await DatabaseHelper.instance.insertOfficer(user['officer']);
  }

  dynamic mode = lightmode;
  void getMode() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? mymode = settings['mode'];
    if (mymode == null) {
      setState(() {
        mode = lightmode;
      });
    } else if (mymode == 'Dark') {
      setState(() {
        mode = darkmode;
      });
    } else {
      setState(() {
        mode = lightmode;
      });
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

  _launchURL() async {
    final Uri url = Uri.parse(forgoturl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch ${url}');
    }
  }

  void initState() {
    super.initState();
    getMode();
    //emailed.text = 'admin';
    //passworded.text = 'password';
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget OverCon = Container();

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(body: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        final myWidth = constraints.maxWidth;
        final myHeight = constraints.maxHeight;

        //gettiing field sizes
        double fieldWidth = 0;
        double topheight = myHeight - 380;
        if ((MediaQuery.of(context).size.width - 100) > 500) {
          fieldWidth = 450;
        } else {
          fieldWidth = myWidth - 60;
        }
        double xpad = 20;
        if (myWidth > 768) {
          xpad = myWidth / 5;
        }
        if (topheight > 215) {
          topheight = 215;
        }

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
        Widget loading = Container(
          height: MediaQuery.of(context).size.height,
          width: myWidth,
          color: mode.loadingBg,
          child: Center(
            child: CustomLoader,
          ),
        );

        Widget container = Container();

        //login function
        Future<String> login(String user, String pass) async {
          err = '';
          FocusManager.instance.primaryFocus?.unfocus();
          String url = apiUrl + 'login/';
          setState(() {
            OverCon = loading;
          });

          try {
            Response res2 = await post(
              Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/x-www-form-urlencoded',
                'email': user,
                'password': pass,
              },
              body: (<String, String>{'email': user, 'password': pass}),
            ).timeout(const Duration(seconds: 10));

            if (res2.statusCode == 200) {
              dynamic token = json.decode(res2.body)['data']['token'];
              if (token == null) {
                token = 'null';
                err = json.decode(res2.body)['data']['error'];
                OverCon = container;
              } else {
                setState(() {
                  err = '';
                });
                await DatabaseHelper.instance.insertToken(token);
                String imode;
                if (mode == lightmode) {
                  imode = 'light';
                } else {
                  imode = 'dark';
                }
                Map setting = {
                  'id': 1,
                  'mode': imode,
                  'logged': 'True',
                  'opened': 'True',
                };
                await DatabaseHelper.instance.insertSettings(setting);
                Map auser = json.decode(res2.body)['data']['user'];
                await makeUser(auser);
                Navigator.of(context).pushNamed('Home');
              }
              String bodyI = res2.body;
              String body = bodyI.substring(1, bodyI.length - 1);
              return body;
            } else {
              setState(() {
                OverCon = container;
              });
              return ('incorrect');
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

        Future<bool> popfunc() async {
          exit(0);
          // ignore: dead_code
          return false;
        }

        return WillPopScope(
          onWillPop: popfunc,
          child: Stack(
            children: [
              Container(
                color: mode.background1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: topheight,
                      width: myWidth,
                      decoration: const BoxDecoration(
                        color: Color(0xff231E54),
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/login_bg.png',
                            width: myWidth,
                            cacheHeight: (topheight * 2).floor(),
                            cacheWidth: (myWidth * 2).floor(),
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(topheight / 10.75,
                                topheight / 10.75, topheight / 10.75, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,
                                      topheight / 10.75, 0, topheight / 14.333),
                                  child: Container(
                                    height: topheight / 3.7,
                                    width: topheight / 3.7,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          topheight / 3.7),
                                      child: Image.asset(
                                        'assets/images/circle_icon.png',
                                        height: topheight / 3.7,
                                        width: topheight / 3.7,
                                        cacheHeight: (topheight / 3.7).floor(),
                                        cacheWidth: (topheight / 3.7).floor(),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                      fontSize: topheight / 9.347,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Enter your Email and your password.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: topheight / 17.916,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //login fields
                    Padding(
                      padding: EdgeInsets.fromLTRB(xpad, 0, xpad, 0),
                      child: SizedBox(
                        width: myWidth - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
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
                            const SizedBox(
                              height: 10,
                            ),
                            //Email Field
                            Container(
                              child: Text(
                                'Email Address',
                                style: TextStyle(
                                    fontSize: 15, color: mode.brightText1),
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
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff898989))),
                              ),
                              style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 15, color: mode.brightText1),
                              ),
                            ),
                            //Password Field
                            TextField(
                              controller: passworded,
                              obscureText: obscure,
                              decoration: InputDecoration(
                                alignLabelWithHint: false,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                suffixIcon: HideButton,
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff898989))),
                              ),
                              style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 15,
                              ),
                            ),
                            //Forgot password
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: SizedBox(
                                child: TextButton(
                                  onPressed: _launchURL,
                                  child: const Text(
                                    'Forgot Password?',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Color(0xff0080C8), fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Login Button
                            SizedBox(
                              width: myWidth - 40,
                              height: 56,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xff231E54),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                //Fake checking Username and Password
                                onPressed: () async {
                                  if (emailed.text == '' ||
                                      passworded.text == '') {
                                    setState(() {
                                      err =
                                          'please enter your username and password';
                                    });
                                  } else {
                                    String usernamedText =
                                        emailed.text.toLowerCase();
                                    await login(usernamedText, passworded.text)
                                        .then((value) {
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
                                          err =
                                              'Incorrect Username or Password';
                                        });
                                      } else if (resp == 'network' ||
                                          resp == 'timeout') {
                                        String myerr = 'Network Error';
                                        if (resp == 'timeout') {
                                          myerr = 'Request Timeout';
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          padding: EdgeInsets.zero,
                                          behavior: SnackBarBehavior.floating,
                                          elevation: 0,
                                          margin: EdgeInsets.fromLTRB(
                                              myWidth / 4, 0, myWidth / 4, 30),
                                          backgroundColor: Color.fromARGB(
                                              150, 128, 128, 128),
                                          duration: const Duration(seconds: 2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          content: Container(
                                            width: myWidth / 2,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: mode.floatBg,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      myerr,
                                                      style: TextStyle(
                                                          color: mode.darkText1,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
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
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //Don't have an account
                            Container(
                                child: RichText(
                                    text: TextSpan(children: [
                              TextSpan(
                                  text: 'Visit ',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.notoSans().fontFamily,
                                      color: mode.brightText1,
                                      fontSize: 12)),
                              TextSpan(
                                  text: 'www.elevatemfb.com ',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.notoSans().fontFamily,
                                      color: const Color(0xff0080C8),
                                      fontSize: 12)),
                              TextSpan(
                                  text: 'to register  for Elevate Services',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.notoSans().fontFamily,
                                      color: mode.brightText1,
                                      fontSize: 12))
                            ])))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              OverCon,
            ],
          ),
        );
      }),
    ));
  }
}
