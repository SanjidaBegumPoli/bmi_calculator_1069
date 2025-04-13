import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  double result = 0;
  String bmiMessage = "";
  Color backgroundColor = const Color.fromARGB(255, 0, 134, 187);
  String? errorText;

  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void calculateBmi() {
    final feetText = feetController.text;
    final inchText = inchController.text;
    final weightText = weightController.text;

    if (feetText.isEmpty || inchText.isEmpty || weightText.isEmpty) {
      setState(() {
        errorText = 'All fields are required';
      });
      return;
    }

    final double feet = double.tryParse(feetText) ?? 0;
    final double inch = double.tryParse(inchText) ?? 0;
    final double weight = double.tryParse(weightText) ?? 0;

    final double heightInMeters = ((feet * 12) + inch) * 0.0254;

    if (heightInMeters == 0 || weight == 0) {
      setState(() {
        errorText = 'Invalid values';
      });
      return;
    }

    double bmi = weight / (heightInMeters * heightInMeters);

    setState(() {
      result = bmi;
      errorText = null;

      if (bmi < 18) {
        bmiMessage = "You are underweight";
        backgroundColor = const Color.fromARGB(255, 212, 240, 0);
      } else if (bmi >= 18 && bmi <= 24) {
        bmiMessage = "You are healthy";
        backgroundColor = const Color.fromARGB(255, 0, 255, 8);
      } else {
        bmiMessage = "You are overweight/obese";
        backgroundColor = const Color.fromARGB(255, 255, 0, 25);
      }
    });
  }

  @override
  void dispose() {
    feetController.dispose();
    inchController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Card(
                elevation: 5,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: feetController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Enter Height in feet",
                          hintText: "e.g. 5",
                          errorText: errorText,
                          border: border,
                          prefixIcon: const Icon(Icons.height),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: inchController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Enter Height in inches",
                          hintText: "e.g. 6",
                          border: border,
                          prefixIcon: const Icon(Icons.height),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: weightController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Enter Weight in kg",
                          hintText: "e.g. 60",
                          border: border,
                          prefixIcon: const Icon(Icons.fitness_center),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: calculateBmi,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Calculate BMI"),
                      ),
                      const SizedBox(height: 20),
                      if (result > 0)
                        Column(
                          children: [
                            Text(
                              'Your BMI is ${result.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              bmiMessage,
                              style: TextStyle(
                                fontSize: 20,
                                color: backgroundColor == Colors.red.shade100
                                    ? Colors.red
                                    : backgroundColor == Colors.green.shade100
                                        ? Colors.green
                                        : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
