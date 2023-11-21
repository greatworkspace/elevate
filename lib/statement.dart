import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'models/databaseHelper.dart';
import 'package:intl/intl.dart';

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

final List<Map<String, dynamic>> _languages = [
  {
    'value': 'English',
    'label': 'English',
  },
  {
    'value': 'French',
    'label': 'French',
  }
];

final List<Map<String, dynamic>> _modes = [
  {
    'value': 'Dark',
    'label': 'Dark Mode',
  },
  {
    'value': 'Light',
    'label': 'Light Mode',
  }
];

final List<Map<String, dynamic>> doctypes = [
  {
    'value': 'PDF',
    'label': 'PDF',
  },
];



class StatementScreen extends StatefulWidget {
  @override
  _StatementScreenState createState() => _StatementScreenState();
}

dynamic mode = mode;

class _StatementScreenState extends State<StatementScreen> {
  dynamic mode = lightmode;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();

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
        firstDate: DateTime(DateTime.now().year - 5),
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
  
  

  void initState() {
    super.initState();
    regetdata();
    getMode();
  }

  @override
  Widget build(BuildContext context) {
    bool inivalue;

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      //custom widgets

      Widget continuebtn;

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
        onPressed: null,
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

      continuebtn = greycontinue;

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
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                            border:
                                Border.all(width: 1, color: mode.brightText1)),
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
                    SizedBox(
                      height: 60,
                      width: myWidth - 20,
                      child: SelectFormField(
                        items: doctypes,
                        controller: howCon,
                        type: SelectFormFieldType.dropdown,
                        decoration: InputDecoration(
                          filled: true,
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          label: Container(
                            child: Text(
                              'Choose Document Format',
                              style: TextStyle(
                                fontSize: 10,
                                color: mode.dimText1,
                              ),
                            ),
                          ),
                          fillColor: mode.selectfieldColor,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1, color: mode.fieldBorder)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 17, 0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.solidCircle,
                              size: 7,
                              color: Color(0xff231E54),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1, color: mode.fieldBorder)),
                        ),
                        style: TextStyle(
                            color: mode.dimText1,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          child: realcontinue,
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
          ]));
    })));
  }
}
