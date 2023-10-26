import 'package:flutter/material.dart';
import 'MenuLateral.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para verificar si el usuario y la contraseña son válidos
  Future<bool> _areCredentialsAuthorized(String user, String password) async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/alumnos.php'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> alumnosData = json.decode(response.body);

      for (var alumno in alumnosData) {
        if (alumno['usuario'] == user && alumno['contraseña'] == password) {
          return true; // Credenciales válidas
        }
      }
    }

    return false; // Credenciales no válidas
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FisInfo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 170,
                height: 170,
                color: Colors.white,
                child:  Image.asset('assets/simbolo.png'),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String user = _userController.text;
                  String password = _passwordController.text;

                  // Verificar las credenciales
                  if (await _areCredentialsAuthorized(user, password)) {
                    // Credenciales válidas, permitir el acceso
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MLateral(),
                      ),
                    );
                  } else if (user.isEmpty || password.isEmpty) {
                    // Los campos de usuario o contraseña están vacíos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                      ),
                    );
                  } else {
                    // Credenciales incorrectas
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Credenciales incorrectas'),
                      ),
                    );
                  }
                },
                child: Text('Ingresar'),
              )

            ],
          ),
        ),
      ),
    );
  }
}

