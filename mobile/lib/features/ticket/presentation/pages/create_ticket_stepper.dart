import 'package:flutter/material.dart';

class CreateTicketStepper extends StatefulWidget {
  const CreateTicketStepper({Key? key}) : super(key: key);

  @override
  State<CreateTicketStepper> createState() => _CreateTicketStepperState();
}

class _CreateTicketStepperState extends State<CreateTicketStepper> {
  var currStep = 0;

  bool get _isFirst => currStep == 0;

  @override
  Widget build(BuildContext context) {
    // return  Stepper(
    //     steps:
    // );
    return Placeholder();
  }
}

