import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';

class CreateTicketStepper extends StatelessWidget {
  CreateTicketStepper({Key? key, required this.steps}) : super(key: key);

  final List<Widget> steps;


  final _createTicketStore = locator<CreateTicketStore>();

  bool get _isFirst => _createTicketStore.currStepIndex == 0;
  bool get _isLast => _createTicketStore.currStepIndex == steps.length - 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.75 * MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) => Stack(
            children: steps.mapWithIndex((step, index) => Visibility(visible: index == _createTicketStore.currStepIndex, child: step)).toList()
          ),
        ),
      ),
    );
  }
}

