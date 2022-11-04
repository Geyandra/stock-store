import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_products.dart';
import 'package:mini_project/Widgets/botnav.dart';
import 'package:mini_project/Widgets/field_data.dart';
import 'package:intl/intl.dart';

class DetailsProduct extends StatefulWidget {
  final Products? data;
  DetailsProduct({super.key, required this.data});
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
  final dateeditcontrol = TextEditingController();

  @override
  void initState() {
    codecontrol.text = widget.data!.Barcode;
    namacontrol.text = widget.data!.Nama_Barang;
    jumlahcontrol.text = widget.data!.Jumlah_Barang.toString();
    belicontrol.text = widget.data!.Harga_Beli.toString();
    jualcontrol.text = widget.data!.Harga_Jual.toString();
    datecontrol.text = widget.data!.Tanggal_Masuk;
    dateeditcontrol.text = widget.data!.Tanggal_Edit;
    super.initState();
  }

  String? selectedvalue = "PCS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Details Barang"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FieldData(
              icon: Icons.qr_code_scanner,
              label: "Barcode",
              controller: codecontrol,
            ),
            FieldData(
              icon: Icons.shopify,
              label: "Nama Barang",
              controller: namacontrol,
            ),
            FieldData(
              icon: Icons.onetwothree,
              label: "Stock",
              controller: jumlahcontrol,
              keyboardtype: TextInputType.number,
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
                  value: widget.data!.Tipe,
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
              keyboardtype: TextInputType.number,
            ),
            FieldData(
              icon: Icons.attach_money,
              label: "Harga Jual",
              controller: jualcontrol,
              keyboardtype: TextInputType.number,
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
                controller: dateeditcontrol,
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

            //Edit n Delete
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RGButton(
                  pressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(
                                  "Apakah Anda yakin ingin mengubah data ?"),
                              title: Text("Konfirmasi"),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          final dataedit = Products(
                                            Id: widget.data!.Id,
                                            Barcode: codecontrol.text,
                                            Nama_Barang: namacontrol.text,
                                            Jumlah_Barang:
                                                int.parse(jumlahcontrol.text),
                                            Tipe: selectedvalue.toString(),
                                            Harga_Beli:
                                                int.parse(belicontrol.text),
                                            Harga_Jual:
                                                int.parse(jualcontrol.text),
                                            Tanggal_Masuk: datecontrol.text,
                                            Tanggal_Edit:
                                                DateFormat('dd/MM/yyyy')
                                                    .format(DateTime.now()),
                                          );
                                          updateData(dataedit);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.green.shade300),
                                        child: Text("Yakin")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade300),
                                        child: Text("Batal")),
                                  ],
                                )
                              ],
                            ));
                  },
                  color: Colors.green.shade300,
                  text: 'Ubah Data',
                  margin: EdgeInsets.only(top: 10),
                ),
                RGButton(
                    margin: EdgeInsets.only(top: 10),
                    text: "Hapus Data",
                    color: Colors.red.shade300,
                    pressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Delete"),
                                content: Text(
                                    "Apakah Anda yakin ingin menghapus data ?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            deleteData(widget.data!.Id);
                                            Navigator.of(context).pushNamed(
                                                BottomNavBar.nameRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green.shade300),
                                          child: Text("Yakin")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red.shade300),
                                          child: Text("Batal")),
                                    ],
                                  )
                                ],
                              ),
                              );
                    })
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class RGButton extends StatelessWidget {
  final String text;
  final Color color;
  final margin;
  final VoidCallback pressed;
  const RGButton({
    required this.text,
    required this.color,
    this.margin,
    required this.pressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: margin,
      child: ElevatedButton(
          onPressed: pressed,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text)),
    );
  }
}

class RGButtonDialog extends StatelessWidget {
  final String text;
  final Color color;
  final margin;
  final VoidCallback pressed;
  const RGButtonDialog({
    required this.text,
    required this.color,
    this.margin,
    required this.pressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      margin: margin,
      child: ElevatedButton(
          onPressed: pressed,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text)),
    );
  }
}

Future updateData(Products data) async {
  final docData =
      FirebaseFirestore.instance.collection("Data_Products").doc(data.Id);
  data.Id = docData.id;
  final json = data.toJson();
  docData.update(json);
}

Future deleteData(String data) async {
  final docData =
      FirebaseFirestore.instance.collection("Data_Products").doc(data);
  docData.delete();
}
