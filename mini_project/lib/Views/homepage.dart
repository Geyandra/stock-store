import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/add_data.dart';
import 'package:mini_project/Views/create.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  static const nameRoute = 'Homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddProduct.nameRoute);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Products>>(
          stream: readData(),
          builder: (context, snapshot){
            if (snapshot.hasError) {
              return Text("Ada Kesalahan! ${snapshot.hasError}");
            } else if (snapshot.hasData) {
              final datas = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: DataTable(columns:<DataColumn>[
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Stock"), numeric: true),
            DataColumn(label: Text("Satuan")),
          ],  
          rows: datas.map((data) => 
          DataRow(
            onLongPress: (){
            },
            cells: [
            DataCell(Text(data.Nama_Barang),),
            DataCell(Text("${data.Jumlah_Barang}"),),
            DataCell(Text(data.Tipe),),
          ])
          ).toList()
          ),
              );

            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }
}



Stream<List<Products>> readData() => FirebaseFirestore.instance
    .collection("Data_Products")
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Products.fromJson(doc.data())).toList());