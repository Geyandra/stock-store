import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/field_data.dart';

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
              margin: EdgeInsets.only(top: 90),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Tambah Data")),
            )
          ],
        ),
      ),
    );
  }
}


