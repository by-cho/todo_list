import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:todo_list/provider/date_time_provider.dart';
import 'package:todo_list/provider/radio_provider.dart';
import 'package:todo_list/provider/service_provider.dart';
import '../constant/app_style.dart';
import '../widget/date_time_picker_widget.dart';
import '../widget/radio_widget.dart';
import '../widget/text_filed_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey[200],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Title',
              style: AppStyle.headingStyle,
            ),
            TextFieldWidget(
              hintText: '제목을 설정하세요',
              maxLine: 1,
              txtController: titleController,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description',
              style: AppStyle.headingStyle,
            ),
            TextFieldWidget(
              hintText: '내용을 입력하세요',
              maxLine: 5,
              txtController: descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Label',
              style: AppStyle.headingStyle,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    titleRadio: 'LRN',
                    labelColor: Colors.green,
                    valueInput: 1,
                    onChangeValue: () {
                      ref.read(radioProvider.notifier).update((state) => 1);
                    },
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: 'WRK',
                    labelColor: Colors.blue,
                    valueInput: 2,
                    onChangeValue: () {
                      ref.read(radioProvider.notifier).update((state) => 2);
                    },
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    titleRadio: 'GNR',
                    labelColor: Colors.red,
                    valueInput: 3,
                    onChangeValue: () {
                      ref.read(radioProvider.notifier).update((state) => 3);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimePickerWidget(
                  titleText: 'Date',
                  valueText: dateProv,
                  icon: CupertinoIcons.calendar,
                  pressed: "date",
                ),
                SizedBox(
                  width: 20,
                ),
                DateTimePickerWidget(
                  titleText: 'Time',
                  valueText: timeProv,
                  icon: CupertinoIcons.time,
                  pressed: "time",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);
                      String label = '';

                      switch (getRadioValue) {
                        case 1:
                          label = 'Learning';
                          break;
                        case 2:
                          label = 'Working';
                          break;
                        case 3:
                          label = 'General';
                          break;
                      }

                      ref.read(serviceProvider).addNewTask(
                            TodoModel(
                              titleTask: titleController.text,
                              description: descriptionController.text,
                              label: label,
                              date: ref.read(dateProvider),
                              time: ref.read(
                                (timeProvider),
                              ),
                              isDone: false,
                            ),
                          );
                      print('data is saving');
                      titleController.clear();
                      descriptionController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                    },
                    child: Text('Create'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
