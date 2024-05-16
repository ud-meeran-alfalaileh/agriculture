import 'package:agriculture/firebase_options.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/core/auth_repo/auth_repo.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/page/initial_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

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
