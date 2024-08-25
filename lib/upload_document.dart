import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:select_form_field/select_form_field.dart';
import 'dart:core';
import './humanizeAmount.dart';
import 'dart:convert';

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

class UploadDocument extends StatefulWidget {
  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

final List<Map<String, dynamic>> purposes = [
  {
    'value': 'loan repayment',
    'label': 'Loan Repayment',
  },
  {
    'value': 'investment deposit',
    'label': 'Investment Deposit',
  },
  {
    'value': 'savings deposit',
    'label': 'Savings Deposit',
  },
];

dynamic mode = mode;
Widget loading = Container();
Widget OverCon = Container();
String inifile = 'Click here to upload';
bool gotfile = false;
double xpad = 0;
double xpad2 = 0;

class _UploadDocumentState extends State<UploadDocument>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final purposeCon = TextEditingController();
  final amountCon = TextEditingController();
  final accNameCon = TextEditingController();
  final accNoCon = TextEditingController();
  final bankCon = TextEditingController();
   final refCon = TextEditingController();

  DateTime _iniSelectedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  DateTime _iniSelectedTime = DateTime.now();
  DateTime _selectedTime = DateTime.now();

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

  FilePickerResult? resulted;
  DateFormat dateFormat = DateFormat.yMMMMd();
  DateFormat timeFormat = DateFormat.jm();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  Future<dynamic> uploaddoc() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      OverCon = loading;
    });

    String url = apiUrl + 'make/proof/';

    dynamic token = await DatabaseHelper.instance.getToken();

    Map<String, String> requestBody = <String, String>{
      "bank_name": bankCon.text,
      "account_name": accNameCon.text,
      "account_number": accNoCon.text,
      "purpose": purposeCon.text,
      "reference":refCon.text,
      "amount": getNum(amountCon.text).toString(),
      "date": DateFormat('yyyy-MM-dd').format(_selectedDate.toLocal()),
      "time": DateFormat('HH:mm').format(_selectedTime.toLocal()),
    };
    Map<String, String> headers = <String, String>{'token': token};

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(
          await MultipartFile.fromPath('file', resulted!.files.first.path!))
      ..fields.addAll(requestBody);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    setState(() {
      OverCon = Container();
    });
    return jsonDecode(respStr);
  }

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
                  firstDate: DateTime.now(),
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
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101)),
            );
          }
        },
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _iniSelectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      builder: (context, child) {
        if (mode.name == 'Light') {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: const Color(0xff23AA59),
                    onPrimary: mode.brightText1,
                    onSurface: Colors.black)),
            child: TimePickerDialog(
              initialTime: TimeOfDay.fromDateTime(_selectedTime),
            ),
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
            child: TimePickerDialog(
                initialTime: TimeOfDay.fromDateTime(_selectedTime)),
          );
        }
      },
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (picked != null && picked != _iniSelectedTime) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
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

      if (myWidth > 600) {
        xpad = 200;
        xpad2 = 100;
      } else {
        xpad = 0;
        xpad2 = 0;
      }
      // creating custom widgets

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
        height: myHeight - 175,
        width: myWidth,
        color: mode.loadingBg,
        child: Center(
          child: CustomLoader,
        ),
      );

      Widget greycontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Send',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
      );

      Widget realcontinue = TextButton(
        onPressed: () async {
          dynamic result = await uploaddoc();
          if (result == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.zero,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              margin: EdgeInsets.fromLTRB(myWidth / 4, 0, myWidth / 4, 30),
              backgroundColor: Color.fromARGB(150, 128, 128, 128),
              duration: const Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              content: Container(
                width: myWidth / 2,
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
                          'Success',
                          style: TextStyle(
                              color: mode.darkText1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
            regetdata(context, mode);
            Navigator.of(context).pushNamed('Home');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.zero,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              margin: EdgeInsets.fromLTRB(myWidth / 4, 0, myWidth / 4, 30),
              backgroundColor: Color.fromARGB(150, 128, 128, 128),
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              content: Container(
                width: myWidth / 2,
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
                          result,
                          style: TextStyle(
                              color: mode.darkText1,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
          }
        },
        child: const Text(
          'Send',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff231E54)),
        ),
      );

      Widget continuebtn() {
        if (gotfile == true &&
        refCon.text != '' &&
            purposeCon.text != '' &&
            amountCon.text != '' &&
            accNameCon.text != '' &&
            accNoCon.text != '' &&
            accNoCon.text.length == 10 &&
            bankCon.text != '' &&
            _selectedTime.isBefore(_iniSelectedTime)) {
          return realcontinue;
        } else {
          return greycontinue;
        }
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
                    SizedBox(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              gotfile = false;
                              inifile = 'Click here to upload';
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
                    SizedBox(
                      width: myWidth - 80,
                      child: Center(
                        child: Text(
                          'Upload Document',
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
              height: 100,
              width: myWidth,
              decoration: BoxDecoration(color: mode.background3),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Browse through your files and import the proof \nof payment.',
                        style: TextStyle(
                          color: mode.brightText1,
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(xpad2, 0, xpad2, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: myHeight - 260,
                        width: myWidth,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListView(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              //first
                              SizedBox(
                                width: myWidth - 20,
                                height: 95,
                                child: TextButton(
                                  onPressed: () async {
                                    resulted = await FilePicker.platform
                                        .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                          'png',
                                          'jpg',
                                          'pdf'
                                        ]);
                                    if (resulted != null) {
                                      setState(() {
                                        inifile = resulted!.names[0]!;
                                        gotfile = true;
                                      });
                                    } else {
                                      setState(() {
                                        gotfile = false;
                                        inifile = 'Click here to upload';
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: DottedBorder(
                                      strokeWidth: 1,
                                      borderType: BorderType.RRect,
                                      dashPattern: const [8, 9, 8, 9],
                                      radius: const Radius.circular(10),
                                      padding: const EdgeInsets.all(6),
                                      color: const Color(0xff231E54),
                                      child: SizedBox(
                                        height: 85,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/svg/floating_home_document.svg',
                                                  width: 60,
                                                  height: 60,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  width: myWidth -
                                                      117 -
                                                      (xpad * 2),
                                                  child: Text(
                                                    inifile,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Color(0xff231E54),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //first
                              Text(
                                'Purpose of payment',
                                style: TextStyle(
                                    color: mode.dimText1, fontSize: 11),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 60,
                                width: myWidth - 20,
                                child: SelectFormField(
                                  items: purposes,
                                  controller: purposeCon,
                                  onChanged: (value) {
                                    setState(() {
                                      purposeCon.text = value;
                                    });
                                  },
                                  type: SelectFormFieldType.dropdown,
                                  decoration: InputDecoration(
                                    filled: true,
                                    alignLabelWithHint: false,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    label: Container(
                                      child: Text(
                                        'Choose Purpose of Payment',
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
                                      padding:
                                          EdgeInsets.fromLTRB(10, 17, 0, 0),
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
                              //second
                              Text(
                                'Amount paid',
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
                                  controller: amountCon,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [],
                                  onTapOutside: (event) {
                                    if (amountCon.text != '') {
                                      setState(() {
                                        amountCon.text =
                                            humanizeNo(getNum(amountCon.text));
                                      });
                                    }
                                  },
                                  onTap: () {
                                    setState(() {
                                      amountCon.value = TextEditingValue(
                                        text: amountCon.text,
                                        selection: TextSelection.collapsed(
                                            offset: amountCon.text.length),
                                      );
                                    });
                                  },
                                  cursorColor: mode.background1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        !value.contains('.')) {
                                      dynamic inivalue = getNum(value);
                                      String humanVal = humanizeNo2(inivalue);
                                      setState(() {
                                        amountCon.value = TextEditingValue(
                                          text: humanVal,
                                          selection: TextSelection.collapsed(
                                              offset: humanVal.length),
                                        );
                                      });
                                    } else if (value.contains('.')) {
                                      String newval = '';
                                      List strs = value.split('.');
                                      if (strs[1].length > 2) {
                                        String restred =
                                            strs[1].substring(0, 2);
                                        newval = strs[0] + '.' + restred;
                                      } else {
                                        newval = value;
                                      }

                                      setState(() {
                                        amountCon.value = TextEditingValue(
                                          text: newval,
                                          selection: TextSelection.collapsed(
                                              offset: newval.length),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 15, 0),
                                          child: Text(
                                            'NGN',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: mode.dimText1,
                                              fontWeight: FontWeight.bold,
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
                              //third
                              Text(
                                'Account Name',
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
                                  controller: accNameCon,
                                  onChanged: (value) {
                                    setState(() {
                                      accNameCon.text = value;
                                    });
                                  },
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
                              //third
                              Text(
                                'Account Number',
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
                                  controller: accNoCon,
                                  onChanged: (value) {
                                    setState(() {
                                      accNoCon.text = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
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
                              //fourth
                              Text(
                                'Bank paid from',
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
                                  controller: bankCon,
                                  onChanged: (value) {
                                    setState(() {
                                      bankCon.text = value;
                                    });
                                  },
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
                              Text(
                                'Reference',
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
                                  controller: refCon,
                                  onChanged: (value) {
                                    setState(() {
                                      refCon.text = value;
                                    });
                                  },
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
                              Text(
                                'Date',
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
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xff9DADEC))),
                                    child: TextButton(
                                        onPressed: () => _selectDate(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${DateFormat('MMMM d, yyyy').format(_selectedDate.toLocal())}',
                                              style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )),
                                  )),

                              const SizedBox(
                                height: 10,
                              ),

                              Text(
                                'Time',
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
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xff9DADEC))),
                                    child: TextButton(
                                        onPressed: () => _selectTime(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${DateFormat('jm').format(_selectedTime.toLocal())}',
                                              style: TextStyle(
                                                  color: mode.dimText1,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )),
                                  )),
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
                  ),
                ),
                OverCon,
              ],
            )
          ]));
    })));
  }
}
