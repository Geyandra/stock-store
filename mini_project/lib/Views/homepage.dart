import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_pesanan.dart';
import 'package:mini_project/Models/model_products.dart';
import 'package:mini_project/Providers/orders_provider.dart';
import 'package:mini_project/Views/add_product.dart';
import 'package:mini_project/Views/product_details.dart';
import 'package:mini_project/Widgets/confirm_button_dialog.dart';
import 'package:mini_project/Widgets/field_order.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  static const nameRoute = 'Homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final tokocontrol = TextEditingController();
  final daerahcontrol = TextEditingController();
  final perkiraancontrol = TextEditingController();
  var name;
  int? Columnindex;
  bool asc = false;
  List<Products> search = [];
  String searchresult = '';
  List<Products> sort = [];
  List<Products> selectedProducts = [];
  bool searchNotEmpty = true;
  final nametable = ["Nama Barang", "Stock", "Satuan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(transition(AddProduct.nameRoute, AddProduct()));
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
              return Body(datas, context);
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

  Column Body(List<Products> datas, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchNotEmpty = true;
                searchresult = value;
                search = datas
                    .where((element) => element.Nama_Barang.toLowerCase()
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
                    ? search.map((data) => getRowSearch(context, data)).toList()
                    : sort.map((data) => getRowSort(context, data)).toList()),
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.only(right: 160),
          child: ElevatedButton(
              onPressed: () {
                name = selectedProducts.map((e) => e.Nama_Barang).join(', ');
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(
                      "Data yang akan ditambahkan",
                      textAlign: TextAlign.center,
                    ),
                    children: [
                      FieldOrder(
                        icon: Icons.store_mall_directory,
                        hint: 'Nama Toko',
                        controller: tokocontrol,
                      ),
                      FieldOrder(
                        icon: Icons.location_on,
                        hint: 'Daerah',
                        controller: daerahcontrol,
                      ),
                      FieldOrder(
                        icon: Icons.download_sharp,
                        hint: 'Perkiraan Datang',
                        controller: perkiraancontrol,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RGButtonDialog(
                              text: "Tambah",
                              color: Colors.green.shade300,
                              pressed: () {
                                final tambahbarang = Orders(
                                    Nama_Toko: tokocontrol.text,
                                    Daerah: daerahcontrol.text,
                                    Perkiraan_Datang: perkiraancontrol.text,
                                    Pesanan: name);
                                Provider.of<OrdersProvider>(context, listen: false).addProduct(tambahbarang);
                                tokocontrol.text = '';
                                daerahcontrol.text = '';
                                perkiraancontrol.text = '';
                                setState(() {
                                  selectedProducts = [];
                                });
                                Navigator.of(context).pop();
                              }),
                          RGButtonDialog(
                              text: "Batal",
                              color: Colors.red.shade300,
                              pressed: () {
                                tokocontrol.text = '';
                                daerahcontrol.text = '';
                                perkiraancontrol.text = '';
                                Navigator.of(context).pop();
                              }),
                        ],
                      )
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              child: Text("Select ${selectedProducts.length} Products")),
        ),
      ],
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
          Navigator.of(context).push(
              transition(DetailsProduct.nameRoute, DetailsProduct(data: data)));
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
          Navigator.of(context).push(
              transition(DetailsProduct.nameRoute, DetailsProduct(data: data)));
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

  PageRouteBuilder<dynamic> transition(routesname, page) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routesname),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.fastLinearToSlowEaseIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

Stream<List<Products>> readData() => FirebaseFirestore.instance
    .collection("Data_Products")
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Products.fromJson(doc.data())).toList());


