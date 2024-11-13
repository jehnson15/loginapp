import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  bool _validateForm() {
    if (_nameController.text.length < 3 || _nameController.text.length > 10) {
      _showSnackBar('El nombre debe tener entre 3 y 10 caracteres.');
      return false;
    }
    final emailPattern = RegExp(r'^[\w\.-]+@unah(\.edu)?\.hn$');
    if (!_emailController.text.contains('@') ||
        !emailPattern.hasMatch(_emailController.text)) {
      _showSnackBar(
          'Ingrese un correo válido con dominio unah.edu.hn o unah.hn');
      return false;
    }
    if (_emailController.text.split('@').length != 2) {
      _showSnackBar('El correo debe contener solo una @');
      return false;
    }
    final phonePattern = RegExp(r'^[39][0-9]{7}$');
    if (!phonePattern.hasMatch(_phoneController.text)) {
      _showSnackBar('El teléfono debe comenzar con 3 o 9 y tener 8 dígitos.');
      return false;
    }
    final passwordPattern = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*]).{8,}$');
    if (!passwordPattern.hasMatch(_passwordController.text)) {
      _showSnackBar(
          'La contraseña debe tener al menos 8 caracteres, una mayúscula y un carácter especial.');
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Las contraseñas no coinciden.');
      return false;
    }
    return true;
  }

  void _submitForm() {
    if (_validateForm()) {
      print('Nombre: ${_nameController.text}');
      print('Correo: ${_emailController.text}');
      print('Teléfono: ${_phoneController.text}');
      print('Contraseña: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Crear cuenta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese su nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Ingrese su correo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  hintText: 'Ingrese su teléfono',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  hintText: 'Repita su contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Registrar cuenta',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
