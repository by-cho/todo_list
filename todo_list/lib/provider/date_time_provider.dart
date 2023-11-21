import 'package:flutter_riverpod/flutter_riverpod.dart';

DateTime selectedTime = DateTime(
  DateTime.now().hour,
  DateTime.now().minute,
);

DateTime selectedDate = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);
final dateProvider = StateProvider<String>((ref) {
  return '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
});

final timeProvider = StateProvider<String>((ref) {
  return 'AM 00 : 00';
});
