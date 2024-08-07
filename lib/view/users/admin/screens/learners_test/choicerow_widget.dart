import 'package:flutter/material.dart';

class ChoiceRowWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final Color? iconColor;

  const ChoiceRowWidget({
    required this.label,
    required this.hintText,
    this.validator,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: const Color.fromARGB(255, 29, 121, 196),
            ),
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          Container(
            height: 20,
            width: 500,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                  letterSpacing: letterSpacing,
                ),
              ),
              validator: validator,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Icon(
              Icons.close,
              size: 18,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
