import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_products.dart';
import 'package:mini_project/Views/create.dart';
import 'package:mini_project/Views/details.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  static const nameRoute = 'Homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int? Columnindex;
  bool asc = false;
  List<Products> search = [];
  String searchresult = '';
  final nametable = ["Nama Barang", "Stock", "Satuan"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddProduct.nameRoute);
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<List<Products>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Ada Kesalahan! ${snapshot.hasError}");
          } else if (snapshot.hasData) {
            List<Products> datas = snapshot.data!;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 10),
                  width: double.infinity,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        search = datas
                            .where((element) =>
                                element.Nama_Barang.toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "Search Data",
                      hintStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      sortColumnIndex: Columnindex,
                      sortAscending: asc,
                      columns: nametable
                          .map((String column) => DataColumn(
                                label: Text(column),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    Columnindex = columnIndex;
                                    asc = ascending;
                                  });
                                  if (columnIndex == 0) {
                                    if (asc) {
                                      datas.sort(
                                        (a, b) => a.Nama_Barang.compareTo(
                                            b.Nama_Barang),
                                      );
                                    } else {
                                      datas.sort(
                                        (a, b) => b.Nama_Barang.compareTo(
                                            a.Nama_Barang),
                                      );
                                    }
                                  } else if (columnIndex == 1) {
                                    if (asc) {
                                      datas.sort(
                                        (a, b) => a.Jumlah_Barang.compareTo(
                                            b.Jumlah_Barang),
                                      );
                                    } else {
                                      datas.sort(
                                        (a, b) => b.Jumlah_Barang.compareTo(
                                            a.Jumlah_Barang),
                                      );
                                    }
                                  }
                                },
                              ))
                          .toList(),
                      rows: search
                          .map((data) => DataRow(
                                  onLongPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsProduct(
                                                data: data,
                                              )),
                                    );
                                  },
                                  cells: [
                                    DataCell(
                                      Text(data.Nama_Barang),
                                    ),
                                    DataCell(
                                      Text("${data.Jumlah_Barang}"),
                                    ),
                                    DataCell(
                                      Text(data.Tipe),
                                    ),
                                  ]))
                          .toList()),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}

Stream<List<Products>> readData() => FirebaseFirestore.instance
    .collection("Data_Products")
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Products.fromJson(doc.data())).toList());
