import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorExtractor {
  static Future<Color> getDominantColor(ImageProvider imageProvider) async {
    try {
      final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(imageProvider);
      return generator.dominantColor?.color ?? const Color(0xFF191414);
    } catch (e) {
      return const Color(0xFF191414);
    }
  }
}