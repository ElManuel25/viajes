import 'package:viajes/models/gasto.dart';

class Viaje {
  String nombre;
  DateTime fechaInicio;
  DateTime fechaFin;
  List<Gasto> gastos;

  
  Viaje({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.gastos

  });
}