import 'package:crud_project_android/Todo.dart';
import 'package:crud_project_android/provider/todos.dart';
import 'package:crud_project_android/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedTodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
            child: Text("Brak listy zadań"),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(5),
            physics: const BouncingScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          );
  }
}
