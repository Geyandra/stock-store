import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_products.dart';

class ProductsProvider with ChangeNotifier {
  Future<void> addProduct(Products data) async {
    final docData =
        FirebaseFirestore.instance.collection("Data_Products").doc();
    data.Id = docData.id;
    final json = data.toJson();
    docData.set(json);
    notifyListeners();
  }
  Future<void> editProduct(Products data) async{
    final docData =
      FirebaseFirestore.instance.collection("Data_Products").doc(data.Id);
  data.Id = docData.id;
  final json = data.toJson();
  docData.update(json);
  notifyListeners();
  }

  Future<void> deleteProduct(String data) async{
    final docData =
      FirebaseFirestore.instance.collection("Data_Products").doc(data);
  docData.delete();
  }
}
