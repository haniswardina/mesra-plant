import 'package:flutter/material.dart';
import '../models/plant.dart';
import 'plant_detail_page.dart';
import 'vacation_page.dart';

class MyPlantsPage extends StatefulWidget {
  final List<Plant> plants;

  MyPlantsPage({required this.plants});

  @override
  _MyPlantsPageState createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {

  List<Plant> get plants => widget.plants;

  void addPlant() {
    TextEditingController nameController = TextEditingController();
    TextEditingController potController = TextEditingController();
    String selectedType = "Tropical";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Plant"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Plant Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: potController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Pot Size (Liters)"),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: ["Succulent", "Tropical", "Flowering"]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedType = value!;
                },
                decoration: InputDecoration(labelText: "Plant Type"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              double? potSize = double.tryParse(potController.text);

              if (nameController.text.isNotEmpty && potSize != null) {
                setState(() {
                  plants.add(
                    Plant(
                      name: nameController.text,
                      image: "🌱",
                      ph: 6.5,
                      moisture: 65.0,
                      potSize: potSize,
                      type: selectedType,
                    ),
                  );
                });
              }
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void deletePlant(int index) {
    setState(() {
      plants.removeAt(index);
    });
  }

  void scanDisease(Plant plant) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Disease Scan Result"),
        content: Text(
          "Scanning ${plant.name}...\n\n"
          "Dummy AI Result:\n"
          "No major disease detected 🌿\n"
          "Leaf health: Good\n"
          "Suggestion: Continue regular watering.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          )
        ],
      ),
    );
  }

  void goToVacationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VacationPage(plants: plants),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Plants"),
        actions: [
          IconButton(
            icon: Icon(Icons.beach_access),
            onPressed: goToVacationPage,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPlant,
        child: Icon(Icons.add),
      ),
      body: plants.isEmpty
          ? Center(child: Text("No plants added yet 🌱"))
          : ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Text(
                      plant.image,
                      style: TextStyle(fontSize: 28),
                    ),
                    title: Text(plant.name),
                    subtitle: Text(
                      "Type: ${plant.type}\n"
                      "Pot: ${plant.potSize}L | pH: ${plant.ph} | Moisture: ${plant.moisture.toStringAsFixed(1)}%",
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlantDetailPage(plant: plant),
                        ),
                      );
                    },
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "delete") {
                          deletePlant(index);
                        } else if (value == "scan") {
                          scanDisease(plant);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "scan",
                          child: Text("Scan Disease"),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}