import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _outputHistory = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _outputHistory = '';
        return;
      } else if (buttonText == '=') {
        _outputHistory = _output;
        _output = _evaluateOutput();
        return;
      }

      _output = _output == '0' ? buttonText : _output + buttonText;
    });
  }

  String _evaluateOutput() {
    // You can implement your own evaluation logic here, or use packages like math_expressions to evaluate expressions
    try {
      return Parser().parse(_output.replaceAll('x', '*')).evaluate(EvaluationType.REAL, ContextModel()).toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.0),
              color: Colors.white,
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _outputHistory,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('x'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () => _onButtonPressed(buttonText),
        child: Container(
          height: 100.0,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}