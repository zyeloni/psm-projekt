import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project_android/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Todo.dart';

class FirebaseApi {

  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection("todo").doc();
    todo.id = docTodo.id;

    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<QuerySnapshot> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      //.where('userUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots();

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.delete();
  }
}