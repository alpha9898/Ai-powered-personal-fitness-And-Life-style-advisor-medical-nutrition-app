import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class User_Profile_Photo extends StatefulWidget {
  final String userId;
  const User_Profile_Photo({super.key, required this.userId});

  @override
  State<User_Profile_Photo> createState() => _User_Profile_PhotoState();
}

class _User_Profile_PhotoState extends State<User_Profile_Photo> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final supabase = Supabase.instance.client;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
      await _uploadToSupabase();
    }
  }

  Future<void> _uploadToSupabase() async {
    if (_imageFile == null) return;

    try {
      String fileName = 'profile_${widget.userId}.jpg'; // اسم الصورة
      final fileBytes = await _imageFile!.readAsBytes();

      // رفع الصورة على Supabase
      await supabase.storage.from('userimages').uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      // جلب الرابط النهائي
      final String imageUrl =
          supabase.storage.from('userimages').getPublicUrl(fileName);

      await _updateFirestore(imageUrl); // تحديث الرابط في Firestore
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("شخررررره خطأ في رفع الصورة: $e")));
    }
  }

  // 📌 3️⃣ تحديث Firestore برابط الصورة
  Future<void> _updateFirestore(String imageUrl) async {
    try {
      await firestore.collection('users').doc(widget.userId).update({
        'profileImage': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم تحديث صورة البروفايل بنجاح!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" خطأ في تحديث الصورةاحااااااا: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          child: Center(
            child: CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage(
              //     Assets.assetsImagesBlankProfilePicture973460960720),
              backgroundImage: GetUser().profileImage != null &&
                      GetUser().profileImage!.isNotEmpty
                  ? NetworkImage(GetUser().profileImage!) as ImageProvider
                  : const AssetImage(Assets
                      .assetsImagesBlankProfilePicture973460960720), // صورة افتراضية
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: KPacScoundColor,
              ),
              child: const Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
