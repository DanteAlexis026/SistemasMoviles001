import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CursoCiclo.dart';

class Curso {
  final String nombre;
  final int id_curso;

  Curso({required this.nombre, required this.id_curso});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nombre: json['nombre'],
      id_curso: json['id'],
    );
  }
}

class CursoListScreen extends StatefulWidget {
  @override
  _CursoListScreenState createState() => _CursoListScreenState();
}

class _CursoListScreenState extends State<CursoListScreen> {
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
    return cursos.where((curso) => curso.id_curso >= 1 && curso.id_curso <= 7).toList();
  }

  List<Curso> getCursosSegundoCiclo() {
    return cursos.where((curso) => curso.id_curso >= 8 && curso.id_curso <= 15).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cursos'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Primer Ciclo'),
            children: getCursosPrimerCiclo().map((curso) {
              return ListTile(
                title: Text(curso.nombre),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CursoCiclo(id_curso: curso.id_curso),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CursoCiclo(id_curso: curso.id_curso),
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
