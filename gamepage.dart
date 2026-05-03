import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // Game constants
  static const int rowCount = 10;
  static const int columnCount = 20;
  static const int totalSquares = rowCount * columnCount;

  // Game state
  List<int> snake = [45, 65, 85];
  int food = 250;
  var direction = 'down';
  bool isPlaying = false;
  Timer? timer;
  
  // Scoring and Difficulty
  int score = 0;
  int highScore = 0;
  String difficulty = 'Medium';
  Map<String, int> levels = {
    'Easy': 400,
    'Medium': 200,
    'Hard': 80,
  };

  void startGame() {
    setState(() {
      generateNewFood();
      isPlaying = true;
      snake = [45, 65, 85];
      direction = 'down';
      score = 0;
    });

    // Set speed based on selected difficulty
    int speed = levels[difficulty]!;
    
    timer = Timer.periodic(Duration(milliseconds: speed), (timer) {
      updateGame();
    });
  }

  void updateGame() {
    setState(() {
      int newHead = snake.last;

      if (direction == 'down') newHead += columnCount;
      if (direction == 'up') newHead -= columnCount;
      if (direction == 'left') newHead -= 1;
      if (direction == 'right') newHead += 1;

      // Check for collisions
      if (snake.contains(newHead) ||
          newHead < 0 ||
          newHead >= totalSquares ||
          (direction == 'left' && (newHead + 1) % columnCount == 0) ||
          (direction == 'right' && newHead % columnCount == 0)) {
        gameOver();
        return;
      }

      snake.add(newHead);

      if (newHead == food) {
        score++;
        if (score > highScore) {
          highScore = score; // Update high score
        }
        generateNewFood();
      } else {
        snake.removeAt(0);
      }
    });
  }

  void generateNewFood() {
    food = Random().nextInt(totalSquares);
    if (snake.contains(food)) {
      generateNewFood();
    }
  }

  void gameOver() {
    timer?.cancel();
    isPlaying = false;
    showDialog(
      context: context,

       barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Score: $score\nHigh Score: $highScore'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: const Text('Play Again'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Score Board
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('SCORE', style: TextStyle(color: Colors.grey)),
                    Text('$score', style: const TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                ),
                Column(
                  children: [
                    const Text('HIGH SCORE', style: TextStyle(color: Colors.grey)),
                    Text('$highScore', style: const TextStyle(color: Colors.amber, fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),

          // Difficulty Selector (Only visible when NOT playing)
          if (!isPlaying)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Easy', 'Medium', 'Hard'].map((level) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(level),
                      selected: difficulty == level,
                      onSelected: (bool selected) {
                        setState(() {
                          difficulty = level;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

          // Game Board
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) direction = 'down';
                if (direction != 'down' && details.delta.dy < 0) direction = 'up';
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) direction = 'right';
                if (direction != 'right' && details.delta.dx < 0) direction = 'left';
              },
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: totalSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                ),
                itemBuilder: (context, index) {
                  if (snake.contains(index)) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: index == snake.last ? Colors.white : Colors.white70,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  } else if (index == food) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                        ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          // Start Button
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 20),
            child: isPlaying
                ? const Text('SWIPE TO CONTROL', style: TextStyle(color: Colors.grey))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: startGame,
                    child: const Text('START GAME', style: TextStyle(color: Colors.white)),
                  ),
          ),
        ],
      ),
    );
  }
}