import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo/Models/todo_model.dart';
import 'package:todo/Screens/Home/home_screen.dart';
import 'package:todo/services/todo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qmwthpukgejjesmpdlzt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFtd3RocHVrZ2VqamVzbXBkbHp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAyMTAwMDQsImV4cCI6MjAxNTc4NjAwNH0.HnA3_yLOQpLCfkU-R2l7Jkpz9zJR96VBZX0wXOz1BBI',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
