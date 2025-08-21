import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/app_button.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _input = "";
        _output = "0";
      } else if (buttonText == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (buttonText == "=") {
        if (_input.isEmpty) return;
        try {
          String finalExpression = _input.replaceAll('×', '*').replaceAll('÷', '/');
          Parser p = Parser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          _output = eval.toString();
          if (_output.endsWith('.0')) {
            _output = _output.substring(0, _output.length - 2);
          }
        } catch (e) {
          _output = "Error";
        }
      } else {
        _input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCalcBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_input.isEmpty ? '0' : _input, style: kCalcInputTextStyle),
                    const SizedBox(height: 10),
                    Text(_output, style: kCalcOutputTextStyle),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(children: [
                    AppButton(label: "AC", onTap: () => _buttonPressed("AC"), backgroundColor: kCalcTopRowBtnColor),
                    AppButton(label: "⌫", onTap: () => _buttonPressed("⌫"), backgroundColor: kCalcTopRowBtnColor),
                    AppButton(label: "%", onTap: () => _buttonPressed("%"), backgroundColor: kCalcTopRowBtnColor),
                    AppButton(label: "÷", onTap: () => _buttonPressed("÷"), backgroundColor: kCalcOperatorBtnColor),
                  ]),
                  Row(children: [
                    AppButton(label: "7", onTap: () => _buttonPressed("7"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "8", onTap: () => _buttonPressed("8"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "9", onTap: () => _buttonPressed("9"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "×", onTap: () => _buttonPressed("×"), backgroundColor: kCalcOperatorBtnColor),
                  ]),
                  Row(children: [
                    AppButton(label: "4", onTap: () => _buttonPressed("4"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "5", onTap: () => _buttonPressed("5"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "6", onTap: () => _buttonPressed("6"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "-", onTap: () => _buttonPressed("-"), backgroundColor: kCalcOperatorBtnColor),
                  ]),
                  Row(children: [
                    AppButton(label: "1", onTap: () => _buttonPressed("1"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "2", onTap: () => _buttonPressed("2"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "3", onTap: () => _buttonPressed("3"), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "+", onTap: () => _buttonPressed("+"), backgroundColor: kCalcOperatorBtnColor),
                  ]),
                  Row(children: [
                    Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(8.0), child: ElevatedButton(onPressed: () => _buttonPressed("0"), style: ElevatedButton.styleFrom(backgroundColor: kCalcNumberBtnColor, shape: const StadiumBorder(), padding: const EdgeInsets.symmetric(vertical: 24)), child: const Text("0", style: TextStyle(fontSize: 24, color: Colors.white))))),
                    AppButton(label: ".", onTap: () => _buttonPressed("."), backgroundColor: kCalcNumberBtnColor),
                    AppButton(label: "=", onTap: () => _buttonPressed("="), backgroundColor: kCalcOperatorBtnColor),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

