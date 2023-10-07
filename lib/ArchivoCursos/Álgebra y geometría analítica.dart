import 'package:flutter/material.dart';

class Algebra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álgebra y geometría analítica"),
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
                fontSize: 24.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Nombre: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Álgebra y geometría analítica",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Descripción: ",
                    style: TextStyle(
                      fontSize: 17.0, // Tamaño de fuente para la descripción
                      fontWeight: FontWeight.bold, // Texto en negrita para la descripción
                    ),
                  ),
                  TextSpan(
                    text: "El curso de Álgebra y Geometría Analítica tiene como objetivo principal desarrollar en los estudiantes la capacidad de comprender y aplicar conceptos algebraicos y geométricos para resolver problemas matemáticos y analizar situaciones del mundo real. Los estudiantes adquirirán habilidades fundamentales en matemáticas que son esenciales en una variedad de disciplinas académicas y aplicaciones prácticas.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Prerrequisito: ",
                    style: TextStyle(
                      fontSize: 17.0, // Tamaño de fuente para "Prerrequisito"
                      fontWeight: FontWeight.bold, // Texto en negrita para "Prerrequisito"
                    ),
                  ),
                  TextSpan(
                    text: "Ninguno",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Profesores: ",
                    style: TextStyle(
                      fontSize: 17.0, // Tamaño de fuente para "Prerrequisito"
                      fontWeight: FontWeight.bold, // Texto en negrita para "Prerrequisito"
                    ),
                  ),
                  TextSpan(
                    text: "Profesor 1, Profesor2, Profesor 3",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            /* RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "(Opcional) Sílabus: ",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "[Enlace al sílabus]",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
