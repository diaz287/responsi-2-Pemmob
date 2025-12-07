import 'dart:convert';
import 'package:responsi_2/helpers/api.dart';
import 'package:responsi_2/helpers/api_url.dart';
import 'package:responsi_2/model/barang.dart';

class BarangBloc {
  static Future<List<Barang>> getBarangs() async {
    String apiUrl = ApiUrl.listBarang;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBarang = (jsonObj as Map<String, dynamic>)['data'];
    List<Barang> barangs = [];
    for (int i = 0; i < listBarang.length; i++) {
      barangs.add(Barang.fromJson(listBarang[i]));
    }
    return barangs;
  }

  static Future addBarang({Barang? barang}) async {
    String apiUrl = ApiUrl.createBarang;
    var body = {
      "nama_barang": barang!.namaBarang,
      "harga": barang.harga.toString(),
      "jumlah": barang.jumlah.toString(),
      "tanggal_masuk": barang.tanggalMasuk,
      "tanggal_kedaluwarsa": barang.tanggalKedaluwarsa,
    };
    var response = await Api().post(apiUrl, body);
    return json.decode(response.body)['status'];
  }

  static Future updateBarang({required Barang barang}) async {
    String apiUrl = ApiUrl.updateBarang(barang.id!);
    var body = {
      "nama_barang": barang.namaBarang,
      "harga": barang.harga.toString(),
      "jumlah": barang.jumlah.toString(),
      "tanggal_masuk": barang.tanggalMasuk,
      "tanggal_kedaluwarsa": barang.tanggalKedaluwarsa,
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    return json.decode(response.body)['status'];
  }

  static Future<bool> deleteBarang({int? id}) async {
    String apiUrl = ApiUrl.deleteBarang(id!);
    var response = await Api().delete(apiUrl);
    return (json.decode(response.body) as Map<String, dynamic>)['data'];
  }
}
