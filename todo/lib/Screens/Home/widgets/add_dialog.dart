import 'package:flutter/material.dart';
import 'package:todo/Screens/Home/widgets/card_widget.dart';
import 'package:todo/constents/colors.dart';
import 'package:todo/services/todo_repository.dart';

class AddTodoDialog extends StatefulWidget {
  AddTodoDialog({required this.toDo});
  final TodoRepository toDo;
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final taskController = TextEditingController();
  late String category = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: grey,
      title: const Center(
          child: Text(
        'Add Task',
        style: TextStyle(color: yellow),
      )),
      content: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                    labelText: 'Task',
                    labelStyle: const TextStyle(color: light),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: light)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: light))),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              ' Choose Category :',
              style: TextStyle(color: light, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CardCategory(
                    onTap: () {
                      category = 'Study';
                    },
                    text: 'Study'),
                CardCategory(
                  onTap: () {
                    setState(() {
                      category = 'Sport';
                    });
                  },
                  text: 'Sport',
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: light, fontSize: 20),
            ),
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            }),
        TextButton(
          child:
              const Text('Add', style: TextStyle(color: light, fontSize: 20)),
          onPressed: () {
            final task = taskController.text;
            widget.toDo.addTask(task, category);
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
