import 'package:flutter/material.dart';

import '../model/model.dart';

class TodoView extends StatefulWidget {
  Todo todo;
  TodoView({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState(todo: this.todo);
}

class _TodoViewState extends State<TodoView> {
  Todo todo;

  _TodoViewState({required this.todo});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      titleController.text = todo.task;
      descriptionController.text = todo.taskDec;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Update Todo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                  child: (TextField(
                    onChanged: (data) {
                      todo.task = data;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Title",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: titleController,
                  ))),
              SizedBox(
                height: 25,
              ),
              Container(
                  child: (TextField(
                    maxLines: 3,
                    onChanged: (data) {
                      todo.taskDec = data;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Description",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: descriptionController,
                  ))),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text == "" &&
                      descriptionController.text == "") {
                    var snackBar = SnackBar(
                      content: Text('Please Fill Title and Description',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black ,
                      ),),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (titleController.text == "") {
                    var snackBar = SnackBar(
                      content: Text('Please Fill Title ',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black ,
                      ),),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (descriptionController.text == "") {
                    var snackBar = SnackBar(
                      content: Text("Please Fill  Description ",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black ,
                      ),),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.pop(context, todo);
                    var snackbar = SnackBar(
                      content: Text("Task updated",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black ,
                      ),),
                      backgroundColor: Colors.greenAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: EdgeInsets.all(11),
                    primary: Colors.lightBlueAccent),
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
