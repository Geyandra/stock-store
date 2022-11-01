import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/field_data.dart';
import 'package:intl/intl.dart';

class DetailsProduct extends StatefulWidget {
  DetailsProduct({super.key});
  static const nameRoute = 'Details';

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  final codecontrol = TextEditingController();

  final namacontrol = TextEditingController();

  final jumlahcontrol = TextEditingController();

  final belicontrol = TextEditingController();

  final jualcontrol = TextEditingController();

  final datecontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Detail Barang"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickdate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 2),
                      lastDate: DateTime(DateTime.now().year + 2));

                  if (pickdate != null) {
                    setState(() {
                      datecontrol.text =
                          DateFormat('dd/MM/yyyy').format(pickdate);
                    });
                  }
                },
                controller: datecontrol,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    label: Text("Tanggal Masuk"),
                    labelStyle: TextStyle(color: Colors.blue.shade600),
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    label: Text("Tanggal Ubah"),
                    labelStyle: TextStyle(color: Colors.blue.shade600),
                    prefixIcon: Icon(
                      Icons.date_range_outlined,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade300),
                      child: Text("Edit Data")),
                ),
                Container(
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade300),
                      child: Text("Delete Data")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
