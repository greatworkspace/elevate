import 'package:elevate/home.dart';
import 'package:elevate/humanizeAmount.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'target_saving.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'models/databaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart';

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

class EditTarget extends StatefulWidget {
  @override
  _EditTargetState createState() => _EditTargetState();
}

final List<Map<String, dynamic>> savetypes = [
  {
    'value': 'Monthly',
    'label': 'Monthly',
  },
  {
    'value': 'Weekly',
    'label': 'Weekly',
  },
  {
    'value': 'Daily',
    'label': 'Daily',
  },
];

dynamic mode = mode;
Widget OverCon = Container();
Widget loading = Container();
Widget Correctpin = Container();
Widget Failedtrans = Container();

class _EditTargetState extends State<EditTarget>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  DateTime _iniSelectedDate = DateTime.now();
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();
  final nameCon = TextEditingController();
  final tAmountCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          if (mode.name == 'Light') {
            return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                      primary: const Color(0xff23AA59),
                      onPrimary: mode.brightText1,
                      onSurface: Colors.black)),
              child: DatePickerDialog(
                  initialDate: _selectedDate2,
                  firstDate: _selectedDate,
                  lastDate: DateTime(2101)),
            );
          } else {
            return Theme(
              data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                      primary: const Color(0xff23AA59),
                      surface: const Color(0xff23AA59),
                      shadow: Colors.black,
                      onPrimary: mode.brightText1,
                      onSurface: Colors.white)),
              child: DatePickerDialog(
                  initialDate: _selectedDate2,
                  firstDate: _selectedDate,
                  lastDate: DateTime(2101)),
            );
          }
        },
        context: context,
        initialDate: _selectedDate2,
        firstDate: _selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != _iniSelectedDate) {
      setState(() {
        _selectedDate2 = picked;
      });
    }
  }

  void edittarget() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      OverCon = loading;
    });
    String url = apiUrl + 'edit/target/';

    dynamic token = await DatabaseHelper.instance.getToken();
    String mid = item['id'].toString();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
        'id': mid,
        'name': nameCon.text,
        'amount': getNum(tAmountCon.text).toString(),
        'end': '${DateFormat('dd-MM-yyyy').format(_selectedDate2.toLocal())}',
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      String result = json.decode(res2.body);
      if (result == 'success') {
        setState(() {
          OverCon = Correctpin;
        });
        regetdata();
      } else {
        setState(() {
          OverCon = Failedtrans;
        });
      }
    } else {
      print(res2.statusCode);
      setState(() {
        OverCon = Failedtrans;
      });
    }
  }

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

  Map item = targets.where((element) => element['id'] == targetD).toList()[0];

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
    nameCon.text = item['name'];
    _selectedDate = DateFormat('yyyy-MM-dd').parse(item['start']);
    _selectedDate2 = DateFormat('yyyy-MM-dd').parse(item['end']);
    tAmountCon.text = humanizeNo(item['target']);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          // creating custom widgets

          loading = Scaffold(body:
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
            Widget loader = Container(
              height: myHeight,
              width: myWidth,
              color: mode.background1,
              child: Center(
                child: CustomLoader,
              ),
            );
            return loader;
          })));

          return Stack(
            children: [
              Scaffold(
                body: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final myHeight = constraints.maxHeight;
                    final myWidth = constraints.maxWidth;
                    // creating custom widgets

                    Correctpin = Scaffold(
                      body: Container(
                          height: myHeight,
                          width: myWidth,
                          color: mode.background2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: myHeight / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/request_sent.svg'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Request Sent',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: mode.brightText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: myHeight / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 100),
                                      child: Container(
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              backgroundColor: mode.background2,
                                            ),
                                            onPressed: () {
                                              OverCon = Container();
                                             setState(() {
                                    savingsI = 3;
                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                index:
                                                                    selectedindex,
                                                              )));
                                            },
                                            child: Text(
                                              'Back to Targets',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );

                    Failedtrans = Scaffold(
                      body: Container(
                          height: myHeight,
                          width: myWidth,
                          color: mode.background2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: myHeight / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/request_failed.svg'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Request Failed',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: mode.brightText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: myHeight / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 54,
                                            width: myWidth - 40,
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff23AA59),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    OverCon = Container();
                                                  });
                                                },
                                                child: const Text(
                                                  'Try Again',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 54,
                                            width: myWidth - 40,
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  backgroundColor:
                                                      mode.background2,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                    savingsI = 3;
                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                index:
                                                                    selectedindex,
                                                              )));
                                                },
                                                child: Text(
                                                  'Back to Targets',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: mode.brightText1,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );

                    Widget greycontinue = TextButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffD9D9D9)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xffD9D9D9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );

                    Widget realcontinue = TextButton(
                      onPressed: () {
                        edittarget();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff23AA59)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xff23AA59),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );

                    Widget continuebtn() {
                      if (tAmountCon.text != '' && nameCon.text != '') {
                        try {
                          getNum(tAmountCon.text);
                          if (getNum(tAmountCon.text) >= 1000) {
                            return realcontinue;
                          }
                        } catch (e) {
                          return greycontinue;
                        }
                      } else {
                        return greycontinue;
                      }

                      return greycontinue;
                    }

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
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
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: myWidth,
                            decoration: BoxDecoration(color: mode.background3),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Edit Target Details',
                                      style: TextStyle(
                                          color: mode.brightText1,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('Edit - ' + item['name'],
                                      style: TextStyle(
                                        color: mode.brightText1,
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: myHeight - 260,
                                width: myWidth,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: ListView(
                                    children: [
                                      //first
                                      Text(
                                        'Name of Target',
                                        style: TextStyle(
                                            color: mode.dimText1, fontSize: 11),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 60,
                                        width: myWidth - 20,
                                        child: TextField(
                                          controller: nameCon,
                                          style: TextStyle(
                                              color: mode.brightText1,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: false,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.8,
                                                    color: mode.brightText1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mode.fieldBorder)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //second
                                      Text(
                                        'Target',
                                        style: TextStyle(
                                            color: mode.dimText1, fontSize: 11),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 60,
                                        width: myWidth - 20,
                                        child: TextField(
                                          controller: tAmountCon,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [],
                                          onTapOutside: (event) {
                                            if (tAmountCon.text != '') {
                                              setState(() {
                                                tAmountCon.text = humanizeNo(
                                                    getNum(tAmountCon.text));
                                              });
                                            }
                                          },
                                          onTap: () {
                                            setState(() {
                                              tAmountCon.value =
                                                  TextEditingValue(
                                                text: tAmountCon.text,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: tAmountCon
                                                            .text.length),
                                              );
                                            });
                                          },
                                          cursorColor: mode.background1,
                                          onChanged: (value) {
                                            if (value.isNotEmpty &&
                                                !value.contains('.')) {
                                              dynamic inivalue = getNum(value);
                                              String humanVal =
                                                  humanizeNo2(inivalue);
                                              setState(() {
                                                tAmountCon.value =
                                                    TextEditingValue(
                                                  text: humanVal,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset:
                                                              humanVal.length),
                                                );
                                              });
                                            } else if (value.contains('.')) {
                                              String newval = '';
                                              List strs = value.split('.');
                                              if (strs[1].length > 2) {
                                                String restred =
                                                    strs[1].substring(0, 2);
                                                newval =
                                                    strs[0] + '.' + restred;
                                              } else {
                                                newval = value;
                                              }

                                              setState(() {
                                                tAmountCon.value =
                                                    TextEditingValue(
                                                  text: newval,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset:
                                                              newval.length),
                                                );
                                              });
                                            }
                                          },
                                          style: TextStyle(
                                              color: mode.brightText1,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            prefixIcon: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 15, 0),
                                                  child: Text(
                                                    'NGN',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: mode.dimText1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            alignLabelWithHint: false,
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.8,
                                                    color: mode.brightText1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: mode.fieldBorder)),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //fourth
                                      Text(
                                        'Start date',
                                        style: TextStyle(
                                            color: mode.dimText1, fontSize: 11),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                          height: 50,
                                          width: myWidth - 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: mode.selectfieldColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 10, 0),
                                              child: TextButton(
                                                  onPressed: null,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${DateFormat('MMMM d, yyyy').format(_selectedDate.toLocal())}',
                                                        style: TextStyle(
                                                            color:
                                                                mode.dimText1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //fifth
                                      Text(
                                        'End date (Optional)',
                                        style: TextStyle(
                                            color: mode.dimText1, fontSize: 11),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                          height: 50,
                                          width: myWidth - 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color(
                                                        0xff9DADEC))),
                                            child: TextButton(
                                                onPressed: () =>
                                                    _selectDate2(context),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 0, 0),
                                                      child: Text(
                                                        '${DateFormat('MMMM d, yyyy').format(_selectedDate2.toLocal())}',
                                                        style: TextStyle(
                                                            color:
                                                                mode.dimText1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: myWidth - 20,
                                child: Column(children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: myWidth - 20,
                                    child: continuebtn(),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  )
                                ]),
                              )
                            ],
                          )
                        ]));
                  }),
                ),
              ),
              OverCon,
            ],
          );
        })));
  }
}
