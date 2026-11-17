import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key}); // Ensure MyApp is marked as const
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.lightBlue),
          hintStyle: TextStyle(color: Colors.lightBlue),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
        ),
      ),
      home: SplashScreen(), // Start with the SplashScreen
    );
  }
}