import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnable/screens/splash_screen.dart';
import 'package:learnable/utils/learnable_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnable',
      theme: learnableTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
