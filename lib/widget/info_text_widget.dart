import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  final String description;
  final String value;
  const InfoTextWidget(
    this.description,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          description,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }
}
