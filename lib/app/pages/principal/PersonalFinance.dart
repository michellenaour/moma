import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:plantilla_ca/app/pages/principal/gasto.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PersonalFinancePage extends StatefulWidget {
  @override
  _PersonalFinancePageState createState() => _PersonalFinancePageState();
}

class _PersonalFinancePageState extends State<PersonalFinancePage> {

    String selectedCategory='Food';
    final List<ChartData> chartData = [
      ChartData('Restaurantes', 25, Color.fromRGBO(192, 188, 245, 1),
          Icons.restaurant),
      ChartData(
          'Mascotas', 38, Color.fromRGBO(218, 200, 156, 1), Icons.pets),
      ChartData('Ropa', 34, Color.fromRGBO(245, 187, 219, 1), Icons.shopping_bag),
      ChartData('Entretenimiento', 52, Color.fromRGBO(232, 203, 146, 1),
          Icons.theaters),
      ChartData(
          'Supermercado', 34, Color.fromRGBO(184, 190, 255, 1), Icons.shopping_cart),
      ChartData(
          'Telefono', 52, Color.fromRGBO(192, 255, 179, 1), Icons.phone),
    ];
      List<Category> categories = [
    Category('Día', Icons.check_box),
    Category('Mes', Icons.check_box),
    Category('Año', Icons.check_box),
  ];

   @override
  void dispose() {
    
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tu resumen Mensual'),
        backgroundColor: Color.fromRGBO(1, 139, 73, 1),
      ),
      body: Column(
        children: [
          Container(
            child: SfCircularChart(series: <CircularSeries>[
              // Renders doughnut chart
              DoughnutSeries<ChartData, String>(
                  
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) => data.x,
                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true, 
                                    labelPosition: ChartDataLabelPosition.outside,
                                    // Renders background rectangle and fills it with series color
                                    useSeriesColor: true
                                ))
            ]),
          ),
          SizedBox(height: 10.0),
           const Padding(
            padding: EdgeInsets.all(1.0),
            child: Text(
              'Total: \$ 166.00',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Align(
  alignment: Alignment.topLeft,
  child: Padding(
    padding: EdgeInsets.all(8.0),
    child: Wrap(
      spacing: 2.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return ChoiceChip(
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
  ),
),

            SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: chartData.length,
              itemBuilder: (context, index) {
                final expense = chartData[index];
                return Container(
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: expense.color,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    leading: Icon(expense.icon), // Add the icon
                    title: Text(expense.x),
                    trailing: Text('\$${expense.y.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0,151,178,0.8),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpensePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Expense {
  final String category;
  final double amount;

  Expense(this.category, this.amount);
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.icon);
  final String x;
  final double y;
  final Color color;
  final IconData icon;
}

class Category {
  final String name;
  final IconData icon;

  Category(this.name, this.icon);
}
