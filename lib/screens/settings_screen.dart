import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.equalizer, color: Colors.white),
            title: Text('Equalizer', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.timer, color: Colors.white),
            title: Text('Sleep Timer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}