import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  String selectedCategory = 'Food'; // Set the default selected category here

  List<Category> categories = [
    Category('Food', Icons.fastfood),
    Category('Transportation', Icons.directions_car),
    Category('Shopping', Icons.shopping_cart),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: categories.map((category) {
                return ChoiceChip(
                  selected: selectedCategory == category.name,
                  onSelected: (selected) {
                    selectedCategory = selected ? category.name : '';
                  },
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          category.icon,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(width: 4.0),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
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
