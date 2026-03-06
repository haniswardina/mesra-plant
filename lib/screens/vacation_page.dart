import 'package:flutter/material.dart';
import '../models/plant.dart';

class VacationPage extends StatefulWidget {
  final List<Plant> plants;

  VacationPage({required this.plants});

  @override
  _VacationPageState createState() => _VacationPageState();
}

class _VacationPageState extends State<VacationPage> {
  bool vacationMode = false;

  DateTime? startDate;
  DateTime? endDate;

  Plant? selectedPlant;

  String resultMessage = "";

  TextEditingController potSizeController = TextEditingController();

  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime initialDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void activateVacationMode() {
    if (startDate == null || endDate == null) {
      setState(() {
        resultMessage = "Please select start and end date.";
      });
      return;
    }

    if (selectedPlant == null) {
      setState(() {
        resultMessage = "Please select a plant.";
      });
      return;
    }

    double? potSize = double.tryParse(potSizeController.text);

    if (potSize == null || potSize <= 0) {
      setState(() {
        resultMessage = "Invalid pot size.";
      });
      return;
    }

    int days = endDate!.difference(startDate!).inDays;

    if (days <= 0) {
      setState(() {
        resultMessage = "End date must be after start date.";
      });
      return;
    }

    // 🧠 AI Water Multiplier Based on Plant Type
    double multiplier = 0.2;

    if (selectedPlant!.type == "Succulent") {
      multiplier = 0.1;
    } else if (selectedPlant!.type == "Tropical") {
      multiplier = 0.3;
    } else if (selectedPlant!.type == "Flowering") {
      multiplier = 0.25;
    }

    double dailyWaterNeed = potSize * multiplier;
    double totalWaterNeeded = dailyWaterNeed * days;

    double survivalChance = 100 - (days * 5);
    if (survivalChance < 30) survivalChance = 30;

    setState(() {
      vacationMode = true;
      resultMessage =
          "🌴 Vacation AI Plan\n\n"
          "Plant: ${selectedPlant!.name}\n"
          "Type: ${selectedPlant!.type}\n\n"
          "Duration: $days days\n"
          "Daily Water: ${dailyWaterNeed.toStringAsFixed(2)} L\n"
          "Total Water Needed: ${totalWaterNeeded.toStringAsFixed(2)} L\n\n"
          "Preparation Tips:\n"
          "• Water deeply before leaving\n"
          "• Move plant to shaded area\n"
          "• Reduce direct sunlight\n"
          "• Place near humidity source\n\n"
          "Estimated Survival Probability: ${survivalChance.toStringAsFixed(0)}%";
    });
  }

  void deactivateVacationMode() {
    setState(() {
      vacationMode = false;
      resultMessage = "Vacation Mode Deactivated.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vacation Mode")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Vacation Switch Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Vacation Mode",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: vacationMode,
                      onChanged: (value) {
                        if (value) {
                          activateVacationMode();
                        } else {
                          deactivateVacationMode();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Text("Select Vacation Dates",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => pickDate(context, true),
              child: Text(startDate == null
                  ? "Select Start Date"
                  : "Start: ${startDate!.toLocal().toString().split(' ')[0]}"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => pickDate(context, false),
              child: Text(endDate == null
                  ? "Select End Date"
                  : "End: ${endDate!.toLocal().toString().split(' ')[0]}"),
            ),

            SizedBox(height: 20),

            // 🌿 Plant Dropdown
            DropdownButtonFormField<Plant>(
              value: selectedPlant,
              hint: Text("Select Your Plant"),
              items: widget.plants.map((plant) {
                return DropdownMenuItem(
                  value: plant,
                  child: Text(plant.name),
                );
              }).toList(),
              onChanged: (plant) {
                setState(() {
                  selectedPlant = plant;
                  potSizeController.text =
                      plant!.potSize.toString();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Pot Size (Auto-filled)
            TextField(
              controller: potSizeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Pot Size (Liters)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Result Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  resultMessage,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}