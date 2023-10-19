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
  Map<int, List<Map<String, dynamic>>> horariosData = {};
  Map<int, Map<String, dynamic>> docentesData = {};

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
        docentesData = Map.fromIterable(
          jsonData,
          key: (docente) => docente['id'],
          value: (docente) => docente,
        );
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
            ? DataTable(
          columns: <DataColumn>[
            DataColumn(label: Center(child: Text('Sección'))),
            DataColumn(label: Center(child: Text('Código del Docente'))),
            DataColumn(label: Text('Nombre del Docente')),
            DataColumn(label: Center(child: Text('Aula')), numeric: true),
            DataColumn(label: Center(child: Text('Horarios')), numeric: true),
          ],
          rows: salonesData.map((salon) {
            final docenteData = docentesData[salon['id_docente']] ?? {
              'codigo_docente': 'No encontrado',
              'docente': 'No encontrado',
            };
            final horariosDeSeccion = horariosData[salon['seccion']] ?? [];

            return DataRow(cells: [
              DataCell(Center(child: Text(salon['seccion'].toString()))),
              DataCell(Text(docenteData['codigo_docente'])),
              DataCell(Text(docenteData['docente'])),
              DataCell(Center(child: Text(salon['aula']))),
              DataCell(
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showHorariosDialog(horariosDeSeccion);
                    },
                    child: Text('Ver Horarios'),
                  ),
                ),
              ),
            ]);
          }).toList(),
        )
            : Text('Cargando datos...'),
      ),
    );
  }

  void showHorariosDialog(List<Map<String, dynamic>> horarios) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Horarios'),
          content: SingleChildScrollView(
            child: Column(
              children: horarios.map((horario) {
                return Column(
                  children: <Widget>[
                    Text('ID de Horario: ${horario['id']}'),
                    Text('Día: ${horario['dia']}'),
                    Text('Hora de inicio: ${horario['hora_inicio']}'),
                    Text('Hora de fin: ${horario['hora_fin']}'),
                    Text('Tipo de clase: ${horario['tipo_clase']}'),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
