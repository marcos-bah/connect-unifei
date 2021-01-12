import 'package:connect_unifei/complements/DatabaseUser.dart';
import 'package:connect_unifei/splash_page.dart';
import 'package:connect_unifei/login_page.dart';
import 'package:connect_unifei/tasks_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/TasksPage': (BuildContext context) => new TasksPage(),
      },
    );
  }
}
