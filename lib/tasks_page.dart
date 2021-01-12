import 'package:connect_unifei/login_page.dart';
import 'package:connect_unifei/model/user_model.dart';
import 'package:connect_unifei/complements/DatabaseUser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  final response;

  const TasksPage({Key key, this.response}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

bool isVertical = true;

class _TasksPageState extends State<TasksPage> {
  Future<List<Tasks>> _getTasks(response) async {
    List<Tasks> tasks = [];

    for (var u in response) {
      Tasks task = Tasks(
        date: u["date"],
        subject: u["subject"],
        type: u["type"],
      );

      tasks.add(task);
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    var screenOrientation = MediaQuery.of(context).orientation;
    if (screenOrientation == Orientation.landscape) {
      isVertical = true;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _getColorFromHex("#445BEB"),
        /*actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage(),
                ),
              );
            },
          ),
        ],*/
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: _getColorFromHex("#445BEB"),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "Tarefas",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 70,
                    width: 280,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.response["profile"]["nome"],
                          style: TextStyle(color: _getColorFromHex("#329D9C")),
                        ),
                        Text(
                          widget.response["profile"]["curso"],
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                      future: _getTasks(widget.response["tasks"]),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else {
                          return listTasks(isVertical, snapshot.data);
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget listTasks(bool isVertical, List<Tasks> task) {
  return Expanded(
    child: ListView.builder(
      scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
      shrinkWrap: true,
      itemCount: task.length,
      itemBuilder: (context, index) {
        if (!DateTime.parse(task[index].date[0])
            .isBefore(DateTime.now().add(Duration(days: -1)))) {
          return tasks(
            task[index].type,
            task[index].subject[0],
            task[index].date[0],
            task[index].date.length > 2 ? task[index].date[2] : "",
            task[index].date.length != 1
                ? task[index].date[1]
                : "Prazo Excedido",
            isVertical,
          );
        } else {
          return Container();
        }
      },
    ),
  );
}

Widget tasks(String type, String subject, String date, String day, String hour,
    bool isVertical) {
  return Container(
    width: 340,
    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0),
        )
      ],
    ),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: isVertical ? 10 : 50,
        ),
        isVertical
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              )
            : SizedBox(
                width: 180,
                height: 180,
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.white,
                  elevation: 0,
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 5,
                      color: Colors.grey[100],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.assignment,
                        size: 50,
                        color: Colors.blue,
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        subject,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
        SizedBox(
          height: isVertical ? 10 : 50,
        ),
        Divider(
          color: Colors.black54,
        ),
        isVertical
            ? SizedBox(
                height: 10,
              )
            : Expanded(
                child: Container(),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$date - $hour",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
                  child: Text(
                    subject,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue[900],
                  child: Text(
                    "Adicionar à Agenda",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              day,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Color _getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}

class Tasks {
  final String type;
  final List subject;
  final List date;

  Tasks({
    this.type,
    this.subject,
    this.date,
  });
}

void _exec(User user) async {
  var db = new DatabaseUser();
}
