import 'package:flutter/material.dart';

class ShopsPage extends StatelessWidget {

  final List<Map<String, String>> shops = [
    {
      "name": "GreenLeaf Nursery",
      "address": "Jalan Tun Razak, Kuala Lumpur",
      "phone": "012-3456789"
    },
    {
      "name": "Urban Plant House",
      "address": "Petaling Jaya, Selangor",
      "phone": "017-9876543"
    },
    {
      "name": "Borneo Garden Supplies",
      "address": "Kuching, Sarawak",
      "phone": "013-2233445"
    },
  ];

  void showShopDetails(BuildContext context, Map<String, String> shop) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(shop["name"]!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍 Address: ${shop["address"]}"),
            SizedBox(height: 10),
            Text("📞 Phone: ${shop["phone"]}"),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shops Near Me")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // Fake Map UI
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "🗺️ Map Preview (Dummy)",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(Icons.store, color: Colors.green),
                      title: Text(shop["name"]!),
                      subtitle: Text(shop["address"]!),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => showShopDetails(context, shop),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}