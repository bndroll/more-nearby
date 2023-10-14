import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/features/map/domain/use_cases/get_current_user_location_use_case.dart';

import '../../../../core/routing/routes_path.dart';
import '../../../map/presentation/widgets/route_point_view.dart';
import '../../entities/department.dart';

class DepartmentInfoPage extends StatefulWidget {
  const DepartmentInfoPage({Key? key, required this.department}) : super(key: key);

  final Department department;

  @override
  State<DepartmentInfoPage> createState() => _DepartmentInfoPageState();
}

class _DepartmentInfoPageState extends State<DepartmentInfoPage> {
   final _tooltipBehavior = TooltipBehavior(enable: true);
   final List<_SalesData> data = [
     _SalesData('Jan', 35),
     _SalesData('Feb', 28),
     _SalesData('Mar', 34),
     _SalesData('Apr', 32),
     _SalesData('May', 40),
     _SalesData('June', 10)
   ];

  _buildOnTapCreateDrivingRoute(BuildContext context) =>  () async {
    final pEnd = widget.department.point;
    locator<GetCurrentUserLocationUseCase>()
        .execute(null)
    .then((res) {
      if(res.isRight()) {
        final sLocation = res.getOrElse((l) => ValueNotifier(null)).value;
        context.beamToNamed(routeSession, data: [
          RoutePointView(id: 'start_placemark', isEndMark: false, location: sLocation!),
          RoutePointView(
              id: 'end_point',
              isEndMark: true,
              location: pEnd
          )
        ]);
      }
    });

  };

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text(
                widget.department.title,
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
                    widget.department.address,
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
                widget.department.picture ?? '',
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            const SizedBox(height: 10),
            Text(widget.department.info),
            const SizedBox(height: 10),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFCDD7E1)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              height: 300,
              child: SfCartesianChart(
                isTransposed: true,
                // title: ChartTitle(text: 'Загруженность банка'),
                legend: const Legend(isVisible: false),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  BarSeries<_SalesData, String>(
                      name: '',
                      dataSource: data,
                      pointColorMapper: (_, index) => index.isEven ? const Color(0xFF9CA9CA) : const Color(0xFFCDD7E1),
                      xValueMapper: (_SalesData sd, _) => sd.year,
                      yValueMapper: (_SalesData gdp, _) => gdp.sales,
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                      enableTooltip: true)
                ],
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.none,)
              ),
            ),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}