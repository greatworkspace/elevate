import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'package:file_picker/file_picker.dart';
import 'savings.dart';

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

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

dynamic mode = mode;

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  dynamic transactions;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final beneCon = TextEditingController();
  final accountTCon = TextEditingController();
  final accCon = TextEditingController();
  final amountCon = TextEditingController();
  final narateCon = TextEditingController();

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

  Future mgetUser() async {
    dynamic got = await DatabaseHelper.instance.getUser();
    dynamic trans = await DatabaseHelper.instance.getTrans();

    return {
      'data': got,
      'transactions': trans,
    };
  }

  FilePickerResult? result;
  Widget AccountW = Container();
  String accountN = '';
  bool isEnabled = true;
  Widget loader = Container();
  Widget AccountText = Container();
  bool err = true;
  bool loaded = false;

  DateFormat dateFormat = DateFormat.yMMMMd();
  DateFormat timeFormat = DateFormat.jm();

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('en');
    timeFormat = new DateFormat.jm('en');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mgetUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            dynamic initransactions = snapshot.data['transactions'];

            if (loaded == false) {
              transactions = initransactions;
              loaded = true;
            }

            return Scaffold(
                backgroundColor: mode.background1,
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;
                  // creating custom widgets
                  double myconheight = myHeight - 147;
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
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                Container(
                                  width: myWidth - 80,
                                  child: Center(
                                    child: Text(
                                      'Transation History',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mode.brightText1,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 4,
                          color: mode.background3,
                        ),
                        Container(
                          height: 74,
                          color: mode.background2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: myWidth - 20,
                                  child: TextField(
                                    onChanged: (value) {
                                      List<Map<String, dynamic>> newlist = [];
                                      for (var item in initransactions) {
                                        if (item['transaction_name']
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                          newlist.add(item);
                                        } else if (item['name']
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                          newlist.add(item);
                                        } else if (item['note']
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                          newlist.add(item);
                                        }
                                      }
                                      setState(() {
                                        transactions = newlist;
                                      });
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(""))
                                    ],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: SvgPicture.asset(
                                            'assets/svg/search_icon.svg'),
                                      ),
                                      alignLabelWithHint: false,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        color: mode.dimText1,
                                        fontSize: 15,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: mode.fieldBorder)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: mode.fieldBorder,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: mode.dimText1,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          height: 4,
                          color: mode.background3,
                        ),
                        Container(
                          height: myconheight,
                          color: mode.background2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                Widget amountWid = Container();
                                imagecon() {
                                  if (transactions[index]['image'] == '' ||
                                      transactions[index]['image'] == null) {
                                    return Container(
                                      height: 42,
                                      width: 42,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(42),
                                        child: Image.asset(
                                          'assets/images/default_pic.png',
                                          width: 42,
                                          cacheHeight: 84,
                                          cacheWidth: 84,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 42,
                                      width: 42,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(42),
                                        child: Image.network(
                                          transactions[index]['image'],
                                          width: 42,
                                          cacheHeight: 84,
                                          cacheWidth: 84,
                                        ),
                                      ),
                                    );
                                  }
                                }

                                String date = dateFormat.format(DateTime.parse(
                                        transactions[index]['date'])) +
                                    ' ' +
                                    timeFormat.format(DateTime.parse(
                                        transactions[index]['date']));
                                if (transactions[index]['trans_type']
                                            .toString()
                                            .toLowerCase() ==
                                        'deposit' ||
                                    transactions[index]['name']
                                            .toString()
                                            .toLowerCase() ==
                                        'interest gain') {
                                  amountWid = Text(
                                    '+' +
                                        humanizeNo(
                                            transactions[index]['amount']),
                                    style: const TextStyle(
                                        color: Color(0xff05F200), fontSize: 13),
                                  );
                                } else {
                                  amountWid = Text(
                                    '-' +
                                        humanizeNo(
                                            transactions[index]['amount']),
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  );
                                }
                                Widget container = Container();
                                Widget Mystroke = Container();
                                if ((index < transactions.length - 1) &
                                    (index > 0)) {
                                  Mystroke = Row(
                                    children: [
                                      const SizedBox(
                                        width: 62,
                                      ),
                                      Container(
                                        width: myWidth - 62,
                                        height: 1,
                                        color: mode.kunleStroke,
                                      )
                                    ],
                                  );
                                }
                                if (transactions[index]['trans_type']
                                            .toString()
                                            .toLowerCase() !=
                                        'investment' &&
                                        transactions[index]['note']
                                            .toString()
                                            .toLowerCase() !=
                                        'investment deposit' &&
                                    transactions[index]['trans_type']
                                            .toString()
                                            .toLowerCase() !=
                                        'loan') {
                                  String nametext = transactions[index]
                                          ['transaction_name'] ??
                                      '';
                                  if (transactions[index]['trans_type'] ==
                                      'target') {
                                    nametext = transactions[index]['note'];
                                  }
                                  container = TextButton(
                                    onPressed: () {
                                      setState(() {
                                        transIndex = initransactions.indexWhere(
                                            (map) =>
                                                map["id"] ==
                                                transactions[index]['id']);
                                        if (transIndex != -2) {
                                          Navigator.of(context)
                                              .pushNamed('TransactionDetails');
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Column(
                                      children: [
                                        //transaction 1
                                        Container(
                                          height: 63,
                                          width: myWidth,
                                          color: mode.background1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    //placeholder for picture
                                                    imagecon(),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: myWidth - 72,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                nametext,
                                                                style: TextStyle(
                                                                    color: mode
                                                                        .brightText1,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                date,
                                                                style: TextStyle(
                                                                    color: mode
                                                                        .dimText1,
                                                                    fontSize:
                                                                        13),
                                                              )
                                                            ],
                                                          ),
                                                          amountWid,
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Mystroke
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Widget transpic = Container();
                                  if (transactions[index]['trans_type'] ==
                                      'loan') {
                                    transpic = SvgPicture.asset(
                                      'assets/svg/trans_loan.svg',
                                      width: 42,
                                    );
                                  } else {
                                    transpic = SvgPicture.asset(
                                      'assets/svg/trans_invest.svg',
                                      width: 42,
                                    );
                                  }
                                  container = TextButton(
                                    onPressed: () {
                                      setState(() {
                                        transIndex = index;
                                      });
                                      Navigator.of(context)
                                          .pushNamed('TransactionDetails');
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Column(
                                      children: [
                                        //transaction 1
                                        Container(
                                          height: 63,
                                          width: myWidth,
                                          color: mode.background1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    //placeholder for picture
                                                    transpic,
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      width: myWidth - 72,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                transactions[
                                                                            index]
                                                                        [
                                                                        'note'] ??
                                                                    '',
                                                                style: TextStyle(
                                                                    color: mode
                                                                        .brightText1,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                date,
                                                                style: TextStyle(
                                                                    color: mode
                                                                        .dimText1,
                                                                    fontSize:
                                                                        13),
                                                              )
                                                            ],
                                                          ),
                                                          amountWid,
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Mystroke,
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return container;
                              },
                            ),
                            //end of listbuilder
                          ),
                        ),
                      ]));
                })));
          } else {
            return Scaffold(body:
                SafeArea(child: LayoutBuilder(builder: (context, constraints) {
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
        });
  }
}
