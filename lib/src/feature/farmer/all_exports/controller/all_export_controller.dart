import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllExportsController extends GetxController {
  void openWhatsAppChat(String phoneNumber) async {
    final url = Uri.parse('https://wa.me/$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllExports() async {
    List<Map<String, dynamic>> exports = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('Users')
          .where('UserType',
              isEqualTo:
                  'exports') // Order by datetime field in descending order
          .get();

      for (var doc in result.docs) {
        exports.add(doc.data());
      }
    } catch (e) {
      print("Error fetching posts: $e");
    }

    return exports;
  }
}
