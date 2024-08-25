// ignore_for_file: library_private_types_in_public_api, override_on_non_overriding_member, non_constant_identifier_names, must_be_immutable, unused_catch_clause

import 'package:elevate/bank_details2.dart';
import 'package:elevate/credit_score.dart';
import 'package:elevate/ea_investment.dart';
import 'package:elevate/invest_stats.dart';
import 'package:elevate/schedule_deduction.dart';
import 'package:flutter/material.dart';
import 'models/color.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'maccount.dart';
import 'mainscreen.dart';
import 'addon.dart';
import 'security.dart';
import 'savings.dart';
import 'investment.dart';
import 'target_saving.dart';
import 'target_saving_details.dart';
import 'elevate_loan_product.dart';
import 'invest_details.dart';
import 'bank_details.dart';
import 'documents.dart';
import 'savings_stats.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';
import 'dart:convert';
import 'package:http/http.dart';

const apiUrl = 'https://finx.ginnsltd.com/mobile/';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.index,
  });
  int index;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

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
final ColorClass darkmode = ColorClass(
    id: 1,
    name: 'Dark',
    brightText1: Colors.white,
    brightText2: const Color(0xffF2F2F2),
    dimText1: const Color(0xff616161),
    dimText2: const Color.fromARGB(255, 139, 139, 139),
    navigationBackground: Colors.black,
    navigationIcon: Colors.grey,
    navigationIconActive: Colors.blue,
    navigationText: Colors.grey,
    navigationTextActive: Colors.blue,
    background1: const Color(0xff050505),
    background2: const Color(0xff050505),
    background3: const Color(0xff0C0C0C),
    tileColor: const Color.fromARGB(255, 15, 15, 15),
    defaultPic: Colors.white,
    brightIcon: Colors.white,
    brightIconActive: Colors.blue,
    dimIcon: Colors.grey,
    dimIconActive: Colors.grey,
    canvasColor: const Color(0xff050505),
    dividerColor: const Color.fromARGB(255, 15, 15, 15),
    settingsTileColor: const Color.fromARGB(255, 15, 15, 15),
    searchColor: const Color.fromARGB(255, 37, 38, 40),
    transactionDivider: const Color.fromARGB(255, 43, 44, 46),
    thumbColor: Colors.black,
    iconBlue: Colors.black,
    fieldColor: const Color(0xff303030),
    selectfieldColor: const Color(0xff1E1E26),
    fieldBorder: const Color(0xff1E212D),
    inactiveIcon: const Color(0xffD7D7D7),
    headerDivider: const Color(0xff212121),
    barBackground: const Color(0xff2F2F2F),
    floatBg: const Color.fromARGB(255, 230, 230, 230),
    darkText1: Colors.black,
    kunleStroke: const Color(0xff2E2E2E),
    loadingBg: const Color.fromARGB(220, 0, 0, 0));

final ColorClass lightmode = ColorClass(
  id: 1,
  name: 'Light',
  brightText1: Colors.black,
  brightText2: Colors.black,
  dimText1: const Color(0xff616161),
  dimText2: const Color(0xffBFBFBF),
  navigationBackground: Colors.black,
  navigationIcon: Colors.grey,
  navigationIconActive: Colors.blue,
  navigationText: Colors.grey,
  navigationTextActive: Colors.blue,
  background1: Colors.white,
  background2: Colors.white,
  background3: const Color(0xffF3F3F3),
  tileColor: const Color.fromARGB(255, 15, 15, 15),
  defaultPic: Colors.black,
  brightIcon: Colors.black,
  brightIconActive: Colors.blue,
  dimIcon: Colors.grey,
  dimIconActive: Colors.grey,
  canvasColor: const Color(0xffFFFFFF),
  dividerColor: const Color.fromARGB(255, 215, 215, 215),
  settingsTileColor: const Color.fromARGB(255, 240, 242, 255),
  searchColor: const Color.fromARGB(255, 226, 226, 226),
  transactionDivider: const Color.fromARGB(255, 43, 44, 46),
  thumbColor: Colors.white,
  iconBlue: const Color(0xff231E54),
  fieldColor: const Color(0xffD9D9D9),
  selectfieldColor: const Color(0xffDCE4E7),
  fieldBorder: const Color(0xffD9D9D9),
  inactiveIcon: const Color(0xffBEBEBE),
  headerDivider: const Color(0xffD9D9D9),
  barBackground: const Color(0xffE0E0E0),
  floatBg: const Color.fromARGB(255, 65, 65, 65),
  darkText1: Colors.white,
  kunleStroke: const Color(0xffD7D7D7),
  loadingBg: const Color.fromARGB(220, 255, 255, 255),
);

String action = '';
String target_id = '';

int accountI = 1;
int savingsI = 1;
int homeI = 1;
int investI = 1;
int selectedindex = 0;
String gotstate = '';

Future makeUser2(Map user) async {
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
  await DatabaseHelper.instance.makeAll(
    usered,
    user['loan'],
    user['savings'],
    user['transactions'],
    user['investmentaccount']['investment'],
    user['investmentaccount']['activity'],
    user['bank'],
    user['loan_products'],
    inv,
    user['beneficiary'],
    user['notifications'],
    user['officer'],
  );
}

Future regetdata2() async {
  try {
    String url = apiUrl + 'get/user/';

    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      },
      body: (<String, String>{}),
    ).timeout(const Duration(seconds: 15));
    if (res2.statusCode == 200) {
      Map auser = json.decode(res2.body)['data']['user'];
      await makeUser2(auser);
    }
    gotstate = '';
  } on SocketException catch (e) {
    gotstate = 'network';
  } on TimeoutException catch (e) {
    gotstate = 'timeout';
  }
}

Future regetdata(BuildContext cont, dynamic mode) async {
  try {
    String url = apiUrl + 'get/user/';

    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      },
      body: (<String, String>{}),
    ).timeout(const Duration(seconds: 15));
    if (res2.statusCode == 200) {
      Map auser = json.decode(res2.body)['data']['user'];
      await makeUser2(auser);
    }
  } on SocketException catch (e) {
    double myWidth = MediaQuery.of(cont).size.width;
    ScaffoldMessenger.of(cont).showSnackBar(SnackBar(
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      margin: EdgeInsets.fromLTRB(myWidth / 4, 0, myWidth / 4, 30),
      backgroundColor: Color.fromARGB(150, 128, 128, 128),
      duration: const Duration(seconds: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Container(
        width: myWidth / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mode.floatBg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Network Error',
                  style: TextStyle(
                      color: mode.darkText1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
    await Future.delayed(Duration(seconds: 5));
    regetdata(cont, mode);
  } on TimeoutException catch (e) {
    double myWidth = MediaQuery.of(cont).size.width;
    ScaffoldMessenger.of(cont).showSnackBar(SnackBar(
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      margin: EdgeInsets.fromLTRB(myWidth / 4, 0, myWidth / 4, 30),
      backgroundColor: Color.fromARGB(150, 128, 128, 128),
      duration: const Duration(seconds: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Container(
        width: myWidth / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mode.floatBg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Request Timeout',
                  style: TextStyle(
                      color: mode.darkText1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
    regetdata(cont, mode);
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
    selectedindex = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getMode();

    /*



    The List Screen Tab




    */

    Future<bool> _onWillPop() async {
      if (selectedindex == 3) {
        if (accountI == 4) {
          setState(() {
            accountI = 1;
          });
          return false;
        } else if (accountI == 9) {
          setState(() {
            accountI = 8;
          });
          return false;
        } else if (accountI != 1) {
          setState(() {
            accountI = 1;
          });
          return false;
        } else {
          exit(0);
        }
      } else if (selectedindex == 1) {
        if (savingsI == 5) {
          setState(() {
            savingsI = 3;
          });
          return false;
        } else if (savingsI != 1) {
          setState(() {
            savingsI = 1;
          });
          return false;
        } else {
          exit(0);
        }
      } else if (selectedindex == 0) {
        setState(() {
          homecardindex = 1;
        });
        if (homeI != 1) {
          setState(() {
            homeI = 1;
          });
          return false;
        } else {
          exit(0);
        }
      } else if (selectedindex == 2) {
        if (investI != 1) {
          setState(() {
            investI = 1;
          });
          return false;
        } else {
          exit(0);
        }
      } else {
        exit(0);
      }
    }

    if (mode == null) {
      return Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: const Size(20, 20)),
        body: Stack(
          children: [Container(color: Colors.black), const Overlay()],
        ),
      );
    } else {}

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: mode.background1,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(0.95)),
          child: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
            final myHeight = constraints.maxHeight;

            //List Widget
            Widget Home() {
              if (homeI == 2) {
                return LoanProduct(
                  amode: mode,
                  index: homeI,
                );
              } else {
                return MainScreen(
                  amode: mode,
                  index: homeI,
                );
              }
            }

            /*


      The Checkout Screen Tab


      
      */

            Widget Savings() {
              if (savingsI == 3) {
                return TargetSaving(
                  amode: mode,
                  index: savingsI,
                );
              } else if (savingsI == 4) {
                return ScheduleDeduction(
                  amode: mode,
                  index: savingsI,
                );
              } else if (savingsI == 5) {
                return TargetSavingDetails(
                  amode: mode,
                  index: savingsI,
                );
              } else if (savingsI == 6) {
                return SavingsStats(
                  amode: mode,
                  index: savingsI,
                );
              } else {
                return SavingsScreen(
                  amode: mode,
                  index: savingsI,
                );
              }
            }
            /*




      The Transaction screen Tab


      */

            Widget Investments() {
              if (investI == 2) {
                return EaInvestment(
                  amode: mode,
                  index: investI,
                );
              } else if (investI == 3) {
                return InvestDetails(
                  amode: mode,
                  index: investI,
                );
              } else if (investI == 5) {
                return InvestStats(
                  amode: mode,
                  index: investI,
                );
              } else {
                return InvestmentScreen(
                  amode: mode,
                  index: investI,
                );
              }
            }
            /*



The Settings Screen Tab



      */

            Widget MAccount() {
              if (accountI == 2) {
                return SecurityScreen(
                  amode: mode,
                  index: accountI,
                );
              }
              if (accountI == 3) {
                return BankDetails(
                  amode: mode,
                  index: accountI,
                );
              }
              if (accountI == 4) {
                return BankDetails2(
                  amode: mode,
                  index: accountI,
                );
              } else if (accountI == 7) {
                return DocumentsScreen(
                  amode: mode,
                  index: accountI,
                );
              } else if (accountI == 8) {
                return AddonScreen(
                  amode: mode,
                  index: accountI,
                );
              } else if (accountI == 9) {
                return CreditScore(
                  amode: mode,
                  index: accountI,
                );
              } else {
                return MAccountScreen(
                  amode: mode,
                  index: accountI,
                );
              }
            }

            getWid(int index) {
              final List widgets = [
                Home(),
                Savings(),
                Investments(),
                MAccount()
              ];
              return (widgets[index]);
            }

            //scaffold body starts here
            return SizedBox(
              height: myHeight,
              child: Column(
                children: [
                  SizedBox(
                      height: myHeight,
                      child: AnimatedSwitcher(
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        duration: const Duration(milliseconds: 50),
                        child: getWid(selectedindex),
                      )),
                ],
              ),
            );
          })),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              brightness: Brightness.dark,
              canvasColor: mode.canvasColor,
              primaryColor: const Color.fromARGB(255, 45, 124, 243),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(bodySmall: const TextStyle(color: Colors.grey))),
          child: SizedBox(
            height: 60,
            child: BottomNavigationBar(
                elevation: 0,
                onTap: (int index) {
                  setState(() {
                    selectedindex = index;
                    
                  });
                  if (index == 3) {
                    setState(() {
                        accountI = 1;
                    });
                    }
                },
                currentIndex: selectedindex,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: mode.inactiveIcon,
                selectedItemColor: mode.brightText1,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(fontSize: 11),
                unselectedLabelStyle: const TextStyle(fontSize: 11),
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: SvgPicture.asset(
                        'assets/svg/home_stroke.svg',
                        width: 25,
                        height: 25,
                        color: mode.inactiveIcon,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/svg/home.svg',
                      color: mode.brightText1,
                      width: 28,
                      height: 28,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: SvgPicture.asset(
                          'assets/svg/savings_stroke.svg',
                          width: 25,
                          height: 25,
                          color: mode.inactiveIcon,
                        )),
                    activeIcon: SvgPicture.asset(
                      'assets/svg/savings.svg',
                      color: mode.brightText1,
                      width: 28,
                      height: 28,
                    ),
                    label: 'Savings',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: SvgPicture.asset(
                        'assets/svg/investment_stroke.svg',
                        width: 25,
                        height: 25,
                        color: mode.inactiveIcon,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/svg/investment.svg',
                      color: mode.brightText1,
                      width: 28,
                      height: 28,
                    ),
                    label: 'Investments',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: SvgPicture.asset(
                        'assets/svg/account_stroke.svg',
                        width: 25,
                        height: 25,
                        color: mode.inactiveIcon,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/svg/account.svg',
                      color: mode.brightText1,
                      width: 28,
                      height: 28,
                    ),
                    label: 'Account',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
