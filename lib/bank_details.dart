import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

String accountNo = '012345678';

// ignore: must_be_immutable
class BankDetails extends StatefulWidget {
  BankDetails({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

dynamic mode = mode;
bool changedb = false;

class _BankDetailsState extends State<BankDetails>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  Future getbank() async {
    dynamic bank = await DatabaseHelper.instance.getBank();

    return {
      'bank': bank,
    };
  }

  void initState() {
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;

          //custom widgets

          Widget continuebtn;

          Widget realcontinue = TextButton(
            onPressed: () {
              setState(() {
                accountI = 4;
              });
            },
            child: const Text(
              'Change',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff231E54)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xff231E54),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0))),
            ),
          );

          continuebtn = realcontinue;
          Widget PendingCon = Container();

          //scaffold body starts here
          return Container(
              decoration: BoxDecoration(
                color: mode.background3,
              ),
              child: Column(children: [
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
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  accountI = 1;
                                });
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
                          'Bank Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mode.brightText1,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 40,
                        )
                      ],
                    ),
                  ),
                ),
                //other items in statement after header
                Container(
                  width: myWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      children: [
                        Text(
                          'Bank Details registered with\nElevate Alliance NIG LTD.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mode.brightText1),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: getbank(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        Map bank = snapshot.data['bank'];
                        if (bank['id'] == null) {
                          accountI = 4;
                        }
                        if (bank['status'] == 'pending') {
                          PendingCon = Container(
                            child: const Text(
                              'Change Pending',
                              style: TextStyle(
                                color: Color(0xffF6B41A),
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: myWidth,
                          height: myHeight - 153,
                          color: mode.background2,
                          child: Column(
                            children: [
                              Container(
                                width: myWidth,
                                decoration: BoxDecoration(
                                  color: mode.background2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Account Name',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: mode.brightText1,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 56,
                                        width: myWidth - 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: mode.selectfieldColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 10, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(bank['name'] ?? '',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: mode.brightText1,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('Account Number',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: mode.brightText1,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 56,
                                        width: myWidth - 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: mode.selectfieldColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 10, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(bank['account_number'] ?? '',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: mode.brightText1,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('Bank Name',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: mode.brightText1,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 56,
                                        width: myWidth - 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: mode.selectfieldColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 10, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(bank['bank_name'] ?? '',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: mode.brightText1,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PendingCon,
                                      Container(
                                        width: myWidth - 20,
                                        child: Column(children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 50,
                                            width: myWidth - 20,
                                            child: continuebtn,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
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
                          height: myHeight - 151,
                          width: myWidth,
                          color: mode.background1,
                          child: Center(
                            child: CustomLoader,
                          ),
                        );
                        return loading;
                      }
                    })
              ]));
        })));
  }
}
