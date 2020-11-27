import 'dart:convert';

Pengaduan pengaduanFromJson(String str) => Pengaduan.fromJson(json.decode(str));

String pengaduanToJson(Pengaduan data) => json.encode(data.toJson());

class Pengaduan {
  Pengaduan({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  List<Datum> data;

  factory Pengaduan.fromJson(Map<String, dynamic> json) => Pengaduan(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.idPengaduan,
    this.nik,
    this.tglPengaduan,
    this.laporan,
    this.tglTanggapan,
    this.tanggapan,
    this.status,
  });

  int idPengaduan;
  int nik;
  DateTime tglPengaduan;
  String laporan;
  DateTime tglTanggapan;
  String tanggapan;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPengaduan: json["id_pengaduan"] == null ? null : json["id_pengaduan"],
        nik: json["nik"] == null ? null : json["nik"],
        tglPengaduan: json["tgl_pengaduan"] == null
            ? null
            : DateTime.parse(json["tgl_pengaduan"]),
        laporan: json["laporan"] == null ? null : json["laporan"],
        tglTanggapan: json["tgl_tanggapan"] == null
            ? null
            : DateTime.parse(json["tgl_tanggapan"]),
        tanggapan: json["tanggapan"] == null ? null : json["tanggapan"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengaduan": idPengaduan == null ? null : idPengaduan,
        "nik": nik == null ? null : nik,
        "tgl_pengaduan":
            tglPengaduan == null ? null : tglPengaduan.toIso8601String(),
        "laporan": laporan == null ? null : laporan,
        "tgl_tanggapan":
            tglTanggapan == null ? null : tglTanggapan.toIso8601String(),
        "tanggapan": tanggapan == null ? null : tanggapan,
        "status": status == null ? null : status,
      };
}
