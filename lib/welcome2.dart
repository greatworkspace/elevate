import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';

class Welcome2 extends StatefulWidget {
  @override
  _Welcome2State createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final myHeight = constraints.maxHeight;
        final myWidth = constraints.maxWidth;
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
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/welcome2.png',
                      height: (myHeight / 100 * 35),
                      fit: BoxFit.fitWidth,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 56,
                    width: myWidth - 60,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pushNamed('Login'),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xff122774),
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xff122774),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 56,
                    width: myWidth - 60,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('Signup');
                      },
                      child: Text(
                        'Get Started',
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
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
