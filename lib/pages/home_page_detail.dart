import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.text,
    required this.title,
    required this.dateTime,
    required this.updateTime,
  });

  final String text;
  final String title;
  final String dateTime;
  final String updateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Comments"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title: $title",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Text: $text",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Date Time: $dateTime",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Update Time: $updateTime",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
