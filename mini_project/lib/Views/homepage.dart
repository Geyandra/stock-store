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
  List<Products> sort = [];
  List<Products> selectedProducts = [];
  String searchresult = '';
  bool searchNotEmpty = true;
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
              search = datas
                  .where((element) => element.Nama_Barang.toLowerCase()
                      .contains(searchresult.toLowerCase()))
                  .toList();
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    width: double.infinity,
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          searchNotEmpty = true;
                          searchresult = value;
                          search = datas
                              .where((element) =>
                                  element.Nama_Barang.toLowerCase()
                                      .contains(searchresult.toLowerCase()))
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
                    height: 560,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          onSelectAll: (value) {
                            setState(() {
                              selectedProducts = value! ? datas : [];
                            });
                          },
                          sortColumnIndex: Columnindex,
                          sortAscending: asc,
                          columns: nametable
                              .map((String column) => getColumn(column, datas))
                              .toList(),
                          rows: searchNotEmpty
                              ? search
                                  .map((data) => getRowSearch(context, data))
                                  .toList()
                              : sort
                                  .map((data) => getRowSort(context, data))
                                  .toList()),
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(right: 160),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child:
                            Text("Select ${selectedProducts.length} Products")),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  DataRow getRowSort(BuildContext context, Products data) {
    return DataRow(
        selected: selectedProducts.contains(data),
        onSelectChanged: (value) {
          setState(() {
            final isAdd = value != null && value;
            isAdd ? selectedProducts.add(data) : selectedProducts.remove(data);
          });
        },
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
        ]);
  }

  DataRow getRowSearch(BuildContext context, Products data) {
    return DataRow(
        selected: selectedProducts.contains(data),
        onSelectChanged: (value) {
          setState(() {});
        },
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
        ]);
  }

  DataColumn getColumn(String column, List<Products> datas) {
    return DataColumn(
      label: Text(column),
      onSort: (columnIndex, ascending) {
        setState(() {
          sort = datas
              .where((element) => element.Nama_Barang.toLowerCase()
                  .contains(searchresult.toLowerCase()))
              .toList();
          searchNotEmpty = false;
          Columnindex = columnIndex;
          asc = ascending;
        });
        if (columnIndex == 0) {
          if (asc) {
            sort.sort(
              (a, b) => a.Nama_Barang.compareTo(b.Nama_Barang),
            );
          } else {
            sort.sort(
              (a, b) => b.Nama_Barang.compareTo(a.Nama_Barang),
            );
          }
        } else if (columnIndex == 1) {
          if (asc) {
            sort.sort(
              (a, b) => a.Jumlah_Barang.compareTo(b.Jumlah_Barang),
            );
          } else {
            sort.sort(
              (a, b) => b.Jumlah_Barang.compareTo(a.Jumlah_Barang),
            );
          }
        }
      },
    );
  }
}

Stream<List<Products>> readData() => FirebaseFirestore.instance
    .collection("Data_Products")
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Products.fromJson(doc.data())).toList());
