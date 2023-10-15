import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vtb_map/features/banks/presentation/widgets/tag_view.dart';
import 'package:vtb_map/features/ticket/data/create_ticket_dto.dart';
import 'package:vtb_map/features/ticket/domain/use_cases/create_ticket_use_case.dart';

import '../../../../core/di/locator.dart';
import '../../domain/store/create_ticket_store.dart';

class ChooseQueueDurationStep extends StatefulWidget {
  const ChooseQueueDurationStep({Key? key}) : super(key: key);

  @override
  State<ChooseQueueDurationStep> createState() => _ChooseQueueDurationStepState();
}

class _ChooseQueueDurationStepState extends State<ChooseQueueDurationStep> {
  final _createDepartmentStore = locator<CreateTicketStore>();

  final CreateTicketUseCase _createTicketUseCase = CreateTicketUseCase();
  var selectedTimeId = '0';
  _selectTime(String id) {
    setState(() {
      selectedTimeId = id;
    });
    _createDepartmentStore.updateStepper(timeToSetInQueuee: const Duration(seconds: 5));
  }

  onNextGo() async {
   ( await _createTicketUseCase.execute(CreateTicketDto(
        request: 'sasd',
        status: 'Pending',
        userId: const String.fromEnvironment('USER_ID'),
        tagId: _createDepartmentStore.selectedTagsIds[0], visitDate: DateTime.now(), departmentQueueId: ''))
   ).match(
           (l) => debugPrint(l.message),
           (r) => _createDepartmentStore.setStepIndex(_createDepartmentStore.currStepIndex +1 )
   );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                'Встаньте в очередь до прихода в отделение',
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
                 Column(
                  children: [
                    const Text(
                      'Поставьте меня в очередь, когда я буду за',
                      style: TextStyle(
                        color: Color(0xFF31383E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _selectTime('0'),
                            child: TagView(tagTitle: '3 минут', isSelected: selectedTimeId == '0')
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                            onTap: () => _selectTime('1'),
                            child: TagView(tagTitle: '5 минут', isSelected: selectedTimeId == '1')
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                            onTap: () => _selectTime('2'),
                            child: TagView(tagTitle: '10 минут', isSelected: selectedTimeId == '2')
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'взамен я',
                            style: TextStyle(
                              color: Color(0xFF31383E),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF259125),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: InkWell(
                            onTap: (){},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Помогу бездомным котикам',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(onPressed: onNextGo, child: const Text('Продолжить'))
      ],
    );
  }
}
