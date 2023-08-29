import 'package:flutter/material.dart';
import 'package:techkushxemulator/widgets/textfield.dart';

class AddDataDialogBox {
  final TextEditingController _titleToDo = TextEditingController();
  final TextEditingController _descriptionToDo = TextEditingController();

  Function handleFunction;

  AddDataDialogBox({required this.handleFunction});

  Future showAddDialogBox(BuildContext context) {
    final focusNode = FocusScope.of(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TechKushTextField(
                  focusNode: focusNode,
                  textController: _titleToDo,
                  hintText: 'Title'),
              const SizedBox(
                height: 16,
              ),
              TechKushTextField(
                  focusNode: focusNode,
                  textController: _descriptionToDo,
                  hintText: 'Description'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                handleFunction(_titleToDo.text, _descriptionToDo.text);
                Navigator.pop(context);
              },
              child: const Text('ADD'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }
}
