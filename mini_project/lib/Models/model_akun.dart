class Accounts {
  String Id;
  String Nama;
  String Email;
  String Password;
  Accounts({
    this.Id = '',
    required this.Nama,
    required this.Email,
    required this.Password,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Nama": Nama,
        "Email": Email,
        "Password": Password,
      };

  static Accounts fromJson(Map<String, dynamic> json) => Accounts(
      Id: json["Id"],
      Nama: json["Nama"],
      Email: json["Email"],
      Password: json["Password"]);
}
