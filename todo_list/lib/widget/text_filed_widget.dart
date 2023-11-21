import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.txtController,
  });

  final String hintText;
  final int maxLine;
  final TextEditingController txtController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey[200],
          ),
          child: TextField(
            controller: txtController,
            maxLines: maxLine,
            decoration: InputDecoration(
              // Remove the border
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 15),
              border: InputBorder.none,
              // Add padding if needed
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        ),
      ],
    );
  }
}
