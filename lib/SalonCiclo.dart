import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalonCiclo extends StatefulWidget {
  final int idCurso;

  SalonCiclo({required this.idCurso});

  @override
  _SalonCicloState createState() => _SalonCicloState(idCurso: idCurso);
}

class _SalonCicloState extends State<SalonCiclo> {
  final int idCurso;
  List<Map<String, dynamic>> salonesData = [];
  List<Map<String, dynamic>> docentesData = [];
  Map<int, List<Map<String, dynamic>>> horariosData = {};

  _SalonCicloState({required this.idCurso});

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDocentes();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/salon.php?idCurso=$idCurso'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        salonesData = List<Map<String, dynamic>>.from(jsonData);
      });

      // Llama a fetchHorarios para cada sección única en salonesData
      for (var salon in salonesData) {
        await fetchHorarios(salon['seccion']);
      }

    } else {
      throw Exception('Error al cargar la información de los salones');
    }
  }


  Future<void> fetchDocentes() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/docente.php'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        docentesData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      throw Exception('Error al cargar la información de los docentes');
    }
  }

  Future<void> fetchHorarios(int seccion) async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/horario.php?idCurso=$idCurso&seccion=$seccion'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        horariosData[seccion] = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      throw Exception('Error al cargar la información de los horarios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salones del Curso'),
      ),
      body: Center(
        child: salonesData.isNotEmpty
            ? ListView.builder(
          itemCount: salonesData.length,
          itemBuilder: (context, index) {
            final docenteData = docentesData.firstWhere(
                  (docente) => docente['id'] == salonesData[index]['id_docente'],
              orElse: () => {'codigo_docente': 'No encontrado', 'docente': 'No encontrado'},
            );

            List<Map<String, dynamic>> horariosDeSeccion = horariosData[salonesData[index]['seccion']] ?? [];
            List<Widget> widgetsHorarios = horariosDeSeccion.map((horario) {
              return Column(
                children: <Widget>[
                  Text('ID de Horario: ${horario['id']}'),
                  Text('Día: ${horario['dia']}'),
                  Text('Hora de inicio: ${horario['hora_inicio']}'),
                  Text('Hora de fin: ${horario['hora_fin']}'),
                  Text('Tipo de clase: ${horario['tipo_clase']}'),
                ],
              );
            }).toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ID del Curso: $idCurso',
                  style: TextStyle(fontSize: 24),
                ),
                Text('Aula: ${salonesData[index]['aula']}'),
                Text('Sección: ${salonesData[index]['seccion']}'),
                Text('ID del Docente: ${salonesData[index]['id_docente']}'),
                Text('Código del Docente: ${docenteData['codigo_docente']}'),
                Text('Nombre del Docente: ${docenteData['docente']}'),
              ]
                  + widgetsHorarios
                  + [Divider()],
            );
          },
        )
            : Text('Cargando datos...'),
      ),
    );
  }
}