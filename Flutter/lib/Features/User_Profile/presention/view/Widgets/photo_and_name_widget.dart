import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/Widgets/User_Profile_Photo.dart';

import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Id.dart';

class photo_and_name_widget extends StatelessWidget {
  const photo_and_name_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        User_Profile_Photo(
          userId: getCurrentUserId(),
        ),
        Text(
          GetUser().name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          GetUser().email,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}





// Container(
//           height: 120,
//           width: 120,
//           child: Center(
//             child: ClipOval(
//                 child: Image.asset(
//               Assets.assetsImagesBlankProfilePicture973460960720,
//             )),
//           ),
//         ),