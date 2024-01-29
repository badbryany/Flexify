import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  DeleteAlertDialog({
    super.key,
    required this.actions,
  });

  List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'Do you want to delete this set?',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      actions: actions,
    );
  }
}
