import 'package:flutter/material.dart';
import 'package:responsi_2/bloc/login_bloc.dart';
import 'package:responsi_2/helpers/user_info.dart';
import 'package:responsi_2/ui/barang_page.dart';
import 'package:responsi_2/ui/registrasi_page.dart';
import 'package:responsi_2/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  if (_formKey.currentState!.validate() && !_isLoading) {
                    setState(() => _isLoading = true);
                    LoginBloc.login(
                      email: _emailCtrl.text,
                      password: _passCtrl.text,
                    ).then(
                      (value) async {
                        if (value.code == 200) {
                          await UserInfo().setToken(value.token!);
                          await UserInfo().setUserID(value.userID!);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarangPage(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const WarningDialog(description: "Login Gagal"),
                          );
                        }
                      },
                      onError: (error) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const WarningDialog(description: "Login Gagal"),
                        );
                      },
                    );
                    setState(() => _isLoading = false);
                  }
                },
              ),
              TextButton(
                child: const Text("Registrasi"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrasiPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
