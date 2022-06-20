import 'package:crud_project_android/provider/todos.dart';
import 'package:crud_project_android/todo_form_widget.dart';
import 'package:crud_project_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Edycja zadania"),
          actions: [
            IconButton(
              onPressed: deleteTodo,
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangeTitle: (title) => setState(() => this.title = title),
              onChangeDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.updateTodo(widget.todo, title, description);

    Utils.showSnackBarSuccess(context, "Edytowano pomyślnie");

    Navigator.of(context).pop();
  }

  void deleteTodo() {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(widget.todo);
    Utils.showSnackBarSuccess(context, "Usunięto pomyślnie");
    Navigator.of(context).pop();
  }
}
