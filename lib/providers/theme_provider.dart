import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _dominantColor = const Color(0xFF191414);
  Color get dominantColor => _dominantColor;

  void updateThemeColor(String? imagePath) {
    notifyListeners();
  }
}