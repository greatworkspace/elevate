import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'humanizeAmount.dart';
import 'package:file_picker/file_picker.dart';
import 'savings.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/user.dart';

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

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

dynamic mode = mode;

class _TransactionDetailsState extends State<TransactionDetails>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;

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
  String transtype = '';
  String transbank = '';
  String transacc = '';

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
    bool inivalue;

    return FutureBuilder(
        future: mgetUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data['data'];
            dynamic transactions = snapshot.data['transactions'];

            return Scaffold(
                backgroundColor: mode.background1,
                body: SafeArea(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final myHeight = constraints.maxHeight;
                  final myWidth = constraints.maxWidth;
                  // creating custom widgets

                  Map item = transactions[transIndex];
                  Widget DepositCon = Container();
                  String date =
                      dateFormat.format(DateTime.parse(item['date'])) +
                          ' ' +
                          timeFormat.format(DateTime.parse(item['date']));
                  if (item['trans_type'].toString().toLowerCase() ==
                      'deposit') {
                    DepositCon = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Through:',
                              style: TextStyle(
                                color: Color(0xff23AA59),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'ELEVATE ALLIANCE',
                              style: TextStyle(
                                color: mode.brightText1,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                  String ttype = item['trans_type'] ?? '';
                  if (ttype.toLowerCase() == 'loan' ||
                      ttype.toLowerCase() ==
                          'investment') {
                    transtype = item['name'] ?? '';
                    transbank = 'Elevate Alliance NIG LTD.';
                    if (ttype.toLowerCase() == 'loan') {
                      transacc = 'ELEVATE MARKET MONIE';
                    } else {
                      transacc = 'EA INVESTMENT SAVINGS';
                    }
                  } else {
                    transtype = item['trans_type'] ?? '';
                    transbank = item['transaction_bank'] ?? '';
                    transacc = item['transaction_name'] ?? '';
                  }

                  //scaffold body starts here
                  return Container(
                      decoration: BoxDecoration(
                        color: mode.background2,
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
                                      'Transation Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: mode.brightText1,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
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
                          width: myWidth,
                          height: myHeight - 69,
                          decoration: BoxDecoration(color: mode.background2),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //date
                                      const Text(
                                        'Transaction Type:',
                                        style: TextStyle(
                                          color: Color(0xff23AA59),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        transtype,
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Date / Time',
                                        style: TextStyle(
                                          color: Color(0xff23AA59),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        date,
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  DepositCon,
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  //amount
                                  const Text(
                                    'Amount:',
                                    style: TextStyle(
                                      color: Color(0xff23AA59),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'N ' + humanizeNo(item['amount']),
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        child: Container(
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                              color: mode.brightText1,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ),
                                      Text(
                                        transacc,
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  //bank
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Bank:',
                                        style: TextStyle(
                                          color: Color(0xff23AA59),
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Text(
                                        'Account Number:',
                                        style: TextStyle(
                                          color: Color(0xff23AA59),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        transbank,
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        item['transaction_no'],
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  //note
                                  const Text(
                                    'Note:',
                                    style: TextStyle(
                                      color: Color(0xff23AA59),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item['note'] ?? '',
                                    style: TextStyle(
                                      color: mode.brightText1,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  //payment process and charges
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Payment Process:',
                                        style: TextStyle(
                                          color: Color(0xff23AA59),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'charges:',
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['payment_process'] ?? '',
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'N ' + humanizeNo(0.0),
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  //Reference
                                  const Text(
                                    'Reference Number:',
                                    style: TextStyle(
                                      color: Color(0xff23AA59),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['reference'],
                                        style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Container(
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                8.484848976135254),
                                            color: const Color(0xff78e58f)),
                                        child: TextButton(
                                            onPressed: () async {
                                              Clipboard.setData(ClipboardData(
                                                      text: item['reference']))
                                                  .then((value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        elevation: 0,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                myWidth / 4,
                                                                0,
                                                                myWidth / 4,
                                                                30),
                                                        backgroundColor:
                                                            mode.background1,
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        shape:
                                                            BeveledRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        content: Container(
                                                          width: myWidth / 2,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: mode.floatBg,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    'Copied!',
                                                                    style: TextStyle(
                                                                        color: mode
                                                                            .darkText1,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/mark.svg',
                                                                    color: mode
                                                                        .darkText1,
                                                                    height: 12,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )));
                                            },
                                            child: const Text(
                                              'Copy',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.5),
                                            )),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  //status
                                  const Text(
                                    'Status:',
                                    style: TextStyle(
                                      color: Color(0xff23AA59),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item['status'] ?? '',
                                    style: TextStyle(
                                      color: mode.brightText1,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 25),
                                    child: Container(
                                      height: 1,
                                      width: myWidth - 40,
                                      color: mode.kunleStroke,
                                    ),
                                  ),
                                  Container(
                                    width: myWidth - 40,
                                    height: 53.559776306152344,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            9.56424617767334),
                                        color: const Color(0xff23aa59)),
                                    child: const TextButton(
                                      onPressed: null,
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
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
