import 'package:flutter/material.dart';

void Error_bar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));
}
