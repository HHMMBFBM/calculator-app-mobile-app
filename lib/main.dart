import 'package:flutter/material.dart';

void main() {
  runApp(const AdvancedCalculatorApp());
}

class AdvancedCalculatorApp extends StatelessWidget {
  const AdvancedCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  String historyText = '';
  double firstOperand = 0;
  double secondOperand = 0;
  String operator = '';
  bool shouldResetDisplay = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '0';
        historyText = '';
        firstOperand = 0;
        secondOperand = 0;
        operator = '';
      } else if (value == '⌫') {
        displayText = displayText.length > 1 ? displayText.substring(0, displayText.length - 1) : '0';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        firstOperand = double.parse(displayText);
        operator = value;
        historyText = '$displayText $value';
        shouldResetDisplay = true;
      } else if (value == '=') {
        secondOperand = double.parse(displayText);
        double result = 0;
        switch (operator) {
          case '+':
            result = firstOperand + secondOperand;
            break;
          case '-':
            result = firstOperand - secondOperand;
            break;
          case '*':
            result = firstOperand * secondOperand;
            break;
          case '/':
            result = firstOperand / secondOperand;
            break;
        }
        historyText = '$historyText $displayText = $result';
        displayText = result.toString();
        shouldResetDisplay = true;
      } else {
        if (shouldResetDisplay) {
          displayText = value;
          shouldResetDisplay = false;
        } else {
          displayText = displayText == '0' ? value : displayText + value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              historyText,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              displayText,
              style: const TextStyle(
                fontSize: 48,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('/'),
                _buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('*'),
                _buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-'),
                _buildButton('0'), _buildButton('.'), _buildButton('='), _buildButton('+'),
                _buildButton('C'), _buildButton('⌫'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          backgroundColor: text == 'C' || text == '⌫' ? const Color.fromARGB(255, 255, 20, 3) : Color.fromARGB(255, 97, 12, 12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
