import 'package:flutter/material.dart';
import 'package:responsi_2/helpers/user_info.dart';
import 'package:responsi_2/ui/barang_page.dart';
import 'package:responsi_2/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    setState(() {
      page = (token != null) ? const BarangPage() : const LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi 2',
      theme: ThemeData(primarySwatch: Colors.green),
      home: page,
    );
  }
}
