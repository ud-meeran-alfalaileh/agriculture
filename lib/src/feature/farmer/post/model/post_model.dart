import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;

  String name;
  String email;
  String img;
  String description;
  String date;
  String type;
  String userId;
  PostModel({
    required this.userId,
    this.id,
    required this.name,
    required this.email,
    required this.img,
    required this.description,
    required this.date,
    required this.type,
  });

  tojason() {
    return {
      "Name": name,
      "Email": email,
      "Description": description,
      "Date": date,
      "img": img,
      "type": type,
      "id": userId,
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return PostModel(
      id: documentSnapshot.id,
      name: data['Name'],
      description: data['Description'],
      date: data['Date'],
      img: data["img"] ?? "",
      type: data['type'],
      userId: data['id'],
      email: data['Email'],
    );
  }
}
