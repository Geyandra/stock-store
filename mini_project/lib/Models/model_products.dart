class Products {
  String Id;
  String Barcode;
  String Nama_Barang;
  int Jumlah_Barang;
  String Tipe;
  int Harga_Beli;
  int Harga_Jual;
  String Tanggal_Masuk;
  String Tanggal_Edit;

  Products({
    this.Id = '',
    required this.Barcode,
    required this.Nama_Barang,
    required this.Jumlah_Barang,
    required this.Tipe,
    required this.Harga_Beli,
    required this.Harga_Jual,
    required this.Tanggal_Masuk,
    required this.Tanggal_Edit,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Barcode": Barcode,
        "Nama_Barang": Nama_Barang,
        "Jumlah_Barang": Jumlah_Barang,
        "Tipe": Tipe,
        "Harga_Beli": Harga_Beli,
        "Harga_Jual": Harga_Jual,
        "Tanggal_Masuk": Tanggal_Masuk,
        "Tanggal_Edit": Tanggal_Edit,
      };

  static Products fromJson(Map<String, dynamic> json) => Products(
      Id: json["Id"],
      Barcode: json["Barcode"],
      Nama_Barang: json["Nama_Barang"],
      Jumlah_Barang: json["Jumlah_Barang"],
      Tipe: json["Tipe"],
      Harga_Beli: json["Harga_Beli"],
      Harga_Jual: json["Harga_Jual"],
      Tanggal_Masuk: json["Tanggal_Masuk"],
      Tanggal_Edit: json["Tanggal_Edit"]);
}
