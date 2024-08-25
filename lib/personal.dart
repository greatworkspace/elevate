// ignore_for_file: unnecessary_null_comparison


import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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



class PersonalScreen extends StatefulWidget {
  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

dynamic mode = mode;
String accountNo = '0123456789';

class _PersonalScreenState extends State<PersonalScreen>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

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

  void gethidebal() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? got = settings['hidebal'];
    if (got == 'true') {
      setState(() {
        hiddenbalCon.text = 'true';
      });
    } else {
      setState(() {
        hiddenbalCon.text = 'false';
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
    gethidebal();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool inivalue;

    Future getUser() async {
      return (await DatabaseHelper.instance.getUser());
    }

    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(
            child: FutureBuilder(
                future: getUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    User user = snapshot.data;
                     Widget imagecon() {
                      String imageurl = 'assets/images/default_pic.png';
                      if (user.image != '' || user.image != null) {
                        imageurl = user.image;
                        return Image.network(imageurl,
                            alignment: Alignment.center,
                            height: 70,
                            cacheHeight: 140, cacheWidth: 140,);
                      } else {
                        return Image.asset(imageurl,
                            alignment: Alignment.center,height: 70,
                            cacheHeight: 140, cacheWidth: 140,);
                      }
                    }

                    String name = user.firstname + ' ' + user.lastname;
                    String address = user.address ?? '';
                    String nationality = user.nationality ?? '';
                    String gender = user.gender ?? '';
                    String phone = user.phone ?? '';
                    String email = user.email ?? '';
                    String identification = user.identification ?? '';
                    String kin = user.kin ?? '';
                    String marital = user.marital ?? '';
                    String account = user.account ?? '';

                    return LayoutBuilder(builder: (context, constraints) {
                      final myHeight = constraints.maxHeight;
                      final myWidth = constraints.maxWidth;

                      Widget accountwid() {
                        if (account != '') {
                          return TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.zero),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused))
                                  return Colors.transparent;
                                if (states.contains(MaterialState.hovered))
                                  return Colors.transparent;
                                if (states.contains(MaterialState.pressed))
                                  return Colors.transparent;
                                return Colors
                                    .transparent; // Defer to the widget's default.
                              }),
                            ),
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(text: account))
                                  .then((value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        padding: EdgeInsets.zero,
                                        behavior: SnackBarBehavior.floating,
                                        elevation: 0,
                                        margin: EdgeInsets.fromLTRB(
                                            myWidth / 4, 0, myWidth / 4, 30),
                                        backgroundColor: mode.background1,
                                        duration: Duration(seconds: 3),
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        content: Container(
                                          width: myWidth / 2,
                                          height: 40,
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
                                                    'Copied!',
                                                    style: TextStyle(
                                                        color: mode.darkText1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/svg/mark.svg',
                                                    color: mode.darkText1,
                                                    height: 12,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'ELEVATE ACCOUNT',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              GoogleFonts.notoSans().fontFamily,
                                          color: Color(0xff4082D6),
                                        )),
                                    TextSpan(
                                        text: ' : ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              GoogleFonts.notoSans().fontFamily,
                                          color: mode.dimText1,
                                        )),
                                    TextSpan(
                                        text: account,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              GoogleFonts.notoSans().fontFamily,
                                          color: mode.dimText1,
                                        )),
                                  ]),
                                ),
                                SvgPicture.asset('assets/svg/profile_copy.svg')
                              ],
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'ELEVATE ACCOUNT',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            GoogleFonts.notoSans().fontFamily,
                                        color: Color(0xff4082D6),
                                      )),
                                  TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            GoogleFonts.notoSans().fontFamily,
                                        color: mode.dimText1,
                                      )),
                                  TextSpan(
                                      text: 'No Linked Account',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            GoogleFonts.notoSans().fontFamily,
                                        color: mode.dimText1,
                                      )),
                                ]),
                              ),
                            ],
                          );
                        }
                      }

                      //scaffold body starts here
                      return Container(
                          decoration: BoxDecoration(
                            color: mode.background3,
                          ),
                          child: Column(
                            children: [
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
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
                                        'Personal Details',
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
                              //other items in Personal Details after header
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(75),
                                        child: imagecon(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                      height: 22,
                                      width: 258,
                                      child: accountwid(),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: myWidth,
                                height: myHeight - 232,
                                child: ListView(
                                  children: [
                                    //first item
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Container(
                                        width: myWidth,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          )),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 0, 0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Full Name',
                                                  style: TextStyle(
                                                    color: mode.dimText1,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    color: mode.dimText1,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Home Address',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                address,
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nationality',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                nationality,
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Gender',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                gender,
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Phone Number',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                phone,
                                                style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Email Address',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                email,
                                                style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Identification',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                identification,
                                                style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: mode.background2,
                                          border: Border(
                                              bottom: BorderSide(
                                            width: 1,
                                            color: mode.kunleStroke,
                                          ))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Next of Kin',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                kin,
                                                style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: myWidth,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: mode.background2,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Marital Status',
                                                style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                marital,
                                                style: TextStyle(
                                                  color: mode.brightText1,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                    });
                  } else {
                    return Scaffold(
                        backgroundColor: mode.background1,
                        body: SafeArea(child:
                            LayoutBuilder(builder: (context, constraints) {
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
