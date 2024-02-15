import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeleteAlertDialog extends StatelessWidget {
  DeleteAlertDialog({
    super.key,
    required this.actions,
    required this.title,
  });

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'JosefinSans',
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.transparent,
          onPrimary: Theme.of(context).colorScheme.primary,
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.green,
          onBackground: Colors.red,
          surface: Theme.of(context).colorScheme.background,
          onSurface: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        actions: actions,
      ),
    );
  }
}
