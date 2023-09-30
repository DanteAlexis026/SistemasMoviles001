import 'package:flutter/material.dart';
import 'MenuLateral.dart';

class Curso{
  final String curso;
  final String aula;
  Curso(this.curso, this.aula);
}
class Ciclo {
  final String nombre;
  final List<Curso> cursos;
  Ciclo(this.nombre, this.cursos);
}
class Salon extends StatelessWidget{

  final List<Ciclo> listaDeCiclo = [
    Ciclo("Primer Ciclo", [
      Curso("Cálculo I", "Aula 103-NP"),
      Curso("Algebra y geometría analítica", "Aula 105"),
      Curso("Biología", "Aula 205"),
      Curso("Redaccion y técnicas de comunicacion afectiva I", "Aula 208-NP"),
      Curso("Programación y Computación", "Aula 308"),
      Curso("Medio Ambiente y Desarrollo Sostenible", "Aula 108-NP"),
      Curso("Métodos de Estudio Universitario", "Aula 109"),
    ]),
    Ciclo("Segundo Ciclo", [
      Curso("Algebra y geometría analítica", "Aula 206-NP"),
      Curso("Redaccion y técnicas de comunicacion afectiva II", "Aula 207"),
      Curso("Investigación informativa", "Aula 208-NP"),
      Curso("Realidad nacional y mundial", "Aula 205"),
      Curso("Calculo II", "Aula 201-NP"),
      Curso("Física I", "Aula 101"),
      Curso("Química General", "Aula 105-NP"),
      Curso("Introducción a las ciencias e ingeniería", "Aula 108"),
      Curso("Emprendimiento", "Aula 101-NP"),
    ]),
    Ciclo("Tercer Ciclo", [
      Curso("Programación y fundamentos de algorítmica", "Aula 108-NP"),
      Curso("Teoría general de sistemas", "Aula 110"),
      Curso("Organización y administración", "Aula 108"),
      Curso("Ingeniería económica", "Aula 306-NP"),
      Curso("Estadística", "Aula 105"),
      Curso("Series y ecuaciones diferenciales", "Aula 203-NP"),
      Curso("Matemáticas discretas", "Aula 107"),
    ]),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("Cursos y Salones"),
      ),
      body: ListView.builder(
        itemCount: listaDeCiclo.length,
        itemBuilder: (context, index) {
          final ciclo = listaDeCiclo[index];
          return ExpansionTile(
            title: Text(ciclo.nombre),
            children: ciclo.cursos.map((curso) {
              return ListTile(
                title: Text(curso.curso),
                subtitle: Text(curso.aula),

              );
            }).toList(),
          );
        },
      ),
    );
  }
}
//hola