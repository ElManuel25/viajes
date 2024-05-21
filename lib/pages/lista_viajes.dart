import 'package:flutter/material.dart';
import 'package:viajes/models/viaje.dart';
import 'package:viajes/pages/crear_viaje.dart';

class ListaViajes extends StatelessWidget {
  final List<Viaje> viajes;

  ListaViajes({required this.viajes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Viajes'),
      ),
      body: ListView.builder(
        itemCount: viajes.length,
        itemBuilder: (context, index) {
          final viaje = viajes[index];
          return ListTile(
            title: Text(viaje.nombre),
            subtitle: Text('${viaje.fechaInicio.toLocal()} - ${viaje.fechaFin.toLocal()}'),
            onTap: () {
              // Navegar a la pantalla de detalles del viaje
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
Navigator.pushReplacementNamed(context, '/crear_viaje');},
        child: Icon(Icons.add),
      ),
    );
  }
}
