import 'package:flutter/material.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/ticket/domain/department_with_times.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({Key? key, required this.departmentWithTimes, required this.isChosen, required this.onChoose}) : super(key: key);

  final DepartmentWithTimes departmentWithTimes;
  final bool isChosen;
  final VoidCallback onChoose;

  int get timeDrivingAll =>( timeDriving + departmentWithTimes.departmentExtended.minutesQueue + departmentWithTimes.departmentExtended.minutesService).toInt();
  int get timePedestrianAll => (timePedestrian + departmentWithTimes.departmentExtended.minutesQueue + departmentWithTimes.departmentExtended.minutesService).toInt();

  int get timeDriving => departmentWithTimes.drivingTime ~/ 60;
  int get timePedestrian => departmentWithTimes.pedestrianTime ~/60;

  DepartmentWorkload getByTime(num time) {
    if(time <= 20) return DepartmentWorkload.good;
    if(time <= 70) return DepartmentWorkload.warning;
    return DepartmentWorkload.danger;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCDD7E1)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/logo.png'),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  departmentWithTimes.departmentExtended.address,
                  style: const TextStyle(
                    color: Color(0xFF171A1C),
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              TimestampCard(
                  departmentWorkload: getByTime(timeDrivingAll),
                  time: timeDrivingAll.toString(),
                  category: 'Займет(авто)',
                  isGroup: true,
              ),
              TimestampCard(
                  departmentWorkload: getByTime(timePedestrianAll),
                  time: timePedestrianAll.toString(),
                  category: 'Займет(пеш.)',
                  isGroup: true,
              ),
              TimestampCard(
                  departmentWorkload: getByTime(timeDriving),
                  time: timeDriving.toString(),
                  category: 'В пути(авто)'
              ),
              TimestampCard(
                  departmentWorkload: getByTime(timePedestrian),
                  time: timePedestrian.toString(),
                  category: 'В пути(пеш.)'
              ),
              TimestampCard(
                  departmentWorkload: getByTime(departmentWithTimes.departmentExtended.minutesQueue),
                  time: departmentWithTimes.departmentExtended.minutesQueue.toString(),
                  category: 'В очереди'
              ),
              TimestampCard(
                  departmentWorkload: getByTime(departmentWithTimes.departmentExtended.minutesService),
                  time: departmentWithTimes.departmentExtended.minutesService.toString(),
                  category: 'Обслуживание'
              ),
            ],
          ),
          ElevatedButton(
              onPressed: isChosen ? null : onChoose,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(isChosen ? const Color(0xFF636B74) : null)
              ),
              child: Text(isChosen ? 'Выбрано' : 'Выбрать', style: TextStyle(color: isChosen ? Colors.white : Colors.black54))
          )
        ],
      ),
    );
  }
}

class TimestampCard extends StatelessWidget {
  const TimestampCard({Key? key, required this.departmentWorkload, required this.time, this.isGroup = false, required this.category}) : super(key: key);

  final DepartmentWorkload departmentWorkload;
  final String category;
  final String time;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: isGroup ? departmentWorkload.color : const Color(0xFFF0F4F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: category,
                  style: TextStyle(
                    color: isGroup
                        ? Colors.white
                        : const Color(0xFF31383E),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '~ $time мин.',
                  style: TextStyle(
                    color: isGroup ? Colors.white : departmentWorkload.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
