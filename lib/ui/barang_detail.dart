import 'package:flutter/material.dart';
import 'package:responsi_2/bloc/barang_bloc.dart';
import 'package:responsi_2/model/barang.dart';
import 'package:responsi_2/ui/barang_form.dart';
import 'package:responsi_2/ui/barang_page.dart';

class BarangDetail extends StatelessWidget {
  final Barang barang;
  const BarangDetail({Key? key, required this.barang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Barang')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama : ${barang.namaBarang}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Harga : Rp ${barang.harga}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Jumlah : ${barang.jumlah}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Tgl Masuk : ${barang.tanggalMasuk}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Tgl Exp : ${barang.tanggalKedaluwarsa}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("EDIT"),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BarangForm(barang: barang),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("DELETE"),
                  onPressed: () => confirmHapus(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void confirmHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text("Yakin hapus?"),
        actions: [
          TextButton(
            child: const Text("Ya"),
            onPressed: () {
              BarangBloc.deleteBarang(id: barang.id).then((val) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => const BarangPage()),
                  (r) => false,
                );
              });
            },
          ),
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}
