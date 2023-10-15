import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/presentation/separated_column_builder.dart';
import 'package:vtb_map/features/banks/presentation/widgets/department_card.dart';

import '../../domain/store/create_ticket_store.dart';

class ChooseDepartmentStep extends StatefulWidget {
  const ChooseDepartmentStep({Key? key}) : super(key: key);

  @override
  State<ChooseDepartmentStep> createState() => _ChooseDepartmentStepState();
}

class _ChooseDepartmentStepState extends State<ChooseDepartmentStep> {
  final _createDepartmentStore = locator<CreateTicketStore>();

  @override
  void initState() {
      _createDepartmentStore.updateStepper(chosenDepId: _createDepartmentStore.departments[0].departmentExtended.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6)
              ),
              child: InkWell(
                onTap: () => _createDepartmentStore.setStepIndex(_createDepartmentStore.currStepIndex-1),
                  child: const Icon(Icons.arrow_back_outlined)
              ),
            ),
            const SizedBox(width: 6),
            const Expanded(
              child: Text(
                'Мы нашли оптимальное отделение под ваши нужды!',
                style: TextStyle(
                  color: Color(0xFF31383E),
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          flex: 10,
          child: SingleChildScrollView(
            child: Observer(builder: (_) =>
                SeparatedListBuilder(
                    itemCount: _createDepartmentStore.departments.length,
                    itemBuilder: (_, index) => Observer(
                      builder: (_) => DepartmentCard(
                              departmentWithTimes: _createDepartmentStore.departments[index],
                              isChosen:  _createDepartmentStore.departments[index].departmentExtended.id == _createDepartmentStore.selectedDepartmentId,
                              onChoose: () => _createDepartmentStore.updateStepper(chosenDepId: _createDepartmentStore.departments[index].departmentExtended.id),
                          ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 8)
                )
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(onPressed: () => _createDepartmentStore.setStepIndex(_createDepartmentStore.currStepIndex + 1), child: Text('Продолжить'))
      ],
    );
  }
}
