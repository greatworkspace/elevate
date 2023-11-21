import 'package:elevate/accountofficer.dart';
import 'package:elevate/change_password.dart';
import 'package:elevate/change_pin.dart';
import 'package:elevate/invest_application.dart';
import 'package:elevate/pay_invest2.dart';
import 'package:elevate/personal.dart';
import 'package:elevate/privacy.dart';
import 'package:elevate/statement.dart';
import 'package:elevate/transaction_details.dart';
import 'package:elevate/transactions.dart';
import 'package:elevate/withdraw_savings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'edit_target.dart';
import 'support.dart';
import 'welcome.dart';
import 'home.dart';
import 'upload_document.dart';
import 'welcome.dart';
import 'login.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'create_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'apply_savings.dart';
import 'pay_loan.dart';
import 'enter_pin.dart';
import 'pay_invest.dart';
import 'pay_invest2.dart';
import 'withdraw_invest.dart';
import 'elevate_withdraw.dart';
import 'savings_transfer.dart';
import 'pay_savings.dart';
import 'pay_savings2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'notifications.dart';
import 'withdraw_target.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'models/databaseHelper.dart';

Future main() async {
  // Do whatever you need to do here
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Map<String, Widget Function(BuildContext)> myroutes = {
      "Home": (context) => HomeScreen(
            index: 0,
          ),
      "Welcome": (context) => WelcomeScreen(),
      "Login": (context) => LoginScreen(),
      "PersonalScreen": (context) => PersonalScreen(),
      "StatementScreen": (context) => StatementScreen(),
      "CreateTarget1": (context) => CreateTarget(),
      "EditTarget": (context) => EditTarget(),
      "ApplySavings": (context) => ApplySavings(),
      "PayLoan": (context) => PayLoan(),
      "EnterPin": (context) => EnterPin(),
      "UploadDocument": (context) => UploadDocument(),
      "PayInvest": (context) => PayInvest(),
      "PayInvest2": (context) => PayInvest2(),
      "PaySavings": (context) => PaySavings(),
      "PaySavings2": (context) => PaySavings2(),
      "WithdrawInvest": (context) => WithdrawInvest(),
      "WithdrawElevate": (context) => WithdrawElevate(),
      "InvestApplication": (context) => InvestApplication(),
      "SavingsTransfer": (context) => SavingsTransfer(),
      "Notifications": (context) => Notifications(),
      "AccountOfficer": (context) => AccountOfficer(),
      "ChangePassword": (context) => ChangePassword(),
      "ChangePin": (context) => ChangePin(),
      "Privacy": (context) => Privacy(),
      "TransactionDetails": (context) => TransactionDetails(),
      "Transactions": (context) => Transactions(),
      "WithdrawSavings": (context) => WithdrawSavings(),
      "WithdrawTarget": (context) => WithdrawTarget(),
      "Support": (context) => Support(),
    };

    Widget fakehomeScreen = WelcomeScreen();
  
    return MaterialApp(
      title: 'Elevate',
      routes: myroutes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: AnimatedSplashScreen.withScreenFunction(
        splash: SvgPicture.asset('assets/svg/splash.svg'),
        splashIconSize: 850,
        animationDuration: Duration(milliseconds: 1500),
        screenFunction: () async {
          Map settings = await DatabaseHelper.instance.getSettings();
          String? loggedkey = settings['logged'];
          String? opened = settings['opened'];
          if (loggedkey == 'True') {
            fakehomeScreen = HomeScreen(
              index: 0,
            );
          } else if (opened == 'True') {
            fakehomeScreen = LoginScreen();
          }

          return fakehomeScreen;
        },
        backgroundColor: const Color(0xff231E54),
      ),
    );
  }
}
