import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {

  String response = "";

  void askAI(String question) {
    setState(() {
      response = "For now, this is a dummy AI response for: $question";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Plant AI")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: controller),
            ElevatedButton(
              onPressed: () => askAI(controller.text),
              child: Text("Ask"),
            ),
            SizedBox(height: 20),
            Text(response),
          ],
        ),
      ),
    );
  }
}