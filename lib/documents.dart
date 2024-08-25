import 'dart:convert';

import 'package:elevate/home.dart';
import 'package:elevate/models/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
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


List<dynamic> documents = List.empty();

List<dynamic> sorted = [];

// ignore: must_be_immutable
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
      DateTime date = DateFormat('yyyy-MM-dd').parse(idates['date']);
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
        if (DateFormat('yyyy-MM-dd').parse(iniitem['date']) == item) {
          items.add(iniitem);
        }
      }
      sorted.add({
        'date': item,
        'items': items,
      });
    }
  }

  Future getdocuments() async {
    String url = apiUrl + 'get/proofs/';
    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      dynamic data = json.decode(res2.body);
      setState(() {
        documents = data['documents'];
      });
      getdates();
    }
  }

  void initState() {
    super.initState();
    getdocuments();
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;

      //custom widgets

      

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
              height: myHeight - 249,
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
                                    sitem['purpose'].toUpperCase() ?? '',
                                    style: TextStyle(
                                      fontSize: 18,

                                      color: mode.brightText1,
                                    ),
                                  ),
                                  Text(
                                    sitem['mtime'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
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
