import 'package:elevate/home.dart';
import 'package:flutter/material.dart';
import 'models/databaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
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
bool loaded = false;

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

String accountNo = '012345678';

// ignore: must_be_immutable
class BankDetails2 extends StatefulWidget {
  BankDetails2({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;
  @override
  _BankDetails2State createState() => _BankDetails2State();
}

dynamic mode = mode;

class _BankDetails2State extends State<BankDetails2>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  Widget loader2 = Container();
  Widget loading = Container();
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final nameCon = TextEditingController();
  final bankCon = TextEditingController();
  final numCon = TextEditingController();

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

  Future changebank() async {
    loader2 = loading;
    String url = apiUrl + 'change/bank/';
    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
        'name': nameCon.text,
        'number': numCon.text,
        'bank': bankCon.text,
      },
      body: (<String, String>{}),
    );
    if (res2.statusCode == 200) {
      dynamic data = json.decode(res2.body);

      if (data == 'success') {
        await regetdata();
        loader2 = Container();
        setState(() {
          accountI = 3;
        });
      }
      loader2 = Container();
    } else {
      loader2 = Container();
      print('error');
    }
  }

  void initState() {
    loaded = false;
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;

          //custom widgets

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
            height: myHeight - 151,
            width: myWidth,
            color: mode.background1,
            child: Center(
              child: CustomLoader,
            ),
          );


          Widget greycontinue = TextButton(
            onPressed: null,
            child: const Text(
              'Submit',
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
              changebank();
            },
            child: const Text(
              'Submit',
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

          Widget continuebtn() {
            if (nameCon.text == '' ||
                numCon.text.length < 10 ||
                bankCon.text == '') {
              return greycontinue;
            } else {
              return realcontinue;
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
                Container(
                  width: myWidth,
                  color: mode.background2,
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: getbank(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              Map bank = snapshot.data['bank'];
                              if (loaded == false) {
                                nameCon.text = bank['name'] ?? '';
                                numCon.text = bank['account_number'] ?? '';
                                bankCon.text = bank['bank_name'] ?? '';
                                loaded = true;
                              }
                              return Stack(
                                children: [
                                  Container(
                                    width: myWidth,
                                    decoration: BoxDecoration(
                                      color: mode.background2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 20),
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
                                          SizedBox(
                                            width: myWidth - 20,
                                            child: TextField(
                                              controller: nameCon,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 22, 10, 22),
                                                alignLabelWithHint: false,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.8,
                                                            color: mode
                                                                .brightText1)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mode
                                                                .fieldBorder)),
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
                                          SizedBox(
                                            width: myWidth - 20,
                                            child: TextField(
                                              controller: numCon,
                                              maxLength: 10,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                              decoration: InputDecoration(
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 22, 10, 21),
                                                alignLabelWithHint: false,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.8,
                                                            color: mode
                                                                .brightText1)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mode
                                                                .fieldBorder)),
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
                                          SizedBox(
                                            width: myWidth - 20,
                                            child: TextField(
                                              controller: bankCon,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: mode.brightText1,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 22, 10, 22),
                                                alignLabelWithHint: false,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.8,
                                                            color: mode
                                                                .brightText1)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mode
                                                                .fieldBorder)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: myWidth - 20,
                                            child: Column(children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
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
                                  loader2,
                                ],
                              );
                            } else {
                              return loading;
                            }
                          })
                    ],
                  ),
                )
              ]));
        })));
  }
}
