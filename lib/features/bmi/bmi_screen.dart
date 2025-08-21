import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/app_card.dart';
import 'bmi_result_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height = 180.0;
  int weight = 60;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: kBMIBackgroundColor,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      backgroundColor: kBMIBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GenderCard(
                    icon: FontAwesomeIcons.mars,
                    label: 'Male',
                    isSelected: isMale,
                    onTap: () => setState(() => isMale = true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GenderCard(
                    icon: FontAwesomeIcons.venus,
                    label: 'Female',
                    isSelected: !isMale,
                    onTap: () => setState(() => isMale = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppCard(
              color: kBMICardColor,
              child: Column(
                children: [
                  const Text('Height', style: kBMILabelTextStyle),
                  const SizedBox(height: 10),
                  Text('${height.round()} cm', style: kBMINumberTextStyle),
                  Slider(
                    value: height,
                    min: kMinHeight,
                    max: kMaxHeight,
                    onChanged: (value) => setState(() => height = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ValueSelector(
                    label: 'Weight',
                    value: weight,
                    onDecrement: () => setState(() => weight--),
                    onIncrement: () => setState(() => weight++),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ValueSelector(
                    label: 'Age',
                    value: age,
                    onDecrement: () => setState(() => age--),
                    onIncrement: () => setState(() => age++),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                double heightInMeters = height / 100;
                double bmi = weight / pow(heightInMeters, 2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BmiResultScreen(
                      bmiResult: bmi,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kBMIPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Calculate BMI',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// These are supporting widgets, they can stay here or be moved to the widgets folder.
class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard(
      {Key? key,
        required this.icon,
        required this.label,
        required this.isSelected,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      color: isSelected ? kBMISelectedCardColor : kBMIUnselectedCardColor,
      child: Column(
        children: [
          Icon(icon, size: 50, color: isSelected ? kBMISelectedTextColor : kBMIUnselectedTextColor),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 18, color: isSelected ? kBMISelectedTextColor : kBMIUnselectedTextColor)),
        ],
      ),
    );
  }
}

class ValueSelector extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const ValueSelector(
      {Key? key,
        required this.label,
        required this.value,
        required this.onDecrement,
        required this.onIncrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: kBMICardColor,
      child: Column(
        children: [
          Text(label, style: kBMILabelTextStyle),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kBMIPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: const Icon(Icons.remove, color: Colors.white), onPressed: onDecrement),
                Text(value.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: onIncrement),
              ],
            ),
          ),
        ],
      ),
    );
  }
}