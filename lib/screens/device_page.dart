import 'package:flutter/material.dart';
import 'dart:math';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {

  bool isConnected = false;
  String selectedPlant = "Not Assigned";

  double phValue = 0.0;
  double moistureValue = 0.0;

  final List<String> plants = [
    "Rose",
    "Monstera",
    "Aloe Vera"
  ];

  void connectDevice() {
    setState(() {
      isConnected = true;
      generateSensorData();
    });
  }

  void disconnectDevice() {
    setState(() {
      isConnected = false;
      phValue = 0.0;
      moistureValue = 0.0;
    });
  }

  void generateSensorData() {
    final random = Random();

    phValue = 5.5 + random.nextDouble() * 2; // 5.5 - 7.5
    moistureValue = 40 + random.nextDouble() * 40; // 40% - 80%
  }

  void refreshData() {
    if (isConnected) {
      setState(() {
        generateSensorData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IoT Device")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // DEVICE CARD
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ESP32 Sensor",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          isConnected ? Icons.check_circle : Icons.cancel,
                          color: isConnected ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed:
                          isConnected ? disconnectDevice : connectDevice,
                      child: Text(
                          isConnected ? "Disconnect" : "Connect Device"),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // ASSIGN PLANT
            Text("Assign to Plant",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),

            DropdownButton<String>(
              value: selectedPlant == "Not Assigned"
                  ? null
                  : selectedPlant,
              hint: Text("Select Plant"),
              isExpanded: true,
              items: plants
                  .map((plant) => DropdownMenuItem(
                        value: plant,
                        child: Text(plant),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPlant = value!;
                });
              },
            ),

            SizedBox(height: 30),

            // SENSOR DATA
            Text("Live Sensor Data",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("pH Level: ${phValue.toStringAsFixed(2)}"),
                    SizedBox(height: 8),
                    Text("Soil Moisture: ${moistureValue.toStringAsFixed(1)}%"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: refreshData,
              child: Text("Refresh Data"),
            ),
          ],
        ),
      ),
    );
  }
}