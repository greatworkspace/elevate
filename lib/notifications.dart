
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'models/databaseHelper.dart';

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



List<dynamic> notifications = List.empty();

bool warnText = true;
int targetD = 0;
double bottomradius = 20;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

int readI = 0;

class _NotificationsState extends State<Notifications> {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();
  final hiddenbalCon = TextEditingController();

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

  Future makeread(int id) async {
    String url = apiUrl + 'make/read/';
    dynamic token = await DatabaseHelper.instance.getToken();
    Response res2 = await post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'token': token,
        'id': id.toString(),
      },
      body: (<String, String>{}),
    ).timeout(const Duration(seconds: 10));
    if (res2.statusCode == 200) {
      regetdata(context, mode);
    }
    DatabaseHelper.instance.notiread(id);
  }

  void getnoti() async {
    List notis = await DatabaseHelper.instance.getNoti();
    setState(() {
      notifications = notis;
    });
  }

  void gethidebal() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? got = settings['hidebal'];
    if (got == 'true') {
      setState(() {
        hiddenbalCon.text = 'true';
      });
    } else {
      setState(() {
        hiddenbalCon.text = 'false';
      });
    }
  }

  void initState() {
    super.initState();
    getMode();
    getnoti();
    gethidebal();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: mode.background1,
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final myHeight = constraints.maxHeight;
          final myWidth = constraints.maxWidth;
          double iniwidth;
          if (myWidth > 400) {
            iniwidth = 400;
          } else {
            iniwidth = myWidth;
          }

          //building custom widgets
          Widget AllFeeds() {
            List<Widget> allnoty = [];
            Widget targetIc = SvgPicture.asset('assets/svg/target_ic.svg');
            Widget elevateIc = SvgPicture.asset('assets/svg/elevate_ic.svg');
            Widget flexibleIc = SvgPicture.asset('assets/svg/flexible_ic.svg');
            Widget investIc = SvgPicture.asset('assets/svg/invest_ic.svg');
            Widget loanIc = SvgPicture.asset('assets/svg/loan_ic.svg');
            double myfeedheight =
                notifications.length * 75 + (notifications.length - 1);
            if (myfeedheight > myHeight - 80) {
              myfeedheight = myHeight - 80;
              bottomradius = 0;
            }
            if (notifications.length == 0) {
              return Container(
                height: myHeight -80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                        'No New Notificatons',
                        style: TextStyle(color: mode.dimText1, fontSize: 15),
                      ),
                    
                  ],
                ),
              );
            }

            Widget savingsbtn(index) {
              return SizedBox(
                height: 30,
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xffB0FFC2),
                      foregroundColor: Color(0xff53A966)),
                  onPressed: () {
                    makeread(notifications[index]['id']);
                    int iniindex = 1;
                    if (notifications[index]['feedtype'] == 'savings') {
                      iniindex = 2;
                    } else if (notifications[index]['feedtype'] == 'target') {
                      iniindex = 3;
                    }
                    savingsI = iniindex;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  index: 1,
                                )));
                  },
                  child: Text('View'),
                ),
              );
            }

            Widget investbtn(index) {
              return SizedBox(
                height: 30,
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xffF0C6FF),
                      foregroundColor: Color(0xffC978E5)),
                  onPressed: () {
                    notifications[index]['status'] = 'true';
                    investI = 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  index: 2,
                                )));
                  },
                  child: Text('View'),
                ),
              );
            }

            Widget loanbtn(index) {
              return SizedBox(
                height: 30,
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xff9DADEC),
                      foregroundColor: Color(0xff122774)),
                  onPressed: () {
                    notifications[index]['status'] = 'true';
                    homeI = 1;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  index: 0,
                                )));
                  },
                  child: Text('View'),
                ),
              );
            }

            Widget mydivider = Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Container(
                  height: 1,
                  color: mode.kunleStroke,
                  width: myWidth - 80,
                ),
              ],
            );
            Widget mybtn = Container();
            for (var item in notifications) {
              Color textClr;
              if (item['status'] == 'true') {
                textClr = mode.dimText1;
              } else {
                textClr = mode.brightText1;
              }
              Widget myicon = Container();
              if (item['feedtype'] == 'target') {
                myicon = targetIc;
                mybtn = savingsbtn(item['id'] - 1);
              } else if (item['feedtype'] == 'savings') {
                myicon = elevateIc;
                mybtn = savingsbtn(item['id'] - 1);
              } else if (item['feedtype'] == 'flexible') {
                myicon = flexibleIc;
                mybtn = savingsbtn(item['id'] - 1);
              } else if (item['feedtype'] == 'investment') {
                mybtn = investbtn(item['id'] - 1);
                myicon = investIc;
              } else if (item['feedtype'] == 'loan') {
                myicon = loanIc;
                mybtn = loanbtn(item['id'] - 1);
              }
              if (item['id'] == notifications[notifications.length - 1]['id']) {
                mydivider = Container();
              }
              Widget container = Column(
                children: [
                  Container(
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: myicon,
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: myWidth - 85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Container(
                                        width: myWidth - 170,
                                        child: Text(
                                          item['body'],
                                          style: TextStyle(
                                              fontSize: iniwidth / 31,
                                              color: textClr,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      item['mytime'],
                                      style: TextStyle(
                                        fontSize: iniwidth / 31,
                                        color: textClr,
                                      ),
                                    ),
                                  ],
                                ),
                                mybtn
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  mydivider,
                ],
              );
              allnoty.add(container);
            }
            return Container(
              height: myfeedheight,
              child: ListView(
                children: allnoty,
              ),
            );
          }

          //scaffold body starts here
          return Container(
              decoration: BoxDecoration(
                color: mode.background3,
              ),
              child: Column(
                children: [
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
                          Container(
                            width: myWidth - 80,
                            child: Center(
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: mode.brightText1,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: myWidth,
                    decoration: BoxDecoration(
                        color: mode.background2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(bottomradius),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(bottomradius),
                        )),
                    child: AllFeeds(),
                  )
                ],
              ));
        })));
  }
}
