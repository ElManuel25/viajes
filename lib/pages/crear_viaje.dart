import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importar la clase DateFormat

class CrearViaje extends StatefulWidget {
  const CrearViaje({Key? key}) : super(key: key);

  @override
  _CrearViajeState createState() => _CrearViajeState();
}

class _CrearViajeState extends State<CrearViaje> {
  final _nombreController = TextEditingController();
  final _presupuestoController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nombreController.dispose();
    _presupuestoController.dispose();
    super.dispose();
  }

  void _crearViaje() {
    if (_nombreController.text.isNotEmpty &&
        _presupuestoController.text.isNotEmpty &&
        _selectedDate != null) {
      Navigator.pop(context, {
        'nombre': _nombreController.text,
        'presupuesto': _presupuestoController.text,
        'fecha':
            DateFormat('yyyy-MM-dd').format(_selectedDate!), // Corregir aquí
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor ingresa todos los detalles del viaje'),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Viaje'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre del Viaje',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                hintText: 'Ej: Vacaciones en la Playa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Presupuesto del Viaje',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _presupuestoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ej: 1000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Fecha del Viaje: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                _selectedDate != null
                    ? Text(
                        DateFormat('dd/MM/yyyy')
                            .format(_selectedDate!), // Corregir aquí
                        style: TextStyle(fontSize: 18),
                      )
                    : TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Seleccionar Fecha',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _crearViaje,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    'Crear Viaje',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
