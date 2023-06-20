import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'package:timer_builder/timer_builder.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      Widget first = Padding(
        key: ValueKey(1),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              Container(
                height: myHeight / 100 * 50 - 110,
                child: Image.asset(
                  'assets/images/first.png',
                  height: myHeight / 100 * 50 - 110,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Text(
                  'Obtain loans tailored to your needs with our Loan Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(0xff414BA3),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

      Widget second = Padding(
        key: ValueKey(2),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Container(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              Container(
                height: myHeight / 100 * 50 - 130,
                child: Image.asset(
                  'assets/images/second.png',
                  height: myHeight / 100 * 50 - 130,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Text(
                  'Start saving and managing your finances with our Savings Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(0xff414BA3),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

      Widget third = Padding(
        key: ValueKey(3),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Container(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              Container(
                height: myHeight / 100 * 50 - 130,
                child: Image.asset(
                  'assets/images/third.png',
                  height: myHeight / 100 * 50 - 130,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Text(
                  'Grow and monitor your wealth with our Investment Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Color(0xff414BA3),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
      int view = 1;
      Widget _currentSlide = third;
      return TimerBuilder.periodic(Duration(seconds: 6), builder: (context) {
        if (_currentSlide == first) {
          _currentSlide = second;
        } else if (_currentSlide == second) {
          _currentSlide = third;
        } else {
          _currentSlide = first;
        }
        return Container(
          child: Column(
            children: [
              Container(
                height: myHeight / 100 * 22,
                width: myWidth,
                decoration: BoxDecoration(
                  color: const Color(0xff123869),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                      Image.asset(
                        'assets/images/icon_shadow.png',
                        height: 70,
                        width: 70,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: myHeight / 100 * 50,
                width: myWidth,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: _currentSlide,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                height: myHeight / 100 * 28,
                width: myWidth,
                decoration: BoxDecoration(
                  color: const Color(0xff123869),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: (myHeight / 100 * 28) / 2,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('Welcome2'),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 15, 30, 15),
                              child: Text(
                                'Next',
                                style: TextStyle(color: Color(0xff122774)),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
    }));
  }
}
