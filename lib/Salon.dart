import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SalonCiclo.dart';

class Curso {
  final String nombre;
  final int id_curso;
  final int id_ciclo;

  Curso({required this.nombre, required this.id_curso, required this.id_ciclo});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nombre: json['nombre'],
      id_curso: json['id'],
      id_ciclo: json['id_ciclo'], // Asignar el valor de id_ciclo desde los datos
    );
  }
}

class SalonListScreen extends StatefulWidget {
  @override
  _SalonListScreenState createState() => _SalonListScreenState();

}

class _SalonListScreenState extends State<SalonListScreen> {
  List<Curso> cursos = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/cursos.php'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        cursos = jsonData.map<Curso>((item) => Curso.fromJson(item)).toList();
      });
    } else {
      throw Exception('Error al cargar los cursos');
    }
  }

  List<Curso> getCursosPrimerCiclo() {
    return cursos.where((curso) => curso.id_ciclo == 1).toList();
  }

  List<Curso> getCursosSegundoCiclo() {
    return cursos.where((curso) => curso.id_ciclo == 2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salones'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Primer Ciclo'),
            children: getCursosPrimerCiclo().map((curso) {
              return ListTile(
                title: Text(curso.nombre),
                onTap: () {
                  // Navegar a la pantalla de detalle del curso
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonCiclo(idCurso: curso.id_curso),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          ExpansionTile(
            title: Text('Segundo Ciclo'),
            children: getCursosSegundoCiclo().map((curso) {
              return ListTile(
                title: Text(curso.nombre),
                onTap: () {
                  // Navegar a la pantalla de detalle del curso
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonCiclo(idCurso: curso.id_curso),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
