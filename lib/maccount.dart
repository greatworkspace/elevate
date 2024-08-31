// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/cupertino.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';

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

class MAccountScreen extends StatefulWidget {
  MAccountScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _MAccountScreenState createState() => _MAccountScreenState();
}

User? myuser = null;
dynamic mode = mode;
bool gotdata = false;

class _MAccountScreenState extends State<MAccountScreen>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final loanCon = TextEditingController();
  final savingsCon = TextEditingController();
  final investCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  Future getUser() async {
    User use = await DatabaseHelper.instance.getUser();
    setState(() {
      myuser = use;
      gotdata = true;
    });
    return (true);
  }

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    bool inivalue;
    Widget ModeSwitch() {
      if (mode.name == 'Light') {
        inivalue = false;
      } else {
        inivalue = true;
      }
      return Transform.scale(
        scale: 0.9,
        child: CupertinoSwitch(
          value: inivalue,
          onChanged: (value) async {
            if (value == false) {
              setState(() {
                mode = lightmode;
              });
            } else {
              setState(() {
                mode = darkmode;
              });
            }
            if (value == true) {
              await DatabaseHelper.instance.makedark();
            } else {
              await DatabaseHelper.instance.makelight();
            }
          },
          activeColor: Colors.white,
          trackColor: const Color(0xffD9D9D9),
          thumbColor: mode.thumbColor,
          //activeTrackColor: Color(0xffD9D9D9),
        ),
      );
    }

    Widget Modepic = Container();

    if (mode.name == 'Light') {
      Modepic = SvgPicture.asset(
        'assets/svg/lightmode.svg',
        width: 24,
        height: 24,
        fit: BoxFit.fill,
      );
    } else {
      Modepic = SvgPicture.asset(
        'assets/svg/darkmode.svg',
        width: 24,
        height: 24,
      );
    }

    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: getUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData || gotdata) {
                    User? user = myuser;
                    Widget imagecon() {
                      String imageurl = 'assets/images/default_pic.png';
                      if (user!.image != '' || user.image != null) {
                        imageurl = user.image;
                        return Image.network(
                          imageurl,
                          alignment: Alignment.center,
                          height: 60,
                          cacheHeight: 124,
                          cacheWidth: 124,
                        );
                      } else {
                        return Image.asset(
                          imageurl,
                          alignment: Alignment.center,
                          height: 60,
                          cacheHeight: 124,
                          cacheWidth: 124,
                        );
                      }
                    }

                    String name = user!.firstname + ' ' + user.lastname;
                    return LayoutBuilder(builder: (context, constraints) {
                      final myHeight = constraints.maxHeight;
                      final myWidth = constraints.maxWidth;
                      //scaffold body starts here
                      return Container(
                        decoration: BoxDecoration(
                          color: mode.background3,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 85,
                              decoration: BoxDecoration(
                                color: mode.background1,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Account',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mode.brightText1,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              //listview for remaining item
                              height: myHeight - 95,
                              decoration: BoxDecoration(
                                  color: mode.background3,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListView(
                                children: [
                                  Container(
                                    width: myWidth,
                                    height: 89,
                                    //profile
                                    decoration: BoxDecoration(
                                        color: mode.background1,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('PersonalScreen');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                height: 62,
                                                width: 62,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(62),
                                                  child: imagecon(),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    name,
                                                    style: TextStyle(
                                                        color: mode.brightText1,
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    'Personal Details',
                                                    style: TextStyle(
                                                        color: mode.brightText1,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              )
                                            ]),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: mode.brightText1,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //security
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            accountI = 2;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/security.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Security',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //Bank details
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            accountI = 3;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/bank_details.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Bank Details',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //statement
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('StatementScreen');
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/statement.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Statement',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //privacy
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('Privacy');
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/privacy.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Privacy Policy',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //documents
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            accountI = 7;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/document.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Documents',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //add-ons
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            accountI = 8;
                                          });
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/addon.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Add-Ons',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: mode.brightText1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //darkmode
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: null,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Modepic,
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Dark Mode',
                                                      style: TextStyle(
                                                          color:
                                                              mode.brightText1,
                                                          fontSize: 15),
                                                    ),
                                                    ModeSwitch()
                                                  ],
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),
                                  //signout
                                  Container(
                                    decoration: BoxDecoration(
                                      color: mode.background1,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                    ),
                                    height: 70,
                                    child: SizedBox(
                                      child: TextButton(
                                        onPressed: () async {
                                          await DatabaseHelper.instance
                                              .logoutdb();
                                          Navigator.of(context)
                                              .pushNamed('Login');
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                  'assets/svg/signout.svg'),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: myWidth - 97,
                                                child: const Text(
                                                  'Sign Out',
                                                  style: TextStyle(
                                                      color: Color(0xffFF1F1F),
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  )
                                  //end
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
                  } else {
                    return Scaffold(body: SafeArea(
                        child: LayoutBuilder(builder: (context, constraints) {
                      final myHeight = constraints.maxHeight;
                      final myWidth = constraints.maxWidth;
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
                        height: myHeight,
                        width: myWidth,
                        color: mode.background1,
                        child: Center(
                          child: CustomLoader,
                        ),
                      );
                      return loading;
                    })));
                  }
                })));
  }
}
