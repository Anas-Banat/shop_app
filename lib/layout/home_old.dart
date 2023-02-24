// This file befor Bloc

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/todo_app/archive_tasks/archive_tasks_screen.dart';
import 'package:todo_app/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';

// 1. Create database
// 2. Create Tables
// 3. Open database
// 4. Insert to database
// 5. get from database
// 6. update in database
// 7. delete from database
class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  late Database database;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool isBootomSheetShown = false;

  IconData fabIcon = Icons.edit;

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  // We move it to the constants file so we could to access from anywere
  // List<Map> tasks = [];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  @override
  void initState() {
    super.initState();
    // We hide the create because we are using the web for test
    //createDatabase();a1n2a3s4@LOLO.955
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      // we used "CircularProgressIndicator" for loading when the app get the data
      body: tasks.length == 0
          ? Center(child: CircularProgressIndicator())
          : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        // we used "async" for anything will finish in the future
        // we used "await" to waite the value come from the future
        // onPressed: () async {
        //   try {
        //     var name = await getName();
        //     print(name);

        //     throw ('error');
        //   } catch (e) {
        //     print('Error is ${e.toString()}');
        //   }
        // },

        // In this way we dont need to add async and await and its more than beater from try and catch
        // onPressed: () {
        //   getName().then((value) {
        //     print(value);
        //     print('Anas');
        //     throw ('I make an error'); // the system will stop here
        //   }).catchError((e) {
        //     print('Error is ${e.toString()}');
        //   });
        // },

        onPressed: () {
          // insert and getTo Database;
          // First check to hide the form
          // Secound check to validate the value then insert data and get data to screen then close the form
          if (isBootomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                title: titleController.text,
                time: timeController.text,
                date: dateController.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState(() {
                    // this to reload the data in the 'home' screen and we have to relode it in the 'new_tasks_screen' to display the data in the screen but we will fix it in the Bloc
                    isBootomSheetShown = false;
                    fabIcon = Icons.edit;
                    tasks = value;
                    print(tasks);
                  });
                }).catchError((e) {
                  print('Error when get data ${e.toString()}');
                });
              }).catchError((e) {
                print('Error is ${e.toString()}');
              });
            }
            // to show the form
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet(
                  (context) => Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title Field
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            lable: 'Task Title',
                            prefix: Icons.title,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'title must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          // Time Field
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            lable: 'Task Time',
                            prefix: Icons.access_time_filled,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timeController.text =
                                    value!.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Time must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          // Date Field
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            lable: 'Task Date',
                            prefix: Icons.calendar_today,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2024-03-29'),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);
                                print(DateFormat.yMMMd().format(value));
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Date must not be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                )
                .closed // To clos the form and change the icon then we drag the form to down
                .then((value) {
              isBootomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBootomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.red[200],
        // we used 'elevation' to make line between the body & Navigation
        elevation: 50.0,
        // we used 'currentIndex' to select the item in the Navigation
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  // "async & await" to let the sys work in the background to bring the data then display it.
  Future<String> getName() async {
    return 'Anas Banat';
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db', // Name of db
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database created');
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table Created');
        }).catchError((e) {
          print('Error when creating table ${e.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value; // This values will come from the 'constants' file.
          });
          print(tasks);
        }).catchError((e) {
          print('Error when get data ${e.toString()}');
        });
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks (title, time, date, status) VALUES ("$title","$time","$date","new task")',
      )
          .then((value) {
        print('$value inserted successfully');
      }).catchError((e) {
        print('Error when creating new row ${e.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
