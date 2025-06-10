import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Set_Up/cubit/cubit/user_cubit.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Models/BodyConditionModel.dart';
import 'package:graduation_project_ui/core/Services/Data_Base_Service.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as bodyConditionModel;

class SummaryPage extends StatelessWidget {
  final String gender;
  final int age;
  final int weight;
  final num height;
  final BodyConditionModel bodyConditionModel;

  const SummaryPage(
      {super.key,
      required this.gender,
      required this.age,
      required this.weight,
      required this.height,
      required this.bodyConditionModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(storeService: getIt<DatabaseService>()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Information",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text("Gender: $gender",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                Text("Age: $age",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                Text("Weight: $weight KG",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                Text("Height: $height CM",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 40),
                Text("Bmi: ${bodyConditionModel.bmi} CM",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 40),
                Text("Predicted Case: ${bodyConditionModel.predictedCase}",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 18)),
                const SizedBox(height: 40),
                buttonwithbloccnsumer(
                  gender: gender,
                  age: age,
                  weight: weight,
                  height: height,
                  bodyConditionModel: bodyConditionModel,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class buttonwithbloccnsumer extends StatelessWidget {
  final String gender;
  final int age;
  final int weight;
  final num height;
  final BodyConditionModel bodyConditionModel;
  const buttonwithbloccnsumer(
      {super.key,
      required this.gender,
      required this.age,
      required this.weight,
      required this.height,
      required this.bodyConditionModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حفظ البيانات بنجاح!')),
          );
          GoRouter.of(context).push('/Main_view');
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is UserLoading
              ? null
              : () {
                  String userId = FirebaseAuth
                      .instance.currentUser!.uid; // ID المستخدم الحالي
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({
                    "weight": weight,
                    "height": height,
                    "gender": gender,
                    "age": age,
                    "bodyCondition": bodyConditionModel.predictedCase,
                  }).then((_) {
                    context.read<UserCubit>().updateBodyData(
                        weight: weight,
                        height: height,
                        gender: gender,
                        age: age);
                    GoRouter.of(context)
                        .push('/Main_view'); // يروح للصفحة الرئيسية بعد الحفظ
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ في حفظ البيانات: $error')),
                    );
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          child: state is UserLoading
              ? const CircularProgressIndicator()
              : const Text("Done",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
        );
      },
    );
  }
}
