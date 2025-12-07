class ApiUrl {
  static const String baseUrl = 'http://192.168.1.10:8080';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBarang = baseUrl + '/barang';
  static const String createBarang = baseUrl + '/barang';

  static String updateBarang(int id) => baseUrl + '/barang/' + id.toString();
  static String deleteBarang(int id) => baseUrl + '/barang/' + id.toString();
}
