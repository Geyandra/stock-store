import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_pesanan.dart';

class SelectedData extends StatefulWidget {
  const SelectedData({super.key});
  static const nameRoute = 'Selected Data';

  @override
  State<SelectedData> createState() => _SelectedDataState();
}

List<Orders> orders = [];
List<String> isdone = [];
List<String> isexpand = [];
List<String> undone = [];
List<String> deletebutton = [];

class _SelectedDataState extends State<SelectedData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Orders>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Ada Kesalahan! ${snapshot.hasError}");
          } else if (snapshot.hasData) {
            final datas = snapshot.data!;
            orders = datas;
            return ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: () {
                  if (deletebutton.contains(datas[index].Id.toString())) {
                    deletebutton.remove(datas[index].Id.toString());
                  } else {
                    deletebutton.add(datas[index].Id.toString());
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.blue)),
                  height:
                      isexpand.contains(datas[index].Id.toString()) ? 400 : 75,
                  child: isexpand.contains(datas[index].Id.toString())
                      ? ExpandedContainer(datas, index, context)
                      : NormalContainer(datas, index),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Column NormalContainer(List<Orders> datas, int index) {
    return Column(
      children: [
        ListTile(
          leading: undone.contains(datas[index].Id.toString())
              ? Icon(
                  Icons.done_all,
                  color: Colors.green,
                )
              : Icon(
                  Icons.highlight_remove,
                  color: Colors.red,
                ),
          title: Text(
            datas[index].Nama_Toko,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            datas[index].Daerah,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  isexpand.add(datas[index].Id);
                });
              },
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              )),
        ),
      ],
    );
  }

  SingleChildScrollView ExpandedContainer(
      List<Orders> datas, int index, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: undone.contains(datas[index].Id.toString())
                ? Icon(
                    Icons.done_all,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.highlight_remove,
                    color: Colors.red,
                  ),
            title: Text(
              datas[index].Nama_Toko,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              datas[index].Daerah,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isexpand.remove(datas[index].Id);
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_up,
                  color: Colors.blue,
                )),
          ),
          Divider(
            color: Colors.blue.shade300,
          ),
          ListOrder(
            title: 'Nama Toko',
            trailing: datas[index].Nama_Toko,
          ),
          ListOrder(
            title: 'Daerah Toko',
            trailing: datas[index].Daerah,
          ),
          ListOrder(
            title: 'Estimasi Datang',
            trailing: datas[index].Perkiraan_Datang,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            color: Colors.blue.shade100,
            child: ListTile(
              title: Text("Pesanan"),
              subtitle: Text(
                datas[index].Pesanan,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ButtonPesanan(datas, index, context),
        ],
      ),
    );
  }

  Container ButtonPesanan(List<Orders> datas, int index, BuildContext context) {
    return Container(
        child: deletebutton.contains(datas[index].Id.toString())
            ? Container(
                margin: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Delete"),
                          content:
                              Text("Apakah Anda yakin ingin menghapus data ?"),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      deleteData(datas[index].Id);
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade300),
                                    child: Text("Yakin")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade300),
                                    child: Text("Batal")),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(letterSpacing: 1.4),
                    )),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    // width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade300),
                        onPressed: () {
                          setState(() {
                            undone.add(datas[index].Id);
                          });
                        },
                        child: Text(
                          "Diterima",
                          style: TextStyle(letterSpacing: 1.4),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    // width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade300),
                        onPressed: () {
                          setState(() {
                            undone.remove(datas[index].Id);
                          });
                        },
                        child: Text(
                          "Batal",
                          style: TextStyle(letterSpacing: 1.4),
                        )),
                  ),
                ],
              ));
  }
}

class ListOrder extends StatelessWidget {
  final String title;
  final String trailing;
  ListOrder({Key? key, required this.title, required this.trailing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(title),
        trailing: Text(
          trailing,
          style: TextStyle(color: Color.fromARGB(228, 0, 0, 0)),
        ),
      ),
    );
  }
}

Stream<List<Orders>> readData() => FirebaseFirestore.instance
    .collection("Data_Pesanan")
    .snapshots()
    .map((snapshots) =>
        snapshots.docs.map((doc) => Orders.fromJson(doc.data())).toList());

Future deleteData(String data) async {
  final docData =
      FirebaseFirestore.instance.collection("Data_Pesanan").doc(data);
  docData.delete();
}
