import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class TextFaild extends StatelessWidget {
  TextFaild({
    super.key,
    required this.obscureText,
    this.text,
    required this.onSaved,
    this.icon,
  });
  bool obscureText;
  String? text;
  final void Function(String?)? onSaved;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return ' this field is required';
        }
        return null;
      },
      onSaved: onSaved,
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText,
      decoration: InputDecoration(
        focusColor: Colors.black,
        filled: true,
        suffixIcon: icon,
        fillColor: Colors.white, // لون الخلفية (مشابه للصورة)
        hintText: text, // النص التوضيحي
        hintStyle: const TextStyle(
          color: Colors.black, // لون النص التوضيحي
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ), // مساحة داخلية للنص
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // الحواف المستديرة
          borderSide: const BorderSide(
            color: Colors.transparent, // بدون حدود
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: KDarkerPrimaryColor, // حدود أثناء التركيز
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
