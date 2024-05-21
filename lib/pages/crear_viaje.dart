import 'package:flutter/material.dart';

class CrearViaje extends StatefulWidget {
  const CrearViaje({super.key});

  @override
  _CrearViajeState createState() => _CrearViajeState();
}

class _CrearViajeState extends State<CrearViaje> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _presupuestoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _presupuestoController.dispose();
    super.dispose();
  }

  void _agregarViaje() {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text;
      String presupuesto = _presupuestoController.text;
      // Aquí puedes manejar el viaje agregado, como guardarlo en una lista o enviarlo a un servidor.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Viaje agregado: $nombre con presupuesto \$${presupuesto}'),
      ));
      _nombreController.clear();
      _presupuestoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Viajes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Text(
                'Crear Viajes',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(labelText: 'Nombre del Viaje'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre del viaje';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _presupuestoController,
                    decoration:
                        InputDecoration(labelText: 'Presupuesto del Viaje'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el presupuesto del viaje';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor ingrese un número válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _agregarViaje,
                    child: Text('Agregar Viaje'),
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
