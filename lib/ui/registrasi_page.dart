import 'package:flutter/material.dart';
import 'package:responsi_2/bloc/registrasi_bloc.dart';
import 'package:responsi_2/widget/success_dialog.dart';
import 'package:responsi_2/widget/warning_dialog.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrasi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field("Nama", _namaTextboxController),
              _field("Email", _emailTextboxController, isEmail: true),
              _field("Password", _passwordTextboxController, isPassword: true),
              _konfirmasiPassword(),
              const SizedBox(height: 20),
              _buttonRegistrasi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool isPassword = false,
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: ctrl,
      obscureText: isPassword,
      decoration: InputDecoration(labelText: label),
      validator: (val) {
        if (val!.isEmpty) return "Wajib diisi";
        if (isEmail && !val.contains('@')) return "Email tidak valid";
        if (isPassword && val.length < 6) return "Min 6 karakter";
        return null;
      },
    );
  }

  Widget _konfirmasiPassword() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      validator: (val) {
        if (val != _passwordTextboxController.text)
          return "Password tidak sama";
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return ElevatedButton(
      child: const Text("Registrasi"),
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          setState(() => _isLoading = true);
          RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text,
          ).then(
            (value) {
              showDialog(
                context: context,
                builder: (context) => SuccessDialog(
                  description: "Registrasi Berhasil",
                  okClick: () => Navigator.pop(context),
                ),
              );
            },
            onError: (error) {
              showDialog(
                context: context,
                builder: (context) =>
                    const WarningDialog(description: "Registrasi Gagal"),
              );
            },
          );
          setState(() => _isLoading = false);
        }
      },
    );
  }
}
