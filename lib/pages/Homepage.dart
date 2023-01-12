import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/updatepage.dart';

import '../model/model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var addtaskname = TextEditingController();
  var addDes = TextEditingController();

  List<Todo> todolist = [];
  bool? check;
  SharedPreferences? prefs;

  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs!.getString('todo');
    List todoList = jsonDecode(stringTodo!);
    for (var todo in todoList) {
      setState(() {
        todolist.add(
            Todo(task: addtaskname.text, taskDec: addDes.text, ischecked: check)
                .fromJson(todo));
      });
    }
  }

  void saveTodo() {
    List items = todolist.map((e) => e.toJson()).toList();
    prefs!.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: "Title",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: addtaskname,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: "Description",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            controller: addDes,
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.all(11),
                primary: Colors.lightBlueAccent,
              ),
              onPressed: () {
                if (addtaskname.text == "" && addDes.text == "") {
                  var snackBar = SnackBar(
                    content: Text('Please Fill Title and Description',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black ,
                    ),),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (addtaskname.text == "") {
                  var snackBar = SnackBar(
                    content: Text('Please Fill Title',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black ,
                    ),),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (addDes.text == "") {
                  var snackBar = SnackBar(
                    content: Text("Please Fill Description ",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black ,
                    ),),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  setState(() {
                    todolist.insert(
                        0,
                        Todo(
                          task: addtaskname.text,
                          taskDec: addDes.text,
                          ischecked: check,
                        ));
                  });
                  var snackbar = SnackBar(
                    content: Text("Task Added" , style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black ,
                    ),),
                    backgroundColor: Colors.yellowAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  saveTodo();
                  addtaskname.clear();
                  addDes.clear();
                }
              },
              child: Text("Add Task")),
          SizedBox(
            height: 15,
          ),
          Divider(),
          Text(
            "Tasks",
            style: TextStyle(
              fontSize: 22,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todolist.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border:
                  Border.all(width: 2, color: Colors.lightBlueAccent),
                ),
                child: InkWell(
                  onTap: () async {
                    Todo update = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoView(
                                todo: Todo(
                                    task: todolist[index].task,
                                    taskDec: todolist[index].taskDec))));
                    if (update != null) {
                      setState(() {
                        todolist[index] = update;
                      });

                      saveTodo();
                    }
                  },
                  child: ListTile(
                    title: Center(
                        child: Text(
                          todolist[index].task,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    subtitle: Text(
                      todolist[index].taskDec,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.lightBlueAccent, ) ,
                      onPressed: () {
                        setState(() {
                          todolist.removeAt(index);
                        });
                        var snackbar = SnackBar(
                          content: Text("Task Deleted",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black ,
                          ),),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        saveTodo();
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
