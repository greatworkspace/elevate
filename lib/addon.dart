import 'package:elevate/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'models/databaseHelper.dart';
import 'models/user.dart';
import 'package:http/http.dart';


dynamic shakey = KeyClass.shakeKey1;




// ignore: must_be_immutable
class AddonScreen extends StatefulWidget {
  AddonScreen({
    required this.amode,
    required this.index,
  });

  final dynamic amode;
  int index;

  @override
  _AddonScreenState createState() => _AddonScreenState();
}

dynamic mode = mode;

class _AddonScreenState extends State<AddonScreen>
    with SingleTickerProviderStateMixin {
  dynamic mode = lightmode;
  final languageCon = TextEditingController();
  final geoCon = TextEditingController();
  final autodedCon = TextEditingController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  Future getded() async {
    User use = await DatabaseHelper.instance.getUser();
    String ded = use.deduction;
    return ded;
  }

  void makeded(bool ded) async {
    String val = '';
    if (ded == true) {
      val = 'true';
    } else {
      val = 'false';
    }
    await DatabaseHelper.instance.makeded(val);
    String url = apiUrl + 'make/ded/';
      dynamic token = await DatabaseHelper.instance.getToken();
      await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'token': token,
          'ded': val,
        },
        body: (<String, String>{}),
      );
  }

  void initState() {
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
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myWidth = constraints.maxWidth;
      final myHeight = constraints.maxHeight;
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
                      'Add-Ons',
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
            //other items in security after header

            FutureBuilder(
                future: getded(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    String ded = snapshot.data;

                    bool inivalue2;
                    Widget autodedSwitch() {
                      if (ded == 'true') {
                        inivalue2 = true;
                      } else {
                        inivalue2 = false;
                      }

                      if (mode.name == 'Light') {
                        return Transform.scale(
                          scale: 0.9,
                          child: CupertinoSwitch(
                            value: inivalue2,
                            onChanged: (value) async {
                              makeded(value);
                            },
                            activeColor: const Color(0xff46A623),
                            trackColor: const Color(0xffD9D9D9),
                            thumbColor: mode.thumbColor,
                          ),
                        );
                      } else {
                        return Transform.scale(
                          scale: 0.9,
                          child: CupertinoSwitch(
                              value: inivalue2,
                              onChanged: (value) async {
                               makeded(value);
                              },
                              activeColor: const Color(0xff46A623),
                              trackColor: const Color(0xffD9D9D9),
                              thumbColor: Colors.white),
                        );
                      }
                    }

                    return Column(children: [
                      //support
            //          Container(
              //          decoration: BoxDecoration(
                //          color: mode.background1,
                  //      ),
                  //      height: 70,
                //        child: SizedBox(
         //                 child: TextButton(
           //                 onPressed: () {
             //                 Navigator.of(context).pushNamed('Support');
               //             },
                 //           child: Padding(
                   //             padding:
                     //               const EdgeInsets.fromLTRB(10, 0, 10, 0),
                       //         child: Row(children: [
                         //         SvgPicture.asset('assets/svg/livechat.svg'),
                           //       const SizedBox(
                            //        width: 30,
                          //        ),
                        //          SizedBox(
                      //              width: myWidth - 90,
                            //        child: Row(
                           //           mainAxisAlignment:
                         //                 MainAxisAlignment.spaceBetween,
                       //               children: [
                     //                   Text(
                   //                       'Support Ticket',
                 //                         style: TextStyle(
               //                               color: mode.brightText1,
             //                                 fontSize: 15),
           //                             ),
                                   //     Icon(
                                 //         Icons.arrow_forward_ios,
                               //           color: mode.brightText1,
                             //             size: 18,
                           //             ),
                         //             ],
                       //             ),
                     //             ),
                   //             ])),
                 //         ),
               //         ),
             //         ),

  //                    //credit score
   //                   Container(
    //                    decoration: BoxDecoration(
     //                     color: mode.background1,
      //                  ),
       //                 height: 70,
        //                child: SizedBox(
         //                 child: TextButton(
          //                  onPressed: () {
           //                   setState(() {
            //                    accountI = 9;
             //                 });
              //              },
     //                       child: Padding(
      //                          padding:
       //                             const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                        child: Row(children: [
         //                         SvgPicture.asset(
          //                            'assets/svg/creditscore.svg'),
           //                       const SizedBox(
           //                         width: 30,
      //                            ),
       //                           SizedBox(
        //                            width: myWidth - 90,
         //                           child: Row(
          //                            mainAxisAlignment:
           //                               MainAxisAlignment.spaceBetween,
           //                           children: [
            //                            Text(
             //                             'Credit Score',
              //                            style: TextStyle(
               //                               color: mode.brightText1,
                //                              fontSize: 15),
           //                             ),
            //                            Icon(
             //                             Icons.arrow_forward_ios,
              //                            color: mode.brightText1,
               //                           size: 18,
               //                         ),
        //                              ],
         //                           ),
          //                        ),
        //                        ])),
       //                   ),
        //                ),
         //             ),

                      //auto deduction
                      Container(
                        decoration: BoxDecoration(
                          color: mode.background1,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        height: 70,
                        child: SizedBox(
                          child: TextButton(
                            onPressed: null,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(children: [
                                  SvgPicture.asset('assets/svg/autoded.svg'),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: myWidth - 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Auto Deduction',
                                          style: TextStyle(
                                              color: mode.brightText1,
                                              fontSize: 15),
                                        ),
                                        autodedSwitch()
                                      ],
                                    ),
                                  ),
                                ])),
                          ),
                        ),
                      ),
                    ]);
                  } else {
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
                      height: myHeight - 65,
                      width: myWidth,
                      color: mode.background1,
                      child: Center(
                        child: CustomLoader,
                      ),
                    );
                    return loading;
                  }
                })
          ]));
    })));
  }
}
