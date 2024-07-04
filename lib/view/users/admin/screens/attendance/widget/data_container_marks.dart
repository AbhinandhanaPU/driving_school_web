import 'package:flutter/material.dart';

class DataContainerMarksWidget extends StatelessWidget {
  final MainAxisAlignment rowMainAccess;
  final bool? wantColor;
  final int index;
  final String headerTitle;
  final double? width;
  final Color? color;
  final double? height;

  const DataContainerMarksWidget({
    required this.index,
    this.color,
    this.width,
    this.height,
    this.wantColor,
    required this.headerTitle,
    super.key,
    required this.rowMainAccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      decoration: BoxDecoration(
        color: wantColor == true
            ? index % 2 == 0
                ? const Color.fromARGB(255, 246, 246, 246)
                : Colors.blue[50]
            : color,
      ),
      child: Row(
        mainAxisAlignment: rowMainAccess,
        children: [
          Text(
            headerTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.5,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
