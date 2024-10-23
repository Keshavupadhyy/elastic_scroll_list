import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ElasticListAnimation(),
    );
  }
}

class ElasticListAnimation extends StatefulWidget {
  @override
  _ElasticListAnimationState createState() => _ElasticListAnimationState();
}

class _ElasticListAnimationState extends State<ElasticListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for the elastic effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Elastic List Animation")),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ListView.builder(
            physics:
                BouncingScrollPhysics(), // Enables the elastic bounce physics
            itemCount: 20,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTapDown: (_) {
                  _controller.forward();
                },
                onTapUp: (_) {
                  _controller.reverse();
                },
                child: Transform.scale(
                  scale: _animation.value,
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Item ${index + 1}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
