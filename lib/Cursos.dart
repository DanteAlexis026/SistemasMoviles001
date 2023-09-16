import 'package:flutter/material.dart';
import 'MenuLateral.dart';

class Curso {
  final String nombre;
  final String descripcion; // Agregamos una descripción
  Curso(this.nombre, this.descripcion);
}

class Ciclo {
  final String nombre;
  final List<Curso> cursos;
  Ciclo(this.nombre, this.cursos);
}

class Cursos extends StatelessWidget {
  final List<Ciclo> ListaDeCursos = [
    Ciclo("Primer Ciclo", [
      Curso("Cálculo I", "-"),
      Curso("Álgebra y geometría analítica", "-"),
      Curso("Biología", "-"),
      Curso("Redaccion y técnicas de comunicacion afectiva I", "-"),
      Curso("Programación y Computación", "-"),
      Curso("Medio Ambiente y Desarrollo Sostenible", "-"),
      Curso("Métodos de Estudio Universitario", "-"),
      // Agrega descripciones para otros cursos aquí
    ]),

    Ciclo("Segundo Ciclo", [
      Curso("Redaccion y técnicas de comunicacion afectiva II", "Redaccion y técnicas de comunicacion afectiva I"),
      Curso("Investigación informativa", "-"),
      Curso("Realidad nacional y mundial", "-"),
      Curso("Calculo II", "Cálculo I"),
      Curso("Física I", "-"),
      Curso("Química General", "-"),
      Curso("Introducción a las ciencias e ingeniería", "-"),
      Curso("Emprendimiento", "-"),
    ]),
    // Agrega más ciclos y cursos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("CURSOS POR CICLO"),
      ),
      body: ListView.builder(
        itemCount: ListaDeCursos.length,
        itemBuilder: (context, index) {
          final ciclo = ListaDeCursos[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    ciclo.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Column(
                  children: ciclo.cursos.map((curso) {
                    return ListTile(
                      title: Text(curso.nombre),
                      trailing: Text(curso.descripcion), // Muestra la descripción en la parte derecha
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}