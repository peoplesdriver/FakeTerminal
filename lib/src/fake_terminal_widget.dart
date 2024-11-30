import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loading_animation.dart';

class FakeTerminal extends StatelessWidget {
  final List<ValueNotifier<String>> lines;
  final Color backgroundColor;
  final Color textColor;
  final TextEditingController inputController;
  final Function(String)? onCommand;
  final ScrollController? scrollController;
  final bool isProcessing;

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
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text(
                          line,
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'DejaVuSansMono',
                            fontSize: 14.sp, // Use ScreenUtil for font size
                            height: 1.4.h, // Adjust line height dynamically
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
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          color: backgroundColor,
          child: Row(
            children: [
              // Show TextField if not processing, else show LoadingAnimation
              if (!isProcessing)
                Expanded(
                  child: TextField(
                    controller: inputController,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'Courier',
                      fontSize: 14.sp, // Use ScreenUtil for font size
                    ),
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

