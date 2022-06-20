import 'package:crud_project_android/Todo.dart';
import 'package:crud_project_android/edit_todo_page.dart';
import 'package:crud_project_android/provider/todos.dart';
import 'package:crud_project_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  TodoWidget({Key? key, required this.todo}) : super(key: key);

  Widget buildTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);

                final after = provider.toggleTodoStatus(todo);
                final text = after
                    ? "Przeniesiono do ukończonych"
                    : "Przeniesiono do zrobienia";
                Utils.showSnackBarSuccess(context, text);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Theme.of(context).primaryColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    todo.description,
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                )
              ],
            ))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Slidable(
      key: Key(todo.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => editTodo(context, todo),
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            label: "Edytuj",
            icon: Icons.edit,
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => deleteTodo(context, todo),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            label: "Usuń",
            icon: Icons.delete,
          )
        ],
      ),
      child: buildTodo(context));

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar("Zadanie zostało usunięte");
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));
}
