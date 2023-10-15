import 'package:flutter/material.dart';
import 'package:vtb_map/features/ticket/presentation/pages/choose_department_step.dart';
import 'package:vtb_map/features/ticket/presentation/pages/choose_queue_duration_step.dart';
import 'package:vtb_map/features/ticket/presentation/pages/create_physical_ticket.dart';
import 'package:vtb_map/features/ticket/presentation/pages/create_ticket_stepper.dart';

import '../../../../core/presentation/bottom_sheet/presentation/default_bottom_sheet_header.dart';
import '../../../ticket/presentation/pages/ticket_view_step.dart';
import 'filter_departments_page.dart';

class DepartmentEventModalPage extends StatefulWidget {
  const DepartmentEventModalPage({Key? key}) : super(key: key);

  @override
  State<DepartmentEventModalPage> createState() => _DepartmentEventModalPageState();
}

class _DepartmentEventModalPageState extends State<DepartmentEventModalPage> {

  String selectedEvent = '0';

  _buildOnSelectOption(String id) => () {
    setState(() {
      selectedEvent = id;
    });
  };

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: (){},
      enableDrag: false,
      shadowColor: Colors.transparent,
      builder: (_) =>Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SelectBottomSheetOption(label: 'Фильтры', isSelected: selectedEvent == '0', optionId: '0', onSelect: _buildOnSelectOption('0')),
                const SizedBox(width: 10),
                SelectBottomSheetOption(label: 'Оставить заявку', isSelected: selectedEvent == '1', optionId: '1', onSelect: _buildOnSelectOption('1'))
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 40, child: DefaultBottomSheetHeader()),
                SingleChildScrollView(
                  child: Builder(builder: (_) => selectedEvent == '0'
                      ? const FilterDepartmentsPage()
                      : CreateTicketStepper(steps: const [
                        CreatePhysicalTicket(),
                        ChooseDepartmentStep(),
                        ChooseQueueDurationStep(),
                        TicketViewStep()
                  ])
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ],
      ));
  }
}

class SelectBottomSheetOption extends StatelessWidget {
  const SelectBottomSheetOption({Key? key, required this.label, required this.isSelected, required this.optionId, required this.onSelect}) : super(key: key);

  final String label;
  final bool isSelected;
  final String optionId;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: ShapeDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x14151515),
              blurRadius: 24,
              offset: Offset(0, 20),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x14151515),
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: -2,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF31383E),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }
}