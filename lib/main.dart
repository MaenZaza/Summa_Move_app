import 'package:flutter/material.dart';
// import 'pages/login_page.dart';
import 'pages/oefeningen_page.dart';
import 'pages/prestatie_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Oefening App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) =>  LoginPage(),
        '/oefeningen': (context) => OefeningenPage(),
        '/prestatie': (context) => PrestatiePage(),
      },
    );
  }
}
