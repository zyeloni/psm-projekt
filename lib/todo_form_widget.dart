import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;
  final VoidCallback onSavedTodo;

  TodoFormWidget(
      {Key? key,
      this.title = '',
      this.description = '',
      required this.onChangeTitle,
      required this.onChangeDescription,
      required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(
              height: 10,
            ),
            buildDescription(),
            SizedBox(
              height: 32,
            ),
            buildButton()
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangeTitle,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (title) {
          if (title!.isEmpty) {
            return "Tytuł nie może być pusty";
          }
          return null;
        },
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: "Tytuł"),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangeDescription,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (description) {
          if (description!.isEmpty) {
            return "Opis nie może być pusty";
          }
          return null;
        },
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: "Opis"),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTodo,
          child: const Text("Zapisz"),
        ),
      );
}
