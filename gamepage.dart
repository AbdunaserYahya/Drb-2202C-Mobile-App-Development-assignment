import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  static const int rowCount = 20;
  static const int columnCount = 20;
  static const int totalSquares = rowCount * columnCount;

  // Game state
  List<int> snake = [45, 65, 85]; // Initial positions
  int food = 250;
  var direction = 'down';
  bool isPlaying = false;
  Timer? timer;
  int score = 0;

  void startGame() {
    setState(() {
      isPlaying = true;
      snake = [45, 65, 85];
      direction = 'down';
      score = 0;
    });
    
    // The timer acts as the game loop
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateGame();
    });
  }

  void updateGame() {
    setState(() {
      // 1. Move the head forward
      int newHead = snake.last;
      
      if (direction == 'down') newHead += columnCount;
      if (direction == 'up') newHead -= columnCount;
      if (direction == 'left') newHead -= 1;
      if (direction == 'right') newHead += 1;

      // 2. Check for collisions (Walls or Self)
      if (snake.contains(newHead) || 
          newHead < 0 || 
          newHead >= totalSquares ||
          (direction == 'left' && (newHead + 1) % columnCount == 0) ||
          (direction == 'right' && newHead % columnCount == 0)) {
        gameOver();
        return;
      }

      snake.add(newHead);

      // 3. Check if food is eaten
      if (newHead == food) {
        score++;
        generateNewFood();
      } else {
        // Remove the tail
        snake.removeAt(0);
      }
    });
  }

  void generateNewFood() {
    food = Random().nextInt(totalSquares);
    // Ensure food doesn't spawn on the snake's body
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
        content: Text('Your score: $score'),
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
          // Score Display
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              'Score: $score',
              style: const TextStyle(color: Colors.white, fontSize: 30),
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
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (index == food) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(color: Colors.green),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(color: Colors.grey[900]),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          // Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: isPlaying
                ? const SizedBox() // Hide button while playing
                : ElevatedButton(
                    onPressed: startGame,
                    child: const Text('START GAME'),
                  ),
          ),
        ],
      ),
    );
  }
}