import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project_android/add_todo_dialog.dart';
import 'package:crud_project_android/api/firebase_api.dart';
import 'package:crud_project_android/complete_todo_list_widget.dart';
import 'package:crud_project_android/provider/todos.dart';
import 'package:crud_project_android/todos_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Todo.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectedIndex = 0;

  final tabs = [
    TodoListWidget(),
    CompletedTodoListWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseApi.readTodos(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              final provider = Provider.of<TodosProvider>(context);
              List<Todo> todos =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                return Todo.fromJson(document.data()! as Map<String, dynamic>);
              }).toList();

              provider.setTodos(todos);

              return tabs[selectedIndex];
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => AddTodoDialogWidget(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => {
          if (index == 2)
            FirebaseAuth.instance.signOut()
          else
            setState(() {
              selectedIndex = index;
            })
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 25,
              ),
              label: "Ukończone"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
                size: 25,
              ),
              label: "Wyloguj"),
        ],
      ),
    );
  }
}
