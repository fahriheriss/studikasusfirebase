import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void toLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }
}

  Future addUser(String username, String email, String password) async {
    await FirebaseFirestore.instance.collection('Users').add({
      'username': username,
      'email': email,
      'password': password,
    });
  }

    Future register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      final username = _usernameController.text;

      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        throw ("Please fill all the fields");
      } else {
        if (password.length < 6) {
          throw ("Password must be at least 6 characters");
        } else {
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          await addUser(username, email, password);
        }
      }
    } catch (error) {
      final snackBar = SnackBar(content: Text("Error: ${error.toString()}"));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


class ItemList extends StatelessWidget {
  final String transaksiDocId;
  final Todo todo;
  const ItemList({super.key, required this.todo, required this.transaksiDocId});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference todoCollection = _firestore.collection('Todos');
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    return GestureDetector(
      onTap: () {
        _showUpdateDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    todo.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(
                todo.isComplete
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: todo.isComplete ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                todoCollection.doc(transaksiDocId).update({
                  'isComplete': !todo.isComplete,
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteTodo();
              },
            ),
          ],
        ),
      )
    );
  }
}
void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Todo'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateTodo();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                deleteTodo();
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteTodo() async {
    await todoCollection.doc(transaksiDocId).delete();
  }

  Future<void> updateTodo() async {
    await todoCollection.doc(transaksiDocId).update({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'isComplete': false,
    });
  }


class ChecklistButton extends StatefulWidget {
  const ChecklistButton({super.key});

  @override
  State<ChecklistButton> createState() => _ChecklistButtonState();
}

class _ChecklistButtonState extends State<ChecklistButton> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: isChecked ? Colors.blue : Colors.grey,
        size: 25,
      ),
      onPressed: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
    );
  }
}
