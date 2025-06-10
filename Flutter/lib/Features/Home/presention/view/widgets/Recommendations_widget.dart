import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Recommendations_widget extends StatelessWidget {
  const Recommendations_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/Recomendation_view');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recommendations',
            style: TextStyle(
              color: Color(0xffE2F163),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const Text(
                'See all',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Transform.scale(
                scale: 1.3,
                child: const Icon(Icons.arrow_right, color: Color(0xffE2F163)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
