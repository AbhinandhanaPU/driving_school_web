import 'package:flutter/material.dart';

class TextFontWidget extends StatelessWidget {
  final int? index;
  final String text;
  final double fontsize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final TextOverflow? overflow;
  final String? Function(String?)? validator;
  const TextFontWidget({
    this.validator,
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.overflow,
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      // maxLines: 1,
      style: TextStyle(
        decoration: TextDecoration.none,
        letterSpacing: letterSpacing,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color ?? Colors.black,
      ),
    );
  }
}

class TextFontWidgetRouter extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final TextOverflow? overflow;
  const TextFontWidgetRouter({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      // maxLines: 1,
      style: TextStyle(
        decoration: TextDecoration.none,
        letterSpacing: letterSpacing,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: Colors.white,
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final Icon;

  const TextFormFieldWidget({
    required this.hintText,
    this.validator,
    required this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    // ignore: non_constant_identifier_names
    super.key,required this.Icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
