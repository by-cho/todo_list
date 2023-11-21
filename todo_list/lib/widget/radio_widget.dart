import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.labelColor,
    required this.valueInput,
    required this.onChangeValue,
  });

  final String titleRadio;
  final Color labelColor;
  final int valueInput;
  final VoidCallback onChangeValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: labelColor),
        child: RadioListTile(
          activeColor: labelColor,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: Offset(-22, 0),
            child: Text(
              '${titleRadio}',
              style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          value: valueInput,
          groupValue: radio,
          onChanged: (value) {
            onChangeValue();
          },
        ),
      ),
    );
  }
}
