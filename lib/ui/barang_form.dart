import 'package:flutter/material.dart';
import 'package:responsi_2/bloc/barang_bloc.dart';
import 'package:responsi_2/model/barang.dart';

class BarangForm extends StatefulWidget {
  Barang? barang;
  BarangForm({Key? key, this.barang}) : super(key: key);
  @override
  _BarangFormState createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH INVENTARIS";
  String tombolSubmit = "SIMPAN";

  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _masukController = TextEditingController();
  final _expController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      judul = "UBAH INVENTARIS";
      tombolSubmit = "UBAH";
      _namaController.text = widget.barang!.namaBarang!;
      _hargaController.text = widget.barang!.harga.toString();
      _jumlahController.text = widget.barang!.jumlah.toString();
      _masukController.text = widget.barang!.tanggalMasuk!;
      _expController.text = widget.barang!.tanggalKedaluwarsa!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field("Nama Barang", _namaController),
              _field("Harga", _hargaController, number: true),
              _field("Jumlah", _jumlahController, number: true),
              _field("Tanggal Masuk", _masukController),
              _field("Tanggal Kedaluwarsa", _expController),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(tombolSubmit),
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) simpan();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool number = false,
  }) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(labelText: label),
      keyboardType: number ? TextInputType.number : TextInputType.text,
      validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
    );
  }

  void simpan() {
    setState(() => _isLoading = true);
    Barang obj = Barang(id: widget.barang?.id);
    obj.namaBarang = _namaController.text;
    obj.harga = int.parse(_hargaController.text);
    obj.jumlah = int.parse(_jumlahController.text);
    obj.tanggalMasuk = _masukController.text;
    obj.tanggalKedaluwarsa = _expController.text;

    if (widget.barang != null) {
      BarangBloc.updateBarang(barang: obj).then((val) => navBack());
    } else {
      BarangBloc.addBarang(barang: obj).then((val) => navBack());
    }
  }

  void navBack() {
    Navigator.pop(context); // Kembali ke halaman sebelumnya
  }
}
