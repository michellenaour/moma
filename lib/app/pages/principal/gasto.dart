import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory = 'Food';
  TextEditingController amountController = TextEditingController();

  List<Category> categories = [
    Category('Restaurante', Icons.fastfood, Colors.red),
    Category('Transporte', Icons.directions_car, Colors.blue),
    Category('Compras', Icons.shopping_cart, Colors.green),
    Category('Entretenimiento', Icons.movie, Colors.purple),
    Category('Supermercado', Icons.receipt, Colors.orange),
  ];

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
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
            ),Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),child:

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                ),),
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
      if (amount != null && selectedCategory != null) {
        // Save the expense in the database or another data structure
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Ingrese un Monto'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
)

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
