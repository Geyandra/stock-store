import 'package:flutter/material.dart';
import 'package:mini_project/create.dart';
import 'package:mini_project/details.dart';

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
        child: SizedBox(
          width: double.infinity,
          child: DataTable(columns: <DataColumn>[
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Stock"), numeric: true),
            DataColumn(label: Text("Satuan")),
          ], rows: [
            DataRow(
                onLongPress: () {
                  Navigator.of(context).pushNamed(DetailsProduct.nameRoute);
                },
                cells: [
                  DataCell(Text("Pensil 2B Staedler")),
                  DataCell(Text("120")),
                  DataCell(Text("PCS")),
                ]),
            DataRow(cells: [
              DataCell(Text("Pencil 2B Staedler")),
              DataCell(Text("10")),
              DataCell(Text("PAK")),
            ]),
          ]),
        ),
      ),
    );
  }
}
