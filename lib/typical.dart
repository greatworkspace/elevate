
import 'package:flutter/material.dart';

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

    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      //scaffold body starts here
      return Container();
    })));
  }
}
