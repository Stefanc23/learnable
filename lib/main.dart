import 'package:flutter/material.dart';
import 'package:learnable/screens/loading.dart';
import 'package:learnable/utils/learnable_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnable',
      theme: learnableTheme,
      home: const Loading(),
      debugShowCheckedModeBanner: false,
    );
  }
}
