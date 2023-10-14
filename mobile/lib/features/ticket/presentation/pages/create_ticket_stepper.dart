import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';

class CreateTicketStepper extends StatefulWidget {
  const CreateTicketStepper({Key? key, required this.steps}) : super(key: key);

  final List<Widget> steps;

  @override
  State<CreateTicketStepper> createState() => _CreateTicketStepperState();
}

class _CreateTicketStepperState extends State<CreateTicketStepper> {

  final _createTicketStepperViewModel = CreateTicketStore();

  bool get _isFirst => _createTicketStepperViewModel.currStepIndex == 0;
  bool get _isLast => _createTicketStepperViewModel.currStepIndex == widget.steps.length - 1;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.75 * MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Overlay(
                  initialEntries: widget.steps
                      .map((step) => OverlayEntry(builder: (_) => step, maintainState: true))
                      .toList(),
                )
              ),
            ),
            const Spacer(flex: 1,),
            Observer(
                builder: (_) => ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                        textStyle: const MaterialStatePropertyAll(TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ))
                    ),
                    onPressed: () {},
                    child: const Text('Продолжить', style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ))
                )
            )
          ],
        ),
      ),
    );
  }
}


class _TicketStepper extends StatelessWidget {
  const _TicketStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
