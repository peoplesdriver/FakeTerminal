// lib/widgets/fake_terminal.dart

import 'package:flutter/material.dart';

class FakeTerminal extends StatelessWidget {
  final List<ValueNotifier<String>> lines;
  final Color backgroundColor;
  final Color textColor;
  final TextEditingController inputController;
  final Function(String)? onCommand;
  final ScrollController? scrollController;
  final bool isProcessing; // New parameter

  const FakeTerminal({
    Key? key,
    required this.lines,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.green,
    required this.inputController,
    this.onCommand,
    this.scrollController,
    this.isProcessing = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terminal Output Area
        Expanded(
          child: Container(
            color: backgroundColor,
            child: ListView.builder(
              controller: scrollController,
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<String>(
                  valueListenable: lines[index],
                  builder: (context, line, child) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          line,
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Courier',
                            fontSize: 14.0,
                            height: 1.4, // Adjust line height
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        // Input Area
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: backgroundColor,
          child: Row(
            children: [
              // Show TextField if not processing, else show LoadingAnimation
              if (!isProcessing)
                Expanded(
                  child: TextField(
                    controller: inputController,
                    style: TextStyle(color: textColor, fontFamily: 'Courier'),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a command...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: (value) {
                      if (onCommand != null && value.trim().isNotEmpty) {
                        onCommand!(value.trim());
                        inputController.clear();
                      }
                    },
                  ),
                )
              else
                const LoadingAnimation(), // Show loading animation when processing
            ],
          ),
        ),
      ],
    );
  }
}

// LoadingAnimation Widget
class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    // Define staggered animations for each dot
    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.7, curve: Curves.easeIn)),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.9, curve: Curves.easeIn)),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  // Helper method to build each animated dot
  Widget _buildDot(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          '.',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 24.0,
            fontFamily: 'Courier',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(_animation1),
        _buildDot(_animation2),
        _buildDot(_animation3),
      ],
    );
  }
}
