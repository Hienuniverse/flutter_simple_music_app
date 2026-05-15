import 'package:flutter/material.dart';

class AllSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Songs')),
      body: const Center(child: Text('Giao diện hiển thị tất cả bài hát', style: TextStyle(color: Colors.white))),
    );
  }
}