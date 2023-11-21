import 'package:elevate/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'models/databaseHelper.dart';


dynamic mode = mode;



class OverlayL extends StatefulWidget {
  const OverlayL({super.key});

  @override
  State<OverlayL> createState() => _OverlayLState();
}

class _OverlayLState extends State<OverlayL> with TickerProviderStateMixin {

  void getMode() async {
    Map settings = await DatabaseHelper.instance.getSettings();
    String? mymode = settings['mode'];
    if (mymode == null) {
      setState(() {
        mode = lightmode;
      });
    } else if (mymode == 'Dark') {
      setState(() {
        mode = darkmode;
      });
    } else {
      setState(() {
        mode = lightmode;
      });
    }
  }



  void initState() {
    super.initState();
    getMode();
    initializeDateFormatting();
  }
  @override




  Widget build(BuildContext context) {
    late final AnimationController _controller = AnimationController(
  duration: const Duration(seconds: 5),
  vsync: this,
)..repeat(reverse: false);

late final Animation<double> _animation = CurvedAnimation(
  parent: _controller,
  curve: Curves.linear,
);




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
    Widget loading(Color mycolor) {
      return Builder(builder: (context) {
        double myHeight = MediaQuery.of(context).size.height;
        double myWidth = MediaQuery.of(context).size.width;
        return Container(
          height: myHeight,
          width: myWidth,
          color: mycolor,
          child: Center(
            child: CustomLoader,
          ),
        );
      });
    }

    return loading(mode.background1);
  }
}
