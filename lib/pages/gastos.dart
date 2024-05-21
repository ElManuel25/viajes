import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetallesViaje extends StatefulWidget {
  final Map<String, dynamic> viaje;
  final ValueChanged<Map<String, dynamic>> onUpdate;

  const DetallesViaje({required this.viaje, required this.onUpdate, Key? key})
      : super(key: key);

  @override
  _DetallesViajeState createState() => _DetallesViajeState();
}

class _DetallesViajeState extends State<DetallesViaje> {
  final _gastoController = TextEditingController();
  final _nombreGastoController = TextEditingController();
  double _presupuestoRestante = 0;
  List<Map<String, dynamic>> _gastos = [];

  @override
  void initState() {
    super.initState();
    _presupuestoRestante = double.parse(widget.viaje['presupuesto']);
  }

  void _agregarGasto() {
    if (_nombreGastoController.text.isNotEmpty &&
        _gastoController.text.isNotEmpty) {
      double gasto = double.parse(_gastoController.text.replaceAll(',', '.'));
      if (gasto <= _presupuestoRestante) {
        setState(() {
          _presupuestoRestante -= gasto;
          widget.viaje['presupuesto'] = _presupuestoRestante.toStringAsFixed(2);
          _gastos.add({
            'nombre': _nombreGastoController.text,
            'valor': gasto,
          });
        });
        widget.onUpdate(widget.viaje);
        _gastoController.clear();
        _nombreGastoController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No tienes presupuesto suficiente')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor ingresa el nombre y el valor del gasto')),
      );
    }
  }

  @override
  void dispose() {
    _gastoController.dispose();
    _nombreGastoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Viaje'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${widget.viaje['nombre']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Fecha: ${widget.viaje['fecha']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Presupuesto Restante: \$${NumberFormat('#,###.##').format(_presupuestoRestante)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Agregar Gasto:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nombreGastoController,
              decoration: InputDecoration(
                labelText: 'Nombre del Gasto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _gastoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor del Gasto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _agregarGasto,
              child: Text('Agregar'),
            ),
            SizedBox(height: 10),
            Text(
              'Gastos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _gastos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_gastos[index]['nombre']),
                    subtitle: Text(
                        'Valor: \$${NumberFormat('#,###.##').format(_gastos[index]['valor'])}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
