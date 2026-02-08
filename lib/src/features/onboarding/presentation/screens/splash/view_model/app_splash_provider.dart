import 'package:flutter/material.dart';

class AppSplashProvider extends ChangeNotifier {
  final bool isTest;
  bool isReady = false;
  bool _disposed = false;

  AppSplashProvider({this.isTest = false}) {
    init();
  }

  Future<void> init() async {
    if (!isTest) {
      await Future.delayed(const Duration(seconds: 3));
    }

    if (_disposed) return;

    isReady = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
