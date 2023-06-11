
import 'package:flutter/material.dart';

Future<String?> showUserInputDialog({
  required BuildContext context,
  required String label,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => UserInputDialog(
      label: label,
    ),
  );
}

class UserInputDialog extends StatefulWidget {  
  const UserInputDialog({
    Key? key,
    required this.label,
    this.width = 320.0,
    this.height = 450.0,
});
final String label;
final double width;
final double height;
  @override
  State<UserInputDialog> createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  late String input;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            TextFormField(
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Wpisz numer ${widget.label}',
              ),
              onChanged: (value) => input = value,
          ),
          ElevatedButton(
          onPressed: () =>{Navigator.of(context).pop(input)},
          child: const Text("dodaj"),
          ),
          ]
        ),
        
        ),
    );
  }
}

Future<String?> showUserInput({
  required BuildContext context,
  required String label,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => UserInputDialog(
      label: label,
    ),
  );
}