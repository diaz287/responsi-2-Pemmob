class Barang {
  int? id;
  String? namaBarang;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  String? tanggalKedaluwarsa;

  Barang({
    this.id,
    this.namaBarang,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.tanggalKedaluwarsa,
  });

  factory Barang.fromJson(Map<String, dynamic> obj) {
    return Barang(
      id: int.tryParse(obj['id'].toString()),
      namaBarang: obj['nama_barang'],
      harga: int.tryParse(obj['harga'].toString()),
      jumlah: int.tryParse(obj['jumlah'].toString()),
      tanggalMasuk: obj['tanggal_masuk'],
      tanggalKedaluwarsa: obj['tanggal_kedaluwarsa'],
    );
  }
}
