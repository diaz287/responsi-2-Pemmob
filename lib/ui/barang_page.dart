import 'package:flutter/material.dart';
import 'package:responsi_2/bloc/barang_bloc.dart';
import 'package:responsi_2/model/barang.dart';
import 'package:responsi_2/ui/barang_detail.dart';
import 'package:responsi_2/ui/barang_form.dart';
import 'package:responsi_2/ui/login_page.dart';
import 'package:responsi_2/bloc/logout_bloc.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({Key? key}) : super(key: key);
  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Bahan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarangForm()),
              );
              setState(() {}); // Refresh setelah tambah
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Barang>>(
        future: BarangBloc.getBarangs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBarang(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListBarang extends StatelessWidget {
  final List<Barang>? list;
  const ListBarang({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemBarang(barang: list![i]);
      },
    );
  }
}

class ItemBarang extends StatelessWidget {
  final Barang barang;
  const ItemBarang({Key? key, required this.barang}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(barang.namaBarang!),
        subtitle: Text(
          "Stok: ${barang.jumlah} | Exp: ${barang.tanggalKedaluwarsa}",
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarangDetail(barang: barang),
            ),
          );
        },
      ),
    );
  }
}
