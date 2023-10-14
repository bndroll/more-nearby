import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vtb_map/features/banks/presentation/widgets/tags_container.dart';

import '../view_models/create_ticket_view_model.dart';

class CreatePhysicalTicket extends StatefulWidget {
  const CreatePhysicalTicket({Key? key}) : super(key: key);

  @override
  State<CreatePhysicalTicket> createState() => _CreatePhysicalTicketState();
}

class _CreatePhysicalTicketState extends State<CreatePhysicalTicket> {

  final TextEditingController _dateController = TextEditingController();

  final _viewModel = CreateTicketViewModel();

  _buildOnDateTap(BuildContext context, Widget child) =>() =>  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Добрый день, я',
                      style: TextStyle(
                        color: Color(0xFF31383E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0x493C3C43),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0x493C3C43),
                          ),
                        )
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'планирую совершить визит в ваше банковское отделение',
                      style: TextStyle(
                        color: Color(0xFF31383E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        suffix:  InkWell(
                          onTap: _buildOnDateTap(context, CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.dateAndTime,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime newTime) {
                              _dateController.text = newTime.toString();
                            },
                          )),
                          child: const Icon(Icons.date_range),
                        ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0x493C3C43),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0x493C3C43),
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'и хотел(а) бы обсудить вопрос',
                      style: TextStyle(
                        color: Color(0xFF31383E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Observer(
                        builder: (_) => TagsContainer(
                            onTagTap: _viewModel.onTagTap,
                            tags: _viewModel.tags,
                            selectedTagsIds: _viewModel.selectedTagsIds
                        )
                    ),
                  ],
                ),
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
                    onPressed: _viewModel.createTicket,
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
