import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

class Loader {
  static final Loader appLoader = Loader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderTextNotifier = ValueNotifier('error message');

  void showLoader() {
    loaderShowingNotifier.value = true;
  }

  void hideLoader() {
    loaderShowingNotifier.value = false;
  }

  void setText({String? errorMessage}) {
    loaderTextNotifier.value = 'input string';
  }

  void setImage() {
    // same as that of setText //
  }
}

class OverlayView extends StatelessWidget {
  const OverlayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                BoxDecoration(color: Color.fromRGBO(100, 100, 100, 450)),
            child: Center(
              child: Container(
                width: 50,
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color.fromRGBO(100, 100, 100, 100),
                  rightDotColor: const Color.fromRGBO(500, 5, 5, 40),
                  size: 70,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class FullOverlayView extends StatelessWidget {
  const FullOverlayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Color(0x212121)),
            child: Center(
              child: Container(
                width: 50,
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: Colors.red,
                  rightDotColor: Colors.blue,
                  size: 70,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
