import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../banks/entities/department.dart';

class DepartmentInfoPage extends StatelessWidget {
  const DepartmentInfoPage({Key? key, required this.department}) : super(key: key);

  final Department department;

  static final List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(department.title, textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Image.network(
            department.picture ?? '',
          errorBuilder: (_, __, ___) => const SizedBox(),
        ),
        const SizedBox(height: 10),
        Text(department.info),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: SfSparkBarChart(
            data: const [1, 5, 9, 10, 2, 18],
          ),
        ),
      ],
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}