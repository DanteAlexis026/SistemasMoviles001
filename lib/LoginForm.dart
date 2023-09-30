import 'package:flutter/material.dart';
import 'MenuLateral.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para verificar si el usuario y la contraseña son válidos
  bool _areCredentialsAuthorized(String user, String password) {
    for (var credentials in DemoData.authorizedUsers) {
      if (credentials['usuario'] == user &&
          credentials['contraseña'] == password) {
        return true; // Credenciales válidas
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
              Image.network(
                'https://industrial.unmsm.edu.pe/wp-content/uploads/2020/11/icono.png',
                height: 150.0,
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
                onPressed: () {
                  String user = _userController.text;
                  String password = _passwordController.text;

                  // Verificar las credenciales
                  if (_areCredentialsAuthorized(user, password)) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemoData {
  static final List<Map<String, String>> authorizedUsers = [
    {
      'usuario': 'usuario1',
      'contraseña': 'contraseña1',
    },
    {
      'usuario': 'usuario2',
      'contraseña': 'contraseña2',
    },
    // Agrega más usuarios autorizados según sea necesario
  ];
}
