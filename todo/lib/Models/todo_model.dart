class Todo {
  late int id;
  late String task;
  late bool status;
  late String category;

  Todo(
      {required this.id,
      required this.task,
      required this.status,
      required this.category});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    status = json['status'];
    category = json['category'] ?? '';
  }
}
