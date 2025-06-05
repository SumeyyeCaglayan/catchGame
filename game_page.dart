import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double playerX = 0; // oyuncu ve x eksenindeki konumu
  double objectX = 0; // bu rastgele belirlenecek x konumunda
  double objectY = -1; // başlangıçta ekranın dışından gelecek
  int score = 0;
  int lives = 3;
  bool gameStarted = false;
  bool isGameOver = false;
  Random random = Random();

  void startGame() {
    gameStarted = true;
    score = 0;
    lives = 3;
    isGameOver = false;
    objectY = -1; // top yukarıdan aşağı başlar ve rastgele x konumunu alır
    objectX = (random.nextDouble() * 2 - 1);

    Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        objectY += 0.01;

        if (objectY > 1) {
          objectY = -1;
          objectX = (random.nextDouble() * 2 - 1);
          lives -= 1;
          if (lives == 0) {
            timer.cancel();
            gameStarted = false;
            isGameOver = true;
          }
        }

        if ((objectY >= 0.9) && ((objectX - playerX).abs() < 0.2)) {
          score += 1;
          objectY = -1;
          objectX = (random.nextDouble() * 2 - 1);
        }
      });
    });
  }

  void moveLeft() {
    setState(() {
      if (playerX > -1) playerX -= 0.1;
    });
  }

  void moveRight() {
    setState(() {
      if (playerX < 1) playerX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(objectX, objectY),
                    child: ClipOval(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          "assets/ball6.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(playerX, 1),
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 62, 46, 110),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (!gameStarted || isGameOver)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!gameStarted)
                            ElevatedButton(
                              onPressed: startGame,
                              child: Text("START"),
                            ),
                          if (isGameOver)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "GAME OVER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SCORE: $score",
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 35, 2, 48),
                    ),
                  ),
                  Text(
                    "LIVES: $lives",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 35, 2, 48),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: moveLeft,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 22, 129, 95),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_left,
                          color: const Color.fromARGB(255, 59, 4, 81),
                          size: 32,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: moveRight,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 22, 129, 95),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_right,
                          color: const Color.fromARGB(255, 59, 4, 81),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
