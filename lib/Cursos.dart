import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CursoCiclo.dart';

class Curso {
  final String nombre;
  final String descripcion;
  final int id_curso;

  Curso({required this.nombre, required this.descripcion, required this.id_curso});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cursos'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cursos[index].nombre),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CursoCiclo(id_curso: cursos[index].id_curso),
                ),
              );
            },
          );
        },
      ),
    );
  }
}