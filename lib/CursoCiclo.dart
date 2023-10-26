import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CursoCiclo extends StatefulWidget {
  final int id_curso;

  CursoCiclo({required this.id_curso});

  @override
  _CursoCicloState createState() => _CursoCicloState();
}

class _CursoCicloState extends State<CursoCiclo> {
  late String nombre = ''; // Valor predeterminado inicial
  late String codigo_curso = ''; // Valor predeterminado inicial
  late String descripcion = ''; // Valor predeterminado inicial
  late String prerrequisito = ''; // Valor predeterminado inicial

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/cursos.php?id_curso=${widget.id_curso}'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        nombre = jsonData[0]['nombre'];
        codigo_curso = jsonData[0]['codigo_curso'];
        descripcion = jsonData[0]['descripcion'];
        prerrequisito = jsonData[0]['prerrequisito'];
      });
    } else {
      throw Exception('Error al cargar el curso');
    }
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Cambio de color a negro
        ),
      ),
    );
  }

  Widget buildIndentedText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(text, style: TextStyle(fontSize: 15.0)),
        ),
        SizedBox(height: 8.0), // Línea de espacio al final del texto
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Información del Curso:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black, // Cambio de color a negro
              ),
            ),
            SizedBox(height: 8.0),

            buildTitle("Código:"),
            buildIndentedText(codigo_curso),

            buildTitle("Descripción:"),
            buildIndentedText(descripcion),

            buildTitle("Prerrequisito:"),
            buildIndentedText(prerrequisito),
          ],
        ),
      ),
    );
  }
}
