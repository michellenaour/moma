import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:plantilla_ca/app/pages/principal/gasto.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PersonalFinancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
      final List<ChartData> chartData = [
            ChartData('Restaurantes', 25, Color.fromRGBO(192, 188, 245, 1)),
            ChartData('Mascotas', 38, Color.fromRGBO(218, 200, 156, 1)),
            ChartData('Ropa', 34, Color.fromRGBO(245, 187, 219, 1)),
            ChartData('Entretenimiento', 52, Color.fromRGBO(232, 203, 146, 1)),
            ChartData('Supermercado', 34, Color.fromRGBO(184, 190, 255, 1)),
            ChartData('Telefono', 52, Color.fromRGBO(192, 255, 179, 1))
        ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Finance'),
      ),
      body: Column(
        children: [
           const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tus gastos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
                    child: SfCircularChart(
                        series: <CircularSeries>[
                            // Renders doughnut chart
                            DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y
                            )
                        ]
                    )
                )
         
         ,
           Expanded(
            child: ListView.builder(
              itemCount: chartData.length,
              itemBuilder: (context, index) {
                final expense = chartData[index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: expense.color,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(expense.x),
                    trailing:
                        Text('\$${expense.y.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
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
        ChartData(this.x, this.y, this.color);
            final String x;
            final double y;
            final Color color;
    }
