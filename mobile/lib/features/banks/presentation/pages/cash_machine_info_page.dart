import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/features/banks/entities/cash_machine.dart';
import 'package:vtb_map/features/map/domain/use_cases/get_current_user_location_use_case.dart';

import '../../../../core/routing/routes_path.dart';
import '../../../map/presentation/widgets/route_point_view.dart';
import '../../entities/department.dart';

class CashMachineInfoPage extends StatefulWidget {
  const CashMachineInfoPage({Key? key, required this.cashMachine}) : super(key: key);

  final CashMachine cashMachine;

  @override
  State<CashMachineInfoPage> createState() => _CashMachineInfoPageState();
}

class _CashMachineInfoPageState extends State<CashMachineInfoPage> {

  _buildOnTapCreateDrivingRoute(BuildContext context) =>  () async {
    final pEnd = widget.cashMachine.location;
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
                Expanded(
                  flex: 8,
                  child: Text(
                    widget.cashMachine.address,
                    style: const TextStyle(
                      color: Color(0xFF171A1C),
                      fontSize: 18,
                      // fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                    ),
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
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Имеется: ${widget.cashMachine.balance}₽',
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
            Text(widget.cashMachine.info),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}