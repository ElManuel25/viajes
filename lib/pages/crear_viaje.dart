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
  final _fechaController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _presupuestoController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  void _agregarViaje() {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text;
      String presupuesto = _presupuestoController.text;
      String fecha = _fechaController.text;
      // Regresar los datos del viaje a HomePage.
      Navigator.pop(context, {
        'nombre': nombre,
        'presupuesto': presupuesto,
        'fecha': fecha,
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _fechaController.text = "${picked.toLocal()}".split(' ')[0];
      });
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
                  TextFormField(
                    controller: _fechaController,
                    decoration: InputDecoration(
                      labelText: 'Fecha del Viaje',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione la fecha del viaje';
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
