import 'package:flutter/material.dart';

class CareToolsPage extends StatefulWidget {
  @override
  _CareToolsPageState createState() => _CareToolsPageState();
}

class _CareToolsPageState extends State<CareToolsPage> {

  // Water Calculator
  final TextEditingController potSizeController = TextEditingController();
  String waterResult = "";

  void calculateWater() {
    double? size = double.tryParse(potSizeController.text);

    if (size == null) {
      setState(() {
        waterResult = "Enter valid pot size";
      });
      return;
    }

    // Dummy formula
    double waterAmount = size * 0.3;

    setState(() {
      waterResult = "Water needed: ${waterAmount.toStringAsFixed(2)} L";
    });
  }

  // Fertilizer Planner
  final TextEditingController daysController = TextEditingController();
  String fertilizerResult = "";

  void planFertilizer() {
    int? days = int.tryParse(daysController.text);

    if (days == null) {
      setState(() {
        fertilizerResult = "Enter valid number of days";
      });
      return;
    }

    setState(() {
      fertilizerResult = "Next fertilizer in $days days 🌱";
    });
  }

  // Growth Tracker
  final TextEditingController heightController = TextEditingController();
  List<double> growthData = [];

  void addGrowth() {
    double? height = double.tryParse(heightController.text);

    if (height == null) return;

    setState(() {
      growthData.add(height);
      heightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Care Tools")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🌊 WATER CALCULATOR
            Text("Water Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: potSizeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Pot size (Liters)"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: calculateWater,
              child: Text("Calculate"),
            ),
            Text(waterResult),
            Divider(height: 40),

            // 🌿 FERTILIZER PLANNER
            Text("Fertilizer Planner", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: daysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Fertilize every (days)"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: planFertilizer,
              child: Text("Plan"),
            ),
            Text(fertilizerResult),
            Divider(height: 40),

            // 📈 GROWTH TRACKER
            Text("Growth Tracker", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Plant height (cm)"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addGrowth,
              child: Text("Add Height"),
            ),
            SizedBox(height: 10),
            Text("Growth Records:"),
            ...growthData.map((e) => Text("${e.toStringAsFixed(1)} cm")).toList(),
          ],
        ),
      ),
    );
  }
}