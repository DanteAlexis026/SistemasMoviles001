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
  late String nombreCurso = '';

  _SalonCicloState({required this.idCurso});

  @override
  void initState() {
    super.initState();
    fetchNombreCurso();
    fetchData();
    fetchDocentes();
  }

  Future<void> fetchNombreCurso() async {
    final response = await http.get(
      Uri.parse('https://servidorwebcito.000webhostapp.com/cursos.php?id_curso=${widget.idCurso}'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        nombreCurso = jsonData[0]['nombre']; // Obtén el nombre del curso
      });
    } else {
      throw Exception('Error al cargar el nombre del curso');
    }
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
        title: Text(
        nombreCurso,
        style: TextStyle(fontSize: 15), // Ajusta el tamaño de fuente según tu preferencia
    )),
      body: Center(
        child: salonesData.isNotEmpty
            ? DataTable(
          dataRowHeight: 40.0, // Altura de las filas
          columnSpacing: 10.0, // Espacio entre columnas
          columns: <DataColumn>[
            DataColumn(label: Center(child: Text('Sección'))),
            DataColumn(label: Text('Docente')),
            DataColumn(label: Center(child: Text('Aula')), numeric: true),
            DataColumn(label: Center(child: Text('Horarios')), numeric: true),
          ],
          rows: salonesData.map((salon) {
            final docenteData = docentesData[salon['id_docente']] ?? {
              'docente': 'No encontrado',
            };
            final horariosDeSeccion = horariosData[salon['seccion']] ?? [];

            return DataRow(cells: [
              DataCell(Center(child: Text(salon['seccion'].toString()))),
              DataCell(
                Text(docenteData['docente'].replaceAll(', ', ',\n')),
              ),
              DataCell(Center(child: Text(salon['aula']))),
              DataCell(
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showHorariosDialog(horariosDeSeccion);
                    },
                    child: Text('Ver'),
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
            child: DataTable(
              dataRowHeight: 40.0, // Altura de las filas
              columnSpacing: 10.0, // Espacio entre columnas
              columns: [
                DataColumn(label: Text('Día')),
                DataColumn(label: Text('Horario')),
                DataColumn(label: Text('Tipo de clase')),
              ],
              rows: horarios.map((horario) {
                final horaInicio = horario['hora_inicio'];
                final horaFin = horario['hora_fin'];
                final horarioRango = '$horaInicio - $horaFin';

                return DataRow(cells: [
                  DataCell(Text('${horario['dia']}')),
                  DataCell(Text(horarioRango)),
                  DataCell(Text('${horario['tipo_clase']}')),
                ]);
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
