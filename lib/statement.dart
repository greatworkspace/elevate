import 'dart:io';

import 'package:elevate/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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



class StatementScreen extends StatefulWidget {
  @override
  _StatementScreenState createState() => _StatementScreenState();
}

dynamic mode = mode;
Widget OverCon = Container();
Widget loading = Container();
Widget complete = Container();
bool down = false;
String filePath = '';

class _StatementScreenState extends State<StatementScreen>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  DateTime iniselecteddate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
  DateTime _selectedDate = DateTime.now();

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

  Future<void> _selectDate(BuildContext context) async {
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
                  initialDate: _selectedDate,
                  firstDate: DateTime(DateTime.now().year - 5),
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
                  initialDate: _selectedDate,
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime(2101)),
            );
          }
        },
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      if (_selectedDate.compareTo(_selectedDate2) > 0) {
        setState(() {
          _selectedDate2 = _selectedDate;
        });
      }
    }
  }

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
                  initialDate: _selectedDate,
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
        initialDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate2 = picked;
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

  Future<String> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
    }
    return directory!.path;
  }

  void getstatement() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      OverCon = loading;
    });
    String url = apiUrl + 'request/statement/';

    dynamic token = await DatabaseHelper.instance.getToken();

    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
        'start': '${DateFormat('dd-MM-yyyy').format(_selectedDate.toLocal())}',
        'end': '${DateFormat('dd-MM-yyyy').format(_selectedDate2.toLocal())}',
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      Map result = json.decode(res2.body);
      if (result['result'] == 'success') {
        String url = result['url'];
        HttpClient httpClient = new HttpClient();
        File file;
        String dir = await getDownloadPath();
        filePath = 'account_statement.pdf';
        filePath = '${dir}/${filePath}';

        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          file = File(filePath);
          await file.writeAsBytes(bytes);
        } else
          filePath = 'Error code: ' + response.statusCode.toString();


        setState(() {
          down = true;
          OverCon = Container();
        });
        Navigator.pop(context);

        regetdata(context, mode);
      } else {
        setState(() {
          OverCon = Container();
        });
      }
    } else {
      setState(() {
        OverCon = Container();
      });
    }
  }

  void initState() {
    super.initState();
    regetdata(context, mode);
    getMode();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

       if (down == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: EdgeInsets.fromLTRB(
            myWidth * (15 / 100), 0, myWidth * (15 / 100), 30),
        backgroundColor: Color.fromARGB(150, 128, 128, 128),
        duration: const Duration(seconds: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Container(
          width: myWidth * (70 / 100),
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
                    'saved to ${filePath}',
                    style: TextStyle(
                        color: mode.darkText1,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
      setState(() {
        down = false;
      });
    }

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
      loading = Container(
        height: myHeight - 166,
        width: myWidth,
        color: mode.background1,
        child: Center(
          child: CustomLoader,
        ),
      );

      //custom widgets

      Widget greycontinue = TextButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffD9D9D9)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xffD9D9D9),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0))),
        ),
        child: const Text(
          'Send Request',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

      Widget realcontinue = TextButton(
        onPressed: () {
          getstatement();
        },
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
        child: const Text(
          'Send Request',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

      Widget continuebtn() {
        if (_selectedDate.compareTo(iniselecteddate) < 0 &&
            (_selectedDate.compareTo(_selectedDate2) < 0)) {
          return realcontinue;
        } else {
          return greycontinue;
        }
      }

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
                    SizedBox(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              OverCon = Container();
                            });
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
                    Text(
                      'Statements',
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
              height: (myWidth - 20) / 4,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  'To get your statement, choose the period in which you want to access.',
                  style: TextStyle(fontSize: 14, color: mode.brightText1),
                )),
              ),
            ),
            Stack(children: [
              Container(
                width: myWidth,
                decoration: BoxDecoration(
                    color: mode.background1,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      //fourth
                      Text(
                        'Start date',
                        style: TextStyle(color: mode.brightText1, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 50,
                          width: myWidth - 20,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1, color: mode.brightText1)),
                            child: TextButton(
                                onPressed: () => _selectDate(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        '${DateFormat('MMMM d, yyyy').format(_selectedDate.toLocal())}',
                                        style: TextStyle(
                                            color: mode.brightText1,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      //fifth
                      Text(
                        'End date',
                        style: TextStyle(color: mode.brightText1, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: myWidth - 20,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: mode.brightText1)),
                          child: TextButton(
                              onPressed: () => _selectDate2(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      '${DateFormat('MMMM d, yyyy').format(_selectedDate2.toLocal())}',
                                      style: TextStyle(
                                          color: mode.brightText1,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), //third
                      Text(
                        'Statement Format',
                        style: TextStyle(color: mode.brightText1, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: myWidth - 20,
                          decoration: BoxDecoration(
                              color: mode.selectfieldColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 1, color: mode.fieldBorder)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  'PDF',
                                  style: TextStyle(
                                      fontSize: 15, color: mode.dimText1),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'NOTE:   Statements will be sent to the email used for registering to EA services.',
                        style: TextStyle(
                          fontSize: 15,
                          color: mode.brightText1,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                  ),
                ),
              ),
              OverCon
            ]),
          ]));
    })));
  }
}
