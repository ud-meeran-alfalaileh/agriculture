import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ExportsCropController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchAllCrops() async {
    List<Map<String, dynamic>> crops = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance.collection('Crops').get();

      for (var doc in result.docs) {
        crops.add(doc.data());
      }
    } catch (e) {
      print("Error fetching crops: $e");
    }

    return crops;
  }
}
