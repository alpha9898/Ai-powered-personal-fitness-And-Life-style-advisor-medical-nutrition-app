import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';

class profile_container_information extends StatefulWidget {
  final String userId;
  const profile_container_information({super.key, required this.userId});

  @override
  State<profile_container_information> createState() =>
      _profile_container_informationState();
}

class _profile_container_informationState
    extends State<profile_container_information> {
  UserModel? localUser; // لتخزين بيانات SharedPreferences محليًا

  @override
  void initState() {
    super.initState();
    _loadLocalUserData();
  }

  Future<void> _loadLocalUserData() async {
    var jsonString = SharedPreferencesSinglton.getString(KUserData);
    if (jsonString != null) {
      setState(() {
        localUser = UserModel.fromJson(jsonDecode(jsonString));
      });
    }
  }

  Stream<UserModel> getUserStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        var user = UserModel.fromJson(snapshot.data()!);

        // تحديث SharedPreferences بالبيانات الجديدة من Firestore
        SharedPreferencesSinglton.setString(
            KUserData, jsonEncode(snapshot.data()));

        return user;
      } else {
        throw Exception('User not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: getUserStream(),
      builder: (context, snapshot) {
        UserModel? user = snapshot.data ??
            localUser; // عرض البيانات من SharedPreferences لو Firestore لسه محملش

        if (user == null) {
          return CircularProgressIndicator(); // لودينج لو مفيش بيانات
        }

        return Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xff896CFE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${user.weight}Kg',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        'Weight',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 35),
                  Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${user.age}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        'Years Old',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 35),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 20,
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${user.height}Cm',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        'Height',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    //Container(
    //   width: MediaQuery.of(context).size.width * 0.85,
    //   decoration: BoxDecoration(
    //     color: const Color(0xff896CFE),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
    //       child: Row(
    //         children: [
    //           const SizedBox(width: 5),
    //           Column(
    //             children: [
    //               Text(
    //                 '${GetUser().weight}Kg',
    //                 style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //               const Text(
    //                 'weight',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(width: 20),
    //           const SizedBox(
    //             height: 50,
    //             child: VerticalDivider(
    //               width: 20,
    //               thickness: 1,
    //               color: Colors.white,
    //             ),
    //           ),
    //           SizedBox(width: 35),
    //           Column(
    //             children: [
    //               Text(
    //                 GetUser().age.toString(),
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //               Text(
    //                 'Years Old',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(width: 35),
    //           SizedBox(
    //             height: 50,
    //             child: VerticalDivider(
    //               width: 20,
    //               thickness: 1,
    //               color: Colors.white,
    //             ),
    //           ),
    //           Column(
    //             children: [
    //               Text(
    //                 '${GetUser().height}Cm',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //               Text(
    //                 'Height',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
