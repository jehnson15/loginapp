import 'package:flutter/material.dart';
import 'package:loginapp/services/user_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false; // Estado para mostrar/ocultar la contraseña
  bool _confirmPasswordVisible =
      false; // Estado para mostrar/ocultar confirmar contraseña

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _validateForm() {
    if (_nameController.text.length < 3 || _nameController.text.length > 10) {
      _showSnackBar('El nombre debe tener entre 3 y 10 caracteres.');
      return false;
    }
    final emailPattern = RegExp(r'^[\w\.-]+@unah(\.edu)?\.hn$');
    if (!emailPattern.hasMatch(_emailController.text)) {
      _showSnackBar(
          'Ingrese un correo válido con dominio unah.edu.hn o unah.hn');
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
      UserDatabase().registerUser(
        _emailController.text,
        _passwordController.text,
      );
      _showSnackBar('Registro exitoso');
      Navigator.pop(context); // Regresa a la pantalla de inicio de sesión
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            children: [
              const Text(
                'Crear cuenta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese su nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Ingrese su correo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  hintText: 'Ingrese su teléfono',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  hintText: 'Repita su contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
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
