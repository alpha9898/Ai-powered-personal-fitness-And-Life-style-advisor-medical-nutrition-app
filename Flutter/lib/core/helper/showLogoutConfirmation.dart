import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Services/Fire_Base_Auth_Service.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

void showLogoutConfirmation(BuildContext context) {
  final FireBaseAuthService fireBaseAuthService = FireBaseAuthService();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)), // نفس التقوس اللي في الصورة
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.30,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: KPrimaryColor, // اللون البنفسجي اللي في الصورة
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: KPrimaryColor, // لون النص الأزرق
                    backgroundColor: Colors.white, // الخلفية بيضاء
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 13),
                  ),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    fireBaseAuthService.signOut();
                    GoRouter.of(context).pushReplacement('/Login_view');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: KPacScoundColor, // لون الخلفية الأصفر
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 13),
                  ),
                  child: const Text("Yes, logout"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
