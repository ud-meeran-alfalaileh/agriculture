import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/admin/nav_bar/admin_navbar_page.dart';
import 'package:agriculture/src/feature/exports/export_start_page.dart';
import 'package:agriculture/src/feature/farmer/navbar_page/view/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../login/view/page/login_page.dart';

class UserAuthWrapper extends StatelessWidget {
  const UserAuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: AppTheme.lightAppColors.primary,
            ));
          } else if (snapshot.hasData) {
            return FutureBuilder<String>(
              future: _getUserType(FirebaseAuth.instance.currentUser!.email!),
              builder: (context, userTypeSnapshot) {
                if (userTypeSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  String userType = userTypeSnapshot.data ?? '';
                  switch (userType) {
                    case 'Farmer':
                      return const StartWidget();
                    case 'exports':
                      return const ExportStartWidget();
                    case 'Admin':
                      return const AdminNavBarWidget();
                    default:
                      return const LoginPage();
                  }
                }
              },
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }

  Future<String> _getUserType(String email) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first['UserType'];
    }

    QuerySnapshot guideQuery = await FirebaseFirestore.instance
        .collection('exports')
        .where('Email', isEqualTo: email)
        .get();

    if (guideQuery.docs.isNotEmpty) {
      return guideQuery.docs.first['UserType'];
    }

    QuerySnapshot adminQuery = await FirebaseFirestore.instance
        .collection('Admin')
        .where('Email', isEqualTo: email)
        .get();

    if (adminQuery.docs.isNotEmpty) {
      return 'Admin';
    }

    return '';
  }
}
