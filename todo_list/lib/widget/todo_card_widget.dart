import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/provider/service_provider.dart';

class TodoCardWidget extends ConsumerWidget {
  TodoCardWidget({
    super.key,
    required this.getIndex,
  });
  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color? labelColor = Colors.white;

          final getLabel = todoData[getIndex].label;

          switch (getLabel) {
            case 'Learning':
              labelColor = Colors.green[300];
              break;
            case 'Working':
              labelColor = Colors.blue[300];
              break;
            case 'General':
              labelColor = Colors.red[300];
              break;
          }
          return Container(
            width: double.infinity,
            height: 105,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: labelColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  width: 14,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(
                            todoData[getIndex].titleTask,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(
                            todoData[getIndex].description,
                            maxLines: 1,
                          ),
                          contentPadding: EdgeInsets.zero,
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.green[400],
                              shape: CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(todoData[getIndex].docId, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -10),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey[200],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(todoData[getIndex].date),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(todoData[getIndex].time),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(serviceProvider)
                                        .deleteTask(todoData[getIndex].docId),
                                    child: Container(
                                      padding: EdgeInsets.only(right: 12),
                                      child: Icon(
                                        CupertinoIcons.delete,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, StackTrace) => Center(child: Text('bye')),
        loading: (() => Center(
              child: CircularProgressIndicator(),
            )));
  }
}
