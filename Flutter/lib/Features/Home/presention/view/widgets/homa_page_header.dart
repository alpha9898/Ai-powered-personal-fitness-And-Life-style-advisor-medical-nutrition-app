import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';
import 'package:graduation_project_ui/core/helper/getBodyCondition.dart';
import 'package:graduation_project_ui/core/helper/getDailyRandomIndexes.dart';

class HomaPageHeader extends StatelessWidget {
  const HomaPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hi, ${GetUser().name}',
              style: const TextStyle(
                color: Color(0XFF896CFE),
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    // String? bodyCondition =
                    //     await getBodyCondition(getCurrentUserId());
                    //  log(bodyCondition.toString());
                    log(GetUser().bodyCondition.toString());
                  },
                  icon: const Icon(Icons.notifications,
                      color: KDarkerPrimaryColor),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push('/User_profile');
                    },
                    icon: const Icon(Icons.person_3, color: Color(0XFF896CFE)),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Text(
          'It\'s time to challenge your limits.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
