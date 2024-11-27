import 'package:flutter/material.dart';

class FakeTerminal extends StatelessWidget {
  final List<ValueNotifier<String>> lines;
  final Color backgroundColor;
  final Color textColor;
  final TextEditingController inputController;
  final Function(String)? onCommand;
  final ScrollController? scrollController;

  const FakeTerminal({
    Key? key,
    required this.lines,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.green,
    required this.inputController,
    this.onCommand,
    this.scrollController,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
