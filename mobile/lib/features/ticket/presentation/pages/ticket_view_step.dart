import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';

class TicketViewStep extends StatefulWidget {
  const TicketViewStep({Key? key,}) : super(key: key);

  @override
  State<TicketViewStep> createState() => _TicketViewStepState();
}

class _TicketViewStepState extends State<TicketViewStep> {

  final _createTicketStore = locator<CreateTicketStore>();

  late final _ticketNum = _createTicketStore.ticket?.num ?? 0;
  late final _ticketStr = _createTicketStore.ticket?.title ?? '';
  late final address = _createTicketStore.departments.firstWhere((element) => _createTicketStore.selectedDepartmentId == element.departmentExtended.id).departmentExtended.address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png'),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address,
                style: const TextStyle(
                    color: Color(0xFF171A1C),
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
        Center(
          child: Text(
            '$_ticketStr $_ticketNum',
            style: const TextStyle(
              fontSize: 48
            ),
          ),
        ),
      ],
    );
  }
}
