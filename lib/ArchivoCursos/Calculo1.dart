import 'package:flutter/material.dart';

class CalculoI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo I"),
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
                    text: "Cálculo I",
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
                    text: "La asignatura corresponde al área de estudios específicos, es de naturaleza teórico-práctica. Tiene como propósito desarrollar en el estudiante la capacidad de solucionar problemas de cálculo diferencial. La asignatura contiene: Límites de una función de variable real. Derivada de una función de una variable real. Aplicaciones de la derivada. Límites de funciones de varias variables. Derivadas de funciones de varias variables.",
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
          ],
        ),
      ),
    );
  }
}
