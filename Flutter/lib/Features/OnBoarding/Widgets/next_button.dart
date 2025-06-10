import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.black45),
        color: Colors.white10.withOpacity(0.75).withAlpha(70), // لون الخلفية
        borderRadius: BorderRadius.circular(30), // الحواف المستديرة
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4), // لون الظل
            offset: const Offset(0, 5), // اتجاه الظل
            blurRadius: 30, // ضبابية الظل
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Get Started',
          style: TextStyle(
            color: Colors.white, // لون النص
            fontSize: 18, // حجم الخط
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            // سمك الخط
          ),
        ),
      ),
    );
  }
}
