import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

final List<Map<String, dynamic>> documents = [
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '12/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '12/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '11/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '11/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '08/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '02/07/2023'},
  {'name': 'Payment - EA invesments', 'doctype': 'JPEG', 'date': '27/06/2023'},
];

List<dynamic> sorted = [];



class DocumentsScreen extends StatefulWidget {
  DocumentsScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;
  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

dynamic mode = mode;

class _DocumentsScreenState extends State<DocumentsScreen> {
  dynamic mode = lightmode;

  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final howCon = TextEditingController();




  void getdates() {
    sorted = [];
    List newlist = [];
    for (var idates in documents) {
      DateTime date = DateFormat('dd/MM/yyyy').parse(idates['date']);
      int a = 0;
      for (var item in newlist) {
        if (date == item) {
          a = 1;
        }
      }
      if (a == 0) {
        newlist.add(date);
      }
    }
    newlist.sort((a, b) => a.compareTo(b));
    Iterable<dynamic> rnewlist = newlist.reversed;
    newlist = [];
    for (var ritem in rnewlist) {
      newlist.add(ritem);
    }

    for (var item in newlist) {
      List items = [];
      for (var iniitem in documents) {
        if (DateFormat('dd/MM/yyyy').parse(iniitem['date']) == item) {
          items.add(iniitem);
        }
      }
      sorted.add({
        'date': item,
        'items': items,
      });
    }
  }

  void initState() {
    super.initState();
    getdates();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      //custom widgets

      // ignore: unused_local_variable
      Widget continuebtn;

      Widget greycontinue = TextButton(
        onPressed: null,
        child: const Text(
          'Send Request',
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
        onPressed: null,
        child: const Text(
          'Send Request',
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
                      'Documents',
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
            SizedBox(
              width: myWidth,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Click on the plus button to add other proofs of\npayment.',
                      style: TextStyle(fontSize: 14, color: mode.brightText1),
                    ),
                  ],
                ),
              ),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('UploadDocument');
                    },
                    child: AnimatedRotation(
                        duration: const Duration(milliseconds: 500),
                        turns: 1,
                        child: SvgPicture.asset(
                          'assets/svg/floating_home.svg',
                          height: 62,
                          width: 62,
                        ))),
              ),
            ]),
            SizedBox(
              height: myHeight - 233,
              child: ListView.builder(
                itemCount: sorted.length,
                itemBuilder: (context, index) {
                  Map itemM = sorted[index];
                  DateTime item = itemM['date'];
                  //container for all docs in a specific date
                  List<Widget> containers2 = [];
                  //add docs to that container
                  for (var sitem in itemM['items']) {
                    containers2.add(Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        width: myWidth - 20,
                        height: 78,
                        decoration: BoxDecoration(
                            color: mode.background2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/document_icon.svg'),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    sitem['name'],
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: mode.brightText1,
                                    ),
                                  ),
                                  Text(
                                    sitem['doctype'],
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: mode.dimText1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  }
                  //add date header and docs underneath
                  String timestr = item.day.toString() +
                      '/' +
                      item.month.toString() +
                      '/' +
                      item.year.toString();
                  Widget columned = Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timestr,
                          style: TextStyle(
                            fontSize: 17,
                            color: mode.dimText1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Column(
                            children: containers2,
                          ),
                        )
                      ],
                    ),
                  );

                  return columned;
                },
              ),
            )
          ]));
    })));
  }
}
