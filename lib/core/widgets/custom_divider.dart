import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry padding;

  const CustomDivider({
    super.key,
    required this.title,
    this.color = Colors.grey,
    this.thickness = 1.0,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: color,
              thickness: thickness,
              endIndent: 8,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Divider(
              color: color,
              thickness: thickness,
              indent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
