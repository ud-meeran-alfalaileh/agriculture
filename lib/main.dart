import 'package:agriculture/firebase_options.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/navbar_page/view/page/initial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const UserAuthWrapper(),
    );
  }
}
