import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_pesanan.dart';

class OrdersProvider with ChangeNotifier {
  Future<void> addProduct(Orders data) async {
    final docData = FirebaseFirestore.instance.collection("Data_Pesanan").doc();
    data.Id = docData.id;
    final json = data.toJson();
    docData.set(json);
    notifyListeners();
  }

  Future<void> deleteProduct(String data) async {
    final docData =
        FirebaseFirestore.instance.collection("Data_Pesanan").doc(data);
    docData.delete();
  }
}
