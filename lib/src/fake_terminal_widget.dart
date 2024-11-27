library fake_terminal_widget;

import 'package:flutter/material.dart';

class FakeTerminal extends StatelessWidget {
  final List<String> lines; // Lines of text displayed in the terminal
  final Color backgroundColor; // Terminal background color
  final Color textColor; // Text color
  final TextEditingController inputController; // Controller for user input
  final Function(String)? onCommand; // Callback for commands entered by the user

  const FakeTerminal({
    Key? key,
    required this.lines,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.green,
    required this.inputController,
    this.onCommand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: backgroundColor,
            child: ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Text(
                  lines[index],
                  style: TextStyle(color: textColor, fontFamily: 'Courier'),
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          color: backgroundColor,
          child: Row(
            children: [
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
