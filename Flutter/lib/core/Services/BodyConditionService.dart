import 'package:dio/dio.dart';
import 'package:graduation_project_ui/core/Models/BodyConditionModel.dart';

class Bodyconditionservice {
  final Dio dio = Dio();

  Future<BodyConditionModel> getBodyConditionData({
    required num weight,
    required double height,
    required int age,
    required String gender,
  }) async {
    try {
      final response = await dio.post(
        'http://10.0.2.2:5000/predict',
        data: {
          'age': age,
          'height': height,
          'weight': weight,
          'gender': gender,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return BodyConditionModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch body condition: $e');
    }
  }
}
