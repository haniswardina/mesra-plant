import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  PlantDetailPage({required this.plant});

  String getSuggestion() {
    if (plant.moisture < 65) {
      return "Water your plant soon!";
    }
    return "Plant is healthy 🌿";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(plant.image, style: TextStyle(fontSize: 60)),
            SizedBox(height: 20),
            Text("pH Level: ${plant.ph}"),
            Text("Soil Moisture: ${plant.moisture}%"),
            SizedBox(height: 20),
            Text("AI Suggestion: ${getSuggestion()}"),
          ],
        ),
      ),
    );
  }
}