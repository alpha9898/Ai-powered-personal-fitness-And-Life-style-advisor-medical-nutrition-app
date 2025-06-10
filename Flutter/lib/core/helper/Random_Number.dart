import 'dart:math';

class RandomNumberGenerator {
  int? _lastNumber; // لتخزين آخر رقم عشوائي تم توليده
  final Random _random = Random();

  int getRandomNumber(int min, int max) {
    if (min >= max) {
      throw ArgumentError("القيمة الدنيا لازم تكون أقل من القيمة العليا");
    }

    int newNumber;
    do {
      newNumber = min + _random.nextInt(max - min + 1);
    } while (newNumber == _lastNumber); // التكرار لحد ما نحصل على رقم جديد

    _lastNumber = newNumber; // تخزين آخر رقم تم توليده
    return newNumber;
  }
}
