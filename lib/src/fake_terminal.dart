library fake_terminal;

export 'fake_terminal_widget.dart';

import 'package:flutter/material.dart';

class FakeTerminal extends StatefulWidget {
  final Color terminalBackgroundColor;
  final Color terminalTextColor;
  final double terminalHeight;
  final double terminalWidth;

  const FakeTerminal({
    super.key,
    this.terminalBackgroundColor = Colors.black,
    this.terminalTextColor = Colors.greenAccent,
    this.terminalHeight = 400,
    this.terminalWidth = 300,
  });

  @override
  State<FakeTerminal> createState() => _FakeTerminalState();
}

class _FakeTerminalState extends State<FakeTerminal> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _output = [];

  void _handleInput(String input) {
    if (input.isNotEmpty) {
      setState(() {
        _output.add("> $input"); // Echo user input
        _output.add(_processCommand(input)); // Process the command
        _controller.clear(); // Clear the input field
      });
      _scrollToBottom(); // Scroll to the latest output
    }
  }

  String _processCommand(String command) {
    // Simulate processing a command
    if (command.trim().toLowerCase() == "help") {
      return "Available commands:\n- help: Show available commands\n- clear: Clear the terminal";
    } else if (command.trim().toLowerCase() == "clear") {
      setState(() {
        _output.clear();
      });
      return "";
    } else {
      return "Unknown command: $command\nType 'help' for a list of available commands.";
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.terminalWidth,
      height: widget.terminalHeight,
      decoration: BoxDecoration(
        color: widget.terminalBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Terminal Output Area
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _output.map((line) {
                    return Text(
                      line,
                      style: TextStyle(
                        color: widget.terminalTextColor,
                        fontFamily: 'Courier',
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Input Field
          Container(
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: widget.terminalTextColor,
                      fontFamily: 'Courier',
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter command...",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: _handleInput,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: widget.terminalTextColor),
                  onPressed: () => _handleInput(_controller.text.trim()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

