import 'package:flutter/material.dart';
import 'Salon.dart';
import 'Cursos.dart';
import 'main.dart';

class MLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("FisInfo"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Botón 1 y descripción en una Card
          Container(
            width: 320,
            height: 320,
            color: Colors.white,
            child: Image.asset('assets/FisInfo.jpg'),
          ),

          SizedBox(height: 20), // Espacio en blanco

          Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => CursoListScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Cursos",
                      style: TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Aquí encontrarás los cursos y sus pre-requisitos respectivamente.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20), // Espacio en blanco

          // Botón 2 y descripción en una Card
          Card(
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SalonListScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Salon",
                      style: TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Aquí encontrarás el aula según el curso que lleves.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Column(
        children: <Widget>[
          // Encabezado del menú
          new UserAccountsDrawerHeader(
            accountName: Text("FISINFO"),
            accountEmail: Text("https://sistemas.unmsm.edu.pe"),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/4/46/UNMSM_Facultad_de_Ingenier%C3%ADa_de_Sistemas_e_Inform%C3%A1tica_2019_-_Vista_lateral.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Elementos de menú
          new ListTile(
            title: Text("INICIO"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => MLateral(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("CURSOS"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => CursoListScreen(),
                ),
              );
            },
          ),
          new ListTile(
            title: Text("SALON"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => SalonListScreen(),
                ),
              );
            },
          ),
          Spacer(),
          // Elemento de cierre de sesión
          new Divider(), // Línea divisoria
          new ListTile(
            title: Text("CERRAR SESIÓN"),
            leading: Icon(Icons.exit_to_app), // Icono de cerrar sesión
            onTap: () {
              // Aquí puedes agregar la lógica para cerrar la sesión
              // Luego, navega de nuevo a la pantalla de inicio de sesión (main.dart)
              Navigator.of(context).pop(); // Cierra el menú lateral
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => MyApp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}