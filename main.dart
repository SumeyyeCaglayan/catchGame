import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'game_page.dart';

void main() {
  runApp(CatchGame());
}

class CatchGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
