import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory='Food';
  TextEditingController amountController = TextEditingController();

  List<Category> categories = [
    Category('Restaurante', Icons.fastfood),
    Category('Transporte', Icons.directions_car),
    Category('Compras', Icons.shopping_cart),
    Category('Entretenimiento', Icons.movie),
    Category('Supermercado', Icons.receipt),
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
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              children: categories.map((category) {
                return ChoiceChip(
                  avatar: Icon(category.icon),
                  label: Text(category.name),
                  selected: selectedCategory == category.name,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = (selected ? category.name : null)!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
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
                      content: Text('Please enter a valid amount and select a category.'),
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
              child: Text('Add Expense'),
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

  Category(this.name, this.icon);
}
