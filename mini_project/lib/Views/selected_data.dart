import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Models/model_pesanan.dart';
import 'package:mini_project/Views/details.dart';
import 'package:mini_project/Widgets/field_order.dart';

class SelectedData extends StatefulWidget {
  const SelectedData({super.key});
  static const nameRoute = 'Selected Data';

  @override
  State<SelectedData> createState() => _SelectedDataState();
}

List<String> isexpand = [];
List<String> undone = [];
List<String> deletebutton = [];
List<Orders> search = [];
String searchresult = '';

final tokocontrol = TextEditingController();
final daerahcontrol = TextEditingController();
final perkiraancontrol = TextEditingController();
final pesanancontrol = TextEditingController();

class _SelectedDataState extends State<SelectedData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
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
                FieldOrder(
                  icon: Icons.list,
                  hint: 'Nama Barang Pesanan',
                  controller: pesanancontrol,
                  maxline: 5,
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
                              Pesanan: pesanancontrol.text);
                          createData(tambahbarang);
                          tokocontrol.text = '';
                          daerahcontrol.text = '';
                          perkiraancontrol.text = '';
                          pesanancontrol.text = '';
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
      ),
      body: StreamBuilder<List<Orders>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Ada Kesalahan! ${snapshot.hasError}");
          } else if (snapshot.hasData) {
            final datas = snapshot.data!;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchresult = value;
                        search = datas
                            .where((element) =>
                                element.Nama_Toko.toLowerCase()
                                    .contains(searchresult.toLowerCase()) ||
                                element.Daerah.toLowerCase()
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
                Expanded(
                  child: ListView.builder(
                    itemCount: search.length,
                    itemBuilder: (context, index) => InkWell(
                      onLongPress: () {
                        if (deletebutton
                            .contains(search[index].Id.toString())) {
                          deletebutton.remove(search[index].Id.toString());
                        } else {
                          deletebutton.add(search[index].Id.toString());
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.blue)),
                        height: isexpand.contains(search[index].Id.toString())
                            ? 430
                            : 75,
                        child: isexpand.contains(search[index].Id.toString())
                            ? ExpandedContainer(search, index, context)
                            : NormalContainer(search, index),
                      ),
                    ),
                  ),
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
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 100,
              color: Colors.blue.shade100,
              child: ListTile(
                title: Text("Pesanan"),
                subtitle: Text(
                  datas[index].Pesanan,
                  style: TextStyle(color: Colors.black),
                ),
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
            : Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
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
                ),
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

Future createData(Orders data) async {
  final docData = FirebaseFirestore.instance.collection("Data_Pesanan").doc();
  data.Id = docData.id;
  final json = data.toJson();
  docData.set(json);
}
