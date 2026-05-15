import 'package:flutter/material.dart';
import 'dart:io';

class AlbumArt extends StatelessWidget {
  final String? imagePath;
  final double size;
  final double borderRadius;

  const AlbumArt({Key? key, this.imagePath, this.size = 50, this.borderRadius = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: imagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.file(File(imagePath!), fit: BoxFit.cover),
            )
          : Icon(Icons.music_note, color: Colors.grey, size: size * 0.5),
    );
  }
}