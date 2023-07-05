import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory = '';

  TextEditingController amountController = TextEditingController();

  List<Category> categories = [
    Category('Restaurantes', Icons.fastfood, Colors.red),
    Category('Transporte', Icons.directions_car, Colors.blue),
    Category('Compras', Icons.shopping_cart, Colors.green),
    Category('Entretenimiento', Icons.movie, Colors.purple),
    Category('Supermercado', Icons.receipt, Colors.orange),
    Category('Mascotas', Icons.pets, Colors.pink),
    Category('Telefono', Icons.call, Colors.lime),
    Category('Ropa', Icons.checkroom, Colors.brown),
  ];

  List<dynamic> expenseList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Gasto'),
        backgroundColor: Color.fromRGBO(1, 139, 73, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Categoría',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                isSelected: categories.map((category) => selectedCategory == category.name).toList(),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                onPressed: (int index) {
                  setState(() {
                    selectedCategory = categories[index].name;
                  });
                },
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(category.icon),
                        SizedBox(height: 4.0),
                        Text(
                          category.name,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(0, 151, 178, 1)),
                ),
                onPressed: () {
                  final amount = double.tryParse(amountController.text);
                  if (amount != null && selectedCategory != '') {
                    guardarTransaccion(selectedCategory, amount, context);
                    
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Ingrese un monto y seleccione una categoría'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category(this.name, this.icon, this.color);
}



class Transaccion {
  String categoria;
  double monto;

  Transaccion(this.categoria, this.monto);

  Map<String, dynamic> toJson() {
    return {
      'x': categoria,
      'y': monto,
    };
  }
}

Transaccion? transaccion;

void guardarTransaccion(String categoria, double monto, BuildContext context) {
  transaccion = Transaccion(categoria, monto);
  guardarTransaccionEnArchivo(context);
}

void guardarTransaccionEnArchivo(BuildContext context) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('assets/data.json');

  // Verificar si el archivo existe
 if (file.existsSync()) {
    final existingData = await file.readAsString();
    final existingJsonData = json.decode(existingData);
    List<dynamic> transaccionesAnteriores = List<dynamic>.from(existingJsonData['transacciones']);
    transaccionesAnteriores.add(transaccion!.toJson());

    final jsonData = json.encode({'transacciones': transaccionesAnteriores});
    await file.writeAsString(jsonData);
  } else {
    // Si el archivo no existe, crear uno nuevo con la transacción actual
    final transaccionJson = transaccion!.toJson();
    final jsonData = json.encode({'transacciones': [transaccionJson]});
    await file.writeAsString(jsonData);
  }

  // Regresar a la página anterior (PersonalFinancePage)
   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PersonalFinancePage()),
  );
}
