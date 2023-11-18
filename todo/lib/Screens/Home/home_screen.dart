import 'package:flutter/material.dart';
import 'package:todo/Models/todo_model.dart';
import 'package:todo/Screens/Home/widgets/add_dialog.dart';
import 'package:todo/Screens/Home/widgets/card_widget.dart';
import 'package:todo/constents/colors.dart';
import 'package:todo/services/todo_repository.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoRepository toDo = TodoRepository();
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 36, 36, 35),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Todo List :',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: light,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CardCategory(
                        onTap: () {
                          setState(() {
                            selectedCategory = '';
                          });
                        },
                        text: 'All',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CardCategory(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Study';
                          });
                        },
                        text: 'Study',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CardCategory(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Sport';
                          });
                        },
                        text: 'Sport',
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Todo>>(
                future: toDo.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final tasks = snapshot.data!;
                    final categoryList = selectedCategory.isNotEmpty
                        ? tasks
                            .where((todo) => todo.category == selectedCategory)
                            .toList()
                        : tasks;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: darkGreen,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    categoryList[index].task,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: light,
                                    ),
                                  ),
                                  leading: Checkbox(
                                    side: const BorderSide(color: grey),
                                    checkColor: darkGreen,
                                    activeColor: yellow,
                                    value: categoryList[index].status,
                                    onChanged: (value) {
                                      toDo.updateTaskStatus(
                                          categoryList[index].id, value!);
                                      setState(() {});
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: grey,
                                    ),
                                    onPressed: () {
                                      toDo.deleteTask(categoryList[index].id);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                if (categoryList[index].category.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 70),
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: yellow,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          categoryList[index].category,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellow,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddTodoDialog(toDo: toDo),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
