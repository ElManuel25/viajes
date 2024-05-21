import 'package:flutter/material.dart';
import 'package:viajes/pages/crear_viaje.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> viajes = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Expense App'),
      ),
      body: viajes.isEmpty
          ? const Center(
              child: Text('Bienvenido a Travel Expense App!'),
            )
          : ListView.builder(
              itemCount: viajes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(viajes[index]['nombre']!),
                  subtitle: Text(
                      'Presupuesto: \$${viajes[index]['presupuesto']} - Fecha: ${viajes[index]['fecha']}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTrip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
