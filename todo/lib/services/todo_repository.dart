import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/Models/todo_model.dart';

class TodoRepository {
  Future<List<Todo>> getTasks() async {
    final response = await Supabase.instance.client.from('Todo').select();
    List<Todo> taskList = [];
    for (var element in response) {
      taskList.add(Todo.fromJson(element));
    }
    return taskList;
  }

  Future addTask(String task, String category) async {
    final response = await Supabase.instance.client
        .from('Todo')
        .insert({'task': task, 'status': false, 'category': category});
  }

  Future updateTaskStatus(int id, bool status) async {
    final response = await Supabase.instance.client
        .from('Todo')
        .update({'status': status}).eq('id', id);
  }

  Future deleteTask(int id) async {
    final response =
        await Supabase.instance.client.from('Todo').delete().eq('id', id);
  }
}
