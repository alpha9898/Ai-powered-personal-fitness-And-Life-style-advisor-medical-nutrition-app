class BodyConditionModel {
  final double bmi;
  final int exercisePlan;
  final String exerciseRecommendation;
  final String nutritionRecommendation;
  final String predictedCase;

  BodyConditionModel({
    required this.bmi,
    required this.exercisePlan,
    required this.exerciseRecommendation,
    required this.nutritionRecommendation,
    required this.predictedCase,
  });

  factory BodyConditionModel.fromJson(Map<String, dynamic> json) {
    return BodyConditionModel(
      bmi:
          (json['Calculated BMI (based on height and weight)'] as num)
              .toDouble(),
      exercisePlan: json['Exercise Plan'] as int,
      exerciseRecommendation: json['Exercise Recommendation'],
      nutritionRecommendation: json['Nutrition Recommendation'],
      predictedCase: json['Predicted BMIcase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Calculated BMI (based on height and weight)': bmi,
      'Exercise Plan': exercisePlan,
      'Exercise Recommendation': exerciseRecommendation,
      'Nutrition Recommendation': nutritionRecommendation,
      'Predicted BMIcase': predictedCase,
    };
  }
}
