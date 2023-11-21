import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/provider/date_time_provider.dart';

import '../constant/app_style.dart';

class DateTimePickerWidget extends ConsumerWidget {
  const DateTimePickerWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.icon,
    required this.pressed,
  });

  final String titleText;
  final String valueText;
  final IconData icon;
  final String pressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime selectedTime = DateTime(
      DateTime.now().hour,
      DateTime.now().minute,
    );

    DateTime selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    void onTimePressed() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext builderContext) {
          DateTime timeSelect = selectedTime; // 초기 값 설정

          return Container(
            height: 300.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: selectedTime,
                      onDateTimeChanged: (DateTime newDateTime) {
                        // Handle the selected time
                        timeSelect = newDateTime;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (timeSelect.hour > 12) {
                        if (timeSelect.hour < 10) {
                          if (timeSelect.minute < 10) {
                            ref.read(timeProvider.notifier).update((state) =>
                                'PM 0${timeSelect.hour} : 0${timeSelect.minute}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(timeProvider.notifier).update((state) =>
                                'PM 0${timeSelect.hour} : ${timeSelect.minute}');
                            Navigator.of(context).pop();
                          }
                        } else {
                          if (timeSelect.minute < 10) {
                            ref.read(timeProvider.notifier).update((state) =>
                                'PM ${timeSelect.hour} : 0${timeSelect.minute}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(timeProvider.notifier).update((state) =>
                                'PM ${timeSelect.hour} : ${timeSelect.minute}');
                            Navigator.of(context).pop();
                          }
                        }
                      } else {
                        if (timeSelect.hour < 10) {
                          if (timeSelect.minute < 10) {
                            ref.read(timeProvider.notifier).update((state) =>
                                'AM 0${timeSelect.hour} : 0${timeSelect.minute}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(timeProvider.notifier).update((state) =>
                                'AM 0${timeSelect.hour} : ${timeSelect.minute}');
                            Navigator.of(context).pop();
                          }
                        } else {
                          if (timeSelect.minute < 10) {
                            ref.read(timeProvider.notifier).update((state) =>
                                'AM ${timeSelect.hour} : 0${timeSelect.minute}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(timeProvider.notifier).update((state) =>
                                'AM ${timeSelect.hour} : ${timeSelect.minute}');
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    child: Text('입력'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void onDatePressed() {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          DateTime dateSelect = selectedDate; // 초기 값 설정

          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: dateSelect,
                        minimumDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        onDateTimeChanged: (DateTime date) {
                          dateSelect = date; // 새로운 날짜 업데이트
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedDate.month < 10) {
                          if (selectedDate.day < 10) {
                            ref.read(dateProvider.notifier).update((state) =>
                                '${dateSelect.year}-0${dateSelect.month}-0${dateSelect.day}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(dateProvider.notifier).update((state) =>
                                '${dateSelect.year}-0${dateSelect.month}-${dateSelect.day}');
                            Navigator.of(context).pop();
                          }
                        } else {
                          if (selectedDate.day < 10) {
                            ref.read(dateProvider.notifier).update((state) =>
                                '${dateSelect.year}-${dateSelect.month}-0${dateSelect.day}');
                            Navigator.of(context).pop();
                          } else {
                            ref.read(dateProvider.notifier).update((state) =>
                                '${dateSelect.year}-${dateSelect.month}-${dateSelect.day}');
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text('입력'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${titleText}',
            style: AppStyle.headingStyle,
          ),
          SizedBox(
            height: 10,
          ),
          // GestureDetector와 달리 버튼 클릭시 클릭 피드백을 주기 위해서 Ink, InkWell사용
          Ink(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                print('object');
                if (pressed == 'date') {
                  onDatePressed();
                } else {
                  onTimePressed();
                }
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(icon),
                    SizedBox(
                      width: 12,
                    ),
                    Text('${valueText}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
