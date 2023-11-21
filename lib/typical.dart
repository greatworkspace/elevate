import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'models/color.dart';
import 'overlay.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'models/databaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

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



class MAccountScreen extends StatefulWidget {
  MAccountScreen({
    required this.amode,
  });

  final dynamic amode;

  @override
  _MAccountScreenState createState() => _MAccountScreenState();
}

dynamic mode = mode;

class _MAccountScreenState extends State<MAccountScreen> {
  dynamic mode;
  final languageCon = TextEditingController();
  final modeCon = TextEditingController();

  
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    dynamic mode = widget.amode;

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final myHeight = constraints.maxHeight;
      final myWidth = constraints.maxWidth;
      //scaffold body starts here
      return Container();
    })));
  }
}
