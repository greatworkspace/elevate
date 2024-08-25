import 'package:flutter/material.dart';

class LoadingLoader extends StatefulWidget {
  @override
  _LoadingLoaderState createState() => _LoadingLoaderState();
}

Widget loadingbuilder(BuildContext) {
  Widget loadText = Text('Loading');
  return loadText;
}

class _LoadingLoaderState extends State<LoadingLoader> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: loadingbuilder,
    );
  }
}
