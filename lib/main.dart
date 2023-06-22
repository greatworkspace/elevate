import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'welcome2.dart';
import 'login.dart';
import 'signup.dart';
import 'package:splashscreen/splashscreen.dart';
import 'createpassword.dart';
import 'confirmpassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "Home": (context) => HomeScreen(),
        "Welcome2": (context) => Welcome2(),
        "Login": (context) => LoginScreen(),
        "Signup": (context) => SignupScreen(),
        "CreatePassword": (context) => CreatePasswordScreen(),
        "ConfirmPassword": (context) => ConfirmPasswordScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: WelcomeScreen(),
        image: new Image.asset('assets/images/splash.png'),
        photoSize: 100.0,
        backgroundColor: const Color(0xff123869),
        loaderColor: Colors.white,
      ),
    );
  }
}
