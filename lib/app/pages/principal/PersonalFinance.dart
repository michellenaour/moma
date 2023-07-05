import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:plantilla_ca/app/pages/principal/gasto.dart';

class PersonalFinancePage extends StatefulWidget {
  @override
  _PersonalFinancePageState createState() => _PersonalFinancePageState();
}

class _PersonalFinancePageState extends State<PersonalFinancePage> {
  String selectedCategory = 'Food';
  List<ChartData> chartData = [];

  List<Category> categories = [
    Category('Restaurantes', Icons.fastfood, Colors.red),
    Category('Transporte', Icons.directions_car, Colors.blue),
    Category('Compras', Icons.shopping_cart, Colors.green),
    Category('Entretenimiento', Icons.movie, Colors.purple),
    Category('Supermercado', Icons.receipt, Colors.orange),
    Category('Mascotas', Icons.receipt, Colors.pink),
    Category('Telefono', Icons.receipt, Colors.lime),
    Category('Ropa', Icons.receipt, Colors.brown),
  ];

  bool _isPageActive = false;

  @override
  void initState() {
    super.initState();
    _parseJsonData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isPageActive) {
      _isPageActive = true;
      _parseJsonData();
    }
  }

  // ...

  @override
  void dispose() {
    _isPageActive = false;
    super.dispose();
  }
  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/data.json');
  }
  

  Future<void> _parseJsonData() async {
    String jsonData = await _loadJsonData();
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    List<dynamic> jsonList = jsonMap['transacciones'];

    setState(() {
      chartData = jsonList.map((json) {
        String x = json['x'];
        double y = json['y'].toDouble();

        Category matchingCategory = categories.firstWhere(
          (category) => category.name == x,
          orElse: () => Category('Unknown', Icons.error, Colors.grey),
        );

        return ChartData(
          x,
          y,
          matchingCategory.color,
          matchingCategory.icon,
        );
      }).toList();
    });
  }
  

  @override
  Widget build(BuildContext context) {

    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Tu resumen Mensual'),
        backgroundColor: Color.fromRGBO(1, 139, 73, 1),
      ),
      body: Column(
        children: [
          Container(
            child: SfCircularChart(series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelMapper: (ChartData data, _) => data.x,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  useSeriesColor: true,
                ),
              )
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
                    leading: Icon(expense.icon),
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
        backgroundColor: Color.fromRGBO(0, 151, 178, 0.8),
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

class ChartData {
  final String x;
  final double y;
  final Color color;
  final IconData icon;

  ChartData(this.x, this.y, this.color, this.icon);
}

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category(this.name, this.icon, this.color);
}
