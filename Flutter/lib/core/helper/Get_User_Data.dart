import 'dart:convert';

import 'package:graduation_project_ui/Features/Auth/data/Models/User_Model.dart';
import 'package:graduation_project_ui/Features/Auth/domin/Entites/User_entity.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';

UserEntity GetUser() {
  var jsonString = SharedPreferencesSinglton.getString(KUserData);
  var userentity = UserModel.fromJson(jsonDecode(jsonString));
  return userentity;
}
