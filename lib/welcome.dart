import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'models/databaseHelper.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      Widget first = Padding(
        key: const ValueKey(1),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SizedBox(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              SizedBox(
                height: myHeight / 100 * 50 - 110,
                child: Image.asset(
                  'assets/images/first.png',
                  height: myHeight / 100 * 50 - 110,
                  cacheHeight: ((myHeight / 100 * 50 - 110)*2).floor(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
                child: Text(
                  'Obtain loans tailored to your needs with our Loan Account',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        color: const Color(0xff414BA3),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(
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
              )
            ],
          ),
        ),
      );

      Widget second = Padding(
        key: const ValueKey(2),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: SizedBox(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              SizedBox(
                height: myHeight / 100 * 50 - 130,
                child: Image.asset(
                  'assets/images/second.png',
                  height: myHeight / 100 * 50 - 130,
                  cacheHeight: ((myHeight / 100 * 50 - 130)*2).floor(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
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
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: const Color(0xff414BA3),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
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
        key: const ValueKey(3),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: SizedBox(
          height: myHeight / 100 * 50 - 20,
          child: Column(
            children: [
              SizedBox(
                height: myHeight / 100 * 50 - 130,
                child: Image.asset(
                  'assets/images/third.png',
                  height: myHeight / 100 * 50 - 130,
                  cacheHeight: ((myHeight / 100 * 50 - 130)*2).floor(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
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
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: const Color(0xff414BA3),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
      Widget _currentSlide = third;
      return TimerBuilder.periodic(const Duration(seconds: 6),
          builder: (context) {
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
                decoration: const BoxDecoration(
                  color: Color(0xff231E54),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                      Image.asset(
                        'assets/images/circle_icon.png',
                        height: 65,
                        cacheHeight: 130,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: myHeight / 100 * 50,
                width: myWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: _currentSlide,
                ),
              ),
              Container(
                height: myHeight / 100 * 28,
                width: myWidth,
                decoration: const BoxDecoration(
                  color: Color(0xff231E54),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ((myHeight / 100 * 28) / 2) -20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              Map setting = {
                                'id': 1,
                                'mode': null,
                                'logged': 'False',
                                'opened': 'True',
                              };
                              await DatabaseHelper.instance
                                  .insertSettings(setting);
                              Navigator.of(context).pushNamed('Login');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                              child: Text(
                                'Next',
                                style: TextStyle(color: Color(0xff231E54)),
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
    })));
  }
}
