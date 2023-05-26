import 'package:flutter/material.dart';

import '../../module/home/dependencies/home_dependencies.dart';
import '../enum/common_enum.dart';

class NoInternetConnectionDialog extends StatefulWidget {
  const NoInternetConnectionDialog({super.key, required this.event});
  final NetworkConnectionState event;

  @override
  State<NoInternetConnectionDialog> createState() =>
      _NoInternetConnectionDialogState();
}

class _NoInternetConnectionDialogState
    extends State<NoInternetConnectionDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Internet Connection'),
      content:
          const Text('Please check your internet connection and try again.'),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
