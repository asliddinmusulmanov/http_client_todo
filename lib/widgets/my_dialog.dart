import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final TextEditingController titleControllers;
  final TextEditingController textControllers;
  final void Function()? onPressed;

  const MyDialog({
    super.key,
    required this.titleControllers,
    required this.textControllers,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          TextField(
            controller: titleControllers,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          TextField(
            controller: textControllers,
            decoration: const InputDecoration(
              labelText: "Text",
            ),
          ),
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
