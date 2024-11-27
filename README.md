# Fake Terminal Widget

A customizable fake terminal widget for Flutter applications, designed for seamless integration and interactivity. Perfect for projects that require a terminal-like UI with the flexibility of Flutter.

---

## Features

- **Interactive Terminal**: Capture user input and display real-time responses.
- **Customizable**: Configure colors, font styles, and dimensions to fit your app's theme.
- **Scroll Support**: Smooth scrolling for terminal content.
- **Mobile-Friendly**: Fully responsive and optimized for mobile devices.

---

## Getting Started

### Installation
Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  fake_terminal: ^0.0.8
```

Run the following command to fetch the package:

```bash
flutter pub get
```

---

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:fake_terminal/fake_terminal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Fake Terminal Example')),
        body: Center(
          child: FakeTerminal(
            initialMessage: "Welcome to Fake Terminal!",
            onCommand: (command) {
              // Process user input here
              return "You entered: \$command";
            },
          ),
        ),
      ),
    );
  }
}
```

---

## API Reference

### FakeTerminal Widget
The `FakeTerminal` widget provides the terminal UI.

#### Parameters
- **initialMessage** *(String?)*: A message to display when the terminal loads.
- **onCommand** *(String Function(String)?)*: A callback to process user input and return a response.
- **backgroundColor** *(Color?)*: Sets the background color of the terminal.
- **textColor** *(Color?)*: Defines the text color for the terminal.
- **height** *(double?)*: Sets the height of the terminal.
- **width** *(double?)*: Sets the width of the terminal.

---

## Example

### Advanced Usage
```
dart
FakeTerminal(
  initialMessage: "Initializing...\nType 'help' for available commands.",
  onCommand: (command) {
    if (command == 'help') {
      return "Available commands:\n1. help - Show available commands\n2. clear - Clear the terminal";
    } else if (command == 'clear') {
      return ""; // Clear the terminal
    } else {
      return "Unknown command: \$command";
    }
  },
  backgroundColor: Colors.black,
  textColor: Colors.green,
  height: 400,
  width: 300,
);
```

---

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/yourusername/fake_terminal).

---

## License

This package is licensed under the MIT License. See the `LICENSE` file for details.

                                          