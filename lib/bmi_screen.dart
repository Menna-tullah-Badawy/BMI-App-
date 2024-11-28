import 'dart:math';

import 'package:flutter/material.dart';

import 'bmi_result_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale = true;
  double height = 290.0;
  int age = 20;
  int weight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0F1E),
      appBar: AppBar(
        backgroundColor: Color(0xff0A0F1E),
        title: Center(
          child: Text(
            "BMI Calculator",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: GenderContainer(
                      color: isMale ? Colors.blue : Color(0xff101323),
                      icon: Icons.male,
                      label: "MALE",
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: GenderContainer(
                      color: isMale ? Color(0xff101323) : Colors.pink,
                      icon: Icons.female,
                      label: "FEMALE",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: HeightContainer(
              height: height,
              onHeightChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InfoContainer(
                    label: "AGE",
                    value: age,
                    onDecrease: () {
                      setState(() {
                        age--;
                      });
                    },
                    onIncrease: () {
                      setState(() {
                        age++;
                      });
                    },
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: InfoContainer(
                    label: "WEIGHT",
                    value: weight,
                    onDecrease: () {
                      setState(() {
                        weight--;
                      });
                    },
                    onIncrease: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xff101323),
                ),
                height:50,
                width: double.infinity,
                child: MaterialButton(
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  onPressed: () {
                    double result = weight / pow(height / 100, 2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BMIResultScreen(
                          age: age,
                          weight: weight,
                          isMale: isMale,
                          result: result.round(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderContainer extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  GenderContainer({required this.color, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      height: 100,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.white),
          Text(
            label,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class HeightContainer extends StatelessWidget {
  final double height;
  final ValueChanged<double> onHeightChanged;

  HeightContainer({required this.height, required this.onHeightChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff101323),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('HEIGHT', style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${height.round()}',
                    style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text('cm', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Slider(
          min: 220,
          max: 300,
          value: height,
          onChanged: onHeightChanged,
        ),
      ],
    );

  }
}

class InfoContainer extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  InfoContainer({
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xff101323),
      ),
      height: 300,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 20, color: Colors.white)),
          Text(
            "$value",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onDecrease,
                icon: Icon(Icons.remove, color: Colors.grey),
              ),
              IconButton(
                onPressed: onIncrease,
                icon: Icon(Icons.add, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
