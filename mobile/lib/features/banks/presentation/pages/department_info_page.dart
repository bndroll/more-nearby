import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/use_cases/get_current_user_location_use_case.dart';

import '../../../../core/routing/routes_path.dart';
import '../../../map/presentation/widgets/route_point_view.dart';
import '../../entities/department.dart';

class DepartmentInfoPage extends StatelessWidget {
  const DepartmentInfoPage({Key? key, required this.department}) : super(key: key);

  final Department department;

  _buildOnTapCreateDrivingRoute(BuildContext context) =>  () async {
    final pEnd = department.point;
    locator<GetCurrentUserLocationUseCase>()
        .execute(null)
    .then((res) {
      if(res.isRight()) {
        final sLocation = res.getOrElse((l) => ValueNotifier(null)).value;
        context.beamToNamed(routeSession, data: [
          RoutePointView(id: 'start_placemark', location: sLocation!),
          RoutePointView(
              id: 'end_point',
              location: pEnd
          )
        ]);
      }
    });

  };

  static final List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
              department.title,
              style: const TextStyle(
                color: Color(0xFF171A1C),
                fontSize: 18,
                // fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary)
              ),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.black54,)
            )],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  department.address,
                  style: const TextStyle(
                    color: Color(0xFF555E68),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: _buildOnTapCreateDrivingRoute(context),
                  child: const Text('Построить маршрут')
              )
            ],
          ),
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
      ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}