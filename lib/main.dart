import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guess',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Number Guessing Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _targetNumber = 0;
  int _userGuess = 50;
  String _message = "Slide to guess a number between 0 and 100";
  bool _gameWon = false;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _targetNumber = Random().nextInt(101); // 0 to 100
      _userGuess = 50;
      _gameWon = false;
      _message = "Slide to guess a number between 0 and 100";
    });
  }

  void _checkGuess(int value) {
    setState(() {
      _userGuess = value;
      if (value == _targetNumber) {
        _message = "🎉 Congratulations! You got it!";
        _gameWon = true;
      } else if (value < _targetNumber) {
        _message = "Try higher! 👆";
      } else {
        _message = "Try lower! 👇";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _gameWon ? '🎮 You Won! 🎮' : 'Guess the Number',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              Text(
                _userGuess.toString(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              Slider(
                value: _userGuess.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                label: _userGuess.toString(),
                onChanged: (double value) {
                  _checkGuess(value.round());
                },
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _message,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              if (_gameWon) ...[
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _startNewGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Play Again'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
