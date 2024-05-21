import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viajes/pages/crear_viaje.dart';
import 'package:viajes/pages/gastos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> viajes = [];

  void _navigateToAddTrip() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrearViaje()),
    );

    if (result != null) {
      setState(() {
        viajes.add(result);
      });
    }
  }

  void _navigateToDetallesViaje(Map<String, dynamic> viaje) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetallesViaje(
          viaje: viaje,
          onUpdate: (updatedViaje) {
            setState(() {
              int index = viajes
                  .indexWhere((v) => v['nombre'] == updatedViaje['nombre']);
              if (index != -1) {
                viajes[index] = updatedViaje;
              }
            });
          },
        ),
      ),
    );
  }

  void _confirmDeleteTrip(int index) async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar este viaje?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      setState(() {
        viajes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Expense App'),
        backgroundColor: Colors.teal,
      ),
      body: viajes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.airplanemode_active,
                    size: 100,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bienvenido a Travel Expense App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Agrega un nuevo viaje para comenzar',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: viajes.length,
              itemBuilder: (context, index) {
                DateTime fecha =
                    DateFormat('yyyy-MM-dd').parse(viajes[index]['fecha']);
                String fechaFormateada =
                    DateFormat('dd \'de\' MMMM \'del\' yyyy').format(fecha);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      viajes[index]['nombre'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                            'Presupuesto: \$${NumberFormat('#,###.##').format(double.parse(viajes[index]['presupuesto']))}'),
                        SizedBox(height: 5),
                        Text('Fecha: $fechaFormateada'),
                      ],
                    ),
                    onTap: () => _navigateToDetallesViaje(viajes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDeleteTrip(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTrip,
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
