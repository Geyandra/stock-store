class Orders {
  String Id;
  String Nama_Toko;
  String Daerah;
  String Perkiraan_Datang;
  String Pesanan;
  Orders({
    this.Id = '',
    required this.Nama_Toko,
    required this.Daerah,
    required this.Perkiraan_Datang,
    required this.Pesanan,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Nama_Toko": Nama_Toko,
        "Daerah": Daerah,
        "Perkiraan_Datang": Perkiraan_Datang,
        "Pesanan": Pesanan,
      };

  static Orders fromJson(Map<String, dynamic> json) => Orders(
      Id: json["Id"],
      Nama_Toko: json["Nama_Toko"],
      Daerah: json["Daerah"],
      Perkiraan_Datang: json["Perkiraan_Datang"],
      Pesanan: json["Pesanan"]);
}
