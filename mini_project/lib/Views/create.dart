import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/Models/model_products.dart';
import 'package:mini_project/Widgets/field_data.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});
  static const nameRoute = 'Add';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final codecontrol = TextEditingController();

  final namacontrol = TextEditingController();

  final jumlahcontrol = TextEditingController();

  final belicontrol = TextEditingController();

  final jualcontrol = TextEditingController();

  String? selectedvalue = "PCS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Tambah Barang"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 40),
              child: Text("Tambahkan Data Barang Baru",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold))),
            ),
            FieldData(
              icon: Icons.qr_code_scanner,
              label: "Bacode/Code",
              controller: codecontrol,
              suffixicon: IconButton(
                  onPressed: () {
                    
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.blue.shade400,
                  )),
            ),
            FieldData(
              icon: Icons.shopify,
              label: "Nama Barang",
              controller: namacontrol,
            ),
            FieldData(
              icon: Icons.onetwothree,
              label: "Jumlah",
              controller: jumlahcontrol,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  value: selectedvalue,
                  items: ["PCS", "PAK"]
                      .map((String item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value;
                    });
                  }),
            ),
            FieldData(
              icon: Icons.money_rounded,
              label: "Harga Beli",
              controller: belicontrol,
            ),
            FieldData(
              icon: Icons.attach_money,
              label: "Harga Jual",
              controller: jualcontrol,
            ),
            Container(
              width: 230,
              height: 50,
              margin: EdgeInsets.only(top: 50),
              child: ElevatedButton(
                  onPressed: () {
                    final ProductData = Products(
                        Barcode: codecontrol.text,
                        Nama_Barang: namacontrol.text,
                        Jumlah_Barang: int.parse(jumlahcontrol.text),
                        Tipe: selectedvalue.toString(),
                        Harga_Beli: int.parse(belicontrol.text),
                        Harga_Jual: int.parse(jualcontrol.text),
                        Tanggal_Masuk:
                            DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        Tanggal_Edit: "");
                    createData(ProductData);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Tambah Data")),
            ),
          ],
        ),
      ),
    );
  }
}

Future createData(Products data) async {
  final docData = FirebaseFirestore.instance.collection("Data_Products").doc();
  data.Id = docData.id;
  final json = data.toJson();
  docData.set(json);
}
