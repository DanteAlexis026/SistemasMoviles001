import 'package:flutter/material.dart';
import 'Salon.dart';
import 'Cursos.dart';
import 'main.dart';
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
            title: Text("CURSOS"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Cursos(),
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
                  builder: (BuildContext context) => Salon(),
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