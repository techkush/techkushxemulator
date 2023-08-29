import 'package:flutter/material.dart';
import 'package:techkushxemulator/widgets/textfield.dart';

class UpdateDataDialogBox {
  final TextEditingController _titleToDo = TextEditingController();
  final TextEditingController _descriptionToDo = TextEditingController();

  Function handleFunction;
  String title, description;

  UpdateDataDialogBox({required this.handleFunction, required this.title, required this.description});

  Future showAddDialogBox(BuildContext context) {
    _titleToDo.text = title;
    _descriptionToDo.text = description;
    final focusNode = FocusScope.of(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Data'),
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
              child: const Text('UPDATE'),
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
