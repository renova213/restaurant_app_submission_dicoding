import 'package:flutter/material.dart';

class AppSplashProvider extends ChangeNotifier {
  bool _isReady = false;
  bool get isReady => _isReady;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    _isReady = true;
    notifyListeners();
  }
}
