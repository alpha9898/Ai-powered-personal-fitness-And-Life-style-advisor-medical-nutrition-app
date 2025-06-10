import 'dart:math';

List<int> getDailyRandomIndexes({required int total, int count = 5}) {
  // نجيب التاريخ الحالي بدون الساعة علشان نضمن إنه ثابت طول اليوم
  final now = DateTime.now();
  final seed = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

  // نستخدم Random بالـ seed
  final random = Random(seed);

  // نعمل شفل لليست فيها الأرقام من 0 لـ total-1
  final indexes = List.generate(total, (index) => index)..shuffle(random);

  // ناخد أول خمس أرقام
  return indexes.take(count).toList();
}
