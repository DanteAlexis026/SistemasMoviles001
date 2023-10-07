import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Curso {
  final String id;
  final String nombre;
  final String codigoCurso;
  final String descripcion;
  final String prerrequisito;
  final String profesores;

  Curso({
    required this.id,
    required this.nombre,
    required this.codigoCurso,
    required this.descripcion,
    required this.prerrequisito,
    required this.profesores,
  });

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nombre: json['nombre'],
      codigoCurso: json['codigo_curso'],
      descripcion: json['descripcion'],
      prerrequisito: json['prerrequisito'],
      profesores: json['profesores'],
    );
  }
}

class ObtenerCursos extends StatefulWidget {
  @override
  _ObtenerCursosState createState() => _ObtenerCursosState();
}

class _ObtenerCursosState extends State<ObtenerCursos> {
  List<Curso> cursos = [];

  Future<List<Curso>> obtenerCursos() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/cursos.php'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) => Curso.fromJson(data)).toList();
    } else {
      throw Exception('Error al cargar los cursos');
    }
  }

  @override
  void initState() {
    super.initState();
    // Llama a obtenerCursos() y actualiza la lista de cursos
    obtenerCursos().then((cursosObtenidos) {
      setState(() {
        cursos = cursosObtenidos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos desde el servidor'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cursos[index].nombre),
            subtitle: Text(cursos[index].descripcion),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ObtenerCursos(),
  ));
}